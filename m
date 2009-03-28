Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: create macro to hint mask on receiving config request
Date: Sat, 28 Mar 2009 14:47:28 -0300
Message-Id: <1238262449-3321-4-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1238262449-3321-3-git-send-email-gustavo@las.ic.unicamp.br>
References: <1238262449-3321-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1238262449-3321-2-git-send-email-gustavo@las.ic.unicamp.br>
 <1238262449-3321-3-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

L2CAP_CONF_HINT is better to understand than 0x80. And we don't need to
go to spec to figure out what 0x80 is.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 include/net/bluetooth/l2cap.h |    2 ++
 net/bluetooth/l2cap.c         |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index ed4ba91..300b63f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -149,6 +149,8 @@ struct l2cap_conf_opt {
 } __attribute__ ((packed));
 #define L2CAP_CONF_OPT_SIZE	2
 
+#define L2CAP_CONF_HINT		0x80
+
 #define L2CAP_CONF_MTU		0x01
 #define L2CAP_CONF_FLUSH_TO	0x02
 #define L2CAP_CONF_QOS		0x03
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 85926f5..a2cc770 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1737,7 +1737,7 @@ static int l2cap_parse_conf_req(struct sock *sk, void *data)
 	while (len >= L2CAP_CONF_OPT_SIZE) {
 		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
 
-		hint  = type & 0x80;
+		hint  = type & L2CAP_CONF_HINT;
 		type &= 0x7f;
 
 		switch (type) {
-- 
1.6.0.6

