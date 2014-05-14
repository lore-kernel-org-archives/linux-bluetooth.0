Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/3] shared/crypto: Add support for AES-CMAC-128
Date: Wed, 14 May 2014 11:04:24 +0200
Message-Id: <1400058266-31790-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch extends bt_crypto with AF_ALG socket for cmac(aes) hash.
Socket is created on bt_crybto initialization.
---
 src/shared/crypto.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/src/shared/crypto.c b/src/shared/crypto.c
index cc7536a..f0b2979 100644
--- a/src/shared/crypto.c
+++ b/src/shared/crypto.c
@@ -70,6 +70,7 @@ struct bt_crypto {
 	int ref_count;
 	int ecb_aes;
 	int urandom;
+	int cmac_aes;
 };
 
 static int urandom_setup(void)
@@ -105,6 +106,28 @@ static int ecb_aes_setup(void)
 	return fd;
 }
 
+static int cmac_aes_setup(void)
+{
+	struct sockaddr_alg salg;
+	int fd;
+
+	fd = socket(PF_ALG, SOCK_SEQPACKET | SOCK_CLOEXEC, 0);
+	if (fd < 0)
+		return -1;
+
+	memset(&salg, 0, sizeof(salg));
+	salg.salg_family = AF_ALG;
+	strcpy((char *) salg.salg_type, "hash");
+	strcpy((char *) salg.salg_name, "cmac(aes)");
+
+	if (bind(fd, (struct sockaddr *) &salg, sizeof(salg)) < 0) {
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
 struct bt_crypto *bt_crypto_new(void)
 {
 	struct bt_crypto *crypto;
@@ -126,6 +149,14 @@ struct bt_crypto *bt_crypto_new(void)
 		return NULL;
 	}
 
+	crypto->cmac_aes = cmac_aes_setup();
+	if (crypto->cmac_aes < 0) {
+		close(crypto->urandom);
+		close(crypto->ecb_aes);
+		free(crypto);
+		return NULL;
+	}
+
 	return bt_crypto_ref(crypto);
 }
 
@@ -149,6 +180,7 @@ void bt_crypto_unref(struct bt_crypto *crypto)
 
 	close(crypto->urandom);
 	close(crypto->ecb_aes);
+	close(crypto->cmac_aes);
 
 	free(crypto);
 }
-- 
1.8.4

