Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017560;
	b=DawmPomPU2w/E8nvAIurX9VAleC5LJUck/Dq9svQV2nFjGn1tgnbEoCBxhQjo5XHCMi1
	 ZxYSmznkQ+iXRj7FbYuQBQaqN/IcjkO6Sa327CHMsjiu03RTT3JIlmRqxCHXJZ7NxAyDi
	 +7MWyTMZaA0zrh7IHOyOMTAucrx/Banlsgo3KTOxqUk3trz6QJAC5Ali9Ec17zEG95FXi
	 7nW33AkRgprnHwwucsGS4zkeaQhlC7KhfyoR/7Dh8XbASiGReHJTtKyr++b7GJx9+GUbC
	 Ez8rcPNkTfVUVRZHrZpgClEl0gvjtzdlXbbIi1VSLPtNfmsh4e8204jz+uyh08xMElQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017560;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n0pqOByGajxzAGxQIu938+LZbHpvZ5anXF1/+ic+foA=;
	b=NZnqAcq8H7RaA/149tYXt9NLPlVcfwhNA6vPeLVSg7LP5gsL8abq8dLK+GyHbvjR+t0W
	 hDRYhGbo3gs5tnGun8ZQ9G6vJzf5XWTByMN8sBZm1t+rsh4aJAehbKP6BLTAfnS8SYgIM
	 3IbRP6TogV32TF1ziZoLgnbeR5TGr+OV0F3Z+dd4QPT739zDdfQ3paZqieG4Pgze5L7l2
	 tLl2d2g3YoRz/SZ9hcGwjTD+rMriUyItWla3MUc+CcRfuHUGH+GRsZOn6w3fc1GKz6qSd
	 j7mrdMYdSu81m/zZ418WQBDPwdomfs/B9ilx3h2atxYNpbNm9pL1cxi3yAj0+GJ8J0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zwXMUAwd;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD56606A335
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 15:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AD56606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zwXMUAwd
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7d2eba2b74aso587579137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 07:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795017559; x=1795622359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n0pqOByGajxzAGxQIu938+LZbHpvZ5anXF1/+ic+foA=;
        b=zwXMUAwdKg9EMDW7jjkL1KX0978J3xIXlCqgfirPI+uRHrSTgNHH11xrUsMK9CYDw0
         l73GncDwiV+l0p1ibromdudrxgk8IrewtkaRAD1JWqrdVQwuFRpfg89Y0utEL/FhlJIG
         FpvRZ7u/tuBVLLH6oaelbMTFNIhoASDe+p2UPH4Zd4moxJc0IstaP64gzaeyTFuhL/cX
         34//bEgnIndMTfTc8X84RpgKkP+rTi3d7Sx1Z+wbPcbVF3O5IhbJB1k2JmL5MymzHOVj
         VFzsB5MD2HKQ/2ZFwDK6N6PTzYUBhvwOPXz2725t5svS2EemcIyAxMvN8pssZlw4wbQW
         qD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017559; x=1795622359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=n0pqOByGajxzAGxQIu938+LZbHpvZ5anXF1/+ic+foA=;
        b=TwZfChHp8G8wRfXxZw5S3cApWe+JdY7Hpheoy17xVIHVtqx00YRnJ1ih2W9kwwQ6+9
         cT+H3iEgMK3Bzj73GNdOCsT4I2LftZvxRBc6Hft0NjkLpdrCMoAsNkymeahc4vtyKAQJ
         gnncfokhjloey5Z1jJfW23hHJOJmbiIElTUbVjSzCaYQErpNmNdC+pBFSVT1WhltyFNJ
         TydobSgYQtVRWxy2Xwz+s/yN8fkeUKtQ3vIa4/Qzi/0vY8IHNbtQR/nEzlLR+n3p11+N
         5ND9ZFE3eJ44ztlJbzxMglgnbXUV0PELTUWZUzpljsgHmbrcPiYt4NjZuTx4DA/HeypA
         dYNg==
X-Gm-Message-State: APuU4Z+9KE3j2uPTnRxKq4awyV0Q4g9DLZ4RoStsWSW7LRBegh4hwZyu
	A1CiveHJL2X4zSAued3LOBmnxHR3f0lL1nvD0EmQ3DITBObj2aTVZybguqZm+zXr
X-Gm-Gg: AYBFou0oUtvuTpBV1USPolrUzVY2Jzslzu5Lz2FS+WyTn4Y+tKHZN342CneKy/wlIa4
	jatZYmWHNVO42aV9hn4jZEANtND6WMQ++YXIA6WO1QLvyXHCGQsK5aE4YiPGyiXur91ZwIgbX9f
	EalY1CMqxZL9ix+sR/uCbvPOZe+B+AByFOLjxY0Zkkbcxqf2387XM7mcBKM8duCvIeUrLu4GtWM
	JasRe0CdPc2DICCHMZtuY9/5tCU3fE7FqPkGn4+n3xaSl2n5pd/Wy82qTArNN6M/1ud4r/i8eOd
	X2pk/bUMhdy43Jz1JtUUAtx5dQqjIZEBN6He5xayMidf2rUgNWKq08n9RPyBinTerMrGH9VRnqZ
	LSl8AKb952FlrdHYY/SK3+xDjy72GK1XkTDqRr3OL01nNSzxI9+PNXTqg+GhEmY+s8U/9fQk7T3
	tP4Rw8vSy6aTSGbll2zXfRICd56hlpQ5sEMArOIQjet119X2o2gtaanPPyy5GWUi6cPePhDk8iQ
	qlmpTOGBtykrR0hg84RSJK+bGhCp/PUFOyGz2eDFM3q9T1mtzrPzdWVYZcWMYOAwVpgBiB0nybh
	qIX8DQCyoN+Mefh3EVJpkZOJbyNSkWvAB2CD2+0gKaKBUd9ySwajaqBqcBCRYyDe4xBeEL0JV2h
	W+biacltSpH9gNgxmvjmdVvnEibgxmLpElfwMMOmAsVmhrBgipaSZAQx7VNZfE34luPiBd5VQSl
	67IWA=
X-Received: by 2002:a05:6102:1489:b0:7d0:5688:f4fd with SMTP id ada2fe7eead31-7d6ba44158amr1274701137.17.1795017559144;
        Wed, 18 Nov 2026 07:59:19 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64e4dfe3sm1919266e0c.5.2026.11.18.07.59.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:59:18 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 03/17] Bluetooth: hci_sync: Lock the lookup in hci_disable_ext_adv_instance_sync()
Date: Wed, 18 Nov 2026 10:59:00 -0500
Message-ID: <20261118155914.178050-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118155914.178050-1-luiz.dentz@gmail.com>
References: <20261118155914.178050-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_disable_ext_adv_instance_sync() calls hci_find_adv_instance() and
dereferences the instance without hdev->lock, racing with the removal of
the instance. Look the instance up under the lock and only use the values
copied while it is held.

Reported-by: sashiko.dev (linux-a364929c-cd00-492a-a83c-5425d042b09f)
Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3fe179d649d0..9cbf2e3009ac 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1226,16 +1226,26 @@ static int hci_disable_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	struct hci_cp_ext_adv_set *set;
 	u8 data[sizeof(*cp) + sizeof(*set) * 1];
 	u8 size;
-	struct adv_info *adv = NULL;
+	u8 handle = instance;
 
 	/* If request specifies an instance that doesn't exist, fail */
 	if (instance > 0) {
+		struct adv_info *adv;
+		bool enabled = false;
+
+		hci_dev_lock(hdev);
 		adv = hci_find_adv_instance(hdev, instance);
+		if (adv) {
+			enabled = adv->enabled;
+			handle = adv->handle;
+		}
+		hci_dev_unlock(hdev);
+
 		if (!adv)
 			return -EINVAL;
 
 		/* If not enabled there is nothing to do */
-		if (!adv->enabled)
+		if (!enabled)
 			return 0;
 	}
 
@@ -1248,7 +1258,7 @@ static int hci_disable_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	cp->num_of_sets = !!instance;
 	cp->enable = 0x00;
 
-	set->handle = adv ? adv->handle : instance;
+	set->handle = handle;
 
 	size = sizeof(*cp) + sizeof(*set) * cp->num_of_sets;
 
-- 
2.56.0

