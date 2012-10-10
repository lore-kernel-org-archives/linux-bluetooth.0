Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Use __constant modifier for RFCOMM PSM
Date: Wed, 10 Oct 2012 22:09:29 +0530
Message-id: <1349887169-20880-4-git-send-email-s.syam@samsung.com>
In-reply-to: <1349887169-20880-1-git-send-email-s.syam@samsung.com>
References: <1349887169-20880-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since the RFCOMM_PSM is constant, __constant_cpu_to_le16() is
the right go here.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 net/bluetooth/rfcomm/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index fb1d83d..201fdf7 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -709,7 +709,7 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 
 	bacpy(&addr.l2_bdaddr, dst);
 	addr.l2_family = AF_BLUETOOTH;
-	addr.l2_psm    = cpu_to_le16(RFCOMM_PSM);
+	addr.l2_psm    = __constant_cpu_to_le16(RFCOMM_PSM);
 	addr.l2_cid    = 0;
 	*err = kernel_connect(sock, (struct sockaddr *) &addr, sizeof(addr), O_NONBLOCK);
 	if (*err == 0 || *err == -EINPROGRESS)
@@ -1987,7 +1987,7 @@ static int rfcomm_add_listener(bdaddr_t *ba)
 	/* Bind socket */
 	bacpy(&addr.l2_bdaddr, ba);
 	addr.l2_family = AF_BLUETOOTH;
-	addr.l2_psm    = cpu_to_le16(RFCOMM_PSM);
+	addr.l2_psm    = __constant_cpu_to_le16(RFCOMM_PSM);
 	addr.l2_cid    = 0;
 	err = kernel_bind(sock, (struct sockaddr *) &addr, sizeof(addr));
 	if (err < 0) {
-- 
1.7.9.5

