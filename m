Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi,
	ulisses@profusion.mobi
Subject: [PATCH 3/7] Bluetooth: Fix crash when monitor timeout expires
Date: Wed, 14 Apr 2010 16:41:48 -0300
Message-Id: <1271274112-7806-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1271274112-7806-3-git-send-email-padovan@profusion.mobi>
References: <1271274112-7806-1-git-send-email-padovan@profusion.mobi>
 <1271274112-7806-2-git-send-email-padovan@profusion.mobi>
 <1271274112-7806-3-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The code was crashing due to a invalid access to hci_conn after the
channel disconnect.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 657a411..b653039 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1547,6 +1547,9 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *m
 
 	BT_DBG("sk %p len %d", sk, (int)len);
 
+	if (!conn)
+		return ERR_PTR(-ENOTCONN);
+
 	if (sdulen)
 		hlen += 2;
 
-- 
1.6.4.4

