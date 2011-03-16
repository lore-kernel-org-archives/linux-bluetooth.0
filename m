Return-Path: <cyrus@holtmann.org>
From: Arun Raghavan <arun.raghavan@collabora.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: [PATCH] Recalculate remote SEP if the codec type changes
Date: Thu, 17 Mar 2011 01:35:57 +0530
Message-Id: <1300305957-8139-1-git-send-email-arun.raghavan@collabora.co.uk>
In-Reply-To: <1300299595.2192.92.camel@snowflake>
References: <1300299595.2192.92.camel@snowflake>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This forces recalculating the remote SEP if the local SEP's codec type
is no longer the same as the remote SEP's codec type. This can happen
after we issue a BT_STOP_STREAM+BT_CLOSE followed by a
BT_SET_CONFIGURATION with a new SEID.
---
 audio/a2dp.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 3407d6f..7827cda 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1058,8 +1058,15 @@ static gboolean a2dp_reconfigure(gpointer data)
 	struct a2dp_setup *setup = data;
 	struct a2dp_sep *sep = setup->sep;
 	int posix_err;
+	struct avdtp_media_codec_capability *rsep_codec;
+	struct avdtp_service_capability *cap;
 
-	if (!setup->rsep)
+	if (setup->rsep) {
+		cap = avdtp_get_codec(setup->rsep);
+		rsep_codec = (struct avdtp_media_codec_capability *) cap->data;
+	}
+
+	if (!setup->rsep || sep->codec != rsep_codec->media_codec_type)
 		setup->rsep = avdtp_find_remote_sep(setup->session, sep->lsep);
 
 	posix_err = avdtp_set_configuration(setup->session, setup->rsep,
-- 
1.7.4.1

