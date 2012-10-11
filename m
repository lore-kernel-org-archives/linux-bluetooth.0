Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: mathewm@codeaurora.org
Subject: [RFC 6/6] Bluetooth: Fix error code byte order
Date: Thu, 11 Oct 2012 17:48:25 +0300
Message-Id: <1349966905-32336-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1349966905-32336-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1349966905-32336-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 62b1d3a..cefac95 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4057,8 +4057,8 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
 
 			rsp.dcid = 0;
 			rsp.scid = cpu_to_le16(scid);
-			rsp.result = L2CAP_CR_BAD_AMP;
-			rsp.status = L2CAP_CS_NO_INFO;
+			rsp.result = __constant_cpu_to_le16(L2CAP_CR_BAD_AMP);
+			rsp.status = __constant_cpu_to_le16(L2CAP_CS_NO_INFO);
 
 			l2cap_send_cmd(conn, cmd->ident, L2CAP_CREATE_CHAN_RSP,
 				       sizeof(rsp), &rsp);
-- 
1.7.9.5

