Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010724;
	b=CwNMV/6CkJ4T+3XU1l9/0yOLVdcF+VOId9W2I205FqiLXanU4JGZZ20EBx3MpWAU1k26
	 uLCH9q6b9Bef3DWi7e5Zr5em1kEQXo0qpkS/t7BhPUSspDkOSJ9DTpnam9jA/2tVh4ZsH
	 2LQ1+dLNrMvYqIO1Yio0p+R4ySICgBS9rgnVx86T/1xqQvHHftWIv3GVEZKk+Q3MSjLed
	 u23MG3Iwq3+QwuzzqDEeLaQskCvOT+lNCU9DCjB+WCf3m2DxegTabZACRLOd78uWVupVH
	 g7aA1IlInXLH+PAR6PM7/Ii7knSErPly9jPgAjV17vGJ8SMFVaF8U7TS255pUBkWaig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n0pqOByGajxzAGxQIu938+LZbHpvZ5anXF1/+ic+foA=;
	b=1TgrdjZhgGYGf5yJexLQDR3mpTxtWh9cBNPOX8i1pPN2rxX+I+zaNcL3kRUHFdzm2Wxs
	 V91ZYBF1ASb5rFNfaTWaTJVHNtu1ftB9dvyTXb7a1+i8sAysZvqzdw7dzPWe+GB+y5nw2
	 DkyKTdyT2dfd1snXDxVquKmNTkrZS//gPyPe/JiryUWPuf7nH4liiS3esDZb4DDWDRK1J
	 BCy633vtZovYIv1nL8Vz3M+EXK1RVlWGQh5a8111ZTbXhph8+lugCMoVjaunTx5v7uaza
	 ZWzSUc44iEGTYHWxlTjE90igWKe7SpQKp9iRtBBZRAr9LePEzlzQQUXqPjoTTM84YGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O99w4wsq;
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD58E60A2611
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD58E60A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O99w4wsq
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso337394137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795010723; x=1795615523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n0pqOByGajxzAGxQIu938+LZbHpvZ5anXF1/+ic+foA=;
        b=O99w4wsqDeasMPMQpHUY8Q2SOZFPfFuWWeARvf1rvnZ/1hu72rVF/bVnb9ym6dYOEC
         Mmz8zKRGcTNeFatvE2GAzUgvHhmyJ4snBai37k3SyLvyjCIsNg7CGIk7xo5KuWperoYP
         16atlULcnXHCCWxF16jlGWuagv1zdIRF+8lA3eAKj7yS0RYMOsnaK2mtKdaoLNRuq6sg
         z91ae2vaV0SNxUPvxuCLsg5jTQ3+dtgE6E1AJTYzQg87sqVGHi91Uo8YszeKYtp440Q3
         6RiH3XgQR4SjlbMQ/cYxE9kmP7A3Cz87cREmzyu4ixpb8xF4c6JDnjo6NAfFesg/Qb0g
         FD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010723; x=1795615523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=n0pqOByGajxzAGxQIu938+LZbHpvZ5anXF1/+ic+foA=;
        b=Wd6wLstnpcNOodg6ZgjIqQHzSbs0qdx+U56kYcY+bTyQBas3dqmWiotJPtCCCTjzUf
         LECGj0ofWUY78YlKYKqu6dRLS9a38aG8UnMR+3I9JNJEEPE80hGlJRLiopIpyMYPfNph
         DGVH9zCDjDCLEHcHXTXHz22imOymfv3wmdZuF1Mt3M6e5+C5k66rOvnMFGfOsIc5XHBg
         sLvPRhDkqrdYWLB4W3WlThjmFn3HddAvK9TfmtL8cW0ORHvdUcTALX3H5596/Hla4New
         b5iGEv8HRAF2rCRWqc848pFp0Cye05zwqs1to+I9rQgNyjg0QVgldLKU9GLNsqfM6Msd
         4JzQ==
X-Gm-Message-State: APuU4Z9z7ACp3yYFBMb5Eb9pVWajF7KKYnWTmeyvPAfAp5yfRROzoNaG
	ixpcxukKcUk8qWeUJe/T2sYPyetIIv3HnYu7XBlFXfUxLQTVy4tYTOH++WTE/h57
X-Gm-Gg: AYBFou2qeSHS9lYRLz9LvUDuRnfNq36R+Zlo4/3cl64JZpujZmNkcXJ6b8PU4T/XSoz
	N5Z6HleE8wdLud6BbjwxNWGldUMY3+vP76A8/bM3NOMQxgc1mkklg9DLgA5pKeX20YZgR60oaO8
	MGL7J9BNAxiRHn2yl8/iRmRU1XLfooV/6g9av26LPnfGCIgegxd2MCQCsbHKkohdKUFU6P1TO2K
	l4Nsjuc0uIvjbJ31c41OmIL1kWdAo/FsRb3zfvtXlEY5KoHwIbroqwkQLC7mkwj36aGT+qgvViC
	o/0WBVnmXJc/rxI5sb9CcDUpH2OoTwKh2RrRT2CG87Kg2ow2WrU6wPXOKoHDzXyOeFgr1Gl4WZY
	rIZwqxzRgW7Czs83eM9dONk392kIjzPJmOthqlZwBQYsej9XtnpfrNWGDAbO5/jnFVqXQZXjFo8
	9UKekDwLICiOpu4apyey1w1P64LYqXfcD2LAeBRpqIKQSfpuItJVjSfncphYwQLbXyQ5Y2idbrO
	x8yh1xvC5NS686BewdA1jGyO/4huf/AN32S1nZ6HtHs/3Bs3hlyUfycBiki94XoJ1ggMRZja6Tm
	MsfqcUChInY/QkweitOQV9VM5D7LbOwdOsSTQFKL4wfPrXoTKBzt42sF6ojJcoal7z3bpBfdOF2
	DoYIxN952by/beFaChg2LjqECEhUqOXXYwyYajjd2mXmP5uaDYtkCoF0V0E+VNSXyXcsKVN1fx+
	/vAZs=
X-Received: by 2002:a05:6102:f83:b0:7c3:9464:efaa with SMTP id ada2fe7eead31-7d6ba1c651emr850902137.2.1795010722911;
        Wed, 18 Nov 2026 06:05:22 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b914e10esm1697639137.3.2026.11.18.06.05.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:05:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 03/17] Bluetooth: hci_sync: Lock the lookup in hci_disable_ext_adv_instance_sync()
Date: Wed, 18 Nov 2026 09:05:04 -0500
Message-ID: <20261118140518.59878-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118140518.59878-1-luiz.dentz@gmail.com>
References: <20261118140518.59878-1-luiz.dentz@gmail.com>
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

