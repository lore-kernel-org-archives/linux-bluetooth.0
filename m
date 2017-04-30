Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: zero kpp input for key generation
Date: Sun, 30 Apr 2017 03:48:33 -0700
Message-Id: <20170430104833.16108-1-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When generating new ECDH keys with kpp, the shared secret input needs to
be set to NULL. Fix this by including kpp_request_set_input call.

Fixes: 58771c1c ("Bluetooth: convert smp and selftest to crypto kpp
API")
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/ecdh_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/ecdh_helper.c b/net/bluetooth/ecdh_helper.c
index 579684bfc322..2a65ca3fa8fa 100644
--- a/net/bluetooth/ecdh_helper.c
+++ b/net/bluetooth/ecdh_helper.c
@@ -191,6 +191,7 @@ bool generate_ecdh_keys(u8 public_key[64], u8 private_key[32])
 			goto free_all;
 
 		sg_init_one(&dst, tmp, 64);
+		kpp_request_set_input(req, NULL, 0);
 		kpp_request_set_output(req, &dst, 64);
 		kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
 					 ecdh_complete, &result);
-- 
2.9.3

