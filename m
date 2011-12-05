Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] btio: Fix byte order conversion when getting L2CAP CID
Date: Mon,  5 Dec 2011 12:54:45 +0100
Message-Id: <1323086085-26024-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The L2CAP CID is passed and received in little endian byte order
through the socket interface so a conversion is in place before
passing it onwards.
---
 btio/btio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index f8c5cc7..0d177a3 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -886,7 +886,7 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
 			break;
 		case BT_IO_OPT_CID:
 			*(va_arg(args, uint16_t *)) = src.l2_cid ?
-						src.l2_cid : dst.l2_cid;
+					btohs(src.l2_cid) : btohs(dst.l2_cid);
 			break;
 		case BT_IO_OPT_OMTU:
 			*(va_arg(args, uint16_t *)) = l2o.omtu;
-- 
1.7.8

