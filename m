Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH RFC] avdtp: Fix incorrect gchar buffer allocation
Date: Fri, 18 May 2012 09:46:29 -0400
Message-Id: <1337348789-21109-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The code was allocating an array of gchar pointers, where an array of
gchar is expected.
---
 audio/gstavdtpsink.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

I did not check the code at length, but looking at other functions, this is
most likely a bug.

diff --git a/audio/gstavdtpsink.c b/audio/gstavdtpsink.c
index af04a56..b5dfae4 100644
--- a/audio/gstavdtpsink.c
+++ b/audio/gstavdtpsink.c
@@ -1144,7 +1144,7 @@ static gboolean gst_avdtp_sink_update_caps(GstAvdtpSink *self)
 
 static gboolean gst_avdtp_sink_get_capabilities(GstAvdtpSink *self)
 {
-	gchar *buf[BT_SUGGESTED_BUFFER_SIZE];
+	gchar buf[BT_SUGGESTED_BUFFER_SIZE];
 	struct bt_get_capabilities_req *req = (void *) buf;
 	struct bt_get_capabilities_rsp *rsp = (void *) buf;
 	int err;
-- 
1.7.5.4

