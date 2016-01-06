Return-Path: <wuninsu@gmail.com>
From: Insu Yun <wuninsu@gmail.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	peter@hurleysoftware.com,
	jaganath.k@samsung.com,
	ying.xue@windriver.com,
	ebiederm@xmission.com,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: taesoo@gatech.edu,
	yeongjin.jang@gatech.edu,
	insu@gatech.edu,
	changwoo@gatech.edu,
	Insu Yun <wuninsu@gmail.com>
Subject: [PATCH] rfcomm: fix information leak in rfcomm_sock_bind
Date: Tue,  5 Jan 2016 23:36:33 -0500
Message-Id: <1452054993-76111-1-git-send-email-wuninsu@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

if addr_len < sizeof(sa), sa.rc_bdaddr(4bytes) can be leaked 
by using rfcomm_sock_getname()

Signed-off-by: Insu Yun <wuninsu@gmail.com>
---
 net/bluetooth/rfcomm/sock.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 7511df7..d61dfdc 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -336,14 +336,15 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
 {
 	struct sockaddr_rc sa;
 	struct sock *sk = sock->sk;
-	int len, err = 0;
+	int err = 0;
 
 	if (!addr || addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
-	memset(&sa, 0, sizeof(sa));
-	len = min_t(unsigned int, sizeof(sa), addr_len);
-	memcpy(&sa, addr, len);
+	if (addr_len != sizeof(sa))
+		return -EINVAL;
+
+	memcpy(&sa, addr, addr_len);
 
 	BT_DBG("sk %p %pMR", sk, &sa.rc_bdaddr);
 
-- 
1.9.1
