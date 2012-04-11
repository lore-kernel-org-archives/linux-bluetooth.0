Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <lucas.demarchi@profusion.mobi>,
	Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH 2/3] AVRCP: Remove unused field in player structure
Date: Wed, 11 Apr 2012 11:12:37 +0200
Message-ID: <1334135558-21866-3-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1334135558-21866-1-git-send-email-michal.labedzki@tieto.com>
References: <1334135558-21866-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove unused "audio_device" field in player structure.
---
 audio/avrcp.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index d456023..f0c9665 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -146,7 +146,6 @@ struct pending_pdu {
 struct avrcp_player {
 	struct avrcp_server *server;
 	struct avctp *session;
-	struct audio_device *dev;
 
 	unsigned int handler;
 	uint16_t registered_events;
-- 
on behalf of ST-Ericsson

