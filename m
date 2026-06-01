Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D892D839C
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330969; cv=none; b=UpyopjhW8BLylTsCt6WVLpajic4Cz66gx4w18C11MZAf1pk3Ggvpya7DObLTG9cpG3NhtMZElT9q0rrGQHeK8myUeqkLs6MANG0XmXXCW9+aEXXPRbdbU+k2fpbrX+X5l21DVWXxmNWY0ec3Yjm9icQRoo1BOQ2cjP/dGEUqU0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330969; c=relaxed/simple;
	bh=XbDa7ahvkbouj4nXflmBjHzwiZb+OcXPwS3KDXfIhLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RlSpN1gF+a0yfkMpd8rgUxZWFJdQqvLpRt149SWZML9t6BfI25o43M+yoX94b8vdbQfv+Hj2gOWls/Oji3KUsw1RTcvwv099VYgWqXWKjuYO0urek9claEfSSTbshITbu2tcMAz/8FBbLBylBMuHcmFgyGlOxKSktIsx+ZRhg7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vpb38Ga5; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vpb38Ga5"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-137335bc3caso8512934c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 09:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780330968; x=1780935768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2jX84Zk+X2wna8QCsEP2HWNpN4PTnI4XWkcFVPYbSFY=;
        b=Vpb38Ga59+ox5SEAcGcWf6IMHUJ/r7/e3QjfbF9tJ8+rceSyBeDs2zeBx1ouMJgmp6
         E2gFEKI/wHo9fTbt0ch9zsQeFN2UbUevZSjVDNbc8+jkTVuXMohi0eJOyiXbBHStZQL2
         sZL1xxz+y1SV1voohcq5q3ebWNsHudyH6hwDEpI0fMgTwBVtrsN4mRVV7rh9Gf+5CTWp
         w/yhQvNd55L71ZDUvtjzOU6LNvj23pm8Iv5teRZgIwQWpUcrg3bAmn1NlSnLMKZwJvq0
         V+Y+6FRSxWKBs+wxG32bqo+D1PweQbcKPA0qOLOsIKtMioVCbvM1yaKCdE8FyBBuFDVn
         BN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780330968; x=1780935768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jX84Zk+X2wna8QCsEP2HWNpN4PTnI4XWkcFVPYbSFY=;
        b=mKxuICXYj92albbjwocJ5/HZ88AtBtzUsOhoCuxQ41MWgr5doxIf6N9rgF70z+Af8n
         fqFd0CRUi4ayolqNLcA/QvLmLQnwWvmqAJPvqBhe+kzSM/rZyYZ4RCNe/F29TLN7O0Cp
         mdQMVfu8xgbL5AdW+oOpw1WZwFn/m3I/8mzKtwgEAcREw+v+IgrEjgkNbJjMVY0pX9jY
         8epPtZPg1hOtpBnPNVSVkLScnHX04Z+xv1mXoOszwXqMSaV8XabWs3kyy+dG+JEdceE/
         jPm0k6Mbk79wSBDVHUCfG2iBAQRsFpeWtzPvD/Vsp7f+5reIFtzzzXaVG9qKoUgYoK/s
         xGGw==
X-Gm-Message-State: AOJu0YwjM9Z7kzO89Uo1uHPO+8eYj0fiwkMrs7mVxu3d3og/u4Q75GAp
	Y5BEvjOSCWMQzC0NxMbtIRiT6AzSn1xMYj8sf0lRsF8GEGs6rTwfXK2uDIcpobUYaKo=
X-Gm-Gg: Acq92OG1NAAER9rKVAhJ9veM+IdG7w5ckFI3FqtAKWIMGQEIMhbODj7G5hz0kbaoAGR
	jhtx54u6I5GyMVGETxMwhFDlat6KnheC6hACA7qzGy/tMop+ywx4Th1fSj5lW3TLxEIAYH5zAmZ
	xTOQk3bQgerwA9kSGf9ekj8i50OiuQT1uMsmtEwJL5pje3+vCb1S5c3ek7OeqgMa3O+PcL2VTJG
	SGMhJGndIIl8XlVF3w2N91VyeG3+VTtlpLrY+//J8TnvUa7IZTzZuD2o402YNr532m0xDRANBKB
	3quN0SVgTuIjX8KsX4IKwYWVF4sgRW4nUsJtAmVaTAYZKxKshY6fH7GfkghMC+kAfm9i5iP0+xB
	QsLeTPCGjLOykUo978WMgjyYyokQBDFjTRrMqXkZfAIbQ575Aips04Nijzfj5Q7NEvJT/a8zZQM
	IXCnVp7XLTAorAJBpULsB1XjwMKCJG6bkcGkFDglxyq3zhQYiMrxipL+oFZj5+pLHGst4HnCc=
X-Received: by 2002:a05:7022:e24:b0:134:df4a:2821 with SMTP id a92af1059eb24-137d42a2f43mr5506484c88.40.1780330967474;
        Mon, 01 Jun 2026 09:22:47 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b2d04287sm9134597c88.0.2026.06.01.09.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 09:22:46 -0700 (PDT)
From: Xiang Mei <bestswngs@gmail.com>
X-Google-Original-From: Xiang Mei <xmei5@asu.edu>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Weiming Shi <bestswngs@gmail.com>,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH bluetooth] Bluetooth: eir: Fix stack OOB write in eir_create_adv_data()
Date: Mon,  1 Jun 2026 09:22:04 -0700
Message-ID: <20260601162203.1253918-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiming Shi <bestswngs@gmail.com>

eir_create_adv_data() builds the advertising data into a fixed-size
buffer of "size" bytes (31 for the legacy path in hci_set_adv_data_sync()).
It may prepend a 3-byte "Flags" AD structure, but the per-instance
advertising data is then copied without checking that it still fits:

skip_flags:
	if (adv) {
		memcpy(ptr, adv->adv_data, adv->adv_data_len);

The "Flags" structure is added whenever BR/EDR is disabled
(LE_AD_NO_BREDR), which is the normal state for an LE-only controller.
However, the mgmt length validator tlv_data_max_len() only reserves
those 3 bytes when the user-supplied adv_flags carries a managed-flags
bit (DISCOV / LIMITED_DISCOV / MANAGED_FLAGS). Adding an instance with
flags == 0 reserves nothing, so adv_data_len is accepted up to the full
buffer size. At advertise time the 3 flag bytes are still prepended,
and the subsequent memcpy() writes 3 + adv_data_len bytes into the
size-byte buffer, overflowing it by the attacker-controlled tail of
adv_data:

  BUG: KASAN: stack-out-of-bounds in eir_create_adv_data (net/bluetooth/eir.c:302)
  Write of size 31 at addr ffff88800b7e7bac by task kworker/u9:0/51
  Workqueue: hci0 hci_cmd_sync_work
   __asan_memcpy (mm/kasan/shadow.c:106)
   eir_create_adv_data (net/bluetooth/eir.c:302)
   hci_update_adv_data_sync (net/bluetooth/hci_sync.c:1689)
   hci_schedule_adv_instance_sync (net/bluetooth/hci_sync.c:2015)
   hci_cmd_sync_work (net/bluetooth/hci_sync.c:332)
  This frame has 1 object:
   [32, 64) 'cp'

The inconsistency dates back to when the managed "Flags" field was first
added to the Add Advertising path: the prepended LE_AD_NO_BREDR flag does
not depend on the user-supplied adv_flags, but tlv_data_is_valid() only
reserved room when MGMT_ADV_FLAG_DISCOV was set. Commit 47c03902269a
("Bluetooth: eir: Fix possible crashes on eir_create_adv_data") later
added the "size" argument and bounds-checked the "Flags" and "Tx Power"
AD structures, but left this copy unguarded. Guard it the same way so
the data is only copied when it fits.

The bug is reachable by a local user with CAP_NET_ADMIN that owns an
LE-only controller using the legacy advertising path.

Fixes: b44133ff03be ("Bluetooth: Support the "discoverable" adv flag")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/bluetooth/eir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
index 3f72111ba651..e574f8f61e16 100644
--- a/net/bluetooth/eir.c
+++ b/net/bluetooth/eir.c
@@ -297,7 +297,7 @@ u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 size)
 	}
 
 skip_flags:
-	if (adv) {
+	if (adv && ad_len + adv->adv_data_len <= size) {
 		memcpy(ptr, adv->adv_data, adv->adv_data_len);
 		ad_len += adv->adv_data_len;
 		ptr += adv->adv_data_len;
-- 
2.43.0

