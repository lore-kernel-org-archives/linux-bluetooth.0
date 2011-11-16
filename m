Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 11/17] sap-u8500: Fix errno handling convention
Date: Wed, 16 Nov 2011 09:19:58 -0400
Message-Id: <1321449604-4188-12-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Variables which are assigned to the errno variable (usually called
"err") should be negative, and "-err" should be used where a positive
value is needed.
---
 sap/sap-u8500.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sap/sap-u8500.c b/sap/sap-u8500.c
index e699fd7..ef7d95c 100644
--- a/sap/sap-u8500.c
+++ b/sap/sap-u8500.c
@@ -571,9 +571,9 @@ static int simd_connect(void *sap_data)
 
 	sock = socket(PF_UNIX, SOCK_STREAM, 0);
 	if (sock < 0) {
-		err = errno;
-		sap_error("creating socket failed: %s", strerror(err));
-		return -err;
+		err = -errno;
+		sap_error("creating socket failed: %s", strerror(-err));
+		return err;
 	}
 
 	memset(&addr, 0, sizeof(addr));
@@ -581,14 +581,14 @@ static int simd_connect(void *sap_data)
 	memcpy(addr.sun_path, STE_SIMD_SOCK, sizeof(STE_SIMD_SOCK) - 1);
 
 	if (connect(sock, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		err = errno;
-		sap_error("connect to the socket failed: %s", strerror(err));
+		err = -errno;
+		sap_error("connect to the socket failed: %s", strerror(-err));
 		goto failed;
 	}
 
 	if (fcntl(sock, F_SETFL, O_NONBLOCK) > 0) {
-		err = errno;
-		sap_error("setting up socket failed: %s", strerror(err));
+		err = -errno;
+		sap_error("setting up socket failed: %s", strerror(-err));
 		goto failed;
 	}
 
@@ -598,7 +598,7 @@ static int simd_connect(void *sap_data)
 
 failed:
 	close(sock);
-	return -err;
+	return err;
 }
 
 void sap_connect_req(void *sap_device, uint16_t maxmsgsize)
-- 
1.7.0.4

