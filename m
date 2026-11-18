Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017561;
	b=NWvzpx2nt/+iA1zcMO53MbPK0S16It3Th2LIyiruJlMhAxYx/d0zAPMZE2BgTSSQoxp6
	 ZandPeb8h+E8cA5lW/Q0YcxuikfUr9ZxoRRNRCeMqzH8iXxMXMQrr7gs936O4pljLtKYi
	 hb8UolmNgoFV3iRahTr5hqw9l1iqCyUBgnws9rd9JH9ybVr3m8IHu10tAEmjEMaaAKflQ
	 smN/LrLUECLwIR/YqEj99B3uYXsvGdCR38TKs8w9tqDf+rNNw0S7Zjfu0YppvKV8dE2tb
	 NyokJj4mWpK9CBgEpxIhNjvEpGMH6USXkBdpJ+30qL6mJDz8wXeC8jENqP5DB7itSLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HrU8Bh5T1SPlOOXv7Kk39fzwLPRearCIicsjvDtC2VE=;
	b=vCR1D+zVUjVkhNkNqaArj9ujIpWWHsdD6ZFfz1ANhEPRPWtzsuEtlsYVyhypioDlckIs
	 cCkJXQDcd0BtzQ+g8tFrYaKMFP5gjOj2BCcFxJttqlOZVlMl30JjrYi3qcFzuvne92RiB
	 pAcPbVFi1c3zNCT8z2jC1GLBZ8gmeSsI1GFQbAwkRW/uXefFgxniyYcennQJkvArWmlmo
	 FWLURob5uf4Bsq2CEriwaCSw61GUeNSoHgn+ionmMNMPVNCBFlajUJT8FHGhM+9Osm8y7
	 3YTzO4IDlSCA3RnIdBIblDHTmWMxySNNS7MdcbKQRsoFkxaRAMDjjL9KSagkJFZHbUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OT1gnqX4;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04C6606A339
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 15:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D04C6606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OT1gnqX4
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eabf243d05so381135e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 07:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795017560; x=1795622360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HrU8Bh5T1SPlOOXv7Kk39fzwLPRearCIicsjvDtC2VE=;
        b=OT1gnqX4td393uJqmxpLykDDkpPOJNKPOzsakYAJZDEufbcF7gPrps/mTgEdm4ICcZ
         QX6UF2ZthCdPZHQccQIS8c455DezKslrwCy4WuSSt/8nHFf2dr9L+dxawk4h1szMXemL
         Sl7g5r8e8wVOzB92dFfA7UIC2ym6IECThQXm9PA6iSzxsijI/LZLt3wEJ1BiraVkQ1uh
         11QtAib9kuVx0uxdw/0CxkKWbqgGUZehXtUvp+GSpQ1pewpsfEmwtGa79sOMWlKBhnE1
         i6PqWvSmR85dKWrnTnAj4EgKzPWI8Cw9DGoSwzqE6Q3G/1N4Xz4CbofR+AJZfEcjUX9B
         1hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017560; x=1795622360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HrU8Bh5T1SPlOOXv7Kk39fzwLPRearCIicsjvDtC2VE=;
        b=bkUoqGa3d5x2F5+fgKjHfKkOydSc9xbVxfXVvZh3URhj2MuyLwlya0g3PyLvVq1lJO
         86jwFqLTjPHS7g2eLBylS+sCmxiS8XHhUT9p7sYE8n5PH0Yt9iFdLy3pI4WWYGF/D93q
         u/IwXgQLMuZqKVeAIZHKjK4TiF0M74rhji92OijsKKGcvZg69zMDunK8EjRuBugGm/+6
         +ff0UvzZgkh77Jmsr1JQDdrtiQCWe1woiuNJaYT5ZOGGEhlADn5wvhFjzcgB/6HwNI/t
         Ok+zjfy7sy9VAGBv8drh91yjjVlfukvFjbGWA5+T59g7e6NYkNyY2j3hUJXd0aEFrLfI
         vq4g==
X-Gm-Message-State: APuU4Z9oxT+ueqGBxco7G598JvoshWJkwXKjSeJgAk1vp1ptZMlrkRvC
	6YYgKBlTBEjIuCY/zFwdpzXWT8MAZrKcrkCzcWQQRjCWtqyRo0LgqVCh/h5KJ6SB
X-Gm-Gg: AYBFou2NRao/L0fYNanCARzz3ZrCFc81gf3PWQdJpZn/DNNegDlo0+NUwtxjositlDl
	s7VN1WLY3YWubJPip9VYyBEM0sC8hbzga/0UqjQV72TWtsOXO66BkHyGikhRGYrL3Rrz92z9j+W
	9/mRAMdhZq9ZdsPykkh9WUPR3SI9svdmOXfYUz897/XOT3TO0k+NnrQ5qVbgN7DKhqNkKjIUiSP
	0g1US9FYVG+IWwunHQ1b1rC87+xyAAmASryAe5dCiIPLazwqCU0RywnBMn6Q9h+HL7CoFSEotVO
	3msotPf6N/VJzcAFI/RNnIepTZpa4KblAipZ73TahC2MoVdhdORrL9AhnKy62IagTAxbF5EwoYa
	8RnaSSBpFMlu2b25InESLSjAH85+I/eE+33OQWdmqnuyH3rxeDXekIHdVDQqnL3q488a+3+alo1
	9hUtgWhD9oKLF/IwoLOZC3q2tPT9yeV5UjFObuonNx4+ryMl0TvfAk3jgqksQVgRgRsCMmlg3gm
	J/c+Pp+WNP72/cBrcztm2droMMowTmBDtG/5fPaXLJwmPEPdc45aYFNJlyZFfv/KmnzmJwmsMsC
	iW7sKkaCXWNKCVgG9gjPod5aefriDyvizjm411ugrjQlwzU6grzUe6jADt77uPxffPdwFTy3Q91
	N2mi4C+AdRNIF+4he8Sk22R4UGWiIesnCkAzIsZAFo3vxDptk/NoyK9U46KQlyxh42UU5FRI41E
	NNTSY=
X-Received: by 2002:a05:6122:1313:b0:5ea:c77f:2f22 with SMTP id 71dfb90a1353d-5ee64cb6b2bmr1174152e0c.22.1795017559836;
        Wed, 18 Nov 2026 07:59:19 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64e4dfe3sm1919266e0c.5.2026.11.18.07.59.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:59:19 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 04/17] Bluetooth: hci_sync: Hold hdev->lock in hci_schedule_adv_instance_sync()
Date: Wed, 18 Nov 2026 10:59:01 -0500
Message-ID: <20261118155914.178050-5-luiz.dentz@gmail.com>
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

The advertising instance returned by hci_find_adv_instance() was
dereferenced without hdev->lock and could be freed concurrently.

Reported-by: sashiko.dev (linux-616b1f8e-06ec-4634-a907-5eb4e82f66df)
Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9cbf2e3009ac..a1f272c14a1e 100644
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

