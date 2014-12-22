Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] Bluetooth: Export ECDH functions for self-test module
Date: Mon, 22 Dec 2014 19:53:08 +0200
Message-Id: <1419270792-29086-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1419270792-29086-1-git-send-email-johan.hedberg@gmail.com>
References: <1419270792-29086-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Similar to the SMP functions, this patch exports the two public ECDH
functions so that a self-test module can access them.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/ecc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/ecc.c b/net/bluetooth/ecc.c
index e1709f8467ac..71d0a9c10775 100644
--- a/net/bluetooth/ecc.c
+++ b/net/bluetooth/ecc.c
@@ -794,6 +794,7 @@ bool ecc_make_key(u8 public_key[64], u8 private_key[32])
 
 	return true;
 }
+EXPORT_SYMBOL(ecc_make_key);
 
 bool ecdh_shared_secret(const u8 public_key[64], const u8 private_key[32],
 		        u8 secret[32])
@@ -814,3 +815,4 @@ bool ecdh_shared_secret(const u8 public_key[64], const u8 private_key[32],
 
 	return !ecc_point_is_zero(&product);
 }
+EXPORT_SYMBOL(ecdh_shared_secret);
-- 
2.1.0

