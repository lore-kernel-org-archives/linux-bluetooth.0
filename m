Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 5/5] AVRCP: handle volume up/down keys as TG
Date: Fri, 21 Oct 2011 15:58:28 -0200
Message-Id: <1319219908-2819-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1319219908-2819-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1319219908-2819-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/avctp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index df3b2b8..fdd8a9e 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -155,6 +155,8 @@ static struct {
 	{ "BACKWARD",		BACKWARD_OP,		KEY_PREVIOUSSONG },
 	{ "REWIND",		REWIND_OP,		KEY_REWIND },
 	{ "FAST FORWARD",	FAST_FORWARD_OP,	KEY_FASTFORWARD },
+	{ "VOLUME UP",          VOL_UP_OP,              KEY_VOLUMEUP },
+	{ "VOLUME DOWN",        VOL_DOWN_OP,            KEY_VOLUMEDOWN },
 	{ NULL }
 };
 
-- 
1.7.7

