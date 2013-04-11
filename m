Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Bluetooth: Minor coding style fix
Date: Thu, 11 Apr 2013 11:35:46 -0300
Message-Id: <1365690946-28050-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1365690946-28050-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1365690946-28050-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes unneeded initialization and empty line.

Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
---
 net/bluetooth/sco.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index ca393b4..af7750e 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -481,8 +481,7 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen
 {
 	struct sockaddr_sco *sa = (struct sockaddr_sco *) addr;
 	struct sock *sk = sock->sk;
-	int err = 0;
-
+	int err;
 
 	BT_DBG("sk %p", sk);
 
-- 
1.7.11.7

