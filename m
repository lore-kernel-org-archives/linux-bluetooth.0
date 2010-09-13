Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix crash on gstreamer plugin if device doesn't support sbc
Date: Mon, 13 Sep 2010 15:40:11 +0300
Message-Id: <1284381611-17203-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 audio/gstavdtpsink.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/audio/gstavdtpsink.c b/audio/gstavdtpsink.c
index f0e5b76..b8c8832 100644
--- a/audio/gstavdtpsink.c
+++ b/audio/gstavdtpsink.c
@@ -448,6 +448,9 @@ static GstStructure *gst_avdtp_sink_parse_sbc_caps(
 	GValue *list;
 	gboolean mono, stereo;
 
+	if (sbc == NULL)
+		return NULL;
+
 	structure = gst_structure_empty_new("audio/x-sbc");
 	value = g_value_init(g_new0(GValue, 1), G_TYPE_STRING);
 
-- 
1.7.1

