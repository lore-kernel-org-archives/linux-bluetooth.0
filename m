Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941864;
	b=AcGgfZN5aIUvUVI+67Ihb0qyzIgbTuMYKxkaX0Cas//Z+ZWYDOLAQSlvYf+fEY04hZFQ
	 c1fSPPB/HgqPyqLR+B0uEcWBHGo6pCuEmFohGOYlVDuhIioQQitYPT/8R8OhAZKkL3ZdR
	 u9u8wa/7K2rmlOeNRyOYt3xTPfZtf6gSZJtLuQtQRtCpCqtQYvHFNxX7sAuAtS2UGlwxf
	 B6VHa50wQW+NuN3rh1A1tazYaYciF2XEkLX3fhGxj/tJz1QWVtrHRrPt1Ubb2cGn3gy/s
	 MsW+Bg4sWnR0PVx1/oKpyfA7hdGcTTOcUrQkcf+EzYrE1OlHuSygaVk1eGuQxZ2QcPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=290k2gPJ5H6KMnI1ED4+iqhthY5Lbl7MAc4dFlH0Oa8=;
	b=Df4GeMF1v0t51cqmAW6jNwX39SKOJ+lj96Ps/MoTHLwD0G2alLbWpK2oUQjnurltkVi1
	 ke2On23UfOjnQfMOfFoITueJyiDi7Ke+MV8VOTjM8g7B7JTyxC8VDWOviIBO8Io3lqkgg
	 16wvrmw3rSo9xLAtq/U9OSQ0QtTYgBk3pwAzwNoYvReS/xG9tBqy0gBm6W1jvysRxH1C2
	 zQ8Rlk6sN9ezXT2mhcy02fWUSkyLKwfYIfL1qA2y0zgUpeavqbPvOA3/vBpOG1RwZ7U5k
	 8SKTu8Hl1uVLP6UxyY5BFllbsRUsoTzF8g3Dyzj3cNz8jEOtTZ9l03mkgYMLciNO/+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fznbCLaC;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30060606A88E
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30060606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fznbCLaC
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7d2bf046ceaso61371137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794941863; x=1795546663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=290k2gPJ5H6KMnI1ED4+iqhthY5Lbl7MAc4dFlH0Oa8=;
        b=fznbCLaCB+4P91n7r1wdwouQzGL5LBcPXtDBLcHktpt/oYyorE8el487DcjxOIkhUQ
         sAJHtSvKlrW+D4tBi3AYKZFvTgQ6PHV+JM7E2wRTyULNl7YgTb7wu9de4ij9Sl66ubQf
         6sd4ixq+u4Es4v7sUM6149RSLaOrZhquPZxs/fzx1TXKQFbrGv0OIb7w2ptfoBf7kMT8
         0V7o1GIEZvi6yfPJbQgtw69QfZ3qp375E1oI5zBIc163DEmsoRDc+c0lAXy8IGaMmVHv
         i/Hq7lFrC3+y4tPKXXL0O4rGUNj8aGjYg07A0uRNzJZ43gz48pVT5zM2nKgEVEiw0gDd
         NECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941863; x=1795546663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=290k2gPJ5H6KMnI1ED4+iqhthY5Lbl7MAc4dFlH0Oa8=;
        b=Dwhs+WOD+vN/S9hGIhhzFcrqozI1A8/d6DjDswE8xCNo59+VL5KwfzMHZrNjOCGz89
         4CVjRKzBkZrQupXE6G0h+74hgtQ+qiGo23TfYaDs2g8mHdOO7B8nt94wvg1N6T5ZUZY4
         8DKCFDi8ROnirH+qb9GELzbK0rBb9UnY7OXMbKTI79d13nTTwEjuEVGcF55Rbq2ZN3Ip
         xZGM9Z+XS2/uUIDhhiSpii/v4PgLZN8g1O1JSFh3wVoekRyKjfx1YP5f4yb8x8ljaIAL
         ctZ/aslNVmeIcTxL/LrtiE2iosQLoLe3fWbxjOTn+vsJqZTzkUR2TxFUWDgh2E0tPFDm
         +Lqg==
X-Gm-Message-State: APuU4Z93qMDwFCkuV4rftcl30wxwM2ekA4Tgwo3GzyKR7rC3s9nrw6+f
	DixqzKn5sUw5sQ6MCH6G4brCGVjTBz+RD6s//4D/NdgZ3kqo/qB3ppCoCWcVpw==
X-Gm-Gg: AYBFou1nh+LqpbLekR7vhEHWjRUv4sRzzrxEHT9jiWx6HSwOhp/UhpD51amafdKjiIW
	qFK4RABMuHPZysgfpwbIbe6ObKgw8OozIinKtrifyaQ6iYYXeO55xJecLbg9dsBGOZv7QiCjEmq
	NydVaE/taIrL3yLu2+hKAOzSQLqEug39bQHGRDYL7Dkq1IYCPziIopDWNFtJDGaC2r3mVhxfXf8
	AuiogSmOsCqOCBcbzwcYnJOVlnISgjSeWgwOtkBLhlaKjaPW4j66TB4eI5IhIuFbA4bmSniZ0Th
	NlW4cJkfAMq5LXlEAUP3mvr8OGcl5NMVcj0kbpHwyp1RSYqhJ36+s2EDMqo56plzPjhGdEc0ioI
	deeOstfCKd1sMFNEsgEbJU0iBCkDib5XowlAm4U+AUH9Uar8bmGj7OYtcWv2dqRZ19IK2DH4sTc
	CBkatzuCbxf2fB5s5l3liIKjB6Qpd9crYY8kP46dOBuOq7xFeEPLbQP165Him8c4NB4X3kOjiKB
	4CdEkEzZ8azqfKaIheLGxuwT2c/90/I9fgIuIQNN9hf/a5QXn/C059cry089C40f96Yix7sP4tM
	9yDabmh8gjfYccZ++gwnOOlrVTavBD8bckkl5ZT7UGRvJLmZ+ClU494stqedq3JViZh3o1xcafJ
	mpPy0CiQlO09Ty94J6AqKoUO/BbmsaYlZJhTNVEPLydN1pYZFLPNw+MPJ+vzpMck0F5EvgFIMXd
	2vkl0=
X-Received: by 2002:a05:6102:e07:b0:7d2:7827:c03 with SMTP id ada2fe7eead31-7d64d810218mr5592626137.25.1794941863137;
        Tue, 17 Nov 2026 10:57:43 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a1b61eesm357064241.3.2026.11.17.10.57.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:57:42 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 04/16] Bluetooth: hci_sync: Hold hdev->lock in hci_schedule_adv_instance_sync()
Date: Tue, 17 Nov 2026 13:57:25 -0500
Message-ID: <20261117185737.3758255-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117185737.3758255-1-luiz.dentz@gmail.com>
References: <20261117185737.3758255-1-luiz.dentz@gmail.com>
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

The advertising instance returned by hci_find_adv_instance() was
dereferenced without hdev->lock and could be freed concurrently.

Reported-by: sashiko.dev (linux-616b1f8e-06ec-4634-a907-5eb4e82f66df)
Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 0a51658f856d..162c83a1eb8d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2207,9 +2207,13 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 	if (hdev->adv_instance_timeout)
 		return -EBUSY;
 
+	hci_dev_lock(hdev);
+
 	adv = hci_find_adv_instance(hdev, instance);
-	if (!adv)
+	if (!adv) {
+		hci_dev_unlock(hdev);
 		return -ENOENT;
+	}
 
 	/* A zero timeout means unlimited advertising. As long as there is
 	 * only one instance, duration should be ignored. We still set a timeout
@@ -2239,6 +2243,8 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 					       secs_to_jiffies(timeout));
 	}
 
+	hci_dev_unlock(hdev);
+
 	/* If we're just re-scheduling the same instance again then do not
 	 * execute any HCI commands. This happens when a single instance is
 	 * being advertised.
-- 
2.56.0

