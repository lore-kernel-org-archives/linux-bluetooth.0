Return-Path: <SRS0=H/dM=OB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F72C43441
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Nov 2018 09:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC2520820
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Nov 2018 09:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOcKuLFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC2520820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405149AbeKVU02 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:26:28 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:41456 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731614AbeKVU01 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Nov 2018 15:26:27 -0500
Received: by mail-oi1-f179.google.com with SMTP id j21so6966844oii.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Nov 2018 01:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B39SaTjeZcnCCcWndQshx8cu421fEhlDPAL0lxuV7yk=;
        b=WOcKuLFhPAMcWvPX8cEnLS03nn4/9oStjDRrzvZ/zNN9RdqNkp6ULrbJ/B3VdAKuOE
         7FJ37135avWolU+pwWF/22anL6w+/T4xxnkZZvEvyIziE84s/akxbsWDi2LjBpvLnRoX
         9RkvolHQjyR75mpHEgNgOAb9JgYzclfemcl7x0vfgUqZsh7Y+cjBDoHf1JGoAolEoJLH
         LlJBWqovBlK2pkXQ2lOytVnGJ83nt9qIIJoIDMmIwu4RBfc7hHpIujxIO5NaY9cN8BG9
         pyF02/w/wJFRXPhKUHG0l3es1zXfRJkZtKw32+e3CAg9Zh/oBHNpyiqBY1BzojvgJVtE
         0XpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B39SaTjeZcnCCcWndQshx8cu421fEhlDPAL0lxuV7yk=;
        b=IRGWmWyyAYiI3wIBehRr77eYbKEzS8mxFZwLXkJxSdIKKA7UwOuk+x3fXdBTFfKCIL
         6zXo9ME3ohcew95AtlC/O4+sV4tsLcRNSzOIpymeRYokH+UfLX1ImhMwToyJ3zLhclxE
         IuybivhwK8qEjy97aGCcr2q95fMbpZGQ7qcTIQ+QbHL+D16IUln0dQgY7cxpdx+TCoer
         0auK/N/14VLqj9mfmhnbkdOt5zHmyFOHjtRQSLgc5wWd9FBzBOvC4PMS/PnpM6EkNpGz
         ri44EAyZa9lMEv/zI7eulfM/UEHJ98Az7Ri6j+BxeQq2SSyrdcQiGMmw5UsCn6MsbKGK
         HGYA==
X-Gm-Message-State: AGRZ1gIcK3+jl6+K9aS3yD5nDkjEIhOoI/jNqXILy1CNMZHTohtSPaSa
        oluP/qtKQUlqsNik2rNDbCbxIOjBdum3+7n8QhewUg5Q
X-Google-Smtp-Source: AJdET5dWUtbZ0m4/mfdwLp0+6Xwt3YlI9u7RlenNf4AH8YMYR3gvbxfjyW4DcG3wASGV1Suvct4CC3OH25my+ibNglc=
X-Received: by 2002:aca:d509:: with SMTP id m9mr5462729oig.82.1542880063345;
 Thu, 22 Nov 2018 01:47:43 -0800 (PST)
MIME-Version: 1.0
References: <CABBYNZ+pLp5W0_sNC4ih_KuW2WmX5drBL2bPX4rG4fHQ4kyecg@mail.gmail.com>
 <20181121125753.15476-1-jengelh@inai.de> <20181121125753.15476-2-jengelh@inai.de>
In-Reply-To: <20181121125753.15476-2-jengelh@inai.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 22 Nov 2018 11:47:31 +0200
Message-ID: <CABBYNZL0jgnZTYSQ+c+54_fHudK+0fg-GwS_-LUzw7gde_aMyA@mail.gmail.com>
Subject: Re: [PATCH 1/7] build: change @foo@ to $(foo) in automake makefiles
To:     jengelh@inai.de
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jan,
On Wed, Nov 21, 2018 at 2:58 PM Jan Engelhardt <jengelh@inai.de> wrote:
>
> When using automake, all AC_SUBSTed variables are made available as
> make variables, so that they can also be set at make time. Therefore,
> they need not use the @harcoded@ style.
> ---
>  Makefile.am         | 70 ++++++++++++++++++++++-----------------------
>  Makefile.mesh       |  4 +--
>  Makefile.obexd      | 10 +++----
>  Makefile.plugins    |  6 ++--
>  Makefile.tools      | 62 +++++++++++++++++++--------------------
>  android/Makefile.am | 18 ++++++------
>  6 files changed, 85 insertions(+), 85 deletions(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index d4f4572d5..1905a74b6 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -19,11 +19,11 @@ CLEANFILES =
>
>  EXTRA_DIST =
>
> -pkglibexecdir = @libexecdir@/bluetooth
> +pkglibexecdir = $(libexecdir)/bluetooth
>
>  libexec_PROGRAMS =
>
> -includedir = @includedir@/bluetooth
> +includedir = $(includedir)/bluetooth
>
>  include_HEADERS =
>
> @@ -31,7 +31,7 @@ AM_CFLAGS = $(WARNING_CFLAGS) $(MISC_CFLAGS)
>  AM_LDFLAGS = $(MISC_LDFLAGS)
>
>  if DATAFILES
> -dbusdir = @DBUS_CONFDIR@/dbus-1/system.d
> +dbusdir = $(DBUS_CONFDIR)/dbus-1/system.d
>  dbus_DATA = src/bluetooth.conf
>
>  confdir = $(sysconfdir)/bluetooth
> @@ -42,10 +42,10 @@ state_DATA =
>  endif
>
>  if SYSTEMD
> -systemdsystemunitdir = @SYSTEMD_SYSTEMUNITDIR@
> +systemdsystemunitdir = $(SYSTEMD_SYSTEMUNITDIR)
>  systemdsystemunit_DATA = src/bluetooth.service
>
> -dbussystembusdir = @DBUS_SYSTEMBUSDIR@
> +dbussystembusdir = $(DBUS_SYSTEMBUSDIR)
>  dbussystembus_DATA = src/org.bluez.service
>  endif
>
> @@ -204,7 +204,7 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
>  src_bluetoothd_LDADD = lib/libbluetooth-internal.la \
>                         gdbus/libgdbus-internal.la \
>                         src/libshared-glib.la \
> -                       @BACKTRACE_LIBS@ @GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt \
> +                       $(BACKTRACE_LIBS) $(GLIB_LIBS) $(DBUS_LIBS) -ldl -lrt \
>                         $(builtin_ldadd)
>  src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
>                                 -Wl,--version-script=$(srcdir)/src/bluetooth.ver
> @@ -239,7 +239,7 @@ include android/Makefile.am
>  include Makefile.mesh
>
>  if HID2HCI
> -rulesdir = @UDEV_DIR@/rules.d
> +rulesdir = $(UDEV_DIR)/rules.d
>
>  rules_DATA = tools/97-hid2hci.rules
>
> @@ -278,7 +278,7 @@ EXTRA_DIST += doc/btsnoop.txt
>
>  EXTRA_DIST += tools/magic.btsnoop
>
> -AM_CFLAGS += @DBUS_CFLAGS@ @GLIB_CFLAGS@
> +AM_CFLAGS += $(DBUS_CFLAGS) $(GLIB_CFLAGS)
>
>  AM_CPPFLAGS = -I$(builddir)/lib
>
> @@ -287,51 +287,51 @@ unit_tests += unit/test-eir
>
>  unit_test_eir_SOURCES = unit/test-eir.c src/eir.c src/uuid-helper.c
>  unit_test_eir_LDADD = src/libshared-glib.la lib/libbluetooth-internal.la \
> -                                                               @GLIB_LIBS@
> +                                                               $(GLIB_LIBS)
>
>  unit_tests += unit/test-uuid
>
>  unit_test_uuid_SOURCES = unit/test-uuid.c
>  unit_test_uuid_LDADD = src/libshared-glib.la lib/libbluetooth-internal.la \
> -                                                               @GLIB_LIBS@
> +                                                               $(GLIB_LIBS)
>
>  unit_tests += unit/test-textfile
>
>  unit_test_textfile_SOURCES = unit/test-textfile.c src/textfile.h src/textfile.c
> -unit_test_textfile_LDADD = src/libshared-glib.la @GLIB_LIBS@
> +unit_test_textfile_LDADD = src/libshared-glib.la $(GLIB_LIBS)
>
>  unit_tests += unit/test-crc
>
>  unit_test_crc_SOURCES = unit/test-crc.c monitor/crc.h monitor/crc.c
> -unit_test_crc_LDADD = src/libshared-glib.la @GLIB_LIBS@
> +unit_test_crc_LDADD = src/libshared-glib.la $(GLIB_LIBS)
>
>  unit_tests += unit/test-crypto
>
>  unit_test_crypto_SOURCES = unit/test-crypto.c
> -unit_test_crypto_LDADD = src/libshared-glib.la @GLIB_LIBS@
> +unit_test_crypto_LDADD = src/libshared-glib.la $(GLIB_LIBS)
>
>  unit_tests += unit/test-ecc
>
>  unit_test_ecc_SOURCES = unit/test-ecc.c
> -unit_test_ecc_LDADD = src/libshared-glib.la @GLIB_LIBS@
> +unit_test_ecc_LDADD = src/libshared-glib.la $(GLIB_LIBS)
>
>  unit_tests += unit/test-ringbuf unit/test-queue
>
>  unit_test_ringbuf_SOURCES = unit/test-ringbuf.c
> -unit_test_ringbuf_LDADD = src/libshared-glib.la @GLIB_LIBS@
> +unit_test_ringbuf_LDADD = src/libshared-glib.la $(GLIB_LIBS)
>
>  unit_test_queue_SOURCES = unit/test-queue.c
> -unit_test_queue_LDADD = src/libshared-glib.la @GLIB_LIBS@
> +unit_test_queue_LDADD = src/libshared-glib.la $(GLIB_LIBS)
>
>  unit_tests += unit/test-mgmt
>
>  unit_test_mgmt_SOURCES = unit/test-mgmt.c
> -unit_test_mgmt_LDADD = src/libshared-glib.la @GLIB_LIBS@
> +unit_test_mgmt_LDADD = src/libshared-glib.la $(GLIB_LIBS)
>
>  unit_tests += unit/test-uhid
>
>  unit_test_uhid_SOURCES = unit/test-uhid.c
> -unit_test_uhid_LDADD = src/libshared-glib.la @GLIB_LIBS@
> +unit_test_uhid_LDADD = src/libshared-glib.la $(GLIB_LIBS)
>
>  unit_tests += unit/test-sdp
>
> @@ -340,21 +340,21 @@ unit_test_sdp_SOURCES = unit/test-sdp.c \
>                                 src/log.h src/log.c \
>                                 src/sdpd-service.c src/sdpd-request.c
>  unit_test_sdp_LDADD = lib/libbluetooth-internal.la \
> -                               src/libshared-glib.la @GLIB_LIBS@
> +                               src/libshared-glib.la $(GLIB_LIBS)
>
>  unit_tests += unit/test-avdtp
>
>  unit_test_avdtp_SOURCES = unit/test-avdtp.c \
>                                 src/log.h src/log.c \
>                                 android/avdtp.c android/avdtp.h
> -unit_test_avdtp_LDADD = src/libshared-glib.la @GLIB_LIBS@
> +unit_test_avdtp_LDADD = src/libshared-glib.la $(GLIB_LIBS)
>
>  unit_tests += unit/test-avctp
>
>  unit_test_avctp_SOURCES = unit/test-avctp.c \
>                                 src/log.h src/log.c \
>                                 android/avctp.c android/avctp.h
> -unit_test_avctp_LDADD = src/libshared-glib.la @GLIB_LIBS@
> +unit_test_avctp_LDADD = src/libshared-glib.la $(GLIB_LIBS)
>
>  unit_tests += unit/test-avrcp
>
> @@ -363,53 +363,53 @@ unit_test_avrcp_SOURCES = unit/test-avrcp.c \
>                                 android/avctp.c android/avctp.h \
>                                 android/avrcp-lib.c android/avrcp-lib.h
>  unit_test_avrcp_LDADD = lib/libbluetooth-internal.la \
> -                               src/libshared-glib.la @GLIB_LIBS@
> +                               src/libshared-glib.la $(GLIB_LIBS)
>
>  unit_tests += unit/test-hfp
>
>  unit_test_hfp_SOURCES = unit/test-hfp.c
> -unit_test_hfp_LDADD = src/libshared-glib.la @GLIB_LIBS@
> +unit_test_hfp_LDADD = src/libshared-glib.la $(GLIB_LIBS)
>
>  unit_tests += unit/test-gdbus-client
>
>  unit_test_gdbus_client_SOURCES = unit/test-gdbus-client.c
>  unit_test_gdbus_client_LDADD = gdbus/libgdbus-internal.la \
> -                               src/libshared-glib.la @GLIB_LIBS@ @DBUS_LIBS@
> +                               src/libshared-glib.la $(GLIB_LIBS) $(DBUS_LIBS)
>
>  unit_tests += unit/test-gobex-header unit/test-gobex-packet unit/test-gobex \
>                         unit/test-gobex-transfer unit/test-gobex-apparam
>
>  unit_test_gobex_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
>                                                 unit/test-gobex.c
> -unit_test_gobex_LDADD = @GLIB_LIBS@
> +unit_test_gobex_LDADD = $(GLIB_LIBS)
>
>  unit_test_gobex_packet_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
>                                                 unit/test-gobex-packet.c
> -unit_test_gobex_packet_LDADD = @GLIB_LIBS@
> +unit_test_gobex_packet_LDADD = $(GLIB_LIBS)
>
>  unit_test_gobex_header_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
>                                                 unit/test-gobex-header.c
> -unit_test_gobex_header_LDADD = @GLIB_LIBS@
> +unit_test_gobex_header_LDADD = $(GLIB_LIBS)
>
>  unit_test_gobex_transfer_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
>                                                 unit/test-gobex-transfer.c
> -unit_test_gobex_transfer_LDADD = @GLIB_LIBS@
> +unit_test_gobex_transfer_LDADD = $(GLIB_LIBS)
>
>  unit_test_gobex_apparam_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
>                                                 unit/test-gobex-apparam.c
> -unit_test_gobex_apparam_LDADD = @GLIB_LIBS@
> +unit_test_gobex_apparam_LDADD = $(GLIB_LIBS)
>
>  unit_tests += unit/test-lib
>
>  unit_test_lib_SOURCES = unit/test-lib.c
>  unit_test_lib_LDADD = src/libshared-glib.la \
> -                               lib/libbluetooth-internal.la @GLIB_LIBS@
> +                               lib/libbluetooth-internal.la $(GLIB_LIBS)
>
>  unit_tests += unit/test-gatt
>
>  unit_test_gatt_SOURCES = unit/test-gatt.c
>  unit_test_gatt_LDADD = src/libshared-glib.la \
> -                               lib/libbluetooth-internal.la @GLIB_LIBS@
> +                               lib/libbluetooth-internal.la $(GLIB_LIBS)
>
>  unit_tests += unit/test-hog
>
> @@ -424,7 +424,7 @@ unit_test_hog_SOURCES = unit/test-hog.c \
>                         attrib/gatt.h attrib/gatt.c \
>                         attrib/gattrib.h attrib/gattrib.c
>  unit_test_hog_LDADD = src/libshared-glib.la \
> -                               lib/libbluetooth-internal.la @GLIB_LIBS@
> +                               lib/libbluetooth-internal.la $(GLIB_LIBS)
>
>  unit_tests += unit/test-gattrib
>
> @@ -432,16 +432,16 @@ unit_test_gattrib_SOURCES = unit/test-gattrib.c attrib/gattrib.c \
>                                         $(btio_sources) src/log.h src/log.c
>  unit_test_gattrib_LDADD = lib/libbluetooth-internal.la \
>                         src/libshared-glib.la \
> -                       @GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt
> +                       $(GLIB_LIBS) $(DBUS_LIBS) -ldl -lrt
>
>  if MIDI
>  unit_tests += unit/test-midi
> -unit_test_midi_CFLAGS = $(AM_CFLAGS) @ALSA_CFLAGS@ -DMIDI_TEST
> +unit_test_midi_CFLAGS = $(AM_CFLAGS) $(ALSA_CFLAGS) -DMIDI_TEST
>  unit_test_midi_SOURCES = unit/test-midi.c \
>                         profiles/midi/libmidi.h \
>                         profiles/midi/libmidi.c
>  unit_test_midi_LDADD = src/libshared-glib.la \
> -                       @GLIB_LIBS@ @ALSA_LIBS@
> +                       $(GLIB_LIBS) $(ALSA_LIBS)
>  endif
>
>  if MAINTAINER_MODE
> diff --git a/Makefile.mesh b/Makefile.mesh
> index 0df7db2be..50bcc19ad 100644
> --- a/Makefile.mesh
> +++ b/Makefile.mesh
> @@ -25,7 +25,7 @@ mesh_meshd_SOURCES = $(mesh_sources) mesh/main.c
>
>  mesh_meshd_LDADD = src/shared/ecc.lo src/shared/queue.lo src/shared/io-ell.lo \
>                                 src/shared/util.lo src/shared/hci.lo src/shared/mgmt.lo \
> -                               @DBUS_LIBS@ @ELL_LIBS@ -ljson-c
> +                               $(DBUS_LIBS) $(ELL_LIBS) -ljson-c
>
>  noinst_PROGRAMS += mesh/btmesh
>
> @@ -37,6 +37,6 @@ mesh_btmesh_SOURCES = $(mesh_sources) \
>  mesh_btmesh_LDADD = src/shared/ecc.lo src/shared/queue.lo src/shared/io-ell.lo \
>                                 src/shared/util.lo src/shared/hci.lo src/shared/mgmt.lo \
>                                 src/libshared-mainloop.la \
> -                               -lreadline @ELL_LIBS@ -ljson-c
> +                               -lreadline $(ELL_LIBS) -ljson-c
>
>  endif
> diff --git a/Makefile.obexd b/Makefile.obexd
> index cd3ace425..9180d7eea 100644
> --- a/Makefile.obexd
> +++ b/Makefile.obexd
> @@ -1,8 +1,8 @@
>  if SYSTEMD
> -systemduserunitdir = @SYSTEMD_USERUNITDIR@
> +systemduserunitdir = $(SYSTEMD_USERUNITDIR)
>  systemduserunit_DATA = obexd/src/obex.service
>
> -dbussessionbusdir = @DBUS_SESSIONBUSDIR@
> +dbussessionbusdir = $(DBUS_SESSIONBUSDIR)
>  dbussessionbus_DATA = obexd/src/org.bluez.obex.service
>  endif
>
> @@ -79,12 +79,12 @@ obexd_src_obexd_SOURCES = $(btio_sources) $(gobex_sources) \
>                         obexd/src/map_ap.h
>  obexd_src_obexd_LDADD = lib/libbluetooth-internal.la \
>                         gdbus/libgdbus-internal.la \
> -                       @ICAL_LIBS@ @DBUS_LIBS@ @GLIB_LIBS@ -ldl
> +                       $(ICAL_LIBS) $(DBUS_LIBS) $(GLIB_LIBS) -ldl
>
>  obexd_src_obexd_LDFLAGS = -Wl,--export-dynamic
>
> -obexd_src_obexd_CFLAGS = $(AM_CFLAGS) @GLIB_CFLAGS@ @DBUS_CFLAGS@ \
> -                               @ICAL_CFLAGS@ -DOBEX_PLUGIN_BUILTIN \
> +obexd_src_obexd_CFLAGS = $(AM_CFLAGS) $(GLIB_CFLAGS) $(DBUS_CFLAGS) \
> +                               $(ICAL_CFLAGS) -DOBEX_PLUGIN_BUILTIN \
>                                 -DPLUGINDIR=\""$(obex_plugindir)"\" \
>                                 -fPIC -D_FILE_OFFSET_BITS=64
>
> diff --git a/Makefile.plugins b/Makefile.plugins
> index 3ab7c1c18..1c9919d71 100644
> --- a/Makefile.plugins
> +++ b/Makefile.plugins
> @@ -97,7 +97,7 @@ builtin_modules += midi
>  builtin_sources += profiles/midi/midi.c \
>                         profiles/midi/libmidi.h \
>                         profiles/midi/libmidi.c
> -builtin_ldadd += @ALSA_LIBS@
> +builtin_ldadd += $(ALSA_LIBS)
>  endif
>
>  builtin_modules += battery
> @@ -107,6 +107,6 @@ if SIXAXIS
>  plugin_LTLIBRARIES += plugins/sixaxis.la
>  plugins_sixaxis_la_SOURCES = plugins/sixaxis.c
>  plugins_sixaxis_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
> -                                               -no-undefined @UDEV_LIBS@
> -plugins_sixaxis_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden @UDEV_CFLAGS@
> +                                               -no-undefined $(UDEV_LIBS)
> +plugins_sixaxis_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden $(UDEV_CFLAGS)
>  endif
> diff --git a/Makefile.tools b/Makefile.tools
> index 231a4b09b..cdfaaf906 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -9,7 +9,7 @@ client_bluetoothctl_SOURCES = client/main.c \
>                                         client/advertising.c \
>                                         client/gatt.h client/gatt.c
>  client_bluetoothctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
> -                               @GLIB_LIBS@ @DBUS_LIBS@ -lreadline
> +                               $(GLIB_LIBS) $(DBUS_LIBS) -lreadline
>  endif
>
>  if MONITOR
> @@ -39,7 +39,7 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
>                                 monitor/broadcom.h monitor/broadcom.c \
>                                 monitor/tty.h
>  monitor_btmon_LDADD = lib/libbluetooth-internal.la \
> -                               src/libshared-mainloop.la @UDEV_LIBS@
> +                               src/libshared-mainloop.la $(UDEV_LIBS)
>  endif
>
>  if LOGGER
> @@ -103,7 +103,7 @@ tools_mgmt_tester_SOURCES = tools/mgmt-tester.c monitor/bt.h \
>                                 emulator/bthost.h emulator/bthost.c \
>                                 emulator/smp.c
>  tools_mgmt_tester_LDADD = lib/libbluetooth-internal.la \
> -                               src/libshared-glib.la @GLIB_LIBS@
> +                               src/libshared-glib.la $(GLIB_LIBS)
>
>  tools_l2cap_tester_SOURCES = tools/l2cap-tester.c monitor/bt.h \
>                                 emulator/hciemu.h emulator/hciemu.c \
> @@ -111,7 +111,7 @@ tools_l2cap_tester_SOURCES = tools/l2cap-tester.c monitor/bt.h \
>                                 emulator/bthost.h emulator/bthost.c \
>                                 emulator/smp.c
>  tools_l2cap_tester_LDADD = lib/libbluetooth-internal.la \
> -                               src/libshared-glib.la @GLIB_LIBS@
> +                               src/libshared-glib.la $(GLIB_LIBS)
>
>  tools_rfcomm_tester_SOURCES = tools/rfcomm-tester.c monitor/bt.h \
>                                 emulator/hciemu.h emulator/hciemu.c \
> @@ -119,7 +119,7 @@ tools_rfcomm_tester_SOURCES = tools/rfcomm-tester.c monitor/bt.h \
>                                 emulator/bthost.h emulator/bthost.c \
>                                 emulator/smp.c
>  tools_rfcomm_tester_LDADD = lib/libbluetooth-internal.la \
> -                               src/libshared-glib.la @GLIB_LIBS@
> +                               src/libshared-glib.la $(GLIB_LIBS)
>
>  tools_bnep_tester_SOURCES = tools/bnep-tester.c monitor/bt.h \
>                                 emulator/hciemu.h emulator/hciemu.c \
> @@ -127,7 +127,7 @@ tools_bnep_tester_SOURCES = tools/bnep-tester.c monitor/bt.h \
>                                 emulator/bthost.h emulator/bthost.c \
>                                 emulator/smp.c
>  tools_bnep_tester_LDADD = lib/libbluetooth-internal.la \
> -                               src/libshared-glib.la @GLIB_LIBS@
> +                               src/libshared-glib.la $(GLIB_LIBS)
>
>  tools_smp_tester_SOURCES = tools/smp-tester.c monitor/bt.h \
>                                 emulator/hciemu.h emulator/hciemu.c \
> @@ -135,7 +135,7 @@ tools_smp_tester_SOURCES = tools/smp-tester.c monitor/bt.h \
>                                 emulator/bthost.h emulator/bthost.c \
>                                 emulator/smp.c
>  tools_smp_tester_LDADD = lib/libbluetooth-internal.la \
> -                               src/libshared-glib.la @GLIB_LIBS@
> +                               src/libshared-glib.la $(GLIB_LIBS)
>
>  tools_gap_tester_SOURCES = tools/gap-tester.c monitor/bt.h \
>                                 emulator/hciemu.h emulator/hciemu.c \
> @@ -145,7 +145,7 @@ tools_gap_tester_SOURCES = tools/gap-tester.c monitor/bt.h \
>  tools_gap_tester_LDADD =  lib/libbluetooth-internal.la \
>                                 gdbus/libgdbus-internal.la \
>                                 src/libshared-glib.la \
> -                               @GLIB_LIBS@ @DBUS_LIBS@
> +                               $(GLIB_LIBS) $(DBUS_LIBS)
>
>  tools_sco_tester_SOURCES = tools/sco-tester.c monitor/bt.h \
>                                 emulator/hciemu.h emulator/hciemu.c \
> @@ -153,10 +153,10 @@ tools_sco_tester_SOURCES = tools/sco-tester.c monitor/bt.h \
>                                 emulator/bthost.h emulator/bthost.c \
>                                 emulator/smp.c
>  tools_sco_tester_LDADD = lib/libbluetooth-internal.la \
> -                               src/libshared-glib.la @GLIB_LIBS@
> +                               src/libshared-glib.la $(GLIB_LIBS)
>
>  tools_hci_tester_SOURCES = tools/hci-tester.c monitor/bt.h
> -tools_hci_tester_LDADD = src/libshared-glib.la @GLIB_LIBS@
> +tools_hci_tester_LDADD = src/libshared-glib.la $(GLIB_LIBS)
>
>  tools_userchan_tester_SOURCES = tools/userchan-tester.c monitor/bt.h \
>                                 emulator/hciemu.h emulator/hciemu.c \
> @@ -164,7 +164,7 @@ tools_userchan_tester_SOURCES = tools/userchan-tester.c monitor/bt.h \
>                                 emulator/bthost.h emulator/bthost.c \
>                                 emulator/smp.c
>  tools_userchan_tester_LDADD = lib/libbluetooth-internal.la \
> -                               src/libshared-glib.la @GLIB_LIBS@
> +                               src/libshared-glib.la $(GLIB_LIBS)
>  endif
>
>  if TOOLS
> @@ -187,7 +187,7 @@ noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
>                         tools/gatt-service profiles/iap/iapd
>
>  tools_bdaddr_SOURCES = tools/bdaddr.c src/oui.h src/oui.c
> -tools_bdaddr_LDADD = lib/libbluetooth-internal.la @UDEV_LIBS@
> +tools_bdaddr_LDADD = lib/libbluetooth-internal.la $(UDEV_LIBS)
>
>  tools_avinfo_LDADD = lib/libbluetooth-internal.la
>
> @@ -217,20 +217,20 @@ tools_btproxy_SOURCES = tools/btproxy.c monitor/bt.h
>  tools_btproxy_LDADD = src/libshared-mainloop.la
>
>  tools_btiotest_SOURCES = tools/btiotest.c btio/btio.h btio/btio.c
> -tools_btiotest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
> +tools_btiotest_LDADD = lib/libbluetooth-internal.la $(GLIB_LIBS)
>
>  tools_mcaptest_SOURCES = tools/mcaptest.c \
>                                 btio/btio.h btio/btio.c \
>                                 src/log.c src/log.h \
>                                 profiles/health/mcap.h profiles/health/mcap.c
> -tools_mcaptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@ \
> +tools_mcaptest_LDADD = lib/libbluetooth-internal.la $(GLIB_LIBS) \
>                                 src/libshared-mainloop.la -lrt
>
>  tools_bneptest_SOURCES = tools/bneptest.c \
>                                 btio/btio.h btio/btio.c \
>                                 src/log.h src/log.c \
>                                 profiles/network/bnep.h profiles/network/bnep.c
> -tools_bneptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@ \
> +tools_bneptest_LDADD = lib/libbluetooth-internal.la $(GLIB_LIBS) \
>                                 src/libshared-mainloop.la
>
>  tools_cltest_SOURCES = tools/cltest.c
> @@ -282,13 +282,13 @@ tools_bluemoon_LDADD = src/libshared-mainloop.la
>  tools_hex2hcd_SOURCES = tools/hex2hcd.c
>
>  tools_mpris_proxy_SOURCES = tools/mpris-proxy.c
> -tools_mpris_proxy_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@
> +tools_mpris_proxy_LDADD = gdbus/libgdbus-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
>
>  tools_gatt_service_SOURCES = tools/gatt-service.c
> -tools_gatt_service_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ gdbus/libgdbus-internal.la
> +tools_gatt_service_LDADD = $(GLIB_LIBS) $(DBUS_LIBS) gdbus/libgdbus-internal.la
>
>  profiles_iap_iapd_SOURCES = profiles/iap/main.c
> -profiles_iap_iapd_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@
> +profiles_iap_iapd_LDADD = gdbus/libgdbus-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
>
>  dist_man_MANS += tools/rctest.1 tools/l2ping.1 tools/bccmd.1 tools/btattach.1
>
> @@ -313,7 +313,7 @@ tools_meshctl_SOURCES = tools/meshctl.c \
>                                 tools/mesh/onoff-model.h tools/mesh/onoff-model.c
>  tools_meshctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
>                                 lib/libbluetooth-internal.la \
> -                               @GLIB_LIBS@ @DBUS_LIBS@ -ljson-c -lreadline
> +                               $(GLIB_LIBS) $(DBUS_LIBS) -ljson-c -lreadline
>  endif
>
>  EXTRA_DIST += tools/mesh/local_node.json tools/mesh/prov_db.json
> @@ -336,7 +336,7 @@ tools_hciconfig_SOURCES = tools/hciconfig.c tools/csr.h tools/csr.c
>  tools_hciconfig_LDADD = lib/libbluetooth-internal.la
>
>  tools_hcitool_SOURCES = tools/hcitool.c src/oui.h src/oui.c
> -tools_hcitool_LDADD = lib/libbluetooth-internal.la @UDEV_LIBS@
> +tools_hcitool_LDADD = lib/libbluetooth-internal.la $(UDEV_LIBS)
>
>  tools_hcidump_SOURCES = tools/hcidump.c \
>                                 tools/parser/parser.h tools/parser/parser.c \
> @@ -365,7 +365,7 @@ tools_hcidump_SOURCES = tools/hcidump.c \
>                                 tools/parser/bpa.c
>
>  tools_sdptool_SOURCES = tools/sdptool.c src/sdp-xml.h src/sdp-xml.c
> -tools_sdptool_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
> +tools_sdptool_LDADD = lib/libbluetooth-internal.la $(GLIB_LIBS)
>
>  tools_ciptool_LDADD = lib/libbluetooth-internal.la
>  tools_hcidump_LDADD = lib/libbluetooth-internal.la
> @@ -385,11 +385,11 @@ EXTRA_DIST += tools/rctest.1 tools/l2ping.1 tools/bccmd.1 tools/btattach.1
>  endif
>
>  if HID2HCI
> -udevdir = @UDEV_DIR@
> +udevdir = $(UDEV_DIR)
>
>  udev_PROGRAMS = tools/hid2hci
>
> -tools_hid2hci_LDADD = @UDEV_LIBS@
> +tools_hid2hci_LDADD = $(UDEV_LIBS)
>
>  dist_man_MANS += tools/hid2hci.1
>  else
> @@ -403,20 +403,20 @@ noinst_PROGRAMS += tools/btmgmt tools/obex-client-tool tools/obex-server-tool \
>  tools_obex_client_tool_SOURCES = $(gobex_sources) $(btio_sources) \
>                                                 tools/obex-client-tool.c
>  tools_obex_client_tool_LDADD = lib/libbluetooth-internal.la \
> -                                               @GLIB_LIBS@ -lreadline
> +                                               $(GLIB_LIBS) -lreadline
>
>  tools_obex_server_tool_SOURCES = $(gobex_sources) $(btio_sources) \
>                                                 tools/obex-server-tool.c
> -tools_obex_server_tool_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
> +tools_obex_server_tool_LDADD = lib/libbluetooth-internal.la $(GLIB_LIBS)
>
>  tools_bluetooth_player_SOURCES = tools/bluetooth-player.c
>  tools_bluetooth_player_LDADD = gdbus/libgdbus-internal.la \
>                                 src/libshared-glib.la \
> -                               @GLIB_LIBS@ @DBUS_LIBS@ -lreadline
> +                               $(GLIB_LIBS) $(DBUS_LIBS) -lreadline
>
>  tools_obexctl_SOURCES = tools/obexctl.c
>  tools_obexctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
> -                               @GLIB_LIBS@ @DBUS_LIBS@ -lreadline
> +                               $(GLIB_LIBS) $(DBUS_LIBS) -lreadline
>
>  tools_btmgmt_SOURCES = tools/btmgmt.c src/uuid-helper.c client/display.c
>  tools_btmgmt_LDADD = lib/libbluetooth-internal.la src/libshared-mainloop.la \
> @@ -430,7 +430,7 @@ attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
>                                 attrib/utils.c src/log.c client/display.c \
>                                 client/display.h
>  attrib_gatttool_LDADD = lib/libbluetooth-internal.la \
> -                       src/libshared-glib.la @GLIB_LIBS@ -lreadline
> +                       src/libshared-glib.la $(GLIB_LIBS) -lreadline
>
>  endif
>  endif
> @@ -446,7 +446,7 @@ profiles_cups_bluetooth_SOURCES = profiles/cups/main.c \
>                                         profiles/cups/spp.c \
>                                         profiles/cups/hcrp.c
>
> -profiles_cups_bluetooth_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ \
> +profiles_cups_bluetooth_LDADD = $(GLIB_LIBS) $(DBUS_LIBS) \
>                                 lib/libbluetooth-internal.la \
>                                 gdbus/libgdbus-internal.la
>  endif
> @@ -469,6 +469,6 @@ if BTPCLIENT
>  noinst_PROGRAMS += tools/btpclient
>
>  tools_btpclient_SOURCES = tools/btpclient.c src/shared/btp.c src/shared/btp.h
> -tools_btpclient_CFLAGS = $(AM_CFLAGS) @ELL_CFLAGS@
> -tools_btpclient_LDADD = @ELL_LIBS@ lib/libbluetooth-internal.la
> +tools_btpclient_CFLAGS = $(AM_CFLAGS) $(ELL_CFLAGS)
> +tools_btpclient_LDADD = $(ELL_LIBS) lib/libbluetooth-internal.la
>  endif
> diff --git a/android/Makefile.am b/android/Makefile.am
> index d665d1e14..d09a52d69 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -12,7 +12,7 @@ android_system_emulator_LDADD = src/libshared-mainloop.la
>  noinst_PROGRAMS += android/bluetoothd-snoop
>
>  android_bluetoothd_snoop_SOURCES = android/bluetoothd-snoop.c src/log.c
> -android_bluetoothd_snoop_LDADD = src/libshared-mainloop.la @GLIB_LIBS@
> +android_bluetoothd_snoop_LDADD = src/libshared-mainloop.la $(GLIB_LIBS)
>
>  noinst_PROGRAMS += android/bluetoothd
>
> @@ -59,7 +59,7 @@ android_bluetoothd_SOURCES = android/main.c \
>                                 src/sdp-client.h src/sdp-client.c \
>                                 profiles/network/bnep.h profiles/network/bnep.c
>  android_bluetoothd_LDADD = lib/libbluetooth-internal.la \
> -                               src/libshared-glib.la @GLIB_LIBS@
> +                               src/libshared-glib.la $(GLIB_LIBS)
>
>  plugin_LTLIBRARIES += android/bluetooth.default.la
>
> @@ -110,7 +110,7 @@ android_avdtptest_SOURCES = android/avdtptest.c \
>                                 src/shared/log.h src/shared/log.c \
>                                 android/avdtp.h android/avdtp.c
>  android_avdtptest_CFLAGS = $(AM_CFLAGS)
> -android_avdtptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
> +android_avdtptest_LDADD = lib/libbluetooth-internal.la $(GLIB_LIBS)
>
>  noinst_PROGRAMS += android/haltest
>
> @@ -165,7 +165,7 @@ android_android_tester_SOURCES = emulator/hciemu.h emulator/hciemu.c \
>  android_android_tester_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
>                                 -DPLUGINDIR=\""$(android_plugindir)"\"
>  android_android_tester_LDADD = lib/libbluetooth-internal.la \
> -                               src/libshared-glib.la @GLIB_LIBS@
> +                               src/libshared-glib.la $(GLIB_LIBS)
>  android_android_tester_LDFLAGS = -pthread -ldl
>
>  noinst_PROGRAMS += android/ipc-tester
> @@ -178,7 +178,7 @@ android_ipc_tester_SOURCES = emulator/hciemu.h emulator/hciemu.c \
>                                 android/ipc-common.h android/ipc-tester.c
>  android_ipc_tester_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
>  android_ipc_tester_LDADD = lib/libbluetooth-internal.la \
> -                               src/libshared-glib.la @GLIB_LIBS@
> +                               src/libshared-glib.la $(GLIB_LIBS)
>
>  plugin_LTLIBRARIES += android/audio.a2dp.default.la
>
> @@ -193,8 +193,8 @@ android_audio_a2dp_default_la_SOURCES = android/audio-msg.h \
>                                         android/hardware/hardware.h \
>                                         android/system/audio.h
>  android_audio_a2dp_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
> -                                       @SBC_CFLAGS@
> -android_audio_a2dp_default_la_LIBADD = @SBC_LIBS@
> +                                       $(SBC_CFLAGS)
> +android_audio_a2dp_default_la_LIBADD = $(SBC_LIBS)
>  android_audio_a2dp_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
>                                         -no-undefined -pthread -lrt
>
> @@ -210,7 +210,7 @@ android_audio_sco_default_la_SOURCES = android/hal-log.h \
>                                         android/audio_utils/resampler.h \
>                                         android/system/audio.h
>  android_audio_sco_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
> -android_audio_sco_default_la_LIBADD = @SPEEXDSP_LIBS@
> +android_audio_sco_default_la_LIBADD = $(SPEEXDSP_LIBS)
>  android_audio_sco_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
>                                         -no-undefined -lrt
>  unit_tests += android/test-ipc
> @@ -219,7 +219,7 @@ android_test_ipc_SOURCES = android/test-ipc.c \
>                                 src/log.h src/log.c \
>                                 android/ipc-common.h \
>                                 android/ipc.c android/ipc.h
> -android_test_ipc_LDADD = src/libshared-glib.la @GLIB_LIBS@
> +android_test_ipc_LDADD = src/libshared-glib.la $(GLIB_LIBS)
>
>  endif
>
> --
> 2.19.1

Makefile:2392: *** Recursive variable 'includedir' references itself
(eventually).  Stop.
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [Makefile:9544: install-am] Error 2
make[1]: *** [Makefile:9538: install] Error 2
make: *** [Makefile:9449: distcheck] Error 1
warning: execution failed: make distcheck
You can fix the problem, and then run

Ive also got other problems when doing make distcheck with all patches
applied so Id recommend you do:

git rebase -i origin/master --exec "make distcheck"



-- 
Luiz Augusto von Dentz
