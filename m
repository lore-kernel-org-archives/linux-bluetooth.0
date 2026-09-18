Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6351FFC59
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 00:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689777; cv=pass; b=QJ8inv6WD0Qn5o0gsI1CHePlj2Rkb9++rjjWsggNejfdNXYiG4WK09a/PFSf0IRVCS6HkL/PnHOW1bl4CxtAexxfFjpRpQTwv22I4RfI6P0FJVHurwhTLkk1qf3/iaWfmCrON8LS+BES1bJjEFCShsvWogQGAgjW0VuuWyMHZGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689777; c=relaxed/simple;
	bh=KfKnOQs9hWbofLT8F90HFmmZs7LY+HkM3O0GADuRUgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2QX5Cz5k1dDEFp/VTM1GJRAWBVqHyhOHFTRAmbyzgnWzaZBgxpPEXJW3RbnBlfXSUVKcxwVrxMF/TsYxcHfnnHZk1UlRuf3tlE40R3E1ZlRvUb82S/Vt4k7uLEwCUPlOMgpl4TbiTXGYPQuhioRg1o8gR6UI0XuEtHSUpfn3jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=tGe2wNLR; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="tGe2wNLR"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:f410::dc01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hmCVv2myDz10s5;
	Fri, 18 Sep 2026 03:02:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789689767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/aRnjy+hMh5Qpt9tqc0RnDGZbBSEfntpAqaHYY75+0=;
	b=tGe2wNLRaHGHbkeMF8O/La/ezjWo22HiKO3cG8gVaeiEBFbyrx3eiP5k//dPInJEUyTCkO
	NOBd9hjbcrujSwYh9sG4LJjdMMzQKRpsnyt0JDrNFCU8sW5kFOMuOuAo+QdTD5AE6Repk0
	O1WuPlMnM1mBKT8VeLYaXXoZlNJmP9E=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789689767;
	b=Jj2wZIDZpWWAl1fc2eSPkWOVoOqGW7GlAT+AfjgR0Fw35PrvpOysN5WjzgDMgBxnqRjkqk
	8vUNX2gHjBeUPYoigLl4mK5uLFMq8ygnraiBPjIIHW97a48fWmp+QUWqFp3jrgwVSAQ3Bs
	i8JvTEu3QqBfJuopJc3O6M7QlfN7oQ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789689767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/aRnjy+hMh5Qpt9tqc0RnDGZbBSEfntpAqaHYY75+0=;
	b=KUKPArn7lNxDU4g2MflnuDYwqfLhw/1foQ57XABMUr+uTaBia6TqvIXb3rm7kdhGaB9IBZ
	n1azMXDOz3JDX6k2810ZySnsjxjoynkXzN8qwAq29UszkrRH5g5Uj5e9Bxe1wNxLcdRDGv
	rvuN4M3CvoqZcPGyMCAwxQpb6buahdg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/4] device: Fix resolving a coordinated set over Secure Connections
Date: Fri, 18 Sep 2026 03:02:28 +0300
Message-ID: <fc4dcb6890e80cd5978da814ab4255801b3862eb.1789689632.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789689632.git.pav@iki.fi>
References: <cover.1789689632.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9251e630efdd ("device: keep the long term key of both roles")
adds separate central/peripheral slots for LTKs.

Kernel only sets LTK event central flag for legacy pairing:
net/bluetooth/mgmt.c:mgmt_new_ltk() sets it if key->type == SMP_LTK.
For Secure Connections there's then no role difference, and BlueZ puts
those keys to peripheral slot.

CSIP coordinator is GAP Central (CSIP 4.2). To decrypt SIRK in
btd_device_add_set() / add_set() it reads device->ltk central key
which then never exists with Secure Connections.

test_bap.py:test_bap_unicast_set_* implicitly use legacy pairing since
pytest-bluezenv==0.1.9 powers controller on before bluetoothd, so these
tests miss this bug.

Fix by tracking the MGMT LTK type in struct ltk_info so the code knows
which kind of key it has.  For Secure Connections, store the same key in
both slots.  If key type changes, drop both slots, to avoid mixed
legacy/SC keys.

This fixes test_bap.py:test_bap_unicast_set_* with SC enabled, ie if
controller is powered off before bluetoothd start.

Assisted-by: qwen3.8-flash-next
---
 src/adapter.c |  5 +++--
 src/device.c  | 32 +++++++++++++++++++++++++++-----
 src/device.h  |  2 +-
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index fc734424b..717db2ea9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4580,7 +4580,7 @@ static void load_ltks(struct btd_adapter *adapter, GSList *keys)
 			device_set_paired(dev, info->bdaddr_type);
 			device_set_bonded(dev, info->bdaddr_type);
 			device_set_ltk(dev, info->val, info->central,
-						info->enc_size);
+					info->authenticated, info->enc_size);
 		}
 	}
 
@@ -9241,7 +9241,8 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
 		device_set_bonded(device, addr->type);
 	}
 
-	device_set_ltk(device, ev->key.val, ev->key.central, ev->key.enc_size);
+	device_set_ltk(device, ev->key.val, ev->key.central, ev->key.type,
+							ev->key.enc_size);
 
 	bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
 }
diff --git a/src/device.c b/src/device.c
index 443fbbca9..6d82ea3e2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -163,6 +163,7 @@ struct bearer_state {
 
 struct ltk_info {
 	uint8_t key[16];
+	uint8_t type;
 	uint8_t enc_size;
 };
 
@@ -2132,21 +2133,41 @@ static void add_set(void *data, void *user_data)
 	}
 }
 
-void device_set_ltk(struct btd_device *device, const uint8_t val[16],
-				bool central, uint8_t enc_size)
+static bool ltk_is_sc(uint8_t type)
 {
-	struct ltk_info **ltk;
+	return type == MGMT_LTK_P256_UNAUTH || type == MGMT_LTK_P256_AUTH ||
+						type == MGMT_LTK_P256_DEBUG;
+}
+
+void device_set_ltk(struct btd_device *device, const uint8_t val[16],
+				bool central, uint8_t type, uint8_t enc_size)
+{
+	struct ltk_info **ltk, **other;
 
 	/* Legacy pairing distributes one key per role, so both are kept
 	 * to let each of them be selected by the role of the link.
+	 * Secure Connections has no difference, so duplicate same key in
+	 * both slots.
 	 */
 	ltk = central ? &device->ltk : &device->peripheral_ltk;
+	other = central ? &device->peripheral_ltk : &device->ltk;
 
 	if (!*ltk)
 		*ltk = new0(struct ltk_info, 1);
 
 	memcpy((*ltk)->key, val, sizeof((*ltk)->key));
+	(*ltk)->type = type;
 	(*ltk)->enc_size = enc_size;
+
+	if (ltk_is_sc(type)) {
+		free(*other);
+		*other = util_memdup(*ltk, sizeof(**ltk));
+	} else if (*other && ltk_is_sc((*other)->type)) {
+		/* Drop stale SC key */
+		free(*other);
+		*other = NULL;
+	}
+
 	bt_att_set_enc_key_size(device->att, enc_size);
 
 	/* Check if there is any set/sirk that needs decryption */
@@ -2162,8 +2183,9 @@ bool btd_device_get_ltk(struct btd_device *device, uint8_t key[16],
 		return false;
 
 	/* The key securing the link is the one distributed by the
-	 * peripheral, so each side has to select the one matching its
-	 * role for both to use the same key.
+	 * peripheral, so for LE legacy pairing each side has to select
+	 * the one matching its role for both to use the same key.
+	 * Secure Connections duplicates its single shared key in both slots.
 	 */
 	ltk = btd_device_is_initiator(device) ? device->ltk :
 						device->peripheral_ltk;
diff --git a/src/device.h b/src/device.h
index 7c3f45333..2ed369856 100644
--- a/src/device.h
+++ b/src/device.h
@@ -149,7 +149,7 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg);
 bool device_is_disconnecting(struct btd_device *device);
 bool device_is_connecting(struct btd_device *device);
 void device_set_ltk(struct btd_device *device, const uint8_t val[16],
-				bool central, uint8_t enc_size);
+				bool central, uint8_t type, uint8_t enc_size);
 bool btd_device_get_ltk(struct btd_device *device, uint8_t val[16],
 				uint8_t *enc_size);
 void device_set_csrk(struct btd_device *device, const uint8_t val[16],
-- 
2.55.0

