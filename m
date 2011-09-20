Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 3/3] avrcp: handle volume up/down passthroughs as TG
Date: Tue, 20 Sep 2011 15:31:36 -0300
Message-Id: <1316543496-18575-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1316543496-18575-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1316543496-18575-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/avctp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index e9b8e40..59fbed9 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -155,6 +155,8 @@ static struct {
 	{ "BACKWARD",		BACKWARD_OP,		KEY_PREVIOUSSONG },
 	{ "REWIND",		REWIND_OP,		KEY_REWIND },
 	{ "FAST FORWARD",	FAST_FORWARD_OP,	KEY_FASTFORWARD },
+	{ "VOLUME UP",		VOL_UP_OP,		KEY_VOLUMEUP },
+	{ "VOLUME DOWN",	VOL_DOWN_OP,		KEY_VOLUMEDOWN },
 	{ NULL }
 };
 
-- 
1.7.6.1

