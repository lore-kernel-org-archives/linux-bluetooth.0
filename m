Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ] profiles/midi: Added MIDI over BLE profile
 implementation
To: linux-bluetooth@vger.kernel.org
References: <20161118145944.22266-1-eu@felipetonello.com>
From: Felipe Ferreri Tonello <eu@felipetonello.com>
Message-ID: <f5c20530-bf2e-4cb5-ba1e-bb63114c22f0@felipetonello.com>
Date: Mon, 21 Nov 2016 11:21:50 +0000
MIME-Version: 1.0
In-Reply-To: <20161118145944.22266-1-eu@felipetonello.com>
Content-Type: multipart/mixed;
 boundary="------------BAC222B18FCA2301043D690B"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------BAC222B18FCA2301043D690B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi all,

On 18/11/16 14:59, Felipe F. Tonello wrote:
> This plugin implements the Central roli of MIDI over Bluetooth
> Low-Energy (BLE-MIDI) 1.0 specification as published by MMA in
> November/2015.
> 
> It was implmemented as a bluez plugin because of latency requirements
> of MIDI. There are still room for improvements on this regard.
> 
> Since all parsing and state-machine code is in libmidi.[hc] it should be
> simple to implement Peripheral role as a GATT service as well.
> 
> I have also implemented several unit-tests that can be easily extended
> without adding any code, just use-cases.
> 
> Files added:
>  * profiles/midi/midi.c: Actual GATT plugin
>  * profiles/midi/libmidi.[ch]: MIDI parsers
>  * unit/test-midi.c: Unit-tests
> 
> I will still maintain a personal branch on my github[1] so others can
> contribute there and I can test before sending to bluez.
> 
> This patch adds ALSA dependency since there is no other way of doing it,
> sorry for it. :/ But this can be easily disabled with --disable-alsa
> configure flag.
> 
> I have tested on a normal laptop Arch-linux (x86_64) and a Raspberry Pi 2
> (ARM A8) and it works very well. As I mentioned, the latency can always be
> improved.
> 
> NOTE: the timestamp support is incomplete since ALSA doesn't support the
> way MIDI over BLE expects (asign timestamp to an event without scheduling).
> We are working on ALSA to improve this.
> 
> OBS: I would like to send kudos to ROLI Ltd. which allowed my to work
> on this as part of my full-time job.
> 
> [1] https://github.com/ftonello/bluez/
> ---
>  Makefile.am             |  13 +-
>  Makefile.plugins        |   8 +
>  README                  |   6 +
>  configure.ac            |  10 +
>  profiles/midi/libmidi.c | 391 ++++++++++++++++++++++++++++++++++++++
>  profiles/midi/libmidi.h | 140 ++++++++++++++
>  profiles/midi/midi.c    | 491 ++++++++++++++++++++++++++++++++++++++++++++++++
>  unit/test-midi.c        | 464 +++++++++++++++++++++++++++++++++++++++++++++
>  8 files changed, 1522 insertions(+), 1 deletion(-)
>  create mode 100644 profiles/midi/libmidi.c
>  create mode 100644 profiles/midi/libmidi.h
>  create mode 100644 profiles/midi/midi.c
>  create mode 100644 unit/test-midi.c
> 
> diff --git a/Makefile.am b/Makefile.am
> index c469a6caf83a..c077b2568d5d 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -147,6 +147,7 @@ gobex_sources = gobex/gobex.h gobex/gobex.c \
>  builtin_modules =
>  builtin_sources =
>  builtin_nodist =
> +builtin_ldadd =
>  
>  include Makefile.plugins
>  
> @@ -191,7 +192,8 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
>  src_bluetoothd_LDADD = lib/libbluetooth-internal.la \
>  			gdbus/libgdbus-internal.la \
>  			src/libshared-glib.la \
> -			@BACKTRACE_LIBS@ @GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt
> +			@BACKTRACE_LIBS@ @GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt \
> +			$(builtin_ldadd)
>  src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
>  				-Wl,--version-script=$(srcdir)/src/bluetooth.ver
>  
> @@ -421,6 +423,15 @@ unit_test_gattrib_LDADD = lib/libbluetooth-internal.la \
>  			src/libshared-glib.la \
>  			@GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt
>  
> +if ALSA
> +unit_tests += unit/test-midi
> +unit_test_midi_SOURCES = unit/test-midi.c \
> +			profiles/midi/libmidi.h \
> +			profiles/midi/libmidi.c
> +unit_test_midi_LDADD = src/libshared-glib.la \
> +			@GLIB_LIBS@ @ALSA_LIBS@
> +endif
> +
>  if MAINTAINER_MODE
>  noinst_PROGRAMS += $(unit_tests)
>  endif
> diff --git a/Makefile.plugins b/Makefile.plugins
> index 59342c0cb803..3600f113304c 100644
> --- a/Makefile.plugins
> +++ b/Makefile.plugins
> @@ -95,6 +95,14 @@ builtin_sources += profiles/scanparam/scan.c
>  builtin_modules += deviceinfo
>  builtin_sources += profiles/deviceinfo/deviceinfo.c
>  
> +if ALSA
> +builtin_modules += midi
> +builtin_sources += profiles/midi/midi.c \
> +			profiles/midi/libmidi.h \
> +			profiles/midi/libmidi.c
> +builtin_ldadd += @ALSA_LIBS@
> +endif
> +
>  if SIXAXIS
>  plugin_LTLIBRARIES += plugins/sixaxis.la
>  plugins_sixaxis_la_SOURCES = plugins/sixaxis.c
> diff --git a/README b/README
> index 3ee367092137..e582f1fadfb0 100644
> --- a/README
> +++ b/README
> @@ -13,6 +13,12 @@ Read more about the project at:
>  * http://blog.felipetonello.com/2015/12/14/midi-over-bluetooth-low-energy-on-linux/
>  * https://www.marc.info/?l=linux-bluetooth&m=144368891120651&w=4
>  
> +This branch[1] is under heavy development, so don't assume that things will not
> +break or the histry log will not change, because it will!
> +
> +The idea is that most MIDI related commits will be squashed and cleaned-up.
> +
> +[1] https://github.com/ftonello/bluez/

Please, ignore this README change. I will remove this on v2.

>  
>  Compilation and installation
>  ============================
> diff --git a/configure.ac b/configure.ac
> index 768a20cc5b2b..ffe0dd61c4e5 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -210,8 +210,18 @@ AM_CONDITIONAL(HID2HCI, test "${enable_tools}" != "no" &&
>  
>  AC_ARG_ENABLE(cups, AC_HELP_STRING([--disable-cups],
>                  [disable CUPS printer support]), [enable_cups=${enableval}])
> +if (test "${enable_alsa}" != "no"); then
> +	PKG_CHECK_MODULES(ALSA, alsa, dummy=yes,
> +				AC_MSG_ERROR(ALSA lib is required))
> +	AC_SUBST(ALSA_CFLAGS)
> +	AC_SUBST(ALSA_LIBS)
> +fi
>  AM_CONDITIONAL(CUPS, test "${enable_cups}" != "no")
>  
> +AC_ARG_ENABLE(alsa, AC_HELP_STRING([--disable-alsa],
> +                [disable ALSA MIDI support]), [enable_alsa=${enableval}])
> +AM_CONDITIONAL(ALSA, test "${enable_alsa}" != "no")
> +
>  AC_ARG_ENABLE(obex, AC_HELP_STRING([--disable-obex],
>  		[disable OBEX profile support]), [enable_obex=${enableval}])
>  if (test "${enable_obex}" != "no"); then
> diff --git a/profiles/midi/libmidi.c b/profiles/midi/libmidi.c
> new file mode 100644
> index 000000000000..970fe2b1a300
> --- /dev/null
> +++ b/profiles/midi/libmidi.c
> @@ -0,0 +1,391 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2015,2016 Felipe F. Tonello <eu@felipetonello.com>
> + *  Copyright (C) 2016 ROLI Ltd.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + *
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "libmidi.h"
> +
> +inline static void append_timestamp_high_maybe(struct midi_write_parser *parser)
> +{
> +	if (!midi_write_has_data(parser)) {
> +		guint8 timestamp_high = 0x80;
> +		parser->rtime = g_get_monotonic_time() / 1000; /* convert µs to ms */
> +		timestamp_high |= (parser->rtime & 0x1F80) >> 7;
> +		/* set timestampHigh */
> +		g_byte_array_append(parser->midi_stream, &timestamp_high,
> +		                    sizeof(timestamp_high));
> +	}
> +}
> +
> +inline static void append_timestamp_low(struct midi_write_parser *parser)
> +{
> +	const guint8 timestamp_low = 0x80 | (parser->rtime & 0x7F);
> +	g_byte_array_append(parser->midi_stream, &timestamp_low,
> +	                    sizeof(timestamp_low));
> +}
> +
> +void midi_read_ev(struct midi_write_parser *parser, const snd_seq_event_t *ev,
> +                  midi_read_ev_cb write_cb, gpointer user_data)
> +{
> +	g_assert(write_cb);
> +
> +#define GET_AVAILABLE_SIZE (parser->stream_size - parser->midi_stream->len)
> +
> +	if (GET_AVAILABLE_SIZE == 0) {
> +		write_cb(parser->midi_stream->data, parser->midi_stream->len,
> +		         user_data);
> +		midi_write_reset(parser);
> +	}
> +
> +	append_timestamp_high_maybe(parser);
> +
> +	/* SysEx is special case:
> +	   SysEx has two timestampLow bytes, before F0 and F7
> +	*/
> +	if (ev->type == SND_SEQ_EVENT_SYSEX) {
> +
> +		unsigned int used_sysex = 0;
> +
> +		/* Algorithm:
> +		   1) check initial timestampLow:
> +		       if used_sysex == 0, then tsLow = 1, else tsLow = 0
> +		   2) calculate sysex size of current packet:
> +		   2a) first check special case:
> +		       if midi->out_length - 1 (tsHigh) - tsLow ==
> +		          sysex_length - used_sysex
> +		       size is: min(midi->out_length - 1 - tsLow,
> +		                    sysex_length - used_sysex - 1)
> +		   2b) else size is: min(midi->out_length - 1 - tsLow,
> +		                     sysex_length - used_sysex)
> +		   3) check if packet contains F7: fill respective tsLow byte
> +		*/
> +
> +#define GET_SYSEX_IDX(_i) (((guint8*)ev->data.ext.ptr)[_i])
> +#define GET_DATA_REVERSE_IDX(_i) (parser->midi_stream->data \
> +                                  [parser->midi_stream->len - ((_i) + 1)])
> +
> +		/* We need at least 2 bytes (timestampLow + F0) */
> +		if (GET_AVAILABLE_SIZE < 2) {
> +			/* send current message and start new one */
> +			write_cb(parser->midi_stream->data, parser->midi_stream->len,
> +			         user_data);
> +			midi_write_reset(parser);
> +			append_timestamp_high_maybe(parser);
> +		}
> +
> +		/* timestampLow on initial F0 */
> +		if (GET_SYSEX_IDX(0) == 0xF0)
> +			append_timestamp_low(parser);
> +
> +		do {
> +			unsigned int size_of_sysex;
> +
> +			append_timestamp_high_maybe(parser);
> +
> +			size_of_sysex = MIN(GET_AVAILABLE_SIZE,
> +			                    ev->data.ext.len - used_sysex);
> +
> +			if (GET_AVAILABLE_SIZE == ev->data.ext.len - used_sysex)
> +				size_of_sysex--;
> +
> +			g_byte_array_append(parser->midi_stream,
> +			                    ev->data.ext.ptr + used_sysex,
> +			                    size_of_sysex);
> +			used_sysex += size_of_sysex;
> +
> +			if (GET_AVAILABLE_SIZE <= 1 && GET_DATA_REVERSE_IDX(0) != 0xF7) {
> +				write_cb(parser->midi_stream->data, parser->midi_stream->len,
> +				         user_data);
> +				midi_write_reset(parser);
> +			}
> +		} while (used_sysex < ev->data.ext.len);
> +
> +		/* check for F7 and update respective timestampLow byte */
> +		if (GET_DATA_REVERSE_IDX(0) == 0xF7) {
> +			guint8 tmp;
> +			append_timestamp_low(parser);
> +			tmp = GET_DATA_REVERSE_IDX(0);
> +			GET_DATA_REVERSE_IDX(0) = 0xF7;
> +			GET_DATA_REVERSE_IDX(1) = tmp;
> +		}
> +
> +#undef GET_DATA_REVERSE_IDX
> +#undef GET_SYSEX_IDX
> +
> +	} else {
> +		int length;
> +
> +		/* check for running status */
> +		if (parser->rstate != ev->type) {
> +			snd_midi_event_reset_decode(parser->midi_ev);
> +			append_timestamp_low(parser);
> +		}
> +
> +		/* each midi message has timestampLow byte to follow */
> +		length = snd_midi_event_decode(parser->midi_ev,
> +		                               parser->midi_stream->data +
> +		                               parser->midi_stream->len,
> +		                               GET_AVAILABLE_SIZE,
> +		                               ev);
> +
> +		if (length == -ENOMEM) {
> +			/* remove previously added timestampLow */
> +			g_byte_array_remove_index_fast(parser->midi_stream,
> +			                               parser->midi_stream->len -1);
> +			write_cb(parser->midi_stream->data, parser->midi_stream->len,
> +			         user_data);
> +			/* cleanup state for next packet */
> +			snd_midi_event_reset_decode(parser->midi_ev);
> +			midi_write_reset(parser);
> +			append_timestamp_high_maybe(parser);
> +			append_timestamp_low(parser);
> +			length = snd_midi_event_decode(parser->midi_ev,
> +			                               parser->midi_stream->data +
> +			                               parser->midi_stream->len,
> +			                               GET_AVAILABLE_SIZE,
> +			                               ev);
> +		}
> +
> +		if (length > 0)
> +			parser->midi_stream->len += length;
> +	}
> +
> +	parser->rstate = ev->type;
> +
> +	if (GET_AVAILABLE_SIZE <= 1) {
> +		write_cb(parser->midi_stream->data, parser->midi_stream->len,
> +		         user_data);
> +		midi_write_reset(parser);
> +	}
> +#undef GET_AVAILABLE_SIZE
> +}
> +
> +static void update_ev_timestamp(struct midi_read_parser *parser, snd_seq_event_t *ev,
> +                                guint16 timestamp)
> +{
> +	int delta_timestamp;
> +	int delta_rtime;
> +	gint64 rtime_current;
> +
> +	rtime_current = g_get_monotonic_time() / 1000; /* convert µs to ms */
> +	delta_timestamp = timestamp - (int)parser->timestamp;
> +	delta_rtime = rtime_current - parser->rtime;
> +
> +	if (delta_rtime > MIDI_MAX_TIMESTAMP)
> +		parser->rtime = rtime_current;
> +	else {
> +
> +		/* If delta_timestamp is way to big than delta_rtime,
> +		   this means that the device sent a message in the past,
> +		   so we have to compensate for this. */
> +		if (delta_timestamp > 7000 && delta_rtime < 1000)
> +			delta_timestamp = 0;
> +
> +		/* check if timestamp did overflow */
> +		if (delta_timestamp < 0) {
> +			/* same timestamp in the past problem */
> +			if ((delta_timestamp + MIDI_MAX_TIMESTAMP) > 7000 &&
> +			    delta_rtime < 1000)
> +				delta_timestamp = 0;
> +			else
> +				delta_timestamp = delta_timestamp + MIDI_MAX_TIMESTAMP;
> +		}
> +
> +		parser->rtime += delta_timestamp;
> +	}
> +
> +	parser->timestamp += delta_timestamp;
> +	if (parser->timestamp > MIDI_MAX_TIMESTAMP)
> +		parser->timestamp %= MIDI_MAX_TIMESTAMP + 1;
> +
> +	/* set event timestamp */
> +	/* TODO: update event timestamp here! */
> +}
> +
> +gsize midi_read_raw(struct midi_read_parser *parser, const guint8 *data,
> +                    gsize size, snd_seq_event_t *ev /* OUT */)
> +{
> +	guint8 midi_size = 0;
> +	gsize i = 0;
> +	gboolean err = FALSE;
> +	guint8 time_low = 0;
> +
> +	if (parser->timestamp_high == 0)
> +		parser->timestamp_high = data[i++] & 0x3F;
> +
> +	snd_midi_event_reset_encode(parser->midi_ev);
> +
> +	/* timestamp byte */
> +	if (data[i] & 0x80) {
> +
> +		guint8 time_low_tmp = data[i] & 0x7F;
> +
> +		/* time_low overwflow results on time_high to increment by one */
> +		if (parser->timestamp_low > time_low_tmp)
> +			parser->timestamp_high++;
> +
> +		parser->timestamp_low = time_low_tmp;
> +
> +		update_ev_timestamp(parser, ev, (parser->timestamp_high << 7) | time_low);
> +
> +		/* check for wrong BLE-MIDI message size */
> +		if (++i == size) {
> +			err = TRUE;
> +			goto _finish;
> +		}
> +	}
> +
> +	/* cleanup sysex_stream if message is broken or is a new SysEx */
> +	if (data[i] >= 0x80 && data[i] != 0xF7 && parser->sysex_stream->len > 0) {
> +		g_byte_array_remove_range(parser->sysex_stream,
> +		                          0,
> +		                          parser->sysex_stream->len);
> +	}
> +
> +	switch (data[i]) {
> +	case 0xF8 ... 0XFF:
> +		/* System Real-Time Messages */
> +		midi_size = 1;
> +		break;
> +
> +		/* System Common Messages */
> +	case 0xF0: /* SysEx Start */ {
> +		guint8 *pos;
> +
> +		/* Avoid parsing if SysEx is contained in one BLE packet */
> +		if ((pos = memchr(data + i, 0xF7, size - i))) {
> +			const gsize sysex_length = pos - (data + i);
> +
> +			g_byte_array_append(parser->sysex_stream, data + i, sysex_length);
> +
> +			time_low = parser->sysex_stream->data[sysex_length - 1] & 0x7F;
> +			/* Remove timestamp byte */
> +			parser->sysex_stream->data[sysex_length - 1] = 0xF7;
> +			update_ev_timestamp(parser, ev,
> +			                    (parser->timestamp_high << 7) | time_low);
> +			snd_seq_ev_set_sysex(ev, parser->sysex_stream->len,
> +			                     parser->sysex_stream->data);
> +
> +			midi_size = sysex_length + 1; /* +1 because of timestampLow */
> +		} else {
> +			g_byte_array_append(parser->sysex_stream, data + i, size - i);
> +			err = TRUE; /* Not an actual error, just incomplete message */
> +			midi_size = size - i;
> +		}
> +
> +		goto _finish;
> +	}
> +
> +	case 0xF1:
> +	case 0xF3:
> +		midi_size = 2;
> +		break;
> +	case 0xF2:
> +		midi_size = 3;
> +		break;
> +	case 0xF4:
> +	case 0xF5: /* Ignore */
> +		i++;
> +		err = TRUE;
> +		goto _finish;
> +		break;
> +	case 0xF6:
> +		midi_size = 1;
> +		break;
> +	case 0xF7: /* SysEx End */
> +		g_byte_array_append(parser->sysex_stream, data + i, 1);
> +		snd_seq_ev_set_sysex(ev, parser->sysex_stream->len,
> +		                     parser->sysex_stream->data);
> +
> +		midi_size = 1; /* timestampLow was alredy processed */
> +		goto _finish;
> +
> +	case 0x80 ... 0xEF:
> +		/*
> +		 * Channel Voice Messages, Channel Mode Messages
> +		 * and Control Change Messages.
> +		 */
> +		parser->rstatus = data[i];
> +		midi_size = (data[i] >= 0xC0 && data[i] <= 0xDF) ? 2 : 3;
> +		break;
> +
> +	case 0x00 ... 0x7F:
> +
> +		/* Check for SysEx messages */
> +		if (parser->sysex_stream->len > 0) {
> +			guint8 *pos;
> +
> +			if ((pos = memchr(data + i, 0xF7, size - i))) {
> +				const gsize sysex_length = pos - (data + i);
> +
> +				g_byte_array_append(parser->sysex_stream, data + i, sysex_length);
> +
> +#define GET_DATA_REVERSE_IDX(_i) (parser->sysex_stream->data \
> +                                  [parser->sysex_stream->len - ((_i) + 1)])
> +
> +				time_low = GET_DATA_REVERSE_IDX(0) & 0x7F;
> +				/* Remove timestamp byte */
> +				GET_DATA_REVERSE_IDX(0) = 0xF7;
> +				update_ev_timestamp(parser, ev,
> +				                    (parser->timestamp_high << 7) | time_low);
> +				snd_seq_ev_set_sysex(ev, parser->sysex_stream->len,
> +				                     parser->sysex_stream->data);
> +
> +#undef GET_DATA_REVERSE_IDX
> +
> +				midi_size = sysex_length + 1; /* +1 because of timestampLow */
> +			} else {
> +				g_byte_array_append(parser->sysex_stream, data + i, size - i);
> +				err = TRUE; /* Not an actual error, just incomplete message */
> +				midi_size = size - i;
> +			}
> +
> +			goto _finish;
> +		}
> +
> +		/* Running State Message */
> +		if (parser->rstatus == 0) {
> +			midi_size = 1;
> +			err = TRUE;
> +			goto _finish;
> +		}
> +
> +		snd_midi_event_encode_byte(parser->midi_ev, parser->rstatus, ev);
> +		midi_size = (parser->rstatus >= 0xC0 && parser->rstatus <= 0xDF) ? 1 : 2;
> +		break;
> +	}
> +
> +	if ((i + midi_size) > size) {
> +		err = TRUE;
> +		goto _finish;
> +	}
> +
> +	snd_midi_event_encode(parser->midi_ev, data + i, midi_size, ev);
> +
> +_finish:
> +	if (err)
> +		ev->type = SND_SEQ_EVENT_NONE;
> +
> +	return i + midi_size;
> +}
> diff --git a/profiles/midi/libmidi.h b/profiles/midi/libmidi.h
> new file mode 100644
> index 000000000000..cc6e13f6c44a
> --- /dev/null
> +++ b/profiles/midi/libmidi.h
> @@ -0,0 +1,140 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2015,2016 Felipe F. Tonello <eu@felipetonello.com>
> + *  Copyright (C) 2016 ROLI Ltd.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + *
> + */
> +
> +#ifndef LIBMIDI_H
> +#define LIBMIDI_H
> +
> +#include <glib.h>
> +#include <alsa/asoundlib.h>
> +
> +#define MIDI_MAX_TIMESTAMP 8191
> +#define MIDI_MSG_MAX_SIZE 12
> +#define MIDI_SYSEX_MAX_SIZE (4 * 1024)
> +
> +/* MIDI I/O Write parser */
> +
> +struct midi_write_parser {
> +	gint64 rtime;                /* last writer's real time */
> +	snd_seq_event_type_t rstate; /* running status event type */
> +	GByteArray *midi_stream;     /* MIDI I/O byte stream */
> +	gsize stream_size;           /* what is the maximum size of the midi_stream array */
> +	snd_midi_event_t *midi_ev;   /* midi<->seq event */
> +};
> +
> +static inline int midi_write_init(struct midi_write_parser *parser, gsize buffer_size)
> +{
> +	parser->rtime = 0;
> +	parser->rstate = SND_SEQ_EVENT_NONE;
> +	parser->stream_size = buffer_size;
> +
> +	parser->midi_stream = g_byte_array_sized_new(buffer_size);
> +	if (!parser->midi_stream)
> +		return -ENOMEM;
> +
> +	return snd_midi_event_new(buffer_size, &parser->midi_ev);
> +}
> +
> +static inline void midi_write_free(struct midi_write_parser *parser)
> +{
> +	g_byte_array_free(parser->midi_stream, TRUE);
> +	snd_midi_event_free(parser->midi_ev);
> +}
> +
> +static inline void midi_write_reset(struct midi_write_parser *parser)
> +{
> +	parser->rstate = SND_SEQ_EVENT_NONE;
> +	g_byte_array_remove_range(parser->midi_stream, 0, parser->midi_stream->len);
> +}
> +
> +static inline gboolean midi_write_has_data(struct midi_write_parser *parser)
> +{
> +	return parser->midi_stream->len > 0;
> +}
> +
> +static inline const guint8 * midi_write_data(struct midi_write_parser *parser)
> +{
> +	return parser->midi_stream->data;
> +}
> +
> +static inline guint midi_write_data_size(struct midi_write_parser *parser)
> +{
> +	return parser->midi_stream->len;
> +}
> +
> +typedef void (*midi_read_ev_cb)(const guint8 *, guint, gpointer);
> +
> +/* It creates BLE-MIDI raw packets from the a sequencer event. If the packet
> +   is full, then it calls write_cb and resets its internal state as many times
> +   as necessary.
> + */
> +void midi_read_ev(struct midi_write_parser *parser, const snd_seq_event_t *ev,
> +                  midi_read_ev_cb write_cb, gpointer user_data);
> +
> +/* MIDI I/O Read parser */
> +
> +struct midi_read_parser {
> +	guint8 rstatus;            /* running status byte */
> +	gint64 rtime;              /* last reader's real time */
> +	gint16 timestamp;          /* last MIDI-BLE timestamp */
> +	gint8 timestamp_low;       /* MIDI-BLE timestampLow from the current packet */
> +	gint8 timestamp_high;      /* MIDI-BLE timestampHigh from the current packet */
> +	GByteArray *sysex_stream;  /* SysEx stream */
> +	snd_midi_event_t *midi_ev; /* midi<->seq event */
> +};
> +
> +static inline int midi_read_init(struct midi_read_parser *parser)
> +{
> +	parser->rstatus = 0;
> +	parser->rtime = -1;
> +	parser->timestamp = 0;
> +	parser->timestamp_low = 0;
> +	parser->timestamp_high = 0;
> +
> +	parser->sysex_stream = g_byte_array_sized_new(MIDI_SYSEX_MAX_SIZE);
> +	if (!parser->sysex_stream)
> +		return -ENOMEM;
> +
> +	return snd_midi_event_new(MIDI_MSG_MAX_SIZE, &parser->midi_ev);
> +}
> +
> +static inline void midi_read_free(struct midi_read_parser *parser)
> +{
> +	g_byte_array_free(parser->sysex_stream, TRUE);
> +	snd_midi_event_free(parser->midi_ev);
> +}
> +
> +static inline void midi_read_reset(struct midi_read_parser *parser)
> +{
> +	parser->rstatus = 0;
> +	parser->timestamp_low = 0;
> +	parser->timestamp_high = 0;
> +}
> +
> +/* Parses raw BLE-MIDI messages and populates a sequencer event representing the
> +   current MIDI message. It returns how much raw data was processed.
> + */
> +gsize midi_read_raw(struct midi_read_parser *parser, const guint8 *data, gsize size,
> +                    snd_seq_event_t *ev /* OUT */);
> +
> +#endif /* LIBMIDI_H */
> diff --git a/profiles/midi/midi.c b/profiles/midi/midi.c
> new file mode 100644
> index 000000000000..403fe5f02191
> --- /dev/null
> +++ b/profiles/midi/midi.c
> @@ -0,0 +1,491 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2015,2016 Felipe F. Tonello <eu@felipetonello.com>
> + *  Copyright (C) 2016 ROLI Ltd.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + *  Information about this plugin:
> + *
> + *  This plugin implements the MIDI over Bluetooth Low-Energy (BLE-MIDI) 1.0
> + *  specification as published by MMA in November/2015.
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <glib.h>
> +#include <alsa/asoundlib.h>
> +
> +#include "lib/bluetooth.h"
> +#include "lib/sdp.h"
> +#include "lib/uuid.h"
> +
> +#include "src/plugin.h"
> +#include "src/adapter.h"
> +#include "src/device.h"
> +#include "src/profile.h"
> +#include "src/service.h"
> +#include "src/shared/util.h"
> +#include "src/shared/att.h"
> +#include "src/shared/queue.h"
> +#include "src/shared/gatt-db.h"
> +#include "src/shared/gatt-client.h"
> +#include "src/shared/io.h"
> +#include "src/log.h"
> +#include "attrib/att.h"
> +
> +#include "libmidi.h"
> +
> +#define MIDI_UUID "03B80E5A-EDE8-4B33-A751-6CE34EC4C700"
> +#define MIDI_IO_UUID "7772E5DB-3868-4112-A1A9-F2669D106BF3"
> +
> +struct midi {
> +	struct btd_device *dev;
> +	struct gatt_db *db;
> +	struct bt_gatt_client *client;
> +	guint io_cb_id;
> +	struct io *io;
> +	uint16_t midi_io_handle;
> +
> +	/* ALSA handlers */
> +	snd_seq_t *seq_handle;
> +	int seq_client_id;
> +	int seq_port_id;
> +
> +	/* MIDI parser*/
> +	struct midi_read_parser midi_in;
> +	struct midi_write_parser midi_out;
> +};
> +
> +static bool midi_write_cb(struct io *io, gpointer user_data)
> +{
> +	struct midi *midi = user_data;
> +	int err;
> +
> +	void foreach_cb(const guint8 *data, guint size, gpointer user_data) {
> +		struct midi *midi = user_data;
> +		bt_gatt_client_write_without_response(midi->client,
> +		                                      midi->midi_io_handle,
> +		                                      false,
> +		                                      data,
> +		                                      size);
> +	};
> +
> +	do {
> +		snd_seq_event_t *event = NULL;
> +
> +		err = snd_seq_event_input(midi->seq_handle, &event);
> +
> +		if (err < 0 || !event)
> +			break;
> +
> +		midi_read_ev(&midi->midi_out, event, foreach_cb, midi);
> +
> +	} while (err > 0);
> +
> +	if (midi_write_has_data(&midi->midi_out))
> +		bt_gatt_client_write_without_response(midi->client,
> +		                                      midi->midi_io_handle,
> +		                                      false,
> +		                                      midi_write_data(&midi->midi_out),
> +		                                      midi_write_data_size(&midi->midi_out));
> +
> +	midi_write_reset(&midi->midi_out);
> +
> +	return true;
> +}
> +
> +static void midi_io_value_cb(uint16_t value_handle, const uint8_t *value,
> +                             uint16_t length, gpointer user_data)
> +{
> +	struct midi *midi = user_data;
> +	snd_seq_event_t ev;
> +	guint i = 0;
> +
> +	if (length < 3) {
> +		warn("MIDI I/O: Wrong packet format: length is %u bytes but it should "
> +		     "be at least 3 bytes", length);
> +		return;
> +	}
> +
> +	snd_seq_ev_clear(&ev);
> +	snd_seq_ev_set_source(&ev, midi->seq_port_id);
> +	snd_seq_ev_set_subs(&ev);
> +	snd_seq_ev_set_direct(&ev);
> +
> +	midi_read_reset(&midi->midi_in);
> +
> +	while (i < length) {
> +		gsize count = midi_read_raw(&midi->midi_in, value + i, length - i, &ev);
> +
> +		if (count == 0)
> +			goto _err;
> +
> +		if (ev.type != SND_SEQ_EVENT_NONE)
> +			snd_seq_event_output_direct(midi->seq_handle, &ev);
> +
> +		i += count;
> +	}
> +
> +	return;
> +
> +_err:
> +	error("Wrong BLE-MIDI message");
> +}
> +
> +static void midi_io_ccc_written_cb(uint16_t att_ecode, gpointer user_data)
> +{
> +	if (att_ecode != 0) {
> +		error("MIDI I/O: notifications not enabled %s",
> +		      att_ecode2str(att_ecode));
> +		return;
> +	}
> +
> +	DBG("MIDI I/O: notification enabled");
> +}
> +
> +static void midi_io_initial_read_cb(bool success, uint8_t att_ecode,
> +                                    const uint8_t *value, uint16_t length,
> +                                    gpointer user_data)
> +{
> +	struct midi *midi = user_data;
> +
> +	if (!success) {
> +		error("MIDI I/O: Failed to read initial request");
> +		return;
> +	}
> +
> +	/* request notify */
> +	midi->io_cb_id =
> +		bt_gatt_client_register_notify(midi->client,
> +		                               midi->midi_io_handle,
> +		                               midi_io_ccc_written_cb,
> +		                               midi_io_value_cb,
> +		                               midi,
> +		                               NULL);
> +
> +}
> +
> +static void handle_midi_io(struct midi *midi, uint16_t value_handle)
> +{
> +	DBG("MIDI I/O handle: 0x%04x", value_handle);
> +
> +	midi->midi_io_handle = value_handle;
> +
> +	/*
> +	 * The BLE-MIDI 1.0 spec specifies that The Centrail shall attempt to
> +	 * read the MIDI I/O characteristic of the Peripheral right after
> +	 * estrablhishing a connection with the accessory.
> +	 */
> +	if (!bt_gatt_client_read_value(midi->client,
> +	                               value_handle,
> +	                               midi_io_initial_read_cb,
> +	                               midi,
> +	                               NULL))
> +		DBG("MIDI I/O: Failed to send request to read initial value");
> +}
> +
> +static void handle_characteristic(struct gatt_db_attribute *attr,
> +                                  gpointer user_data)
> +{
> +	struct midi *midi = user_data;
> +	uint16_t value_handle;
> +	bt_uuid_t uuid, midi_io_uuid;
> +
> +	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle, NULL,
> +	                                     NULL, &uuid)) {
> +		error("Failed to obtain characteristic data");
> +		return;
> +	}
> +
> +	bt_string_to_uuid(&midi_io_uuid, MIDI_IO_UUID);
> +
> +	if (bt_uuid_cmp(&midi_io_uuid, &uuid) == 0)
> +		handle_midi_io(midi, value_handle);
> +	else {
> +		char uuid_str[MAX_LEN_UUID_STR];
> +
> +		bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
> +		DBG("Unsupported characteristic: %s", uuid_str);
> +	}
> +}
> +
> +static void foreach_midi_service(struct gatt_db_attribute *attr,
> +                                 gpointer user_data)
> +{
> +	struct midi *midi = user_data;
> +
> +	gatt_db_service_foreach_char(attr, handle_characteristic, midi);
> +}
> +
> +static int midi_device_probe(struct btd_service *service)
> +{
> +	struct btd_device *device = btd_service_get_device(service);
> +	struct midi *midi;
> +	char addr[18];
> +
> +	ba2str(device_get_address(device), addr);
> +	DBG("MIDI GATT Driver profile probe (%s)", addr);
> +
> +	/* Ignore, if we were probed for this device already */
> +	midi = btd_service_get_user_data(service);
> +	if (midi) {
> +		error("Profile probed twice for the same device!");
> +		return -EADDRINUSE;
> +	}
> +
> +	midi = g_new0(struct midi, 1);
> +	if (!midi)
> +		return -ENOMEM;
> +
> +	midi->dev = btd_device_ref(device);
> +
> +	btd_service_set_user_data(service, midi);
> +
> +	return 0;
> +}
> +
> +static void midi_device_remove(struct btd_service *service)
> +{
> +	struct btd_device *device = btd_service_get_device(service);
> +	struct midi *midi;
> +	char addr[18];
> +
> +	ba2str(device_get_address(device), addr);
> +	DBG("MIDI GATT Driver profile remove (%s)", addr);
> +
> +	midi = btd_service_get_user_data(service);
> +	if (!midi) {
> +		error("MIDI Service not handled by profile");
> +		return;
> +	}
> +
> +	btd_device_unref(midi->dev);
> +	g_free(midi);
> +}
> +
> +static int midi_accept(struct btd_service *service)
> +{
> +	struct btd_device *device = btd_service_get_device(service);
> +	struct gatt_db *db = btd_device_get_gatt_db(device);
> +	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
> +	bt_uuid_t midi_uuid;
> +	struct pollfd pfd;
> +	struct midi *midi;
> +	char addr[18];
> +	char port_name[MAX_NAME_LENGTH];
> +	int err;
> +	snd_seq_client_info_t *info;
> +
> +	ba2str(device_get_address(device), addr);
> +	DBG("MIDI GATT Driver profile accept (%s)", addr);
> +
> +	midi = btd_service_get_user_data(service);
> +	if (!midi) {
> +		error("MIDI Service not handled by profile");
> +		return -ENODEV;
> +	}
> +
> +	/* Port Name */
> +	memset(port_name, 0, sizeof(port_name));
> +	if (device_name_known(device))
> +		device_get_name(device, port_name, sizeof(port_name));
> +	else
> +		strncpy(port_name, addr, sizeof(addr));
> +
> +	/* ALSA Sequencer Client and Port Setup */
> +	err = snd_seq_open(&midi->seq_handle, "default", SND_SEQ_OPEN_DUPLEX, 0);
> +	if (err < 0) {
> +		error("Could not open ALSA Sequencer: %s (%d)", snd_strerror(err), err);
> +		return err;
> +	}
> +
> +	err = snd_seq_nonblock(midi->seq_handle, SND_SEQ_NONBLOCK);
> +	if (err < 0) {
> +		error("Could not set nonblock mode: %s (%d)", snd_strerror(err), err);
> +		goto _err_handle;
> +	}
> +
> +	err = snd_seq_set_client_name(midi->seq_handle, port_name);
> +	if (err < 0) {
> +		error("Could not configure ALSA client: %s (%d)", snd_strerror(err), err);
> +		goto _err_handle;
> +	}
> +
> +	err = snd_seq_client_id(midi->seq_handle);
> +	if (err < 0) {
> +		error("Could retreive ALSA client: %s (%d)", snd_strerror(err), err);
> +		goto _err_handle;
> +	}
> +	midi->seq_client_id = err;
> +
> +	err = snd_seq_create_simple_port(midi->seq_handle, port_name,
> +	                                 SND_SEQ_PORT_CAP_READ |
> +	                                 SND_SEQ_PORT_CAP_WRITE |
> +	                                 SND_SEQ_PORT_CAP_SUBS_READ |
> +	                                 SND_SEQ_PORT_CAP_SUBS_WRITE,
> +	                                 SND_SEQ_PORT_TYPE_MIDI_GENERIC |
> +	                                 SND_SEQ_PORT_TYPE_HARDWARE);
> +	if (err < 0) {
> +		error("Could not create ALSA port: %s (%d)", snd_strerror(err), err);
> +		goto _err_handle;
> +	}
> +	midi->seq_port_id = err;
> +
> +	snd_seq_client_info_alloca(&info);
> +	err = snd_seq_get_client_info(midi->seq_handle, info);
> +	if (err < 0)
> +		goto _err_port;
> +
> +	/* list of relevant sequencer events */
> +	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_NOTEOFF);
> +	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_NOTEON);
> +	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_KEYPRESS);
> +	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_CONTROLLER);
> +	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_PGMCHANGE);
> +	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_CHANPRESS);
> +	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_PITCHBEND);
> +	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_SYSEX);
> +	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_QFRAME);
> +	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_SONGPOS);
> +	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_SONGSEL);
> +	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_TUNE_REQUEST);
> +	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_CLOCK);
> +	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_START);
> +	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_CONTINUE);
> +	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_STOP);
> +	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_SENSING);
> +	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_RESET);
> +	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_CONTROL14);
> +	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_NONREGPARAM);
> +	snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_REGPARAM);
> +
> +	err = snd_seq_set_client_info(midi->seq_handle, info);
> +	if (err < 0)
> +		goto _err_port;
> +
> +
> +	/* Input file descriptors */
> +	snd_seq_poll_descriptors(midi->seq_handle, &pfd, 1, POLLIN);
> +
> +	midi->io = io_new(pfd.fd);
> +	if (!midi->io) {
> +		error("Could not allocate I/O eventloop");
> +		goto _err_port;
> +	}
> +
> +	io_set_read_handler(midi->io, midi_write_cb, midi, NULL);
> +
> +	midi->db = gatt_db_ref(db);
> +	midi->client = bt_gatt_client_ref(client);
> +
> +	err = midi_read_init(&midi->midi_in);
> +	if (err < 0) {
> +		error("Could not initialise MIDI input parser");
> +		goto _err_port;
> +	}
> +
> +	err = midi_write_init(&midi->midi_out, bt_gatt_client_get_mtu(midi->client) - 3);
> +	if (err < 0) {
> +		error("Could not initialise MIDI output parser");
> +		goto _err_midi;
> +	}
> +
> +	bt_string_to_uuid(&midi_uuid, MIDI_UUID);
> +	gatt_db_foreach_service(db, &midi_uuid, foreach_midi_service, midi);
> +
> +	btd_service_connecting_complete(service, 0);
> +
> +	return 0;
> +
> +_err_midi:
> +	midi_read_free(&midi->midi_in);
> +
> +_err_port:
> +	snd_seq_delete_simple_port(midi->seq_handle, midi->seq_port_id);
> +
> +_err_handle:
> +	snd_seq_close(midi->seq_handle);
> +	midi->seq_handle = NULL;
> +
> +	return err;
> +}
> +
> +static int midi_disconnect(struct btd_service *service)
> +{
> +	struct btd_device *device = btd_service_get_device(service);
> +	struct midi *midi;
> +	char addr[18];
> +
> +	ba2str(device_get_address(device), addr);
> +	DBG("MIDI GATT Driver profile disconnect (%s)", addr);
> +
> +	midi = btd_service_get_user_data(service);
> +	if (!midi) {
> +		error("MIDI Service not handled by profile");
> +		return -ENODEV;
> +	}
> +
> +	midi_read_free(&midi->midi_in);
> +	midi_write_free(&midi->midi_out);
> +	io_destroy(midi->io);
> +	snd_seq_delete_simple_port(midi->seq_handle, midi->seq_port_id);
> +	midi->seq_port_id = 0;
> +	snd_seq_close(midi->seq_handle);
> +	midi->seq_handle = NULL;
> +
> +	/* Clean-up any old client/db */
> +	bt_gatt_client_unregister_notify(midi->client, midi->io_cb_id);
> +	bt_gatt_client_unref(midi->client);
> +	gatt_db_unref(midi->db);
> +
> +	btd_service_disconnecting_complete(service, 0);
> +
> +	return 0;
> +}
> +
> +static struct btd_profile midi_profile = {
> +	.name = "MIDI GATT Driver",
> +	.remote_uuid = MIDI_UUID,
> +	.priority = BTD_PROFILE_PRIORITY_HIGH,
> +	.auto_connect = true,
> +
> +	.device_probe = midi_device_probe,
> +	.device_remove = midi_device_remove,
> +
> +	.accept = midi_accept,
> +
> +	.disconnect = midi_disconnect,
> +};
> +
> +static int midi_init(void)
> +{
> +	return btd_profile_register(&midi_profile);
> +}
> +
> +static void midi_exit(void)
> +{
> +	btd_profile_unregister(&midi_profile);
> +}
> +
> +BLUETOOTH_PLUGIN_DEFINE(midi, VERSION, BLUETOOTH_PLUGIN_PRIORITY_HIGH,
> +                        midi_init, midi_exit);
> diff --git a/unit/test-midi.c b/unit/test-midi.c
> new file mode 100644
> index 000000000000..f786c767d7df
> --- /dev/null
> +++ b/unit/test-midi.c
> @@ -0,0 +1,464 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2015,2016 Felipe F. Tonello <eu@felipetonello.com>
> + *  Copyright (C) 2016 ROLI Ltd.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define NUM_WRITE_TESTS 10
> +
> +#include "src/shared/tester.h"
> +#include "profiles/midi/libmidi.h"
> +
> +struct ble_midi_packet {
> +	const guint8 *data;
> +	gsize size;
> +};
> +
> +#define BLE_MIDI_PACKET_INIT(_packet) \
> +	{ \
> +		.data = _packet, \
> +		.size = sizeof(_packet), \
> +	}
> +
> +struct midi_read_test {
> +	const struct ble_midi_packet *ble_packet;
> +	gsize ble_packet_size;
> +	const snd_seq_event_t *event;
> +	gsize event_size;
> +};
> +
> +#define BLE_READ_TEST_INIT(_ble_packet, _event) \
> +	{ \
> +		.ble_packet = _ble_packet, \
> +		.ble_packet_size = G_N_ELEMENTS(_ble_packet), \
> +		.event = _event, \
> +		.event_size = G_N_ELEMENTS(_event), \
> +	}
> +
> +struct midi_write_test {
> +	const snd_seq_event_t *event;
> +	gsize event_size;
> +};
> +
> +#define BLE_WRITE_TEST_INIT(_event) \
> +	{ \
> +		.event = _event, \
> +		.event_size = G_N_ELEMENTS(_event), \
> +	}
> +
> +
> +#define NOTE_EVENT(_event, _channel, _note, _velocity) \
> +	{ \
> +		.type = SND_SEQ_EVENT_##_event, \
> +		.data = { \
> +			.note = { \
> +				.channel = (_channel), \
> +				.note = (_note), \
> +				.velocity = (_velocity), \
> +			}, \
> +		}, \
> +	}
> +
> +#define CONTROL_EVENT(_event, _channel, _value, _param) \
> +	{ \
> +		.type = SND_SEQ_EVENT_##_event, \
> +		.data = { \
> +			.control = { \
> +				.channel = (_channel), \
> +				.value = (_value), \
> +				.param = (_param), \
> +			}, \
> +		}, \
> +	}
> +
> +#define SYSEX_EVENT(_message) \
> +	{ \
> +		.type = SND_SEQ_EVENT_SYSEX, \
> +		.data = { \
> +			.ext = { \
> +				.ptr = (void *)_message, \
> +				.len = sizeof(_message), \
> +			}, \
> +		}, \
> +	}
> +
> +/* Multiple messages in one packet */
> +static const guint8 packet1_1[] = {
> +	0xa6, 0x88, 0xe8, 0x00, 0x40, 0x88, 0xb8, 0x4a,
> +	0x3f, 0x88, 0x98, 0x3e, 0x0e
> +};
> +
> +/* Several one message per packet */
> +static const guint8 packet1_2[] = {
> +	0xa6, 0xaa, 0xd8, 0x71
> +};
> +
> +static const guint8 packet1_3[] = {
> +	0xa6, 0xb7, 0xb8, 0x4a, 0x43
> +};
> +
> +/* This message contains a running status message */
> +static const guint8 packet1_4[] = {
> +	0xa6, 0xc4, 0xe8, 0x7e, 0x3f, 0x7d, 0x3f, 0xc4,
> +	0x7c, 0x3f
> +};
> +
> +/* This message contain a running status message misplaced */
> +static const guint8 packet1_5[] = {
> +	0xa6, 0xd9, 0x3e, 0x00, 0x88, 0x3e, 0x00
> +};
> +
> +static const struct ble_midi_packet packet1[] = {
> +	BLE_MIDI_PACKET_INIT(packet1_1),
> +	BLE_MIDI_PACKET_INIT(packet1_2),
> +	BLE_MIDI_PACKET_INIT(packet1_3),
> +	BLE_MIDI_PACKET_INIT(packet1_4),
> +	BLE_MIDI_PACKET_INIT(packet1_5),
> +};
> +
> +static const snd_seq_event_t event1[] = {
> +	CONTROL_EVENT(PITCHBEND, 8, 0, 0),    /* Pitch Bend */
> +	CONTROL_EVENT(CONTROLLER, 8, 63, 74), /* Control Change */
> +	NOTE_EVENT(NOTEON, 8, 62, 14),        /* Note On */
> +	CONTROL_EVENT(CHANPRESS, 8, 113, 0),  /* Channel Aftertouch */
> +	CONTROL_EVENT(CONTROLLER, 8, 67, 74), /* Control Change*/
> +	CONTROL_EVENT(PITCHBEND, 8, -2, 0),   /* Pitch Bend */
> +	CONTROL_EVENT(PITCHBEND, 8, -3, 0),   /* Pitch Bend */
> +	CONTROL_EVENT(PITCHBEND, 8, -4, 0),   /* Pitch Bend */
> +	NOTE_EVENT(NOTEOFF, 8, 62, 0),        /* Note Off */
> +};
> +
> +static const struct midi_read_test midi1 = BLE_READ_TEST_INIT(packet1, event1);
> +
> +/* Basic SysEx in one packet */
> +static const guint8 packet2_1[] = {
> +	0xa6, 0xda, 0xf0, 0x01, 0x02, 0x03, 0xda, 0xf7
> +};
> +
> +/* SysEx across two packets */
> +static const guint8 packet2_2[] = {
> +	0xa6, 0xda, 0xf0, 0x01, 0x02, 0x03, 0x04, 0x05
> +};
> +
> +static const guint8 packet2_3[] = {
> +	0xa6, 0x06, 0x07, 0x08, 0x09, 0x0a, 0xdb, 0xf7
> +};
> +
> +/* SysEx across multiple packets */
> +static const guint8 packet2_4[] = {
> +	0xa6, 0xda, 0xf0, 0x01, 0x02, 0x03, 0x04, 0x05
> +};
> +
> +static const guint8 packet2_5[] = {
> +	0xa6, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c
> +};
> +static const guint8 packet2_6[] = {
> +	0xa6, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13
> +};
> +
> +static const guint8 packet2_7[] = {
> +	0xa6, 0x14, 0x15, 0x16, 0x17, 0x18, 0xdb, 0xf7
> +};
> +
> +/* Two SysEx interleaved in two packets */
> +static const guint8 packet2_8[] = {
> +	0xa6, 0xda, 0xf0, 0x01, 0x02, 0x03, 0xda, 0xf7,
> +	0xda, 0xf0
> +};
> +
> +static const guint8 packet2_9[] = {
> +	0xa6, 0x06, 0x07, 0x08, 0x09, 0x0a, 0xdb, 0xf7
> +};
> +
> +
> +static const struct ble_midi_packet packet2[] = {
> +	BLE_MIDI_PACKET_INIT(packet2_1),
> +	BLE_MIDI_PACKET_INIT(packet2_2),
> +	BLE_MIDI_PACKET_INIT(packet2_3),
> +	BLE_MIDI_PACKET_INIT(packet2_4),
> +	BLE_MIDI_PACKET_INIT(packet2_5),
> +	BLE_MIDI_PACKET_INIT(packet2_6),
> +	BLE_MIDI_PACKET_INIT(packet2_7),
> +	BLE_MIDI_PACKET_INIT(packet2_8),
> +	BLE_MIDI_PACKET_INIT(packet2_9),
> +};
> +
> +static const guint8 sysex2_1[] = {
> +	0xf0, 0x01, 0x02, 0x03, 0xf7
> +};
> +
> +static const guint8 sysex2_2[] = {
> +	0xf0, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
> +	0x08, 0x09, 0x0a, 0xf7
> +};
> +
> +static const guint8 sysex2_3[] = {
> +	0xf0, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
> +	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> +	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
> +	0x18, 0xf7
> +};
> +
> +static const guint8 sysex2_4[] = {
> +	0xf0, 0x01, 0x02, 0x03, 0xf7
> +};
> +
> +static const guint8 sysex2_5[] = {
> +	0xf0, 0x06, 0x07, 0x08, 0x09, 0x0a, 0xf7
> +};
> +
> +static const snd_seq_event_t event2[] = {
> +	SYSEX_EVENT(sysex2_1),
> +	SYSEX_EVENT(sysex2_2),
> +	SYSEX_EVENT(sysex2_3),
> +	SYSEX_EVENT(sysex2_4),
> +	SYSEX_EVENT(sysex2_5),
> +};
> +
> +static const struct midi_read_test midi2 = BLE_READ_TEST_INIT(packet2, event2);
> +
> +static void compare_events(const snd_seq_event_t *ev1,
> +                           const snd_seq_event_t *ev2)
> +{
> +	g_assert_cmpint(ev1->type, ==, ev2->type);
> +
> +	switch (ev1->type) {
> +	case SND_SEQ_EVENT_NOTEON:
> +	case SND_SEQ_EVENT_NOTEOFF:
> +	case SND_SEQ_EVENT_KEYPRESS:
> +		g_assert_cmpint(ev1->data.note.channel,
> +		                ==,
> +		                ev2->data.note.channel);
> +		g_assert_cmpint(ev1->data.note.note,
> +		                ==,
> +		                ev2->data.note.note);
> +		g_assert_cmpint(ev1->data.note.velocity,
> +		                ==,
> +		                ev2->data.note.velocity);
> +		break;
> +	case SND_SEQ_EVENT_CONTROLLER:
> +		g_assert_cmpint(ev1->data.control.param,
> +		                ==,
> +		                ev2->data.control.param);
> +	case SND_SEQ_EVENT_PITCHBEND:
> +	case SND_SEQ_EVENT_CHANPRESS:
> +	case SND_SEQ_EVENT_PGMCHANGE:
> +		g_assert_cmpint(ev1->data.control.channel,
> +		                ==,
> +		                ev2->data.control.channel);
> +		g_assert_cmpint(ev1->data.control.value,
> +		                ==,
> +		                ev2->data.control.value);
> +		break;
> +	case SND_SEQ_EVENT_SYSEX:
> +		g_assert_cmpmem(ev1->data.ext.ptr, ev1->data.ext.len,
> +		                ev2->data.ext.ptr, ev2->data.ext.len);
> +		break;
> +	default:
> +		g_assert_not_reached();
> +	}
> +}
> +
> +static void test_midi_reader(gconstpointer data)
> +{
> +	const struct midi_read_test *midi_test = data;
> +	struct midi_read_parser midi;
> +	int err;
> +	gsize i; /* ble_packet counter */
> +	gsize j; /* ble_packet length counter */
> +	gsize k = 0; /* event counter */
> +
> +	err = midi_read_init(&midi);
> +	g_assert_cmpint(err, ==, 0);
> +
> +	for (i = 0; i < midi_test->ble_packet_size; i++) {
> +		const gsize length = midi_test->ble_packet[i].size;
> +		j = 0;
> +		midi_read_reset(&midi);
> +		while (j < length) {
> +			snd_seq_event_t ev;
> +			const snd_seq_event_t *ev_expect = &midi_test->event[k];
> +			gsize count;
> +
> +			g_assert_cmpint(k, <, midi_test->event_size);
> +
> +			snd_seq_ev_clear(&ev);
> +
> +			count = midi_read_raw(&midi,
> +			                      midi_test->ble_packet[i].data + j,
> +			                      length - j,
> +			                      &ev);
> +
> +			g_assert_cmpuint(count, >, 0);
> +
> +			if (ev.type == SND_SEQ_EVENT_NONE)
> +				goto _continue_loop;
> +			else
> +				k++;
> +
> +			compare_events(ev_expect, &ev);
> +
> +		_continue_loop:
> +			j += count;
> +		}
> +	}
> +
> +	midi_read_free(&midi);
> +
> +	tester_test_passed();
> +}
> +
> +static const snd_seq_event_t event3[] = {
> +	CONTROL_EVENT(PITCHBEND, 8, 0, 0),    /* Pitch Bend */
> +	CONTROL_EVENT(CONTROLLER, 8, 63, 74), /* Control Change */
> +	NOTE_EVENT(NOTEON, 8, 62, 14),        /* Note On */
> +	CONTROL_EVENT(CHANPRESS, 8, 113, 0),  /* Channel Aftertouch */
> +	CONTROL_EVENT(CONTROLLER, 8, 67, 74), /* Control Change*/
> +	CONTROL_EVENT(PITCHBEND, 8, -2, 0),   /* Pitch Bend */
> +	CONTROL_EVENT(PITCHBEND, 8, -3, 0),   /* Pitch Bend */
> +	CONTROL_EVENT(PITCHBEND, 8, -4, 0),   /* Pitch Bend */
> +	NOTE_EVENT(NOTEOFF, 8, 62, 0),        /* Note Off */
> +};
> +
> +static const struct midi_write_test midi3 = BLE_WRITE_TEST_INIT(event3);
> +
> +static const guint8 sysex4_1[] = {
> +	0xf0, 0x01, 0x02, 0x03, 0xf7
> +};
> +
> +static const guint8 sysex4_2[] = {
> +	0xf0, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
> +	0x08, 0x09, 0x0a, 0xf7
> +};
> +
> +static const guint8 sysex4_3[] = {
> +	0xf0, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
> +	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> +	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
> +	0x18, 0xf7
> +};
> +
> +static const guint8 sysex4_4[] = {
> +	0xf0, 0x01, 0x02, 0x03, 0xf7
> +};
> +
> +static const guint8 sysex4_5[] = {
> +	0xf0, 0x06, 0x07, 0x08, 0x09, 0x0a, 0xf7
> +};
> +
> +static const snd_seq_event_t event4[] = {
> +	SYSEX_EVENT(sysex4_1),
> +	SYSEX_EVENT(sysex4_2),
> +	SYSEX_EVENT(sysex4_3),
> +	SYSEX_EVENT(sysex4_4),
> +	SYSEX_EVENT(sysex4_5),
> +};
> +
> +static const struct midi_write_test midi4 = BLE_WRITE_TEST_INIT(event4);
> +
> +static void test_midi_writer(gconstpointer data)
> +{
> +	const struct midi_write_test *midi_test = data;
> +	struct midi_write_parser midi_out;
> +	struct midi_read_parser midi_in;
> +	gsize i; /* event counter */
> +	gsize j; /* test counter */
> +	static struct midi_data {
> +		gsize events_tested;
> +		const struct midi_write_test *midi_test;
> +		struct midi_read_parser *midi_in;
> +	} midi_data;
> +
> +	void compare_events_cb(const guint8 *data, guint size, gpointer user_data) {
> +		struct midi_data *midi_data = user_data;
> +		const struct midi_write_test *midi_test = midi_data->midi_test;
> +		struct midi_read_parser *midi_in = midi_data->midi_in;
> +		gsize i = 0;
> +
> +		midi_read_reset(midi_in);
> +
> +		while (i < size) {
> +			snd_seq_event_t ev;
> +			gsize count;
> +
> +			snd_seq_ev_clear(&ev);
> +
> +			count = midi_read_raw(midi_in, data + i,
> +			                      size - i, &ev);
> +
> +			g_assert_cmpuint(count, >, 0);
> +
> +			if (ev.type != SND_SEQ_EVENT_NONE){
> +				g_assert_cmpint(midi_data->events_tested,
> +				                <,
> +				                midi_test->event_size);
> +				compare_events(&midi_test->event[midi_data->events_tested],
> +				               &ev);
> +				midi_data->events_tested++;
> +			}
> +
> +			i += count;
> +		}
> +	};
> +
> +	midi_read_init(&midi_in);
> +
> +	for (j = 0; j < NUM_WRITE_TESTS; j++) {
> +
> +		/* Range of test for different MTU sizes. The spec specifies
> +		   sizes of packet as MTU - 3 */
> +		midi_write_init(&midi_out, g_random_int_range(5, 40));
> +
> +		midi_data.events_tested = 0;
> +		midi_data.midi_test = midi_test;
> +		midi_data.midi_in = &midi_in;
> +
> +		for (i = 0; i < midi_test->event_size; i++)
> +			midi_read_ev(&midi_out, &midi_test->event[i],
> +			             compare_events_cb, &midi_data);
> +
> +		if (midi_write_has_data(&midi_out))
> +			compare_events_cb(midi_write_data(&midi_out),
> +			                  midi_write_data_size(&midi_out),
> +			                  &midi_data);
> +
> +		midi_write_free(&midi_out);
> +	}
> +	midi_read_free(&midi_in);
> +
> +	tester_test_passed();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	tester_init(&argc, &argv);
> +
> +	tester_add("/midi/1", &midi1, NULL, test_midi_reader, NULL);
> +	tester_add("/midi/2", &midi2, NULL, test_midi_reader, NULL);
> +	tester_add("/midi/3", &midi3, NULL, test_midi_writer, NULL);
> +	tester_add("/midi/4", &midi4, NULL, test_midi_writer, NULL);
> +
> +	return tester_run();
> +}
> 

-- 
Felipe

--------------BAC222B18FCA2301043D690B
Content-Type: application/pgp-keys;
 name="0x92698E6A.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0x92698E6A.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQINBFYedIcBEACVKGKoEjb3zlvAz5SUvBej7Sx13BPd8hVulQD+mqjfuRFPmZA5
LBXPX1zTRWwGEbbZegP3tLfKP+XekzO6BQhDihMmKuRusdgDsdMtldwhjHuUwKn7
kxB2k79jSG802lAjIv2l5hijOfKIGTATKwiMijuXho54DGltIgNyN/Onwk9HnM6d
jsV5uubaI468JRH6j8HXXievo24BDvsimIE75ImiM53ruiwPwEry1hi1CnE5OpqG
oe/lt27+nLXijfNZOpBZ3Q+RPVBdqPTkMlBJAa4sg+qwZoSMvQJFAGROiJ7+ICCW
O4GPMrAn8CRcCI9ENKBj2dQ4bBEP1a+f16GNMUUU37wocqtyNHo0Pa/DnFh91kcu
/2dvUX4XPeEimEoSKroRLOXC9RGSFYB/r9UXqFgbmyQ4TZLx0mAWIjoUQtbIJNRz
Pt46UeznCVLJTg7CzIvtv8vwmMFvaepr8ONoZn+tpX8VW4dgzsMZDrVspE0Vg3oo
K9JRi1nN3GcJJK4zG2ShvEkPffRHuBuyX5wR8MPRYTShKnJR5qd1cCSK73fCv4DP
bjywmGjucqcLiyYbByjmHaqzRaKJclmT/jhs6qZHs+pVLkmHkHdf/WLP6Xgcvmo8
c+SATrJwRsyW9riyMB7uNg3T84umbQrl00nAhcq73rem/602H+Qrh8rEfQARAQAB
tC1GZWxpcGUgRmVycmVyaSBUb25lbGxvIDxldUBmZWxpcGV0b25lbGxvLmNvbT6J
AjwEEwEIACYCGyMHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAIZAQUCVlXsdwAK
CRDMRLTQkmmOapJFD/9XZZdX5XdXrQ2Qr7znQCOMPfOFiTqK8A1vVJPfLcPdkDyW
iDfV2w4jyxKjgkcO8hgjZWAGdXhKxEXt8bQIZ+Po3eOqKo/O69+WyYS33uAKfNbr
t4BcJOM2Vh2MwTymzh5EKjsKi/vmqFqvcpa81Jc4exDaHhb2mqMW8DZc96nMPwij
+Z4vVooOVt5DVGeG4o2rztoti+KaXys6nycm8ErMmqWmL0viEnXHDRTOUHpnhEQY
Vlg+hfxYrk00DphAePrpRp/HaxNncxR+ID0SHmYlLCaEy7s5ksOORjlKSk+7Nqat
X69ymfXeEI84ror11IR7kuAA+rkhHMacWXANPkXtuEBi9Nl3V5Rvud4f/RL3Sh2x
lwPfxca9rIR/7JYwoCzQ8iORok3VqKOtpufLKMsIl9sdj7ZxI6f6tZDm5uAaCZAt
f15EcGiVWZgGdKlXzIWFkUsdRhtGYEQBF1Li/qLrnoS5T32eSCt8cgJlkDyKqNbX
fxvV0KON8tJ9jBnMmoADetF/9V3A6EIBtTdxsz+UKjk6PV0bx398AbdvNB22r6Kw
n1E2ZqzfNIaAOv5lEHh7VP7+s3vdXcKfnfobW0qd56NpAGTPhAN00wl7T5oMN3xS
MNTPIC4316E8KChA5CQ3h6RRlZYvAJx7QWfJKX5zb8EVcJb0ul67V8hn1h/s54kC
PwQTAQgAKQUCVh50hwIbIwUJCWYBgAcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheA
AAoJEMxEtNCSaY5qHxAP/0LmkXtaZvFelixfYibDHwpz+62mWydYN8I13ikV7uK0
DxpN6W3SeoAY6mF6mwHKyhsNhlOYPR8Rb+CpJxjIez6sPHAA02m4HqfTiNRuAeLM
hSpiMIVesGgR9Lt/2gnCcF/R/pNJd5RC7wWzeeiS9/b2XtFImRSFvctyHwGXLBYM
nlRx/o34kWscTCqixBF7lm3umAErDUd0fvL4oV2sC3W8Ncjfk/WQWfschV50lNtO
h1Imvt+5ud3AJEcwXew0pbHKHvtrVc7toIO3jhZypD9YXP3aR9ZEkHS/bnd5HRHV
t3iEwXH+bNu/evEB5dQcSf6M6Bwt7Ty2fqFx2PUmnZ22W4HGelPmE5aCqkBQqAkR
kBmPEPlUIz6GLoj8jUL1ey+T+oCyD5wZoVb841bJDKIPxAa+P+MjFtQUpSXgyi8x
G0Ic10pK9u3xsu5xzqLoAwt+pK+oxeWrZhJXg9/MFmqQQTX2dH8lIrgIOsHis5uK
ySohiPwYQ0HUbbSFB9wM6e5dq621RvOkMA/myFtdjJX+Ynr7FmIpIZQiWZvOv0nM
0CeF7MotMIVa1ioh9K6/Z5WLjTBQh32DrGL07H0h+SMOvcL1IJuw9aG5qDKH4VW9
VSbHAogVSntamVrCg8jcT8uxEtwZNZH3aBqoYv4pa4MJsIs6vI0/9Y/mVyYVhQPN
tDFGZWxpcGUgRmVycmVyaSBUb25lbGxvIDxmZWxpcGUudG9uZWxsb0BnbWFpbC5j
b20+iQI5BBMBCAAjAhsjBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AFAlZV7HoA
CgkQzES00JJpjmqexA//UHC0P+5NMN0HS0EC3vqdf+9AFfX/Gx+q6BjlaYh8gkGI
5SNGGb25dooGBRhXzFvp5UmxQjngvZO0Jl071kbqOs7IylZWvUB0tIB/9kcvIgJM
U13CvdD2XwHDgKoCCS07ymFd9j31FhfYK6eRpr72oGHtjhGOSIj1u8T/4mJDstoc
zK39gZjTQjzT/2sDbr2sd41KLJ9Ly3H67EgoxYIAQQwwT1Z7x88a8BORIXS8iZPw
z3D8A1r2BT55qukwEP7GktNArKlhrieFRHCxk8PAtZRj8TrOEyG9nnuZWZQWcb6M
suIY6s4cyL5KRTUgGfnpc+VMcNKnm0WmKg5jZXRFwg0DECZi0wJqsS8GPrq4La+K
laxPcXj3ShJePj0YuTcJ/fPYoqqelcbmlqg6m+S9s8PRKPzlESt2jYPbgqMzE0Lu
DLRGT7SBYgHgDVFwIuFyHQaqEhnU/nLWmyMSuTOE5L4s/CR1xY4qQUtOTnDFbwqL
125kbOCiRSMBBMOB4Q+UW3+dJ7uqo6LSqIKa/LWvzRmn5po4iSHAD18ivOh1wTe6
0d/ngjzpTm80uFrwfgkQTexxESYjlBbceBC8kpb1zPFrip41hIi3iPP9UQnnpOO2
hDrQu5z0N8HMIFg3kciR22wUMzQnyVN4iKfkrhERjjuYWOXJmC5I76DBqlEKLCWJ
Aj8EEwEIACkFAlYyWW0CGyMFCQlmAYAHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIX
gAAKCRDMRLTQkmmOakxGD/4xoYnRMuy8m6IwT1Y6mWzXZMkcClxwisUkwgF37jMR
Xk7aitPqlD7AOn/jzKZBmKqOokyH3Y65u/AV6O7jXWWM3Ru0fDYYt0RZR0CkE0c2
Rio64ol6GWnF4dIiyTTSyxBNadVJXRYBpp5G78ie495ZOp35WUoz2RhExeIQGkBb
++UIyCh3eK70PPJ+1/dDV9sSRncIBZLSv+4hc4gS6YoprtSgiS8sdf8uBVtjT3r0
nmrKfTpktADqOOACd/K3LIdf6rlvAYsuWdQ/q32MF7Clrlpt9e5oqi+ASJcLNWUz
cT8nFyvjJzM5kQEBblT6uzyWE5N6+K/t23Uw13vSx3Z2uhhfRQjcSOcZgHdvc8w1
3UXhE+XRCMmtA7jonJuFLYOXbjeeNEbJj5ManrOQMSnVy+kRlf3pLoc7VjJGd2k9
w1U+62b1IVypQCoDNhIy3YTjw7D151z/i5tK5yBvntswji10InowqPRuvt3C3fpW
kv2MnB6qI+u6M5bP/1CvkLSC9vX+gavUFYZ/wCESVrl1FYQPfOoEgvEId9Ajzx0B
qyR/5jXY3ZzWhnXNtYpHXy5/mJdvZ+v5ra5JLWKVA3pa+QbTd3v6ELo9NKavylcD
FX9X2l2s7kp/FRVUZg3mr/3Pf0R1EFZAwM2Fgb5iKPLPjGi4b4sVtMxeXfbXRMBf
5rQwRmVsaXBlIEZlcnJlcmkgVG9uZWxsbyA8ZmVsaXBlLnRvbmVsbG9Acm9saS5j
b20+iQI5BBMBCAAjAhsjBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AFAlZV7HoA
CgkQzES00JJpjmrkTA//YiyBcGn+hjsKsVxFHseUw0ygN7TDLGeG7z0sP7AybVXR
h4AwVcqyNkJjJ1UPXxPm5ra6/TbJf3XEalhIJtqh0MI0p+NQTFVOcGG58e6oMWj1
yBHAPmCyMJCi3GrB1/weP3qMiCdKWOWjxt+NoWss3pqqpSKHGW2rgmM3VP60iheR
uZDDDI9DtoDz1ePT2AQZnopez2k75syZix1zkAI/VM/T3Y5lcnbaO4C+akDusfN0
galjwveYPIv6bBY6gd3B/7leSe2l4M3VIahj/1e4R2aLB78/pyy5BaI47zprkzPF
zOAtZTurrwnE/1s3qWMP3OFeKiD1NLCm8kkvVakk/FjG8avFTAB3idNjpRT3wyPp
nGv3G5Bp2jII35l7L5e2/zGcIigDNAUtdL3IgszfqtTVwGgISZDoxHIyBucqpYqV
+ZesP1CpvyXaG4ME1QNTYZcVj1VTtz97IwntHw51r0d4IXjTbbrwJYR/g15XqNRB
HwQyumPr3kMXLKTHCroK0z1OoT+pwNAO/XEWqQ5NQwyjalkFa1PzSPgcbTH46gs+
lilkrSgDuj/Amt0pkBSadgviJhsq2nQU49E8OOrrgDab0Z+6ur2lTENPWD4U9PS1
PisVd3ZAm8WmLx1ZktMgv2IPS9Tm+HlIdTPcw8OY12iPP1tRcE7pu23HLP3Un++0
KEZlbGlwZSBGZXJyZXJpIFRvbmVsbG8gPGZlbGlwZUByb2xpLmNvbT6JAjkEEwEI
ACMCGyMHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAUCVlXsegAKCRDMRLTQkmmO
aoymD/94mkk+RCXUQI6i3Z5qfenWHaJF86SH1tekpJl3eFHEUji0JWICOWS9225E
3oBbLDAA3szFWFxXNA2JdOv0ljwqWHT/aRXJlQ19LHMItguUyxfoELf818aym8bL
MtazXRrYTy71SfvJwIleMYrNeodZnC4GwSOaKz5Rh/Qbnfzz/wG4dCNtGTcQ+EKP
vcA06bNbYaqGA+qtrZ3st3lEmz/OPqRox7LqZTs/fvdAo49F8BlTZ6p09s2u7wVF
UfYbi4+PQonGpn47QTx41OjFzzeA3NnCDak6JuSYa92QznShP0b03G5g4LdonwbU
P/ivpzkSdWYVNwp/a7GfuhBAyk2VP/StF6WzzGC0j4TyBx+H5RzU32brNNsye1bL
8AMvHl9C3BEdgLnIlsTRMRCjs7f4EoFyEzmW40FUXPaJzxF6bCY/+GzDIhtMisjK
fUFyakHnjITZSjo7Wqhp3W6a64esqPFbuFoX7sp5mWYzqDuKy0yD7S9vjA8wLdCt
usBRw6TvVhaxmnOOa8zkyhOLqJ6le+zw8mW+Cot4LFFkeXyySNyRbrqOx3JqezRc
olouAh2AJEir2sW3kdP53xRwUE5CJogC2QPuGSl5T1pcARmQJmudco2dk7C+hriF
hkCHjp5ue9evv6u/Z7m+AcPJguVlq21ynYRrTeFJXCd2rgkAWbkCDQRWHnSHARAA
yrLAhPO4JiqRk2sem+8bweimfnKmIm+ttTqjDni1DdBKtCZFUxPwEKzuOpU4aals
9Ohk4rQMnm6Q2XaJxIs0lijQJjVFbExtm9G2R2gkPJ5fnk4+k2mvps5F/iJjQk0k
zWMITEA6cJzt9B8YC4dfsIq3lhCInOvSMBIVtDapruDGU4OskFBiKfzIq8diq/Ep
qNfwCxZX2IcPhFv2+SJjph60oUC4WJ4zgINfJWdUGlIZrQp8sr/aEa77BVtLnTsu
MHwqOF7P7yk4qpb3EFuyNCsJVAirYTqZeMWEv/pYiwtAgYOewdwptP8+5lbcXAor
Y8Cs0GdW0r7LUzQjfhXl67EQWJuvGDBKMQ35LyUJtOm5m+qAnalz9Eyb0xRc9Arl
rzH2GfCIr4ga+2RPw7fq7fZcbBcJDs770Mz0kVrLv3IAcc6fmnvuo30TFeIPB62/
c4xIe8njJ8RxbfwYAtd2KoAzwRQEqJQECyNnqENFHj2cimEueXf7NAw+z1nl1HIl
7MrHUeA0FQTw4WdGCahTuFRaJCjmODmKCFAooDWEek6jwNv18hCDJytSDc7uLAvH
D2b9Sd40P1V2ochSf/DS/osfEIEeBf5mkG/MHBBbNxvSGP1h2yUM5C7g4nc6B+nz
5bIULhw0ojZx+U1i63gJkMsVMjKDAa+mGsWu0vAI3v0AEQEAAYkCHwQYAQgACQIb
DAUCVlXsegAKCRDMRLTQkmmOao4vD/9GYLw5VmydK5BJ0sX12QmR7oMK4skMkcg/
gofkJ6njI4ETDG/pQfgBSQ/P0gUMXmhHgmpaRgs0tkS2NwsvURianXiQNpJwUA2g
qKngqWlEvGOVkgOw7JKpdLWBvEW4vfP0Z0Q9brdeQG//9T9xyoyTC/jPM9A33NtI
KlexBfBT7lXBy/y4tqf96KTOXk3STmI6nmSwmpPPtjxXXGQiMExGxAru+VX0HFxi
JBS2fw/ucluVk2kffAO0y7DTL0UH3IWq4wEtHJQlEcujmUkP8PJSVIkhJpNlppR2
97DVxLcMAbnyxCW+ms1lCuZ5KB98KtowipqY9jhAPeP06W2WikENdmpLfNHhyIaM
NKF7J+4zqPda7jZN1aKqs5OguJ4V82xXRJ0O6qSAd3Kvwi3MaKtNAv09JFG7UIcK
ALJ+OQBzc00z54ii19ZPHjER6cYmcVutBUGOssqtyCOZymVbc7VYecdjxVrLwdDp
LHHpcIjFn5ADjIAwGlt5ttkPvFTmqLeSWG9+vtoBShzQdeKJ4AN4r6/for/XsmF4
Jf7qGK8RamVX8lpWaNjUGtVSUOMTaSR1pmQJERDO2/WEZCm5hUFkYDbu+h+9m1W+
KL2ZkyGRC8FoZ46ly1J8koEeEoa57Au/uyK3KyvzlXuCI5zgGE+TohIjOr6d3TN4
SkAyCfQaSw==
=JwBB
-----END PGP PUBLIC KEY BLOCK-----

--------------BAC222B18FCA2301043D690B--
