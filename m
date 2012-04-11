Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0 1/7] btio: Fix bind SCO socket only if server
Date: Wed, 11 Apr 2012 08:57:12 +0200
Message-Id: <1334127438-27617-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1334127438-27617-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334127438-27617-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

When the socket is open is client mode, the bind() system call should
not be used.
---
 btio/btio.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 9781ec4..7564d85 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -1317,8 +1317,9 @@ static GIOChannel *create_io(BtIOType type, gboolean server,
 			ERROR_FAILED(err, "socket(SEQPACKET, SCO)", errno);
 			return NULL;
 		}
-		if (sco_bind(sock, &opts->src, err) < 0)
-			goto failed;
+		if (server)
+			if (sco_bind(sock, &opts->src, err) < 0)
+				goto failed;
 		if (!sco_set(sock, opts->mtu, err))
 			goto failed;
 		break;
-- 
1.7.7.6

