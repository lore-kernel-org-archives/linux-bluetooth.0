Return-Path: <dan.carpenter@oracle.com>
Date: Tue, 2 May 2017 12:29:03 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Salvatore Benedetto <salvatore.benedetto@intel.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: add a check for kmalloc() failure
Message-ID: <20170502092903.u7no6pizkakf454o@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

We should check to see if this kmalloc() fails.

Fixes: e7c404c96c74 ("Bluetooth: allocate data for kpp on heap")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/net/bluetooth/ecdh_helper.c b/net/bluetooth/ecdh_helper.c
index 80184476ff74..c8535845813d 100644
--- a/net/bluetooth/ecdh_helper.c
+++ b/net/bluetooth/ecdh_helper.c
@@ -59,11 +59,15 @@ bool compute_ecdh_secret(const u8 public_key[64], const u8 private_key[32],
 	struct ecdh p;
 	struct ecdh_completion result;
 	struct scatterlist src, dst;
-	u8 *tmp = kmalloc(64, GFP_KERNEL);
+	u8 *tmp;
 	u8 *buf;
 	unsigned int buf_len;
 	int err = -ENOMEM;
 
+	tmp = kmalloc(64, GFP_KERNEL);
+	if (!tmp)
+		goto out;
+
 	tfm = crypto_alloc_kpp("ecdh", CRYPTO_ALG_INTERNAL, 0);
 	if (IS_ERR(tfm)) {
 		pr_err("alg: kpp: Failed to load tfm for kpp: %ld\n",
@@ -130,6 +134,7 @@ bool compute_ecdh_secret(const u8 public_key[64], const u8 private_key[32],
 	crypto_free_kpp(tfm);
 free_tmp:
 	kfree(tmp);
+out:
 	return (err == 0);
 }
 
