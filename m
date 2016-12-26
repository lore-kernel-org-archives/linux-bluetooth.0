Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Cc: agoode@chromium.org
Subject: [PATCH BlueZ v4 1/2] profiles/midi: Added MIDI over BLE profile implementation
Date: Mon, 26 Dec 2016 20:26:33 +0000
Message-Id: <20161226202634.28195-2-eu@felipetonello.com>
In-Reply-To: <20161226202634.28195-1-eu@felipetonello.com>
References: <20161226202634.28195-1-eu@felipetonello.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This plugin implements the Central role of MIDI over Bluetooth
Low-Energy (BLE-MIDI) 1.0 specification as published by MMA in
November/2015.

It was implmemented as a bluetoothd plugin because of latency requirements
of MIDI. There are still room for improvements on this regard.

Like previsouly mentioned, it only implements the Central role, but
since all parsing and state-machine code is in libmidi.[hc] it should be
simple to implement the Peripheral role as a GATT service as well.

Files added:
 * profiles/midi/midi.c: Actual GATT plugin
 * profiles/midi/libmidi.[ch]: MIDI parsers

Techinal notes
==============

This plugin doesn't require any new threads. It relies on notifications
from a device to parse and render proper events that are queued in the
kernel, causing no blocks at all. Even if an error occur, it will be
handled and returned control to bluetoothd.

It also adds a new file descriptor to be read using struct io. That is
necessary to read events from applications and render raw BLE packets to
be sent to the device with a write without response command. It doesn't
block as well.

This patch introduces ALSA as dependency. But this feature is disabled
by default. To enable it, pass --enable-midi to the configure script.

Even though this introduces ALSA dependency, it is not an audio plugin.
It is rather a MIDI plugin, which is a byte stream protocol with low
throughput but requires low-latency.

Observations
============

I have tested on a normal laptop Arch-linux (x86_64) and a Raspberry Pi 2
(ARM Cortex-A8) and it works very well. As I mentioned, the latency can
always be improved.

I will still maintain a personal branch on my github[1] so others can
contribute there and I can test before sending to BlueZ.

IMPORTAT: the timestamp support is incomplete since ALSA doesn't support the
way MIDI over BLE expects (asign timestamp to an event without scheduling).
We are working on ALSA to support this.

Credits
=======

I would like to send kudos to ROLI Ltd. which allowed my to work
on this as part of my full-time job.

[1] https://github.com/ftonello/bluez/
---
 Makefile.am             |   4 +-
 Makefile.plugins        |   8 +
 configure.ac            |  11 ++
 profiles/midi/libmidi.c | 412 ++++++++++++++++++++++++++++++++++++++++
 profiles/midi/libmidi.h | 150 +++++++++++++++
 profiles/midi/midi.c    | 490 ++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 1074 insertions(+), 1 deletion(-)
 create mode 100644 profiles/midi/libmidi.c
 create mode 100644 profiles/midi/libmidi.h
 create mode 100644 profiles/midi/midi.c

diff --git a/Makefile.am b/Makefile.am
index c469a6caf83a..7a758fbde713 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -147,6 +147,7 @@ gobex_sources = gobex/gobex.h gobex/gobex.c \
 builtin_modules =
 builtin_sources =
 builtin_nodist =
+builtin_ldadd =
 
 include Makefile.plugins
 
@@ -191,7 +192,8 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 src_bluetoothd_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la \
 			src/libshared-glib.la \
-			@BACKTRACE_LIBS@ @GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt
+			@BACKTRACE_LIBS@ @GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt \
+			$(builtin_ldadd)
 src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
 				-Wl,--version-script=$(srcdir)/src/bluetooth.ver
 
diff --git a/Makefile.plugins b/Makefile.plugins
index 59342c0cb803..3a9e27c653dd 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -95,6 +95,14 @@ builtin_sources += profiles/scanparam/scan.c
 builtin_modules += deviceinfo
 builtin_sources += profiles/deviceinfo/deviceinfo.c
 
+if MIDI
+builtin_modules += midi
+builtin_sources += profiles/midi/midi.c \
+			profiles/midi/libmidi.h \
+			profiles/midi/libmidi.c
+builtin_ldadd += @ALSA_LIBS@
+endif
+
 if SIXAXIS
 plugin_LTLIBRARIES += plugins/sixaxis.la
 plugins_sixaxis_la_SOURCES = plugins/sixaxis.c
diff --git a/configure.ac b/configure.ac
index fe4103c19037..2b0363c5af94 100644
--- a/configure.ac
+++ b/configure.ac
@@ -212,6 +212,17 @@ AC_ARG_ENABLE(cups, AC_HELP_STRING([--disable-cups],
                 [disable CUPS printer support]), [enable_cups=${enableval}])
 AM_CONDITIONAL(CUPS, test "${enable_cups}" != "no")
 
+AC_ARG_ENABLE(midi, AC_HELP_STRING([--enable-midi],
+                [enable MIDI support]), [enable_midi=${enableval}])
+AM_CONDITIONAL(MIDI, test "${enable_midi}" = "yes")
+
+if (test "${enable_midi}" = "yes"); then
+	PKG_CHECK_MODULES(ALSA, alsa, dummy=yes,
+				AC_MSG_ERROR(ALSA lib is required for MIDI support))
+	AC_SUBST(ALSA_CFLAGS)
+	AC_SUBST(ALSA_LIBS)
+fi
+
 AC_ARG_ENABLE(obex, AC_HELP_STRING([--disable-obex],
 		[disable OBEX profile support]), [enable_obex=${enableval}])
 if (test "${enable_obex}" != "no"); then
diff --git a/profiles/midi/libmidi.c b/profiles/midi/libmidi.c
new file mode 100644
index 000000000000..7e0745aca7ed
--- /dev/null
+++ b/profiles/midi/libmidi.c
@@ -0,0 +1,412 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2015,2016 Felipe F. Tonello <eu@felipetonello.com>
+ *  Copyright (C) 2016 ROLI Ltd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ *
+ */
+
+#include <glib.h>
+
+#include "src/backtrace.h"
+#include "libmidi.h"
+
+inline static void buffer_append_byte(struct midi_buffer *buffer,
+                                      const uint8_t byte)
+{
+	buffer->data[buffer->len] = byte;
+	buffer->len++;
+}
+
+inline static void buffer_append_data(struct midi_buffer *buffer,
+                                      const uint8_t *data, size_t size)
+{
+	memcpy(buffer->data + buffer->len, data, size);
+	buffer->len += size;
+}
+
+inline static uint8_t buffer_reverse_get(struct midi_buffer *buffer, size_t i)
+{
+	return buffer->data[buffer->len - (i + 1)];
+}
+
+inline static size_t parser_get_available_size(struct midi_write_parser *parser)
+{
+	return parser->stream_size - parser->midi_stream.len;
+}
+
+inline static uint8_t sysex_get(const snd_seq_event_t *ev, size_t i)
+{
+	return ((uint8_t*)ev->data.ext.ptr)[i];
+}
+
+inline static void append_timestamp_high_maybe(struct midi_write_parser *parser)
+{
+	if (!midi_write_has_data(parser)) {
+		uint8_t timestamp_high = 0x80;
+		parser->rtime = g_get_monotonic_time() / 1000; /* convert µs to ms */
+		timestamp_high |= (parser->rtime & 0x1F80) >> 7;
+		/* set timestampHigh */
+		buffer_append_byte(&parser->midi_stream, timestamp_high);
+	}
+}
+
+inline static void append_timestamp_low(struct midi_write_parser *parser)
+{
+	const uint8_t timestamp_low = 0x80 | (parser->rtime & 0x7F);
+	buffer_append_byte(&parser->midi_stream, timestamp_low);
+}
+
+/* Algorithm:
+   1) check initial timestampLow:
+       if used_sysex == 0, then tsLow = 1, else tsLow = 0
+   2) calculate sysex size of current packet:
+   2a) first check special case:
+       if midi->out_length - 1 (tsHigh) - tsLow ==
+          sysex_length - used_sysex
+       size is: min(midi->out_length - 1 - tsLow,
+                    sysex_length - used_sysex - 1)
+   2b) else size is: min(midi->out_length - 1 - tsLow,
+                     sysex_length - used_sysex)
+   3) check if packet contains F7: fill respective tsLow byte
+*/
+static void read_ev_sysex(struct midi_write_parser *parser, const snd_seq_event_t *ev,
+                          midi_read_ev_cb write_cb, void *user_data)
+{
+	unsigned int used_sysex = 0;
+
+	/* We need at least 2 bytes (timestampLow + F0) */
+	if (parser_get_available_size(parser) < 2) {
+		/* send current message and start new one */
+		write_cb(parser->midi_stream.data, parser->midi_stream.len,
+		         user_data);
+		midi_write_reset(parser);
+		append_timestamp_high_maybe(parser);
+	}
+
+	/* timestampLow on initial F0 */
+	if (sysex_get(ev, 0) == 0xF0)
+		append_timestamp_low(parser);
+
+	do {
+		unsigned int size_of_sysex;
+
+		append_timestamp_high_maybe(parser);
+
+		size_of_sysex = MIN(parser_get_available_size(parser),
+		                    ev->data.ext.len - used_sysex);
+
+		if (parser_get_available_size(parser) == ev->data.ext.len - used_sysex)
+			size_of_sysex--;
+
+		buffer_append_data(&parser->midi_stream,
+		                    ev->data.ext.ptr + used_sysex,
+		                    size_of_sysex);
+		used_sysex += size_of_sysex;
+
+		if (parser_get_available_size(parser) <= 1 &&
+		    buffer_reverse_get(&parser->midi_stream, 0) != 0xF7) {
+			write_cb(parser->midi_stream.data, parser->midi_stream.len,
+			         user_data);
+			midi_write_reset(parser);
+		}
+	} while (used_sysex < ev->data.ext.len);
+
+	/* check for F7 and update respective timestampLow byte */
+	if (buffer_reverse_get(&parser->midi_stream, 0) == 0xF7) {
+		/* remove 0xF7 from buffer, append timestamp and add 0xF7 back again */
+		parser->midi_stream.len--;
+		append_timestamp_low(parser);
+		buffer_append_byte(&parser->midi_stream, 0xF7);
+	}
+}
+
+static void read_ev_others(struct midi_write_parser *parser, const snd_seq_event_t *ev,
+                           midi_read_ev_cb write_cb, void *user_data)
+{
+	int length;
+
+	/* check for running status */
+	if (parser->rstatus != ev->type) {
+		snd_midi_event_reset_decode(parser->midi_ev);
+		append_timestamp_low(parser);
+	}
+
+	/* each midi message has timestampLow byte to follow */
+	length = snd_midi_event_decode(parser->midi_ev,
+	                               parser->midi_stream.data +
+	                               parser->midi_stream.len,
+	                               parser_get_available_size(parser),
+	                               ev);
+
+	if (length == -ENOMEM) {
+		/* remove previously added timestampLow */
+		if (parser->rstatus != ev->type)
+			parser->midi_stream.len--;
+		write_cb(parser->midi_stream.data, parser->midi_stream.len,
+		         user_data);
+		/* cleanup state for next packet */
+		snd_midi_event_reset_decode(parser->midi_ev);
+		midi_write_reset(parser);
+		append_timestamp_high_maybe(parser);
+		append_timestamp_low(parser);
+		length = snd_midi_event_decode(parser->midi_ev,
+		                               parser->midi_stream.data +
+		                               parser->midi_stream.len,
+		                               parser_get_available_size(parser),
+		                               ev);
+	}
+
+	if (length > 0)
+		parser->midi_stream.len += length;
+}
+
+void midi_read_ev(struct midi_write_parser *parser, const snd_seq_event_t *ev,
+                  midi_read_ev_cb write_cb, void *user_data)
+{
+	/* Avoid linkage problem on unit-tests */
+#ifndef MIDI_TEST
+	btd_assert(write_cb);
+#endif
+
+	append_timestamp_high_maybe(parser);
+
+	/* SysEx is special case:
+	   SysEx has two timestampLow bytes, before F0 and F7
+	*/
+	if (ev->type == SND_SEQ_EVENT_SYSEX)
+		read_ev_sysex(parser, ev, write_cb, user_data);
+	else
+		read_ev_others(parser, ev, write_cb, user_data);
+
+	parser->rstatus = ev->type;
+
+	if (parser_get_available_size(parser) == 0) {
+		write_cb(parser->midi_stream.data, parser->midi_stream.len,
+		         user_data);
+		midi_write_reset(parser);
+	}
+}
+
+static void update_ev_timestamp(struct midi_read_parser *parser,
+                                snd_seq_event_t *ev, uint16_t ts_low)
+{
+	int delta_timestamp;
+	int delta_rtime;
+	int64_t rtime_current;
+	uint16_t timestamp;
+
+	/* time_low overwflow results on time_high to increment by one */
+	if (parser->timestamp_low > ts_low)
+		parser->timestamp_high++;
+
+	timestamp = (parser->timestamp_high << 7) | parser->timestamp_low;
+
+	rtime_current = g_get_monotonic_time() / 1000; /* convert µs to ms */
+	delta_timestamp = timestamp - (int)parser->timestamp;
+	delta_rtime = rtime_current - parser->rtime;
+
+	if (delta_rtime > MIDI_MAX_TIMESTAMP)
+		parser->rtime = rtime_current;
+	else {
+
+		/* If delta_timestamp is way to big than delta_rtime,
+		   this means that the device sent a message in the past,
+		   so we have to compensate for this. */
+		if (delta_timestamp > 7000 && delta_rtime < 1000)
+			delta_timestamp = 0;
+
+		/* check if timestamp did overflow */
+		if (delta_timestamp < 0) {
+			/* same timestamp in the past problem */
+			if ((delta_timestamp + MIDI_MAX_TIMESTAMP) > 7000 &&
+			    delta_rtime < 1000)
+				delta_timestamp = 0;
+			else
+				delta_timestamp = delta_timestamp + MIDI_MAX_TIMESTAMP;
+		}
+
+		parser->rtime += delta_timestamp;
+	}
+
+	parser->timestamp += delta_timestamp;
+	if (parser->timestamp > MIDI_MAX_TIMESTAMP)
+		parser->timestamp %= MIDI_MAX_TIMESTAMP + 1;
+
+	/* set event timestamp */
+	/* TODO: update event timestamp here! */
+}
+
+static size_t handle_end_of_sysex(struct midi_read_parser *parser,
+                                  snd_seq_event_t *ev,
+                                  const uint8_t *data,
+                                  size_t sysex_length)
+{
+	uint8_t time_low;
+
+	/* At this time, timestampLow is copied as the last byte,
+	   instead of 0xF7 */
+	buffer_append_data(&parser->sysex_stream, data, sysex_length);
+
+	time_low = buffer_reverse_get(&parser->sysex_stream, 0) & 0x7F;
+
+	/* Remove timestamp byte */
+	parser->sysex_stream.data[parser->sysex_stream.len - 1] = 0xF7;
+
+	/* Update event */
+	update_ev_timestamp(parser, ev, time_low);
+	snd_seq_ev_set_sysex(ev, parser->sysex_stream.len,
+	                     parser->sysex_stream.data);
+
+	return sysex_length + 1; /* +1 because of timestampLow */
+}
+
+
+
+size_t midi_read_raw(struct midi_read_parser *parser, const uint8_t *data,
+                    size_t size, snd_seq_event_t *ev /* OUT */)
+{
+	size_t midi_size = 0;
+	size_t i = 0;
+	bool err = false;
+
+	if (parser->timestamp_high == 0)
+		parser->timestamp_high = data[i++] & 0x3F;
+
+	snd_midi_event_reset_encode(parser->midi_ev);
+
+	/* timestamp byte */
+	if (data[i] & 0x80) {
+		update_ev_timestamp(parser, ev, data[i] & 0x7F);
+
+		/* check for wrong BLE-MIDI message size */
+		if (++i == size) {
+			err = true;
+			goto _finish;
+		}
+	}
+
+	/* cleanup sysex_stream if message is broken or is a new SysEx */
+	if (data[i] >= 0x80 && data[i] != 0xF7 && parser->sysex_stream.len > 0)
+		parser->sysex_stream.len = 0;
+
+	switch (data[i]) {
+	case 0xF8 ... 0XFF:
+		/* System Real-Time Messages */
+		midi_size = 1;
+		break;
+
+		/* System Common Messages */
+	case 0xF0: /* SysEx Start */ {
+		uint8_t *pos;
+
+		/* cleanup Running Status Message */
+		parser->rstatus = 0;
+
+		/* Avoid parsing if SysEx is contained in one BLE packet */
+		if ((pos = memchr(data + i, 0xF7, size - i))) {
+			const size_t sysex_length = pos - (data + i);
+			midi_size = handle_end_of_sysex(parser, ev, data + i,
+			                                sysex_length);
+		} else {
+			buffer_append_data(&parser->sysex_stream, data + i, size - i);
+			err = true; /* Not an actual error, just incomplete message */
+			midi_size = size - i;
+		}
+
+		goto _finish;
+	}
+
+	case 0xF1:
+	case 0xF3:
+		midi_size = 2;
+		break;
+	case 0xF2:
+		midi_size = 3;
+		break;
+	case 0xF4:
+	case 0xF5: /* Ignore */
+		i++;
+		err = true;
+		goto _finish;
+		break;
+	case 0xF6:
+		midi_size = 1;
+		break;
+	case 0xF7: /* SysEx End */
+		buffer_append_byte(&parser->sysex_stream, 0xF7);
+		snd_seq_ev_set_sysex(ev, parser->sysex_stream.len,
+		                     parser->sysex_stream.data);
+
+		midi_size = 1; /* timestampLow was alredy processed */
+		goto _finish;
+
+	case 0x80 ... 0xEF:
+		/*
+		 * Channel Voice Messages, Channel Mode Messages
+		 * and Control Change Messages.
+		 */
+		parser->rstatus = data[i];
+		midi_size = (data[i] >= 0xC0 && data[i] <= 0xDF) ? 2 : 3;
+		break;
+
+	case 0x00 ... 0x7F:
+
+		/* Check for SysEx messages */
+		if (parser->sysex_stream.len > 0) {
+			uint8_t *pos;
+
+			if ((pos = memchr(data + i, 0xF7, size - i))) {
+				const size_t sysex_length = pos - (data + i);
+				midi_size = handle_end_of_sysex(parser, ev, data + i,
+				                                sysex_length);
+			} else {
+				buffer_append_data(&parser->sysex_stream, data + i, size - i);
+				err = true; /* Not an actual error, just incomplete message */
+				midi_size = size - i;
+			}
+
+			goto _finish;
+		}
+
+		/* Running State Message was not set */
+		if (parser->rstatus == 0) {
+			midi_size = 1;
+			err = true;
+			goto _finish;
+		}
+
+		snd_midi_event_encode_byte(parser->midi_ev, parser->rstatus, ev);
+		midi_size = (parser->rstatus >= 0xC0 && parser->rstatus <= 0xDF) ? 1 : 2;
+		break;
+	}
+
+	if ((i + midi_size) > size) {
+		err = true;
+		goto _finish;
+	}
+
+	snd_midi_event_encode(parser->midi_ev, data + i, midi_size, ev);
+
+_finish:
+	if (err)
+		ev->type = SND_SEQ_EVENT_NONE;
+
+	return i + midi_size;
+}
diff --git a/profiles/midi/libmidi.h b/profiles/midi/libmidi.h
new file mode 100644
index 000000000000..8fcdf1eb2e7a
--- /dev/null
+++ b/profiles/midi/libmidi.h
@@ -0,0 +1,150 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2015,2016 Felipe F. Tonello <eu@felipetonello.com>
+ *  Copyright (C) 2016 ROLI Ltd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ *
+ */
+
+#ifndef LIBMIDI_H
+#define LIBMIDI_H
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <alsa/asoundlib.h>
+
+#define MIDI_MAX_TIMESTAMP 8191
+#define MIDI_MSG_MAX_SIZE 12
+#define MIDI_SYSEX_MAX_SIZE (4 * 1024)
+
+struct midi_buffer {
+	uint8_t *data;
+	size_t len;
+};
+
+/* MIDI I/O Write parser */
+
+struct midi_write_parser {
+	int64_t rtime;                  /* last writer's real time */
+	snd_seq_event_type_t rstatus;   /* running status event type */
+	struct midi_buffer midi_stream; /* MIDI I/O byte stream */
+	size_t stream_size;             /* what is the maximum size of the midi_stream array */
+	snd_midi_event_t *midi_ev;      /* midi<->seq event */
+};
+
+static inline int midi_write_init(struct midi_write_parser *parser, size_t buffer_size)
+{
+	parser->rtime = 0;
+	parser->rstatus = SND_SEQ_EVENT_NONE;
+	parser->stream_size = buffer_size;
+
+	parser->midi_stream.data = malloc(buffer_size);
+	if (!parser->midi_stream.data)
+		return -ENOMEM;
+
+	parser->midi_stream.len = 0;
+
+	return snd_midi_event_new(buffer_size, &parser->midi_ev);
+}
+
+static inline void midi_write_free(struct midi_write_parser *parser)
+{
+	free(parser->midi_stream.data);
+	snd_midi_event_free(parser->midi_ev);
+}
+
+static inline void midi_write_reset(struct midi_write_parser *parser)
+{
+	parser->rstatus = SND_SEQ_EVENT_NONE;
+	parser->midi_stream.len = 0;
+}
+
+static inline bool midi_write_has_data(struct midi_write_parser *parser)
+{
+	return parser->midi_stream.len > 0;
+}
+
+static inline const uint8_t * midi_write_data(struct midi_write_parser *parser)
+{
+	return parser->midi_stream.data;
+}
+
+static inline size_t midi_write_data_size(struct midi_write_parser *parser)
+{
+	return parser->midi_stream.len;
+}
+
+typedef void (*midi_read_ev_cb)(const uint8_t *, size_t, void *);
+
+/* It creates BLE-MIDI raw packets from the a sequencer event. If the packet
+   is full, then it calls write_cb and resets its internal state as many times
+   as necessary.
+ */
+void midi_read_ev(struct midi_write_parser *parser, const snd_seq_event_t *ev,
+                  midi_read_ev_cb write_cb, void *user_data);
+
+/* MIDI I/O Read parser */
+
+struct midi_read_parser {
+	uint8_t rstatus;                 /* running status byte */
+	int64_t rtime;                   /* last reader's real time */
+	int16_t timestamp;               /* last MIDI-BLE timestamp */
+	int8_t timestamp_low;            /* MIDI-BLE timestampLow from the current packet */
+	int8_t timestamp_high;           /* MIDI-BLE timestampHigh from the current packet */
+	struct midi_buffer sysex_stream; /* SysEx stream */
+	snd_midi_event_t *midi_ev;       /* midi<->seq event */
+};
+
+static inline int midi_read_init(struct midi_read_parser *parser)
+{
+	parser->rstatus = 0;
+	parser->rtime = -1;
+	parser->timestamp = 0;
+	parser->timestamp_low = 0;
+	parser->timestamp_high = 0;
+
+	parser->sysex_stream.data = malloc(MIDI_SYSEX_MAX_SIZE);
+	if (!parser->sysex_stream.data)
+		return -ENOMEM;
+
+	parser->sysex_stream.len = 0;
+
+	return snd_midi_event_new(MIDI_MSG_MAX_SIZE, &parser->midi_ev);
+}
+
+static inline void midi_read_free(struct midi_read_parser *parser)
+{
+	free(parser->sysex_stream.data);
+	snd_midi_event_free(parser->midi_ev);
+}
+
+static inline void midi_read_reset(struct midi_read_parser *parser)
+{
+	parser->rstatus = 0;
+	parser->timestamp_low = 0;
+	parser->timestamp_high = 0;
+}
+
+/* Parses raw BLE-MIDI messages and populates a sequencer event representing the
+   current MIDI message. It returns how much raw data was processed.
+ */
+size_t midi_read_raw(struct midi_read_parser *parser, const uint8_t *data,
+                     size_t size, snd_seq_event_t *ev /* OUT */);
+
+#endif /* LIBMIDI_H */
diff --git a/profiles/midi/midi.c b/profiles/midi/midi.c
new file mode 100644
index 000000000000..6d16d7805371
--- /dev/null
+++ b/profiles/midi/midi.c
@@ -0,0 +1,490 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2015,2016 Felipe F. Tonello <eu@felipetonello.com>
+ *  Copyright (C) 2016 ROLI Ltd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ *  Information about this plugin:
+ *
+ *  This plugin implements the MIDI over Bluetooth Low-Energy (BLE-MIDI) 1.0
+ *  specification as published by MMA in November/2015.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <alsa/asoundlib.h>
+
+#include "lib/bluetooth.h"
+#include "lib/sdp.h"
+#include "lib/uuid.h"
+
+#include "src/plugin.h"
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/profile.h"
+#include "src/service.h"
+#include "src/shared/util.h"
+#include "src/shared/att.h"
+#include "src/shared/queue.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/io.h"
+#include "src/log.h"
+#include "attrib/att.h"
+
+#include "libmidi.h"
+
+#define MIDI_UUID "03B80E5A-EDE8-4B33-A751-6CE34EC4C700"
+#define MIDI_IO_UUID "7772E5DB-3868-4112-A1A9-F2669D106BF3"
+
+struct midi {
+	struct btd_device *dev;
+	struct gatt_db *db;
+	struct bt_gatt_client *client;
+	unsigned int io_cb_id;
+	struct io *io;
+	uint16_t midi_io_handle;
+
+	/* ALSA handlers */
+	snd_seq_t *seq_handle;
+	int seq_client_id;
+	int seq_port_id;
+
+	/* MIDI parser*/
+	struct midi_read_parser midi_in;
+	struct midi_write_parser midi_out;
+};
+
+static bool midi_write_cb(struct io *io, void *user_data)
+{
+	struct midi *midi = user_data;
+	int err;
+
+	void foreach_cb(const uint8_t *data, size_t size, void *user_data) {
+		struct midi *midi = user_data;
+		bt_gatt_client_write_without_response(midi->client,
+		                                      midi->midi_io_handle,
+		                                      false,
+		                                      data,
+		                                      size);
+	};
+
+	do {
+		snd_seq_event_t *event = NULL;
+
+		err = snd_seq_event_input(midi->seq_handle, &event);
+
+		if (err < 0 || !event)
+			break;
+
+		midi_read_ev(&midi->midi_out, event, foreach_cb, midi);
+
+	} while (err > 0);
+
+	if (midi_write_has_data(&midi->midi_out))
+		bt_gatt_client_write_without_response(midi->client,
+		                                      midi->midi_io_handle,
+		                                      false,
+		                                      midi_write_data(&midi->midi_out),
+		                                      midi_write_data_size(&midi->midi_out));
+
+	midi_write_reset(&midi->midi_out);
+
+	return true;
+}
+
+static void midi_io_value_cb(uint16_t value_handle, const uint8_t *value,
+                             uint16_t length, void *user_data)
+{
+	struct midi *midi = user_data;
+	snd_seq_event_t ev;
+	unsigned int i = 0;
+
+	if (length < 3) {
+		warn("MIDI I/O: Wrong packet format: length is %u bytes but it should "
+		     "be at least 3 bytes", length);
+		return;
+	}
+
+	snd_seq_ev_clear(&ev);
+	snd_seq_ev_set_source(&ev, midi->seq_port_id);
+	snd_seq_ev_set_subs(&ev);
+	snd_seq_ev_set_direct(&ev);
+
+	midi_read_reset(&midi->midi_in);
+
+	while (i < length) {
+		size_t count = midi_read_raw(&midi->midi_in, value + i, length - i, &ev);
+
+		if (count == 0)
+			goto _err;
+
+		if (ev.type != SND_SEQ_EVENT_NONE)
+			snd_seq_event_output_direct(midi->seq_handle, &ev);
+
+		i += count;
+	}
+
+	return;
+
+_err:
+	error("Wrong BLE-MIDI message");
+}
+
+static void midi_io_ccc_written_cb(uint16_t att_ecode, void *user_data)
+{
+	if (att_ecode != 0) {
+		error("MIDI I/O: notifications not enabled %s",
+		      att_ecode2str(att_ecode));
+		return;
+	}
+
+	DBG("MIDI I/O: notification enabled");
+}
+
+static void midi_io_initial_read_cb(bool success, uint8_t att_ecode,
+                                    const uint8_t *value, uint16_t length,
+                                    void *user_data)
+{
+	struct midi *midi = user_data;
+
+	if (!success) {
+		error("MIDI I/O: Failed to read initial request");
+		return;
+	}
+
+	/* request notify */
+	midi->io_cb_id =
+		bt_gatt_client_register_notify(midi->client,
+		                               midi->midi_io_handle,
+		                               midi_io_ccc_written_cb,
+		                               midi_io_value_cb,
+		                               midi,
+		                               NULL);
+}
+
+static void handle_midi_io(struct midi *midi, uint16_t value_handle)
+{
+	DBG("MIDI I/O handle: 0x%04x", value_handle);
+
+	midi->midi_io_handle = value_handle;
+
+	/*
+	 * The BLE-MIDI 1.0 spec specifies that The Central shall attempt to
+	 * read the MIDI I/O characteristic of the Peripheral right after
+	 * estrablhishing a connection with the accessory.
+	 */
+	if (!bt_gatt_client_read_value(midi->client,
+	                               value_handle,
+	                               midi_io_initial_read_cb,
+	                               midi,
+	                               NULL))
+		DBG("MIDI I/O: Failed to send request to read initial value");
+}
+
+static void handle_characteristic(struct gatt_db_attribute *attr,
+                                  void *user_data)
+{
+	struct midi *midi = user_data;
+	uint16_t value_handle;
+	bt_uuid_t uuid, midi_io_uuid;
+
+	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle, NULL,
+	                                     NULL, &uuid)) {
+		error("Failed to obtain characteristic data");
+		return;
+	}
+
+	bt_string_to_uuid(&midi_io_uuid, MIDI_IO_UUID);
+
+	if (bt_uuid_cmp(&midi_io_uuid, &uuid) == 0)
+		handle_midi_io(midi, value_handle);
+	else {
+		char uuid_str[MAX_LEN_UUID_STR];
+
+		bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
+		DBG("Unsupported characteristic: %s", uuid_str);
+	}
+}
+
+static void foreach_midi_service(struct gatt_db_attribute *attr,
+                                 void *user_data)
+{
+	struct midi *midi = user_data;
+
+	gatt_db_service_foreach_char(attr, handle_characteristic, midi);
+}
+
+static int midi_device_probe(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct midi *midi;
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("MIDI GATT Driver profile probe (%s)", addr);
+
+	/* Ignore, if we were probed for this device already */
+	midi = btd_service_get_user_data(service);
+	if (midi) {
+		error("Profile probed twice for the same device!");
+		return -EADDRINUSE;
+	}
+
+	midi = g_new0(struct midi, 1);
+	if (!midi)
+		return -ENOMEM;
+
+	midi->dev = btd_device_ref(device);
+
+	btd_service_set_user_data(service, midi);
+
+	return 0;
+}
+
+static void midi_device_remove(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct midi *midi;
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("MIDI GATT Driver profile remove (%s)", addr);
+
+	midi = btd_service_get_user_data(service);
+	if (!midi) {
+		error("MIDI Service not handled by profile");
+		return;
+	}
+
+	btd_device_unref(midi->dev);
+	g_free(midi);
+}
+
+static int midi_accept(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct gatt_db *db = btd_device_get_gatt_db(device);
+	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
+	bt_uuid_t midi_uuid;
+	struct pollfd pfd;
+	struct midi *midi;
+	char addr[18];
+	char device_name[MAX_NAME_LENGTH + 11]; /* 11 = " Bluetooth\0"*/
+	int err;
+	snd_seq_client_info_t *info;
+
+	ba2str(device_get_address(device), addr);
+	DBG("MIDI GATT Driver profile accept (%s)", addr);
+
+	midi = btd_service_get_user_data(service);
+	if (!midi) {
+		error("MIDI Service not handled by profile");
+		return -ENODEV;
+	}
+
+	/* Port Name */
+	memset(device_name, 0, sizeof(device_name));
+	if (device_name_known(device))
+		device_get_name(device, device_name, sizeof(device_name));
+	else
+		strncpy(device_name, addr, sizeof(addr));
+
+	/* ALSA Sequencer Client and Port Setup */
+	err = snd_seq_open(&midi->seq_handle, "default", SND_SEQ_OPEN_DUPLEX, 0);
+	if (err < 0) {
+		error("Could not open ALSA Sequencer: %s (%d)", snd_strerror(err), err);
+		return err;
+	}
+
+	err = snd_seq_nonblock(midi->seq_handle, SND_SEQ_NONBLOCK);
+	if (err < 0) {
+		error("Could not set nonblock mode: %s (%d)", snd_strerror(err), err);
+		goto _err_handle;
+	}
+
+	err = snd_seq_set_client_name(midi->seq_handle, device_name);
+	if (err < 0) {
+		error("Could not configure ALSA client: %s (%d)", snd_strerror(err), err);
+		goto _err_handle;
+	}
+
+	err = snd_seq_client_id(midi->seq_handle);
+	if (err < 0) {
+		error("Could retreive ALSA client: %s (%d)", snd_strerror(err), err);
+		goto _err_handle;
+	}
+	midi->seq_client_id = err;
+
+	err = snd_seq_create_simple_port(midi->seq_handle, strcat(device_name, " Bluetooth"),
+	                                 SND_SEQ_PORT_CAP_READ |
+	                                 SND_SEQ_PORT_CAP_WRITE |
+	                                 SND_SEQ_PORT_CAP_SUBS_READ |
+	                                 SND_SEQ_PORT_CAP_SUBS_WRITE,
+	                                 SND_SEQ_PORT_TYPE_MIDI_GENERIC |
+	                                 SND_SEQ_PORT_TYPE_HARDWARE);
+	if (err < 0) {
+		error("Could not create ALSA port: %s (%d)", snd_strerror(err), err);
+		goto _err_handle;
+	}
+	midi->seq_port_id = err;
+
+	snd_seq_client_info_alloca(&info);
+	err = snd_seq_get_client_info(midi->seq_handle, info);
+	if (err < 0)
+		goto _err_port;
+
+	/* list of relevant sequencer events */
+	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_NOTEOFF);
+	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_NOTEON);
+	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_KEYPRESS);
+	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_CONTROLLER);
+	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_PGMCHANGE);
+	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_CHANPRESS);
+	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_PITCHBEND);
+	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_SYSEX);
+	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_QFRAME);
+	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_SONGPOS);
+	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_SONGSEL);
+	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_TUNE_REQUEST);
+	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_CLOCK);
+	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_START);
+	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_CONTINUE);
+	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_STOP);
+	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_SENSING);
+	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_RESET);
+	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_CONTROL14);
+	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_NONREGPARAM);
+	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_REGPARAM);
+
+	err = snd_seq_set_client_info(midi->seq_handle, info);
+	if (err < 0)
+		goto _err_port;
+
+
+	/* Input file descriptors */
+	snd_seq_poll_descriptors(midi->seq_handle, &pfd, 1, POLLIN);
+
+	midi->io = io_new(pfd.fd);
+	if (!midi->io) {
+		error("Could not allocate I/O eventloop");
+		goto _err_port;
+	}
+
+	io_set_read_handler(midi->io, midi_write_cb, midi, NULL);
+
+	midi->db = gatt_db_ref(db);
+	midi->client = bt_gatt_client_ref(client);
+
+	err = midi_read_init(&midi->midi_in);
+	if (err < 0) {
+		error("Could not initialise MIDI input parser");
+		goto _err_port;
+	}
+
+	err = midi_write_init(&midi->midi_out, bt_gatt_client_get_mtu(midi->client) - 3);
+	if (err < 0) {
+		error("Could not initialise MIDI output parser");
+		goto _err_midi;
+	}
+
+	bt_string_to_uuid(&midi_uuid, MIDI_UUID);
+	gatt_db_foreach_service(db, &midi_uuid, foreach_midi_service, midi);
+
+	btd_service_connecting_complete(service, 0);
+
+	return 0;
+
+_err_midi:
+	midi_read_free(&midi->midi_in);
+
+_err_port:
+	snd_seq_delete_simple_port(midi->seq_handle, midi->seq_port_id);
+
+_err_handle:
+	snd_seq_close(midi->seq_handle);
+	midi->seq_handle = NULL;
+
+	btd_service_connecting_complete(service, err);
+
+	return err;
+}
+
+static int midi_disconnect(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct midi *midi;
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("MIDI GATT Driver profile disconnect (%s)", addr);
+
+	midi = btd_service_get_user_data(service);
+	if (!midi) {
+		error("MIDI Service not handled by profile");
+		return -ENODEV;
+	}
+
+	midi_read_free(&midi->midi_in);
+	midi_write_free(&midi->midi_out);
+	io_destroy(midi->io);
+	snd_seq_delete_simple_port(midi->seq_handle, midi->seq_port_id);
+	midi->seq_port_id = 0;
+	snd_seq_close(midi->seq_handle);
+	midi->seq_handle = NULL;
+
+	/* Clean-up any old client/db */
+	bt_gatt_client_unregister_notify(midi->client, midi->io_cb_id);
+	bt_gatt_client_unref(midi->client);
+	gatt_db_unref(midi->db);
+
+	btd_service_disconnecting_complete(service, 0);
+
+	return 0;
+}
+
+static struct btd_profile midi_profile = {
+	.name = "MIDI GATT Driver",
+	.remote_uuid = MIDI_UUID,
+	.priority = BTD_PROFILE_PRIORITY_HIGH,
+	.auto_connect = true,
+
+	.device_probe = midi_device_probe,
+	.device_remove = midi_device_remove,
+
+	.accept = midi_accept,
+
+	.disconnect = midi_disconnect,
+};
+
+static int midi_init(void)
+{
+	return btd_profile_register(&midi_profile);
+}
+
+static void midi_exit(void)
+{
+	btd_profile_unregister(&midi_profile);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(midi, VERSION, BLUETOOTH_PLUGIN_PRIORITY_HIGH,
+                        midi_init, midi_exit);
-- 
2.10.2

