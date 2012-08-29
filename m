Return-Path: <cyrus@holtmann.org>
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: kernel-janitors@vger.kernel.org,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] net/bluetooth/rfcomm/core.c: fix error return code
Date: Wed, 29 Aug 2012 18:49:14 +0200
Message-Id: <1346258957-7649-5-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1346258957-7649-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1346258957-7649-1-git-send-email-Julia.Lawall@lip6.fr>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Julia Lawall <Julia.Lawall@lip6.fr>

Initialize return variable before exiting on an error path.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
(
if@p1 (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret@p1 = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}

// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 net/bluetooth/rfcomm/core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index c75107e..30141c0 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -2010,8 +2010,10 @@ static int rfcomm_add_listener(bdaddr_t *ba)
 
 	/* Add listening session */
 	s = rfcomm_session_add(sock, BT_LISTEN);
-	if (!s)
+	if (!s) {
+		err = -ENOMEM;
 		goto failed;
+	}
 
 	rfcomm_session_hold(s);
 	return 0;
