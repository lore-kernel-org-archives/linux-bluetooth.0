Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 6 Mar 2009 16:59:43 -0800
Message-ID: <35c90d960903061659x433122ddrf6fb38ec02a50d60@mail.gmail.com>
Subject: [RFC] [PATCH] Do no process a stream as connected if AVDTP set
	configuration failed
From: Nick Pelly <npelly@google.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Right now, if set configuration fails then the
sink.c:stream_setup_complete seems to consider the stream connected.
So the DBus AudioSink.Connect() call returns without error. But the
stream is not actually ready.

I have a feeling we may want to do some more cleanup, but this patch
does the trick for us.

It is easy to reproduce the problem with the HTC BH S100. If you
quickly disconnect and then reconnect it will return AVDTP set
configuration failed (presumably because it hasn't closed the SEP on
its end yet), but Dbus does not return an error for Connect.

The verbose hcid logs for this problem look like:

  102        /system/bin/hcid   I  hcid[103]: avdtp_ref(0x145e8): ref=2
  102        /system/bin/hcid   I  hcid[103]: Discovery complete
  102        /system/bin/hcid   I  hcid[103]: a2dp_source_config:
selected SEP 0x12100
  102        /system/bin/hcid   I  hcid[103]: avdtp_ref(0x145e8): ref=3
  102        /system/bin/hcid   I  hcid[103]: setup_ref(0x11930): ref=1
  102        /system/bin/hcid   I  hcid[103]:
avdtp_set_configuration(0x145e8): int_seid=1, acp_seid=1
  102        /system/bin/hcid   I  hcid[103]: stream creation in progress
  102        /system/bin/hcid   I  hcid[103]: session_cb
  102        /system/bin/hcid   I  hcid[103]: SET_CONFIGURATION
request rejected: Stream End Point in Use (19)
  102        /system/bin/hcid   I  hcid[103]: Source 0x12100:
Set_Configuration_Cfm
  102        /system/bin/hcid   I  hcid[103]: setup_ref(0x11930): ref=2
  102        /system/bin/hcid   I  hcid[103]: npelly 174
stream_setup_complete session=0x145e8 sep=0x120d8 stream=0x14ec0
err=0xbeea8aa4 user_data=0x13de8
  102        /system/bin/hcid   I  hcid[103]: Stream successfully created



>From 47866d9e0e9596b8682293f601d195ef390bfd87 Mon Sep 17 00:00:00 2001
From: Nick Pelly <npelly@google.com>
Date: Fri, 6 Mar 2009 16:53:04 -0800
Subject: [PATCH] Do not process stream as connected if AVDTP set
configuration failed.

---
 audio/sink.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/sink.c b/audio/sink.c
index 44faacf..f204cb1 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -191,7 +191,7 @@ static void stream_setup_complete(struct avdtp
*session, struct a2dp_sep *sep,

        pending = sink->connect;

-       if (stream) {
+       if (stream & !err) {
                debug("Stream successfully created");

                if (pending->msg) {
-- 
1.5.5
