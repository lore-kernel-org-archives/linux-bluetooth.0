Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] Bluetooth: Fix not returning proper error in RFCOMM
Date: Tue,  2 Nov 2010 15:03:18 +0000
Message-Id: <1288710198-6108-7-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1288710198-6108-6-git-send-email-padovan@profusion.mobi>
References: <1288710198-6108-1-git-send-email-padovan@profusion.mobi>
 <1288710198-6108-2-git-send-email-padovan@profusion.mobi>
 <1288710198-6108-3-git-send-email-padovan@profusion.mobi>
 <1288710198-6108-4-git-send-email-padovan@profusion.mobi>
 <1288710198-6108-5-git-send-email-padovan@profusion.mobi>
 <1288710198-6108-6-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Return 0 in that situation could lead to errors in the caller.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/rfcomm/sock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index e48fbca..cd7e27a 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -930,7 +930,7 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 	/* Check if we have socket listening on channel */
 	parent = rfcomm_get_sock_by_channel(BT_LISTEN, channel, &src);
 	if (!parent)
-		return 0;
+		return -EINVAL;
 
 	bh_lock_sock(parent);
 
-- 
1.7.3.1

