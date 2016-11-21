Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f5c20530-bf2e-4cb5-ba1e-bb63114c22f0@felipetonello.com>
References: <20161118145944.22266-1-eu@felipetonello.com> <f5c20530-bf2e-4cb5-ba1e-bb63114c22f0@felipetonello.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 21 Nov 2016 13:47:04 +0200
Message-ID: <CABBYNZ+hmPQ3GxP475cGH1=s_U6OdAAutG4NTZBftg56vMG_Tg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] profiles/midi: Added MIDI over BLE profile implementation
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

On Mon, Nov 21, 2016 at 1:21 PM, Felipe Ferreri Tonello
<eu@felipetonello.com> wrote:
> Hi all,
>
> On 18/11/16 14:59, Felipe F. Tonello wrote:
>> This plugin implements the Central roli of MIDI over Bluetooth
>> Low-Energy (BLE-MIDI) 1.0 specification as published by MMA in
>> November/2015.
>>
>> It was implmemented as a bluez plugin because of latency requirements
>> of MIDI. There are still room for improvements on this regard.
>>
>> Since all parsing and state-machine code is in libmidi.[hc] it should be
>> simple to implement Peripheral role as a GATT service as well.
>>
>> I have also implemented several unit-tests that can be easily extended
>> without adding any code, just use-cases.
>>
>> Files added:
>>  * profiles/midi/midi.c: Actual GATT plugin
>>  * profiles/midi/libmidi.[ch]: MIDI parsers
>>  * unit/test-midi.c: Unit-tests

Btw, usually we stayed away from alsa/audio dependencies since they
are quite time sensitive which may impact in the responsiveness of
bluetoothd, so I wonder if you document anything in this regard? Also
please keep in mind many parts of bluetoothd are not thread-safe so if
there are other threads involved Im afraid we won't be taking more
than the GATT plugin leaving the remaining code to be done somewhere
else.

>> I will still maintain a personal branch on my github[1] so others can
>> contribute there and I can test before sending to bluez.
>>
>> This patch adds ALSA dependency since there is no other way of doing it,
>> sorry for it. :/ But this can be easily disabled with --disable-alsa
>> configure flag.
>>
>> I have tested on a normal laptop Arch-linux (x86_64) and a Raspberry Pi =
2
>> (ARM A8) and it works very well. As I mentioned, the latency can always =
be
>> improved.
>>
>> NOTE: the timestamp support is incomplete since ALSA doesn't support the
>> way MIDI over BLE expects (asign timestamp to an event without schedulin=
g).
>> We are working on ALSA to improve this.
>>
>> OBS: I would like to send kudos to ROLI Ltd. which allowed my to work
>> on this as part of my full-time job.
>>
>> [1] https://github.com/ftonello/bluez/
>> ---
>>  Makefile.am             |  13 +-
>>  Makefile.plugins        |   8 +
>>  README                  |   6 +
>>  configure.ac            |  10 +
>>  profiles/midi/libmidi.c | 391 ++++++++++++++++++++++++++++++++++++++
>>  profiles/midi/libmidi.h | 140 ++++++++++++++
>>  profiles/midi/midi.c    | 491 +++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  unit/test-midi.c        | 464 +++++++++++++++++++++++++++++++++++++++++=
++++
>>  8 files changed, 1522 insertions(+), 1 deletion(-)
>>  create mode 100644 profiles/midi/libmidi.c
>>  create mode 100644 profiles/midi/libmidi.h
>>  create mode 100644 profiles/midi/midi.c
>>  create mode 100644 unit/test-midi.c
>>
>> diff --git a/Makefile.am b/Makefile.am
>> index c469a6caf83a..c077b2568d5d 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -147,6 +147,7 @@ gobex_sources =3D gobex/gobex.h gobex/gobex.c \
>>  builtin_modules =3D
>>  builtin_sources =3D
>>  builtin_nodist =3D
>> +builtin_ldadd =3D
>>
>>  include Makefile.plugins
>>
>> @@ -191,7 +192,8 @@ src_bluetoothd_SOURCES =3D $(builtin_sources) \
>>  src_bluetoothd_LDADD =3D lib/libbluetooth-internal.la \
>>                       gdbus/libgdbus-internal.la \
>>                       src/libshared-glib.la \
>> -                     @BACKTRACE_LIBS@ @GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt
>> +                     @BACKTRACE_LIBS@ @GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt=
 \
>> +                     $(builtin_ldadd)
>>  src_bluetoothd_LDFLAGS =3D $(AM_LDFLAGS) -Wl,--export-dynamic \
>>                               -Wl,--version-script=3D$(srcdir)/src/bluet=
ooth.ver
>>
>> @@ -421,6 +423,15 @@ unit_test_gattrib_LDADD =3D lib/libbluetooth-intern=
al.la \
>>                       src/libshared-glib.la \
>>                       @GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt
>>
>> +if ALSA
>> +unit_tests +=3D unit/test-midi
>> +unit_test_midi_SOURCES =3D unit/test-midi.c \
>> +                     profiles/midi/libmidi.h \
>> +                     profiles/midi/libmidi.c
>> +unit_test_midi_LDADD =3D src/libshared-glib.la \
>> +                     @GLIB_LIBS@ @ALSA_LIBS@
>> +endif
>> +
>>  if MAINTAINER_MODE
>>  noinst_PROGRAMS +=3D $(unit_tests)
>>  endif
>> diff --git a/Makefile.plugins b/Makefile.plugins
>> index 59342c0cb803..3600f113304c 100644
>> --- a/Makefile.plugins
>> +++ b/Makefile.plugins
>> @@ -95,6 +95,14 @@ builtin_sources +=3D profiles/scanparam/scan.c
>>  builtin_modules +=3D deviceinfo
>>  builtin_sources +=3D profiles/deviceinfo/deviceinfo.c
>>
>> +if ALSA
>> +builtin_modules +=3D midi
>> +builtin_sources +=3D profiles/midi/midi.c \
>> +                     profiles/midi/libmidi.h \
>> +                     profiles/midi/libmidi.c
>> +builtin_ldadd +=3D @ALSA_LIBS@
>> +endif
>> +
>>  if SIXAXIS
>>  plugin_LTLIBRARIES +=3D plugins/sixaxis.la
>>  plugins_sixaxis_la_SOURCES =3D plugins/sixaxis.c
>> diff --git a/README b/README
>> index 3ee367092137..e582f1fadfb0 100644
>> --- a/README
>> +++ b/README
>> @@ -13,6 +13,12 @@ Read more about the project at:
>>  * http://blog.felipetonello.com/2015/12/14/midi-over-bluetooth-low-ener=
gy-on-linux/
>>  * https://www.marc.info/?l=3Dlinux-bluetooth&m=3D144368891120651&w=3D4
>>
>> +This branch[1] is under heavy development, so don't assume that things =
will not
>> +break or the histry log will not change, because it will!
>> +
>> +The idea is that most MIDI related commits will be squashed and cleaned=
-up.
>> +
>> +[1] https://github.com/ftonello/bluez/
>
> Please, ignore this README change. I will remove this on v2.
>
>>
>>  Compilation and installation
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> diff --git a/configure.ac b/configure.ac
>> index 768a20cc5b2b..ffe0dd61c4e5 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -210,8 +210,18 @@ AM_CONDITIONAL(HID2HCI, test "${enable_tools}" !=3D=
 "no" &&
>>
>>  AC_ARG_ENABLE(cups, AC_HELP_STRING([--disable-cups],
>>                  [disable CUPS printer support]), [enable_cups=3D${enabl=
eval}])
>> +if (test "${enable_alsa}" !=3D "no"); then
>> +     PKG_CHECK_MODULES(ALSA, alsa, dummy=3Dyes,
>> +                             AC_MSG_ERROR(ALSA lib is required))
>> +     AC_SUBST(ALSA_CFLAGS)
>> +     AC_SUBST(ALSA_LIBS)
>> +fi
>>  AM_CONDITIONAL(CUPS, test "${enable_cups}" !=3D "no")
>>
>> +AC_ARG_ENABLE(alsa, AC_HELP_STRING([--disable-alsa],
>> +                [disable ALSA MIDI support]), [enable_alsa=3D${enableva=
l}])
>> +AM_CONDITIONAL(ALSA, test "${enable_alsa}" !=3D "no")
>> +
>>  AC_ARG_ENABLE(obex, AC_HELP_STRING([--disable-obex],
>>               [disable OBEX profile support]), [enable_obex=3D${enableva=
l}])
>>  if (test "${enable_obex}" !=3D "no"); then
>> diff --git a/profiles/midi/libmidi.c b/profiles/midi/libmidi.c
>> new file mode 100644
>> index 000000000000..970fe2b1a300
>> --- /dev/null
>> +++ b/profiles/midi/libmidi.c
>> @@ -0,0 +1,391 @@
>> +/*
>> + *
>> + *  BlueZ - Bluetooth protocol stack for Linux
>> + *
>> + *  Copyright (C) 2015,2016 Felipe F. Tonello <eu@felipetonello.com>
>> + *  Copyright (C) 2016 ROLI Ltd.
>> + *
>> + *  This program is free software; you can redistribute it and/or modif=
y
>> + *  it under the terms of the GNU General Public License as published b=
y
>> + *  the Free Software Foundation; either version 2 of the License, or
>> + *  (at your option) any later version.
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *  GNU General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU General Public License
>> + *  along with this program; if not, write to the Free Software
>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-13=
01  USA
>> + *
>> + *
>> + */
>> +
>> +#define _GNU_SOURCE
>> +
>> +#include "libmidi.h"
>> +
>> +inline static void append_timestamp_high_maybe(struct midi_write_parser=
 *parser)
>> +{
>> +     if (!midi_write_has_data(parser)) {
>> +             guint8 timestamp_high =3D 0x80;
>> +             parser->rtime =3D g_get_monotonic_time() / 1000; /* conver=
t =C2=B5s to ms */
>> +             timestamp_high |=3D (parser->rtime & 0x1F80) >> 7;
>> +             /* set timestampHigh */
>> +             g_byte_array_append(parser->midi_stream, &timestamp_high,
>> +                                 sizeof(timestamp_high));
>> +     }
>> +}
>> +
>> +inline static void append_timestamp_low(struct midi_write_parser *parse=
r)
>> +{
>> +     const guint8 timestamp_low =3D 0x80 | (parser->rtime & 0x7F);
>> +     g_byte_array_append(parser->midi_stream, &timestamp_low,
>> +                         sizeof(timestamp_low));
>> +}
>> +
>> +void midi_read_ev(struct midi_write_parser *parser, const snd_seq_event=
_t *ev,
>> +                  midi_read_ev_cb write_cb, gpointer user_data)
>> +{
>> +     g_assert(write_cb);
>> +
>> +#define GET_AVAILABLE_SIZE (parser->stream_size - parser->midi_stream->=
len)
>> +
>> +     if (GET_AVAILABLE_SIZE =3D=3D 0) {
>> +             write_cb(parser->midi_stream->data, parser->midi_stream->l=
en,
>> +                      user_data);
>> +             midi_write_reset(parser);
>> +     }
>> +
>> +     append_timestamp_high_maybe(parser);
>> +
>> +     /* SysEx is special case:
>> +        SysEx has two timestampLow bytes, before F0 and F7
>> +     */
>> +     if (ev->type =3D=3D SND_SEQ_EVENT_SYSEX) {
>> +
>> +             unsigned int used_sysex =3D 0;
>> +
>> +             /* Algorithm:
>> +                1) check initial timestampLow:
>> +                    if used_sysex =3D=3D 0, then tsLow =3D 1, else tsLo=
w =3D 0
>> +                2) calculate sysex size of current packet:
>> +                2a) first check special case:
>> +                    if midi->out_length - 1 (tsHigh) - tsLow =3D=3D
>> +                       sysex_length - used_sysex
>> +                    size is: min(midi->out_length - 1 - tsLow,
>> +                                 sysex_length - used_sysex - 1)
>> +                2b) else size is: min(midi->out_length - 1 - tsLow,
>> +                                  sysex_length - used_sysex)
>> +                3) check if packet contains F7: fill respective tsLow b=
yte
>> +             */
>> +
>> +#define GET_SYSEX_IDX(_i) (((guint8*)ev->data.ext.ptr)[_i])
>> +#define GET_DATA_REVERSE_IDX(_i) (parser->midi_stream->data \
>> +                                  [parser->midi_stream->len - ((_i) + 1=
)])
>> +
>> +             /* We need at least 2 bytes (timestampLow + F0) */
>> +             if (GET_AVAILABLE_SIZE < 2) {
>> +                     /* send current message and start new one */
>> +                     write_cb(parser->midi_stream->data, parser->midi_s=
tream->len,
>> +                              user_data);
>> +                     midi_write_reset(parser);
>> +                     append_timestamp_high_maybe(parser);
>> +             }
>> +
>> +             /* timestampLow on initial F0 */
>> +             if (GET_SYSEX_IDX(0) =3D=3D 0xF0)
>> +                     append_timestamp_low(parser);
>> +
>> +             do {
>> +                     unsigned int size_of_sysex;
>> +
>> +                     append_timestamp_high_maybe(parser);
>> +
>> +                     size_of_sysex =3D MIN(GET_AVAILABLE_SIZE,
>> +                                         ev->data.ext.len - used_sysex)=
;
>> +
>> +                     if (GET_AVAILABLE_SIZE =3D=3D ev->data.ext.len - u=
sed_sysex)
>> +                             size_of_sysex--;
>> +
>> +                     g_byte_array_append(parser->midi_stream,
>> +                                         ev->data.ext.ptr + used_sysex,
>> +                                         size_of_sysex);
>> +                     used_sysex +=3D size_of_sysex;
>> +
>> +                     if (GET_AVAILABLE_SIZE <=3D 1 && GET_DATA_REVERSE_=
IDX(0) !=3D 0xF7) {
>> +                             write_cb(parser->midi_stream->data, parser=
->midi_stream->len,
>> +                                      user_data);
>> +                             midi_write_reset(parser);
>> +                     }
>> +             } while (used_sysex < ev->data.ext.len);
>> +
>> +             /* check for F7 and update respective timestampLow byte */
>> +             if (GET_DATA_REVERSE_IDX(0) =3D=3D 0xF7) {
>> +                     guint8 tmp;
>> +                     append_timestamp_low(parser);
>> +                     tmp =3D GET_DATA_REVERSE_IDX(0);
>> +                     GET_DATA_REVERSE_IDX(0) =3D 0xF7;
>> +                     GET_DATA_REVERSE_IDX(1) =3D tmp;
>> +             }
>> +
>> +#undef GET_DATA_REVERSE_IDX
>> +#undef GET_SYSEX_IDX
>> +
>> +     } else {
>> +             int length;
>> +
>> +             /* check for running status */
>> +             if (parser->rstate !=3D ev->type) {
>> +                     snd_midi_event_reset_decode(parser->midi_ev);
>> +                     append_timestamp_low(parser);
>> +             }
>> +
>> +             /* each midi message has timestampLow byte to follow */
>> +             length =3D snd_midi_event_decode(parser->midi_ev,
>> +                                            parser->midi_stream->data +
>> +                                            parser->midi_stream->len,
>> +                                            GET_AVAILABLE_SIZE,
>> +                                            ev);
>> +
>> +             if (length =3D=3D -ENOMEM) {
>> +                     /* remove previously added timestampLow */
>> +                     g_byte_array_remove_index_fast(parser->midi_stream=
,
>> +                                                    parser->midi_stream=
->len -1);
>> +                     write_cb(parser->midi_stream->data, parser->midi_s=
tream->len,
>> +                              user_data);
>> +                     /* cleanup state for next packet */
>> +                     snd_midi_event_reset_decode(parser->midi_ev);
>> +                     midi_write_reset(parser);
>> +                     append_timestamp_high_maybe(parser);
>> +                     append_timestamp_low(parser);
>> +                     length =3D snd_midi_event_decode(parser->midi_ev,
>> +                                                    parser->midi_stream=
->data +
>> +                                                    parser->midi_stream=
->len,
>> +                                                    GET_AVAILABLE_SIZE,
>> +                                                    ev);
>> +             }
>> +
>> +             if (length > 0)
>> +                     parser->midi_stream->len +=3D length;
>> +     }
>> +
>> +     parser->rstate =3D ev->type;
>> +
>> +     if (GET_AVAILABLE_SIZE <=3D 1) {
>> +             write_cb(parser->midi_stream->data, parser->midi_stream->l=
en,
>> +                      user_data);
>> +             midi_write_reset(parser);
>> +     }
>> +#undef GET_AVAILABLE_SIZE
>> +}
>> +
>> +static void update_ev_timestamp(struct midi_read_parser *parser, snd_se=
q_event_t *ev,
>> +                                guint16 timestamp)
>> +{
>> +     int delta_timestamp;
>> +     int delta_rtime;
>> +     gint64 rtime_current;
>> +
>> +     rtime_current =3D g_get_monotonic_time() / 1000; /* convert =C2=B5=
s to ms */
>> +     delta_timestamp =3D timestamp - (int)parser->timestamp;
>> +     delta_rtime =3D rtime_current - parser->rtime;
>> +
>> +     if (delta_rtime > MIDI_MAX_TIMESTAMP)
>> +             parser->rtime =3D rtime_current;
>> +     else {
>> +
>> +             /* If delta_timestamp is way to big than delta_rtime,
>> +                this means that the device sent a message in the past,
>> +                so we have to compensate for this. */
>> +             if (delta_timestamp > 7000 && delta_rtime < 1000)
>> +                     delta_timestamp =3D 0;
>> +
>> +             /* check if timestamp did overflow */
>> +             if (delta_timestamp < 0) {
>> +                     /* same timestamp in the past problem */
>> +                     if ((delta_timestamp + MIDI_MAX_TIMESTAMP) > 7000 =
&&
>> +                         delta_rtime < 1000)
>> +                             delta_timestamp =3D 0;
>> +                     else
>> +                             delta_timestamp =3D delta_timestamp + MIDI=
_MAX_TIMESTAMP;
>> +             }
>> +
>> +             parser->rtime +=3D delta_timestamp;
>> +     }
>> +
>> +     parser->timestamp +=3D delta_timestamp;
>> +     if (parser->timestamp > MIDI_MAX_TIMESTAMP)
>> +             parser->timestamp %=3D MIDI_MAX_TIMESTAMP + 1;
>> +
>> +     /* set event timestamp */
>> +     /* TODO: update event timestamp here! */
>> +}
>> +
>> +gsize midi_read_raw(struct midi_read_parser *parser, const guint8 *data=
,
>> +                    gsize size, snd_seq_event_t *ev /* OUT */)
>> +{
>> +     guint8 midi_size =3D 0;
>> +     gsize i =3D 0;
>> +     gboolean err =3D FALSE;
>> +     guint8 time_low =3D 0;
>> +
>> +     if (parser->timestamp_high =3D=3D 0)
>> +             parser->timestamp_high =3D data[i++] & 0x3F;
>> +
>> +     snd_midi_event_reset_encode(parser->midi_ev);
>> +
>> +     /* timestamp byte */
>> +     if (data[i] & 0x80) {
>> +
>> +             guint8 time_low_tmp =3D data[i] & 0x7F;
>> +
>> +             /* time_low overwflow results on time_high to increment by=
 one */
>> +             if (parser->timestamp_low > time_low_tmp)
>> +                     parser->timestamp_high++;
>> +
>> +             parser->timestamp_low =3D time_low_tmp;
>> +
>> +             update_ev_timestamp(parser, ev, (parser->timestamp_high <<=
 7) | time_low);
>> +
>> +             /* check for wrong BLE-MIDI message size */
>> +             if (++i =3D=3D size) {
>> +                     err =3D TRUE;
>> +                     goto _finish;
>> +             }
>> +     }
>> +
>> +     /* cleanup sysex_stream if message is broken or is a new SysEx */
>> +     if (data[i] >=3D 0x80 && data[i] !=3D 0xF7 && parser->sysex_stream=
->len > 0) {
>> +             g_byte_array_remove_range(parser->sysex_stream,
>> +                                       0,
>> +                                       parser->sysex_stream->len);
>> +     }
>> +
>> +     switch (data[i]) {
>> +     case 0xF8 ... 0XFF:
>> +             /* System Real-Time Messages */
>> +             midi_size =3D 1;
>> +             break;
>> +
>> +             /* System Common Messages */
>> +     case 0xF0: /* SysEx Start */ {
>> +             guint8 *pos;
>> +
>> +             /* Avoid parsing if SysEx is contained in one BLE packet *=
/
>> +             if ((pos =3D memchr(data + i, 0xF7, size - i))) {
>> +                     const gsize sysex_length =3D pos - (data + i);
>> +
>> +                     g_byte_array_append(parser->sysex_stream, data + i=
, sysex_length);
>> +
>> +                     time_low =3D parser->sysex_stream->data[sysex_leng=
th - 1] & 0x7F;
>> +                     /* Remove timestamp byte */
>> +                     parser->sysex_stream->data[sysex_length - 1] =3D 0=
xF7;
>> +                     update_ev_timestamp(parser, ev,
>> +                                         (parser->timestamp_high << 7) =
| time_low);
>> +                     snd_seq_ev_set_sysex(ev, parser->sysex_stream->len=
,
>> +                                          parser->sysex_stream->data);
>> +
>> +                     midi_size =3D sysex_length + 1; /* +1 because of t=
imestampLow */
>> +             } else {
>> +                     g_byte_array_append(parser->sysex_stream, data + i=
, size - i);
>> +                     err =3D TRUE; /* Not an actual error, just incompl=
ete message */
>> +                     midi_size =3D size - i;
>> +             }
>> +
>> +             goto _finish;
>> +     }
>> +
>> +     case 0xF1:
>> +     case 0xF3:
>> +             midi_size =3D 2;
>> +             break;
>> +     case 0xF2:
>> +             midi_size =3D 3;
>> +             break;
>> +     case 0xF4:
>> +     case 0xF5: /* Ignore */
>> +             i++;
>> +             err =3D TRUE;
>> +             goto _finish;
>> +             break;
>> +     case 0xF6:
>> +             midi_size =3D 1;
>> +             break;
>> +     case 0xF7: /* SysEx End */
>> +             g_byte_array_append(parser->sysex_stream, data + i, 1);
>> +             snd_seq_ev_set_sysex(ev, parser->sysex_stream->len,
>> +                                  parser->sysex_stream->data);
>> +
>> +             midi_size =3D 1; /* timestampLow was alredy processed */
>> +             goto _finish;
>> +
>> +     case 0x80 ... 0xEF:
>> +             /*
>> +              * Channel Voice Messages, Channel Mode Messages
>> +              * and Control Change Messages.
>> +              */
>> +             parser->rstatus =3D data[i];
>> +             midi_size =3D (data[i] >=3D 0xC0 && data[i] <=3D 0xDF) ? 2=
 : 3;
>> +             break;
>> +
>> +     case 0x00 ... 0x7F:
>> +
>> +             /* Check for SysEx messages */
>> +             if (parser->sysex_stream->len > 0) {
>> +                     guint8 *pos;
>> +
>> +                     if ((pos =3D memchr(data + i, 0xF7, size - i))) {
>> +                             const gsize sysex_length =3D pos - (data +=
 i);
>> +
>> +                             g_byte_array_append(parser->sysex_stream, =
data + i, sysex_length);
>> +
>> +#define GET_DATA_REVERSE_IDX(_i) (parser->sysex_stream->data \
>> +                                  [parser->sysex_stream->len - ((_i) + =
1)])
>> +
>> +                             time_low =3D GET_DATA_REVERSE_IDX(0) & 0x7=
F;
>> +                             /* Remove timestamp byte */
>> +                             GET_DATA_REVERSE_IDX(0) =3D 0xF7;
>> +                             update_ev_timestamp(parser, ev,
>> +                                                 (parser->timestamp_hig=
h << 7) | time_low);
>> +                             snd_seq_ev_set_sysex(ev, parser->sysex_str=
eam->len,
>> +                                                  parser->sysex_stream-=
>data);
>> +
>> +#undef GET_DATA_REVERSE_IDX
>> +
>> +                             midi_size =3D sysex_length + 1; /* +1 beca=
use of timestampLow */
>> +                     } else {
>> +                             g_byte_array_append(parser->sysex_stream, =
data + i, size - i);
>> +                             err =3D TRUE; /* Not an actual error, just=
 incomplete message */
>> +                             midi_size =3D size - i;
>> +                     }
>> +
>> +                     goto _finish;
>> +             }
>> +
>> +             /* Running State Message */
>> +             if (parser->rstatus =3D=3D 0) {
>> +                     midi_size =3D 1;
>> +                     err =3D TRUE;
>> +                     goto _finish;
>> +             }
>> +
>> +             snd_midi_event_encode_byte(parser->midi_ev, parser->rstatu=
s, ev);
>> +             midi_size =3D (parser->rstatus >=3D 0xC0 && parser->rstatu=
s <=3D 0xDF) ? 1 : 2;
>> +             break;
>> +     }
>> +
>> +     if ((i + midi_size) > size) {
>> +             err =3D TRUE;
>> +             goto _finish;
>> +     }
>> +
>> +     snd_midi_event_encode(parser->midi_ev, data + i, midi_size, ev);
>> +
>> +_finish:
>> +     if (err)
>> +             ev->type =3D SND_SEQ_EVENT_NONE;
>> +
>> +     return i + midi_size;
>> +}
>> diff --git a/profiles/midi/libmidi.h b/profiles/midi/libmidi.h
>> new file mode 100644
>> index 000000000000..cc6e13f6c44a
>> --- /dev/null
>> +++ b/profiles/midi/libmidi.h
>> @@ -0,0 +1,140 @@
>> +/*
>> + *
>> + *  BlueZ - Bluetooth protocol stack for Linux
>> + *
>> + *  Copyright (C) 2015,2016 Felipe F. Tonello <eu@felipetonello.com>
>> + *  Copyright (C) 2016 ROLI Ltd.
>> + *
>> + *  This program is free software; you can redistribute it and/or modif=
y
>> + *  it under the terms of the GNU General Public License as published b=
y
>> + *  the Free Software Foundation; either version 2 of the License, or
>> + *  (at your option) any later version.
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *  GNU General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU General Public License
>> + *  along with this program; if not, write to the Free Software
>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-13=
01  USA
>> + *
>> + *
>> + */
>> +
>> +#ifndef LIBMIDI_H
>> +#define LIBMIDI_H
>> +
>> +#include <glib.h>
>> +#include <alsa/asoundlib.h>
>> +
>> +#define MIDI_MAX_TIMESTAMP 8191
>> +#define MIDI_MSG_MAX_SIZE 12
>> +#define MIDI_SYSEX_MAX_SIZE (4 * 1024)
>> +
>> +/* MIDI I/O Write parser */
>> +
>> +struct midi_write_parser {
>> +     gint64 rtime;                /* last writer's real time */
>> +     snd_seq_event_type_t rstate; /* running status event type */
>> +     GByteArray *midi_stream;     /* MIDI I/O byte stream */
>> +     gsize stream_size;           /* what is the maximum size of the mi=
di_stream array */
>> +     snd_midi_event_t *midi_ev;   /* midi<->seq event */
>> +};
>> +
>> +static inline int midi_write_init(struct midi_write_parser *parser, gsi=
ze buffer_size)
>> +{
>> +     parser->rtime =3D 0;
>> +     parser->rstate =3D SND_SEQ_EVENT_NONE;
>> +     parser->stream_size =3D buffer_size;
>> +
>> +     parser->midi_stream =3D g_byte_array_sized_new(buffer_size);
>> +     if (!parser->midi_stream)
>> +             return -ENOMEM;
>> +
>> +     return snd_midi_event_new(buffer_size, &parser->midi_ev);
>> +}
>> +
>> +static inline void midi_write_free(struct midi_write_parser *parser)
>> +{
>> +     g_byte_array_free(parser->midi_stream, TRUE);
>> +     snd_midi_event_free(parser->midi_ev);
>> +}
>> +
>> +static inline void midi_write_reset(struct midi_write_parser *parser)
>> +{
>> +     parser->rstate =3D SND_SEQ_EVENT_NONE;
>> +     g_byte_array_remove_range(parser->midi_stream, 0, parser->midi_str=
eam->len);
>> +}
>> +
>> +static inline gboolean midi_write_has_data(struct midi_write_parser *pa=
rser)
>> +{
>> +     return parser->midi_stream->len > 0;
>> +}
>> +
>> +static inline const guint8 * midi_write_data(struct midi_write_parser *=
parser)
>> +{
>> +     return parser->midi_stream->data;
>> +}
>> +
>> +static inline guint midi_write_data_size(struct midi_write_parser *pars=
er)
>> +{
>> +     return parser->midi_stream->len;
>> +}
>> +
>> +typedef void (*midi_read_ev_cb)(const guint8 *, guint, gpointer);
>> +
>> +/* It creates BLE-MIDI raw packets from the a sequencer event. If the p=
acket
>> +   is full, then it calls write_cb and resets its internal state as man=
y times
>> +   as necessary.
>> + */
>> +void midi_read_ev(struct midi_write_parser *parser, const snd_seq_event=
_t *ev,
>> +                  midi_read_ev_cb write_cb, gpointer user_data);
>> +
>> +/* MIDI I/O Read parser */
>> +
>> +struct midi_read_parser {
>> +     guint8 rstatus;            /* running status byte */
>> +     gint64 rtime;              /* last reader's real time */
>> +     gint16 timestamp;          /* last MIDI-BLE timestamp */
>> +     gint8 timestamp_low;       /* MIDI-BLE timestampLow from the curre=
nt packet */
>> +     gint8 timestamp_high;      /* MIDI-BLE timestampHigh from the curr=
ent packet */
>> +     GByteArray *sysex_stream;  /* SysEx stream */
>> +     snd_midi_event_t *midi_ev; /* midi<->seq event */
>> +};
>> +
>> +static inline int midi_read_init(struct midi_read_parser *parser)
>> +{
>> +     parser->rstatus =3D 0;
>> +     parser->rtime =3D -1;
>> +     parser->timestamp =3D 0;
>> +     parser->timestamp_low =3D 0;
>> +     parser->timestamp_high =3D 0;
>> +
>> +     parser->sysex_stream =3D g_byte_array_sized_new(MIDI_SYSEX_MAX_SIZ=
E);
>> +     if (!parser->sysex_stream)
>> +             return -ENOMEM;
>> +
>> +     return snd_midi_event_new(MIDI_MSG_MAX_SIZE, &parser->midi_ev);
>> +}
>> +
>> +static inline void midi_read_free(struct midi_read_parser *parser)
>> +{
>> +     g_byte_array_free(parser->sysex_stream, TRUE);
>> +     snd_midi_event_free(parser->midi_ev);
>> +}
>> +
>> +static inline void midi_read_reset(struct midi_read_parser *parser)
>> +{
>> +     parser->rstatus =3D 0;
>> +     parser->timestamp_low =3D 0;
>> +     parser->timestamp_high =3D 0;
>> +}
>> +
>> +/* Parses raw BLE-MIDI messages and populates a sequencer event represe=
nting the
>> +   current MIDI message. It returns how much raw data was processed.
>> + */
>> +gsize midi_read_raw(struct midi_read_parser *parser, const guint8 *data=
, gsize size,
>> +                    snd_seq_event_t *ev /* OUT */);
>> +
>> +#endif /* LIBMIDI_H */
>> diff --git a/profiles/midi/midi.c b/profiles/midi/midi.c
>> new file mode 100644
>> index 000000000000..403fe5f02191
>> --- /dev/null
>> +++ b/profiles/midi/midi.c
>> @@ -0,0 +1,491 @@
>> +/*
>> + *
>> + *  BlueZ - Bluetooth protocol stack for Linux
>> + *
>> + *  Copyright (C) 2015,2016 Felipe F. Tonello <eu@felipetonello.com>
>> + *  Copyright (C) 2016 ROLI Ltd.
>> + *
>> + *  This program is free software; you can redistribute it and/or modif=
y
>> + *  it under the terms of the GNU General Public License as published b=
y
>> + *  the Free Software Foundation; either version 2 of the License, or
>> + *  (at your option) any later version.
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *  GNU General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU General Public License
>> + *  along with this program; if not, write to the Free Software
>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-13=
01  USA
>> + *
>> + *  Information about this plugin:
>> + *
>> + *  This plugin implements the MIDI over Bluetooth Low-Energy (BLE-MIDI=
) 1.0
>> + *  specification as published by MMA in November/2015.
>> + *
>> + */
>> +
>> +#ifdef HAVE_CONFIG_H
>> +#include <config.h>
>> +#endif
>> +
>> +#include <errno.h>
>> +#include <stdbool.h>
>> +#include <glib.h>
>> +#include <alsa/asoundlib.h>
>> +
>> +#include "lib/bluetooth.h"
>> +#include "lib/sdp.h"
>> +#include "lib/uuid.h"
>> +
>> +#include "src/plugin.h"
>> +#include "src/adapter.h"
>> +#include "src/device.h"
>> +#include "src/profile.h"
>> +#include "src/service.h"
>> +#include "src/shared/util.h"
>> +#include "src/shared/att.h"
>> +#include "src/shared/queue.h"
>> +#include "src/shared/gatt-db.h"
>> +#include "src/shared/gatt-client.h"
>> +#include "src/shared/io.h"
>> +#include "src/log.h"
>> +#include "attrib/att.h"
>> +
>> +#include "libmidi.h"
>> +
>> +#define MIDI_UUID "03B80E5A-EDE8-4B33-A751-6CE34EC4C700"
>> +#define MIDI_IO_UUID "7772E5DB-3868-4112-A1A9-F2669D106BF3"
>> +
>> +struct midi {
>> +     struct btd_device *dev;
>> +     struct gatt_db *db;
>> +     struct bt_gatt_client *client;
>> +     guint io_cb_id;
>> +     struct io *io;
>> +     uint16_t midi_io_handle;
>> +
>> +     /* ALSA handlers */
>> +     snd_seq_t *seq_handle;
>> +     int seq_client_id;
>> +     int seq_port_id;
>> +
>> +     /* MIDI parser*/
>> +     struct midi_read_parser midi_in;
>> +     struct midi_write_parser midi_out;
>> +};
>> +
>> +static bool midi_write_cb(struct io *io, gpointer user_data)
>> +{
>> +     struct midi *midi =3D user_data;
>> +     int err;
>> +
>> +     void foreach_cb(const guint8 *data, guint size, gpointer user_data=
) {
>> +             struct midi *midi =3D user_data;
>> +             bt_gatt_client_write_without_response(midi->client,
>> +                                                   midi->midi_io_handle=
,
>> +                                                   false,
>> +                                                   data,
>> +                                                   size);
>> +     };
>> +
>> +     do {
>> +             snd_seq_event_t *event =3D NULL;
>> +
>> +             err =3D snd_seq_event_input(midi->seq_handle, &event);
>> +
>> +             if (err < 0 || !event)
>> +                     break;
>> +
>> +             midi_read_ev(&midi->midi_out, event, foreach_cb, midi);
>> +
>> +     } while (err > 0);
>> +
>> +     if (midi_write_has_data(&midi->midi_out))
>> +             bt_gatt_client_write_without_response(midi->client,
>> +                                                   midi->midi_io_handle=
,
>> +                                                   false,
>> +                                                   midi_write_data(&mid=
i->midi_out),
>> +                                                   midi_write_data_size=
(&midi->midi_out));
>> +
>> +     midi_write_reset(&midi->midi_out);
>> +
>> +     return true;
>> +}
>> +
>> +static void midi_io_value_cb(uint16_t value_handle, const uint8_t *valu=
e,
>> +                             uint16_t length, gpointer user_data)
>> +{
>> +     struct midi *midi =3D user_data;
>> +     snd_seq_event_t ev;
>> +     guint i =3D 0;
>> +
>> +     if (length < 3) {
>> +             warn("MIDI I/O: Wrong packet format: length is %u bytes bu=
t it should "
>> +                  "be at least 3 bytes", length);
>> +             return;
>> +     }
>> +
>> +     snd_seq_ev_clear(&ev);
>> +     snd_seq_ev_set_source(&ev, midi->seq_port_id);
>> +     snd_seq_ev_set_subs(&ev);
>> +     snd_seq_ev_set_direct(&ev);
>> +
>> +     midi_read_reset(&midi->midi_in);
>> +
>> +     while (i < length) {
>> +             gsize count =3D midi_read_raw(&midi->midi_in, value + i, l=
ength - i, &ev);
>> +
>> +             if (count =3D=3D 0)
>> +                     goto _err;
>> +
>> +             if (ev.type !=3D SND_SEQ_EVENT_NONE)
>> +                     snd_seq_event_output_direct(midi->seq_handle, &ev)=
;
>> +
>> +             i +=3D count;
>> +     }
>> +
>> +     return;
>> +
>> +_err:
>> +     error("Wrong BLE-MIDI message");
>> +}
>> +
>> +static void midi_io_ccc_written_cb(uint16_t att_ecode, gpointer user_da=
ta)
>> +{
>> +     if (att_ecode !=3D 0) {
>> +             error("MIDI I/O: notifications not enabled %s",
>> +                   att_ecode2str(att_ecode));
>> +             return;
>> +     }
>> +
>> +     DBG("MIDI I/O: notification enabled");
>> +}
>> +
>> +static void midi_io_initial_read_cb(bool success, uint8_t att_ecode,
>> +                                    const uint8_t *value, uint16_t leng=
th,
>> +                                    gpointer user_data)
>> +{
>> +     struct midi *midi =3D user_data;
>> +
>> +     if (!success) {
>> +             error("MIDI I/O: Failed to read initial request");
>> +             return;
>> +     }
>> +
>> +     /* request notify */
>> +     midi->io_cb_id =3D
>> +             bt_gatt_client_register_notify(midi->client,
>> +                                            midi->midi_io_handle,
>> +                                            midi_io_ccc_written_cb,
>> +                                            midi_io_value_cb,
>> +                                            midi,
>> +                                            NULL);
>> +
>> +}
>> +
>> +static void handle_midi_io(struct midi *midi, uint16_t value_handle)
>> +{
>> +     DBG("MIDI I/O handle: 0x%04x", value_handle);
>> +
>> +     midi->midi_io_handle =3D value_handle;
>> +
>> +     /*
>> +      * The BLE-MIDI 1.0 spec specifies that The Centrail shall attempt=
 to
>> +      * read the MIDI I/O characteristic of the Peripheral right after
>> +      * estrablhishing a connection with the accessory.
>> +      */
>> +     if (!bt_gatt_client_read_value(midi->client,
>> +                                    value_handle,
>> +                                    midi_io_initial_read_cb,
>> +                                    midi,
>> +                                    NULL))
>> +             DBG("MIDI I/O: Failed to send request to read initial valu=
e");
>> +}
>> +
>> +static void handle_characteristic(struct gatt_db_attribute *attr,
>> +                                  gpointer user_data)
>> +{
>> +     struct midi *midi =3D user_data;
>> +     uint16_t value_handle;
>> +     bt_uuid_t uuid, midi_io_uuid;
>> +
>> +     if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle, NU=
LL,
>> +                                          NULL, &uuid)) {
>> +             error("Failed to obtain characteristic data");
>> +             return;
>> +     }
>> +
>> +     bt_string_to_uuid(&midi_io_uuid, MIDI_IO_UUID);
>> +
>> +     if (bt_uuid_cmp(&midi_io_uuid, &uuid) =3D=3D 0)
>> +             handle_midi_io(midi, value_handle);
>> +     else {
>> +             char uuid_str[MAX_LEN_UUID_STR];
>> +
>> +             bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
>> +             DBG("Unsupported characteristic: %s", uuid_str);
>> +     }
>> +}
>> +
>> +static void foreach_midi_service(struct gatt_db_attribute *attr,
>> +                                 gpointer user_data)
>> +{
>> +     struct midi *midi =3D user_data;
>> +
>> +     gatt_db_service_foreach_char(attr, handle_characteristic, midi);
>> +}
>> +
>> +static int midi_device_probe(struct btd_service *service)
>> +{
>> +     struct btd_device *device =3D btd_service_get_device(service);
>> +     struct midi *midi;
>> +     char addr[18];
>> +
>> +     ba2str(device_get_address(device), addr);
>> +     DBG("MIDI GATT Driver profile probe (%s)", addr);
>> +
>> +     /* Ignore, if we were probed for this device already */
>> +     midi =3D btd_service_get_user_data(service);
>> +     if (midi) {
>> +             error("Profile probed twice for the same device!");
>> +             return -EADDRINUSE;
>> +     }
>> +
>> +     midi =3D g_new0(struct midi, 1);
>> +     if (!midi)
>> +             return -ENOMEM;
>> +
>> +     midi->dev =3D btd_device_ref(device);
>> +
>> +     btd_service_set_user_data(service, midi);
>> +
>> +     return 0;
>> +}
>> +
>> +static void midi_device_remove(struct btd_service *service)
>> +{
>> +     struct btd_device *device =3D btd_service_get_device(service);
>> +     struct midi *midi;
>> +     char addr[18];
>> +
>> +     ba2str(device_get_address(device), addr);
>> +     DBG("MIDI GATT Driver profile remove (%s)", addr);
>> +
>> +     midi =3D btd_service_get_user_data(service);
>> +     if (!midi) {
>> +             error("MIDI Service not handled by profile");
>> +             return;
>> +     }
>> +
>> +     btd_device_unref(midi->dev);
>> +     g_free(midi);
>> +}
>> +
>> +static int midi_accept(struct btd_service *service)
>> +{
>> +     struct btd_device *device =3D btd_service_get_device(service);
>> +     struct gatt_db *db =3D btd_device_get_gatt_db(device);
>> +     struct bt_gatt_client *client =3D btd_device_get_gatt_client(devic=
e);
>> +     bt_uuid_t midi_uuid;
>> +     struct pollfd pfd;
>> +     struct midi *midi;
>> +     char addr[18];
>> +     char port_name[MAX_NAME_LENGTH];
>> +     int err;
>> +     snd_seq_client_info_t *info;
>> +
>> +     ba2str(device_get_address(device), addr);
>> +     DBG("MIDI GATT Driver profile accept (%s)", addr);
>> +
>> +     midi =3D btd_service_get_user_data(service);
>> +     if (!midi) {
>> +             error("MIDI Service not handled by profile");
>> +             return -ENODEV;
>> +     }
>> +
>> +     /* Port Name */
>> +     memset(port_name, 0, sizeof(port_name));
>> +     if (device_name_known(device))
>> +             device_get_name(device, port_name, sizeof(port_name));
>> +     else
>> +             strncpy(port_name, addr, sizeof(addr));
>> +
>> +     /* ALSA Sequencer Client and Port Setup */
>> +     err =3D snd_seq_open(&midi->seq_handle, "default", SND_SEQ_OPEN_DU=
PLEX, 0);
>> +     if (err < 0) {
>> +             error("Could not open ALSA Sequencer: %s (%d)", snd_strerr=
or(err), err);
>> +             return err;
>> +     }
>> +
>> +     err =3D snd_seq_nonblock(midi->seq_handle, SND_SEQ_NONBLOCK);
>> +     if (err < 0) {
>> +             error("Could not set nonblock mode: %s (%d)", snd_strerror=
(err), err);
>> +             goto _err_handle;
>> +     }
>> +
>> +     err =3D snd_seq_set_client_name(midi->seq_handle, port_name);
>> +     if (err < 0) {
>> +             error("Could not configure ALSA client: %s (%d)", snd_stre=
rror(err), err);
>> +             goto _err_handle;
>> +     }
>> +
>> +     err =3D snd_seq_client_id(midi->seq_handle);
>> +     if (err < 0) {
>> +             error("Could retreive ALSA client: %s (%d)", snd_strerror(=
err), err);
>> +             goto _err_handle;
>> +     }
>> +     midi->seq_client_id =3D err;
>> +
>> +     err =3D snd_seq_create_simple_port(midi->seq_handle, port_name,
>> +                                      SND_SEQ_PORT_CAP_READ |
>> +                                      SND_SEQ_PORT_CAP_WRITE |
>> +                                      SND_SEQ_PORT_CAP_SUBS_READ |
>> +                                      SND_SEQ_PORT_CAP_SUBS_WRITE,
>> +                                      SND_SEQ_PORT_TYPE_MIDI_GENERIC |
>> +                                      SND_SEQ_PORT_TYPE_HARDWARE);
>> +     if (err < 0) {
>> +             error("Could not create ALSA port: %s (%d)", snd_strerror(=
err), err);
>> +             goto _err_handle;
>> +     }
>> +     midi->seq_port_id =3D err;
>> +
>> +     snd_seq_client_info_alloca(&info);
>> +     err =3D snd_seq_get_client_info(midi->seq_handle, info);
>> +     if (err < 0)
>> +             goto _err_port;
>> +
>> +     /* list of relevant sequencer events */
>> +     snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_NOTEOFF);
>> +     snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_NOTEON);
>> +     snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_KEYPRESS)=
;
>> +     snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_CONTROLLE=
R);
>> +     snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_PGMCHANGE=
);
>> +     snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_CHANPRESS=
);
>> +     snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_PITCHBEND=
);
>> +     snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_SYSEX);
>> +     snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_QFRAME);
>> +     snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_SONGPOS);
>> +     snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_SONGSEL);
>> +     snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_TUNE_REQU=
EST);
>> +     snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_CLOCK);
>> +     snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_START);
>> +     snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_CONTINUE)=
;
>> +     snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_STOP);
>> +     snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_SENSING);
>> +     snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_RESET);
>> +     snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_CONTROL14=
);
>> +     snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_NONREGPAR=
AM);
>> +     snd_seq_client_info_event_filter_add(info, SND_SEQ_EVENT_REGPARAM)=
;
>> +
>> +     err =3D snd_seq_set_client_info(midi->seq_handle, info);
>> +     if (err < 0)
>> +             goto _err_port;
>> +
>> +
>> +     /* Input file descriptors */
>> +     snd_seq_poll_descriptors(midi->seq_handle, &pfd, 1, POLLIN);
>> +
>> +     midi->io =3D io_new(pfd.fd);
>> +     if (!midi->io) {
>> +             error("Could not allocate I/O eventloop");
>> +             goto _err_port;
>> +     }
>> +
>> +     io_set_read_handler(midi->io, midi_write_cb, midi, NULL);
>> +
>> +     midi->db =3D gatt_db_ref(db);
>> +     midi->client =3D bt_gatt_client_ref(client);
>> +
>> +     err =3D midi_read_init(&midi->midi_in);
>> +     if (err < 0) {
>> +             error("Could not initialise MIDI input parser");
>> +             goto _err_port;
>> +     }
>> +
>> +     err =3D midi_write_init(&midi->midi_out, bt_gatt_client_get_mtu(mi=
di->client) - 3);
>> +     if (err < 0) {
>> +             error("Could not initialise MIDI output parser");
>> +             goto _err_midi;
>> +     }
>> +
>> +     bt_string_to_uuid(&midi_uuid, MIDI_UUID);
>> +     gatt_db_foreach_service(db, &midi_uuid, foreach_midi_service, midi=
);
>> +
>> +     btd_service_connecting_complete(service, 0);
>> +
>> +     return 0;
>> +
>> +_err_midi:
>> +     midi_read_free(&midi->midi_in);
>> +
>> +_err_port:
>> +     snd_seq_delete_simple_port(midi->seq_handle, midi->seq_port_id);
>> +
>> +_err_handle:
>> +     snd_seq_close(midi->seq_handle);
>> +     midi->seq_handle =3D NULL;
>> +
>> +     return err;
>> +}
>> +
>> +static int midi_disconnect(struct btd_service *service)
>> +{
>> +     struct btd_device *device =3D btd_service_get_device(service);
>> +     struct midi *midi;
>> +     char addr[18];
>> +
>> +     ba2str(device_get_address(device), addr);
>> +     DBG("MIDI GATT Driver profile disconnect (%s)", addr);
>> +
>> +     midi =3D btd_service_get_user_data(service);
>> +     if (!midi) {
>> +             error("MIDI Service not handled by profile");
>> +             return -ENODEV;
>> +     }
>> +
>> +     midi_read_free(&midi->midi_in);
>> +     midi_write_free(&midi->midi_out);
>> +     io_destroy(midi->io);
>> +     snd_seq_delete_simple_port(midi->seq_handle, midi->seq_port_id);
>> +     midi->seq_port_id =3D 0;
>> +     snd_seq_close(midi->seq_handle);
>> +     midi->seq_handle =3D NULL;
>> +
>> +     /* Clean-up any old client/db */
>> +     bt_gatt_client_unregister_notify(midi->client, midi->io_cb_id);
>> +     bt_gatt_client_unref(midi->client);
>> +     gatt_db_unref(midi->db);
>> +
>> +     btd_service_disconnecting_complete(service, 0);
>> +
>> +     return 0;
>> +}
>> +
>> +static struct btd_profile midi_profile =3D {
>> +     .name =3D "MIDI GATT Driver",
>> +     .remote_uuid =3D MIDI_UUID,
>> +     .priority =3D BTD_PROFILE_PRIORITY_HIGH,
>> +     .auto_connect =3D true,
>> +
>> +     .device_probe =3D midi_device_probe,
>> +     .device_remove =3D midi_device_remove,
>> +
>> +     .accept =3D midi_accept,
>> +
>> +     .disconnect =3D midi_disconnect,
>> +};
>> +
>> +static int midi_init(void)
>> +{
>> +     return btd_profile_register(&midi_profile);
>> +}
>> +
>> +static void midi_exit(void)
>> +{
>> +     btd_profile_unregister(&midi_profile);
>> +}
>> +
>> +BLUETOOTH_PLUGIN_DEFINE(midi, VERSION, BLUETOOTH_PLUGIN_PRIORITY_HIGH,
>> +                        midi_init, midi_exit);
>> diff --git a/unit/test-midi.c b/unit/test-midi.c
>> new file mode 100644
>> index 000000000000..f786c767d7df
>> --- /dev/null
>> +++ b/unit/test-midi.c
>> @@ -0,0 +1,464 @@
>> +/*
>> + *
>> + *  BlueZ - Bluetooth protocol stack for Linux
>> + *
>> + *  Copyright (C) 2015,2016 Felipe F. Tonello <eu@felipetonello.com>
>> + *  Copyright (C) 2016 ROLI Ltd.
>> + *
>> + *  This program is free software; you can redistribute it and/or modif=
y
>> + *  it under the terms of the GNU General Public License as published b=
y
>> + *  the Free Software Foundation; either version 2 of the License, or
>> + *  (at your option) any later version.
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *  GNU General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU General Public License
>> + *  along with this program; if not, write to the Free Software
>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-13=
01  USA
>> + *
>> + *
>> + */
>> +
>> +#ifdef HAVE_CONFIG_H
>> +#include <config.h>
>> +#endif
>> +
>> +#define NUM_WRITE_TESTS 10
>> +
>> +#include "src/shared/tester.h"
>> +#include "profiles/midi/libmidi.h"
>> +
>> +struct ble_midi_packet {
>> +     const guint8 *data;
>> +     gsize size;
>> +};
>> +
>> +#define BLE_MIDI_PACKET_INIT(_packet) \
>> +     { \
>> +             .data =3D _packet, \
>> +             .size =3D sizeof(_packet), \
>> +     }
>> +
>> +struct midi_read_test {
>> +     const struct ble_midi_packet *ble_packet;
>> +     gsize ble_packet_size;
>> +     const snd_seq_event_t *event;
>> +     gsize event_size;
>> +};
>> +
>> +#define BLE_READ_TEST_INIT(_ble_packet, _event) \
>> +     { \
>> +             .ble_packet =3D _ble_packet, \
>> +             .ble_packet_size =3D G_N_ELEMENTS(_ble_packet), \
>> +             .event =3D _event, \
>> +             .event_size =3D G_N_ELEMENTS(_event), \
>> +     }
>> +
>> +struct midi_write_test {
>> +     const snd_seq_event_t *event;
>> +     gsize event_size;
>> +};
>> +
>> +#define BLE_WRITE_TEST_INIT(_event) \
>> +     { \
>> +             .event =3D _event, \
>> +             .event_size =3D G_N_ELEMENTS(_event), \
>> +     }
>> +
>> +
>> +#define NOTE_EVENT(_event, _channel, _note, _velocity) \
>> +     { \
>> +             .type =3D SND_SEQ_EVENT_##_event, \
>> +             .data =3D { \
>> +                     .note =3D { \
>> +                             .channel =3D (_channel), \
>> +                             .note =3D (_note), \
>> +                             .velocity =3D (_velocity), \
>> +                     }, \
>> +             }, \
>> +     }
>> +
>> +#define CONTROL_EVENT(_event, _channel, _value, _param) \
>> +     { \
>> +             .type =3D SND_SEQ_EVENT_##_event, \
>> +             .data =3D { \
>> +                     .control =3D { \
>> +                             .channel =3D (_channel), \
>> +                             .value =3D (_value), \
>> +                             .param =3D (_param), \
>> +                     }, \
>> +             }, \
>> +     }
>> +
>> +#define SYSEX_EVENT(_message) \
>> +     { \
>> +             .type =3D SND_SEQ_EVENT_SYSEX, \
>> +             .data =3D { \
>> +                     .ext =3D { \
>> +                             .ptr =3D (void *)_message, \
>> +                             .len =3D sizeof(_message), \
>> +                     }, \
>> +             }, \
>> +     }
>> +
>> +/* Multiple messages in one packet */
>> +static const guint8 packet1_1[] =3D {
>> +     0xa6, 0x88, 0xe8, 0x00, 0x40, 0x88, 0xb8, 0x4a,
>> +     0x3f, 0x88, 0x98, 0x3e, 0x0e
>> +};
>> +
>> +/* Several one message per packet */
>> +static const guint8 packet1_2[] =3D {
>> +     0xa6, 0xaa, 0xd8, 0x71
>> +};
>> +
>> +static const guint8 packet1_3[] =3D {
>> +     0xa6, 0xb7, 0xb8, 0x4a, 0x43
>> +};
>> +
>> +/* This message contains a running status message */
>> +static const guint8 packet1_4[] =3D {
>> +     0xa6, 0xc4, 0xe8, 0x7e, 0x3f, 0x7d, 0x3f, 0xc4,
>> +     0x7c, 0x3f
>> +};
>> +
>> +/* This message contain a running status message misplaced */
>> +static const guint8 packet1_5[] =3D {
>> +     0xa6, 0xd9, 0x3e, 0x00, 0x88, 0x3e, 0x00
>> +};
>> +
>> +static const struct ble_midi_packet packet1[] =3D {
>> +     BLE_MIDI_PACKET_INIT(packet1_1),
>> +     BLE_MIDI_PACKET_INIT(packet1_2),
>> +     BLE_MIDI_PACKET_INIT(packet1_3),
>> +     BLE_MIDI_PACKET_INIT(packet1_4),
>> +     BLE_MIDI_PACKET_INIT(packet1_5),
>> +};
>> +
>> +static const snd_seq_event_t event1[] =3D {
>> +     CONTROL_EVENT(PITCHBEND, 8, 0, 0),    /* Pitch Bend */
>> +     CONTROL_EVENT(CONTROLLER, 8, 63, 74), /* Control Change */
>> +     NOTE_EVENT(NOTEON, 8, 62, 14),        /* Note On */
>> +     CONTROL_EVENT(CHANPRESS, 8, 113, 0),  /* Channel Aftertouch */
>> +     CONTROL_EVENT(CONTROLLER, 8, 67, 74), /* Control Change*/
>> +     CONTROL_EVENT(PITCHBEND, 8, -2, 0),   /* Pitch Bend */
>> +     CONTROL_EVENT(PITCHBEND, 8, -3, 0),   /* Pitch Bend */
>> +     CONTROL_EVENT(PITCHBEND, 8, -4, 0),   /* Pitch Bend */
>> +     NOTE_EVENT(NOTEOFF, 8, 62, 0),        /* Note Off */
>> +};
>> +
>> +static const struct midi_read_test midi1 =3D BLE_READ_TEST_INIT(packet1=
, event1);
>> +
>> +/* Basic SysEx in one packet */
>> +static const guint8 packet2_1[] =3D {
>> +     0xa6, 0xda, 0xf0, 0x01, 0x02, 0x03, 0xda, 0xf7
>> +};
>> +
>> +/* SysEx across two packets */
>> +static const guint8 packet2_2[] =3D {
>> +     0xa6, 0xda, 0xf0, 0x01, 0x02, 0x03, 0x04, 0x05
>> +};
>> +
>> +static const guint8 packet2_3[] =3D {
>> +     0xa6, 0x06, 0x07, 0x08, 0x09, 0x0a, 0xdb, 0xf7
>> +};
>> +
>> +/* SysEx across multiple packets */
>> +static const guint8 packet2_4[] =3D {
>> +     0xa6, 0xda, 0xf0, 0x01, 0x02, 0x03, 0x04, 0x05
>> +};
>> +
>> +static const guint8 packet2_5[] =3D {
>> +     0xa6, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c
>> +};
>> +static const guint8 packet2_6[] =3D {
>> +     0xa6, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13
>> +};
>> +
>> +static const guint8 packet2_7[] =3D {
>> +     0xa6, 0x14, 0x15, 0x16, 0x17, 0x18, 0xdb, 0xf7
>> +};
>> +
>> +/* Two SysEx interleaved in two packets */
>> +static const guint8 packet2_8[] =3D {
>> +     0xa6, 0xda, 0xf0, 0x01, 0x02, 0x03, 0xda, 0xf7,
>> +     0xda, 0xf0
>> +};
>> +
>> +static const guint8 packet2_9[] =3D {
>> +     0xa6, 0x06, 0x07, 0x08, 0x09, 0x0a, 0xdb, 0xf7
>> +};
>> +
>> +
>> +static const struct ble_midi_packet packet2[] =3D {
>> +     BLE_MIDI_PACKET_INIT(packet2_1),
>> +     BLE_MIDI_PACKET_INIT(packet2_2),
>> +     BLE_MIDI_PACKET_INIT(packet2_3),
>> +     BLE_MIDI_PACKET_INIT(packet2_4),
>> +     BLE_MIDI_PACKET_INIT(packet2_5),
>> +     BLE_MIDI_PACKET_INIT(packet2_6),
>> +     BLE_MIDI_PACKET_INIT(packet2_7),
>> +     BLE_MIDI_PACKET_INIT(packet2_8),
>> +     BLE_MIDI_PACKET_INIT(packet2_9),
>> +};
>> +
>> +static const guint8 sysex2_1[] =3D {
>> +     0xf0, 0x01, 0x02, 0x03, 0xf7
>> +};
>> +
>> +static const guint8 sysex2_2[] =3D {
>> +     0xf0, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
>> +     0x08, 0x09, 0x0a, 0xf7
>> +};
>> +
>> +static const guint8 sysex2_3[] =3D {
>> +     0xf0, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
>> +     0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
>> +     0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
>> +     0x18, 0xf7
>> +};
>> +
>> +static const guint8 sysex2_4[] =3D {
>> +     0xf0, 0x01, 0x02, 0x03, 0xf7
>> +};
>> +
>> +static const guint8 sysex2_5[] =3D {
>> +     0xf0, 0x06, 0x07, 0x08, 0x09, 0x0a, 0xf7
>> +};
>> +
>> +static const snd_seq_event_t event2[] =3D {
>> +     SYSEX_EVENT(sysex2_1),
>> +     SYSEX_EVENT(sysex2_2),
>> +     SYSEX_EVENT(sysex2_3),
>> +     SYSEX_EVENT(sysex2_4),
>> +     SYSEX_EVENT(sysex2_5),
>> +};
>> +
>> +static const struct midi_read_test midi2 =3D BLE_READ_TEST_INIT(packet2=
, event2);
>> +
>> +static void compare_events(const snd_seq_event_t *ev1,
>> +                           const snd_seq_event_t *ev2)
>> +{
>> +     g_assert_cmpint(ev1->type, =3D=3D, ev2->type);
>> +
>> +     switch (ev1->type) {
>> +     case SND_SEQ_EVENT_NOTEON:
>> +     case SND_SEQ_EVENT_NOTEOFF:
>> +     case SND_SEQ_EVENT_KEYPRESS:
>> +             g_assert_cmpint(ev1->data.note.channel,
>> +                             =3D=3D,
>> +                             ev2->data.note.channel);
>> +             g_assert_cmpint(ev1->data.note.note,
>> +                             =3D=3D,
>> +                             ev2->data.note.note);
>> +             g_assert_cmpint(ev1->data.note.velocity,
>> +                             =3D=3D,
>> +                             ev2->data.note.velocity);
>> +             break;
>> +     case SND_SEQ_EVENT_CONTROLLER:
>> +             g_assert_cmpint(ev1->data.control.param,
>> +                             =3D=3D,
>> +                             ev2->data.control.param);
>> +     case SND_SEQ_EVENT_PITCHBEND:
>> +     case SND_SEQ_EVENT_CHANPRESS:
>> +     case SND_SEQ_EVENT_PGMCHANGE:
>> +             g_assert_cmpint(ev1->data.control.channel,
>> +                             =3D=3D,
>> +                             ev2->data.control.channel);
>> +             g_assert_cmpint(ev1->data.control.value,
>> +                             =3D=3D,
>> +                             ev2->data.control.value);
>> +             break;
>> +     case SND_SEQ_EVENT_SYSEX:
>> +             g_assert_cmpmem(ev1->data.ext.ptr, ev1->data.ext.len,
>> +                             ev2->data.ext.ptr, ev2->data.ext.len);
>> +             break;
>> +     default:
>> +             g_assert_not_reached();
>> +     }
>> +}
>> +
>> +static void test_midi_reader(gconstpointer data)
>> +{
>> +     const struct midi_read_test *midi_test =3D data;
>> +     struct midi_read_parser midi;
>> +     int err;
>> +     gsize i; /* ble_packet counter */
>> +     gsize j; /* ble_packet length counter */
>> +     gsize k =3D 0; /* event counter */
>> +
>> +     err =3D midi_read_init(&midi);
>> +     g_assert_cmpint(err, =3D=3D, 0);
>> +
>> +     for (i =3D 0; i < midi_test->ble_packet_size; i++) {
>> +             const gsize length =3D midi_test->ble_packet[i].size;
>> +             j =3D 0;
>> +             midi_read_reset(&midi);
>> +             while (j < length) {
>> +                     snd_seq_event_t ev;
>> +                     const snd_seq_event_t *ev_expect =3D &midi_test->e=
vent[k];
>> +                     gsize count;
>> +
>> +                     g_assert_cmpint(k, <, midi_test->event_size);
>> +
>> +                     snd_seq_ev_clear(&ev);
>> +
>> +                     count =3D midi_read_raw(&midi,
>> +                                           midi_test->ble_packet[i].dat=
a + j,
>> +                                           length - j,
>> +                                           &ev);
>> +
>> +                     g_assert_cmpuint(count, >, 0);
>> +
>> +                     if (ev.type =3D=3D SND_SEQ_EVENT_NONE)
>> +                             goto _continue_loop;
>> +                     else
>> +                             k++;
>> +
>> +                     compare_events(ev_expect, &ev);
>> +
>> +             _continue_loop:
>> +                     j +=3D count;
>> +             }
>> +     }
>> +
>> +     midi_read_free(&midi);
>> +
>> +     tester_test_passed();
>> +}
>> +
>> +static const snd_seq_event_t event3[] =3D {
>> +     CONTROL_EVENT(PITCHBEND, 8, 0, 0),    /* Pitch Bend */
>> +     CONTROL_EVENT(CONTROLLER, 8, 63, 74), /* Control Change */
>> +     NOTE_EVENT(NOTEON, 8, 62, 14),        /* Note On */
>> +     CONTROL_EVENT(CHANPRESS, 8, 113, 0),  /* Channel Aftertouch */
>> +     CONTROL_EVENT(CONTROLLER, 8, 67, 74), /* Control Change*/
>> +     CONTROL_EVENT(PITCHBEND, 8, -2, 0),   /* Pitch Bend */
>> +     CONTROL_EVENT(PITCHBEND, 8, -3, 0),   /* Pitch Bend */
>> +     CONTROL_EVENT(PITCHBEND, 8, -4, 0),   /* Pitch Bend */
>> +     NOTE_EVENT(NOTEOFF, 8, 62, 0),        /* Note Off */
>> +};
>> +
>> +static const struct midi_write_test midi3 =3D BLE_WRITE_TEST_INIT(event=
3);
>> +
>> +static const guint8 sysex4_1[] =3D {
>> +     0xf0, 0x01, 0x02, 0x03, 0xf7
>> +};
>> +
>> +static const guint8 sysex4_2[] =3D {
>> +     0xf0, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
>> +     0x08, 0x09, 0x0a, 0xf7
>> +};
>> +
>> +static const guint8 sysex4_3[] =3D {
>> +     0xf0, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
>> +     0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
>> +     0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
>> +     0x18, 0xf7
>> +};
>> +
>> +static const guint8 sysex4_4[] =3D {
>> +     0xf0, 0x01, 0x02, 0x03, 0xf7
>> +};
>> +
>> +static const guint8 sysex4_5[] =3D {
>> +     0xf0, 0x06, 0x07, 0x08, 0x09, 0x0a, 0xf7
>> +};
>> +
>> +static const snd_seq_event_t event4[] =3D {
>> +     SYSEX_EVENT(sysex4_1),
>> +     SYSEX_EVENT(sysex4_2),
>> +     SYSEX_EVENT(sysex4_3),
>> +     SYSEX_EVENT(sysex4_4),
>> +     SYSEX_EVENT(sysex4_5),
>> +};
>> +
>> +static const struct midi_write_test midi4 =3D BLE_WRITE_TEST_INIT(event=
4);
>> +
>> +static void test_midi_writer(gconstpointer data)
>> +{
>> +     const struct midi_write_test *midi_test =3D data;
>> +     struct midi_write_parser midi_out;
>> +     struct midi_read_parser midi_in;
>> +     gsize i; /* event counter */
>> +     gsize j; /* test counter */
>> +     static struct midi_data {
>> +             gsize events_tested;
>> +             const struct midi_write_test *midi_test;
>> +             struct midi_read_parser *midi_in;
>> +     } midi_data;
>> +
>> +     void compare_events_cb(const guint8 *data, guint size, gpointer us=
er_data) {
>> +             struct midi_data *midi_data =3D user_data;
>> +             const struct midi_write_test *midi_test =3D midi_data->mid=
i_test;
>> +             struct midi_read_parser *midi_in =3D midi_data->midi_in;
>> +             gsize i =3D 0;
>> +
>> +             midi_read_reset(midi_in);
>> +
>> +             while (i < size) {
>> +                     snd_seq_event_t ev;
>> +                     gsize count;
>> +
>> +                     snd_seq_ev_clear(&ev);
>> +
>> +                     count =3D midi_read_raw(midi_in, data + i,
>> +                                           size - i, &ev);
>> +
>> +                     g_assert_cmpuint(count, >, 0);
>> +
>> +                     if (ev.type !=3D SND_SEQ_EVENT_NONE){
>> +                             g_assert_cmpint(midi_data->events_tested,
>> +                                             <,
>> +                                             midi_test->event_size);
>> +                             compare_events(&midi_test->event[midi_data=
->events_tested],
>> +                                            &ev);
>> +                             midi_data->events_tested++;
>> +                     }
>> +
>> +                     i +=3D count;
>> +             }
>> +     };
>> +
>> +     midi_read_init(&midi_in);
>> +
>> +     for (j =3D 0; j < NUM_WRITE_TESTS; j++) {
>> +
>> +             /* Range of test for different MTU sizes. The spec specifi=
es
>> +                sizes of packet as MTU - 3 */
>> +             midi_write_init(&midi_out, g_random_int_range(5, 40));
>> +
>> +             midi_data.events_tested =3D 0;
>> +             midi_data.midi_test =3D midi_test;
>> +             midi_data.midi_in =3D &midi_in;
>> +
>> +             for (i =3D 0; i < midi_test->event_size; i++)
>> +                     midi_read_ev(&midi_out, &midi_test->event[i],
>> +                                  compare_events_cb, &midi_data);
>> +
>> +             if (midi_write_has_data(&midi_out))
>> +                     compare_events_cb(midi_write_data(&midi_out),
>> +                                       midi_write_data_size(&midi_out),
>> +                                       &midi_data);
>> +
>> +             midi_write_free(&midi_out);
>> +     }
>> +     midi_read_free(&midi_in);
>> +
>> +     tester_test_passed();
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +     tester_init(&argc, &argv);
>> +
>> +     tester_add("/midi/1", &midi1, NULL, test_midi_reader, NULL);
>> +     tester_add("/midi/2", &midi2, NULL, test_midi_reader, NULL);
>> +     tester_add("/midi/3", &midi3, NULL, test_midi_writer, NULL);
>> +     tester_add("/midi/4", &midi4, NULL, test_midi_writer, NULL);
>> +
>> +     return tester_run();
>> +}
>>
>
> --
> Felipe



--=20
Luiz Augusto von Dentz
