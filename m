Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1285943147-2546-1-git-send-email-haijun.liu@atheros.com>
References: <1285943147-2546-1-git-send-email-haijun.liu@atheros.com>
From: haijun liu <liuhaijun.er@gmail.com>
Date: Fri, 1 Oct 2010 22:43:52 +0800
Message-ID: <AANLkTi=-4yF2qew7YVnESPd_jt7g8bvS12XYkhx27ko8@mail.gmail.com>
Subject: [PATCH] Bluetooth: Replace hard code of configuration continuous flag
To: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: dan.tian@atheros.com, suraj <suraj@atheros.com>,
	Ville Tervo <ville.tervo@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Replace hard code of configuration continuous flag with
self-commented macro L2CAP_CONF_FLAG_CONT in functions
l2cap_config_req() and l2cap_config_rsp().

Signed-off-by: Haijun.Liu <haijun.liu@atheros.com>
---
 include/net/bluetooth/l2cap.h |    2 ++
 net/bluetooth/l2cap_core.c    |    6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index df599dc..2b114ca 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -193,6 +193,8 @@ struct l2cap_conf_rsp {
 #define L2CAP_CONF_REJECT      0x0002
 #define L2CAP_CONF_UNKNOWN     0x0003

+#define L2CAP_CONF_FLAG_CONT   0x0001
+
 struct l2cap_conf_opt {
       __u8       type;
       __u8       len;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 07b55c1..9e788c2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2985,11 +2985,11 @@ static inline int l2cap_config_req(struct
l2cap_conn *conn, struct l2cap_cmd_hdr
       memcpy(l2cap_pi(sk)->conf_req + l2cap_pi(sk)->conf_len, req->data, len);
       l2cap_pi(sk)->conf_len += len;

-       if (flags & 0x0001) {
+       if (flags & L2CAP_CONF_FLAG_CONT) {
               /* Incomplete config. Send empty response. */
               l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
                               l2cap_build_conf_rsp(sk, rsp,
-                                       L2CAP_CONF_SUCCESS, 0x0001), rsp);
+                                       L2CAP_CONF_SUCCESS,
L2CAP_CONF_FLAG_CONT), rsp);
               goto unlock;
       }

@@ -3093,7 +3093,7 @@ static inline int l2cap_config_rsp(struct
l2cap_conn *conn, struct l2cap_cmd_hdr
               goto done;
       }

-       if (flags & 0x01)
+       if (flags & L2CAP_CONF_FLAG_CONT)
               goto done;

       l2cap_pi(sk)->conf_state |= L2CAP_CONF_INPUT_DONE;
--
1.6.3.3
