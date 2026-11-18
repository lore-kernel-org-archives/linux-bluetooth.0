Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017567;
	b=h72BRtXVnXEPP3QE072gEHNu8qFSC+fWvRrh0CTj3gluGUCwXR2ws//cFrq3UGsBlNbs
	 7wsE5HoMXSBhMR8ZDAnn152AnoU0zv0QxlQ6XaLF/SXs8a2THvB9GynsEHAlpHaFPs8rk
	 ZqEnmr7JAL0cbmeV670szZiU2iDqnVkZJuo6B4X6d7izNV8GYA3bIKTVu6S4LV7th58CA
	 Hhb5Clm45SrmkWWYNvj/XTVWVqGRYMimoHkZ+49ZGnYC7gbMDkpy5EXl8vwIftuYMsmQd
	 AdPD5lYySzdLWsf5l5b+xb/G2Mxd6aQ8TcIK6HElfbuExXs7RvtcjkmnalePr4E3spg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VcFHfmCRLVj7oU8mZXuF0owGfxfcjsI6QJ89yOdo7vg=;
	b=plNzsdfUDnQZdFSrStJZO84vzCFflHHxm17aMSfNbnw9FmhE6+sGLjaS0UxuW/k/7Zjo
	 Noy1NyjXn8J3dRCN4qYvnVXwwxPrn+r+nEX7gxDRQOZxoMsHoxG8DA6+dq21wrEKfQBO+
	 SjoqNhky7Lym4pd40RcUs+u0leTgVLEDSwnbef1p4BnRpVGxWn06ZtaWkXBxAtrHdoU0q
	 MKPnOUxyg+TMb1EZlKB19OtiZO8xu7Jto3HIl50pF1KXPmWfS0Riu8184J7rThimseN6d
	 JvUa0wuiY7n/QiA7mTWhbpilsAdvCi1JOspyffENMfsWUJ1i7B8wSzK/Wcf8qTuhwuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lDLiy2cf;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643ED606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 15:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 643ED606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lDLiy2cf
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5ee1e4e3abcso340252e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 07:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795017566; x=1795622366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VcFHfmCRLVj7oU8mZXuF0owGfxfcjsI6QJ89yOdo7vg=;
        b=lDLiy2cffNTibc7b+AUj+dBq9PhmlNqJi6IeC9US+PjUlRwLlaxS6dFanN45vmqRTU
         5sXmJZI6yGifqT9FRYJYeSdgX7Pv3WggvbDaWIeVg/FTu0WVPZQfb9Vo0Jt7tJBnB6xW
         xu4qbzh9qfLRRrOb2VPpWrHkmXUMbVH27WdUJC9sNW9mCbuGLhysLz/fCqdt6J7uIXwD
         4h7Jd0eSrwgHIrQmTwDozB3VYoIx69BWhKAju0x/FqaJxRXXJF5B/oHH1zRqFwUB9uAB
         apWV619nz0xDfk3+sXAzf7ZXrc7teYS+k31BxMzYchKi2ztbSUfQh4xHci3BEFefZC5X
         XaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017566; x=1795622366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VcFHfmCRLVj7oU8mZXuF0owGfxfcjsI6QJ89yOdo7vg=;
        b=nGB9XHivCgk8QGEQKeqTVuxHxoovOekEkSacnib9Z3rdhWN4/cU6L21OK1qOMA+dJb
         kDiAoXlpHwkBV+u4AiMO6g+Sa8W6xl2du+BscYitKsNqnv0bZLd+csONMr8TB3GaIrWd
         7h09nAurEvrzwjD9Uy2NHfUfBwvDX0QXQWOp8iWvK3yYIdVTT1TomsQVWFsGVuiIeKwT
         6+F4zkcD85DEUKIvQiT0OJXukXzttALwA8by3TloiOsFhjH367dYqtb4OYJBpM4Q3Jku
         jPry3su3HzNMXi+z1b2XcXOyuC60HS6zINoALvDNf3agpCZhT8OO7cQE5YaF8cTZEiYJ
         4Gyw==
X-Gm-Message-State: APuU4Z9EtNmycspOW/DIBfSAu53EetP+05OmFoB5RQrXBFqqq8SEvOcu
	XvXRXh9Bk9cTLYKpjdIjzjlp4iSA/hlyrFsqftBt9CS0Y1fte4+cAEyfMBk+wbc1
X-Gm-Gg: AYBFou1FThlxWeq8fJEtDMOlaKJVqHJ4c1gB5CmYGpsft/0M2gzjElKZbpNRLR0g141
	ga+Xjq638Y4uAH2QE8czo5mxpdMeadH8gBLCN/CgZRXfmpqL5bX9p86RA+4vIlPLRNLgX7EOWCY
	ln1n7jnHyGbBj5bf3ZWrECKSsF+gLlL7453Qpbpcz59Wk3mtP26I3Mzichk07iq3ezo+Q4yOZS8
	04E8mN9fkKeLMitJ/0xXKVnd1/OpzpmmqfOthwIOGNRea7iuV7KwhRgbtqu+Ms4/h8ZZ+GqrzLa
	84GsAVwlm+I/VviFNj1rOQiTDNnbwnnCyDeNQbWfHr/vX74p/wKDxSH4xKTqLFcXx4Kq+0wWwRc
	2Pf/t0bvyFv33uG6WBNW5fYYHbW638o5HX+xW36C+2j233oNsjYaT1vUwaNh7DKKs4Hr/UzO3dO
	aUhtGxWEULpCPLF4WGqgwIIXvsJsSxiZ6yMV7fryx64CWNsdsYai18C7u3ESdoPwX5J1XSw6ozV
	MR754iM00Zk72AvE1JJhM9t1vAhwC+gSusTtp+OI/dmMPT1XbOw6zlF4w7PAaJ7Mm0oXDRr7rpi
	Lcd3E4rXKVsno8Wmzw78mSDbT9wlLUPOnl9jb7H62FvJ1qnpXypRR0xh8RBfh1HgqogDZZg2FZm
	fuJ3rhuSB/N5EVX5D4EjLWEmxhuqBkmv2m3kg9zxgDo/VXlQmcllZGpxiHJrMzJLwxJk7ayuC7H
	XCVqI=
X-Received: by 2002:a05:6122:2904:b0:5ea:c330:77c9 with SMTP id 71dfb90a1353d-5ee645fda5emr1544282e0c.1.1795017566178;
        Wed, 18 Nov 2026 07:59:26 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64e4dfe3sm1919266e0c.5.2026.11.18.07.59.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:59:25 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 12/17] Bluetooth: MGMT: Fix use-after-free in mgmt_powering_down()
Date: Wed, 18 Nov 2026 10:59:09 -0500
Message-ID: <20261118155914.178050-13-luiz.dentz@gmail.com>
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

mgmt_powering_down() looked up the Set Powered command and read its
parameters after mgmt_pending_find() dropped mgmt_pending_lock, so the
command could be unlinked and freed in between. Do the lookup and read the
parameters while holding the lock.

Reported-by: sashiko.dev (linux-e45413fa-48a6-43f1-90be-638841567534)
Fixes: 302a1f674c00 ("Bluetooth: MGMT: Fix possible UAFs")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7985332b6623..bce6d086cb9a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -10401,19 +10401,27 @@ bool mgmt_powering_down(struct hci_dev *hdev)
 {
 	struct mgmt_pending_cmd *cmd;
 	struct mgmt_mode *cp;
+	bool powering_down = false;
 
 	if (hci_dev_test_flag(hdev, HCI_POWERING_DOWN))
 		return true;
 
-	cmd = pending_find(MGMT_OP_SET_POWERED, hdev);
-	if (!cmd)
-		return false;
+	mutex_lock(&hdev->mgmt_pending_lock);
 
-	cp = cmd->param;
-	if (!cp->val)
-		return true;
+	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
+		if (hci_sock_get_channel(cmd->sk) != HCI_CHANNEL_CONTROL ||
+		    cmd->opcode != MGMT_OP_SET_POWERED)
+			continue;
 
-	return false;
+		/* cmd can only be freed after it is unlinked under the lock */
+		cp = cmd->param;
+		powering_down = !cp->val;
+		break;
+	}
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
+	return powering_down;
 }
 
 u8 hci_to_mgmt_reason(u8 err)
-- 
2.56.0

