Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029096;
	b=spTtb80XuiuowQddAVtRnpt7AZU431nOjEiz1wq8VkCHu+OYvr7Ifd5680GJ07wHcd3u
	 htI55GKoW+IgbKj7xWaU2NEps4KPfRWEr3CFxfiGMyciIBQzTmx78gNS1GmGGyY148ws0
	 Caujx44W+a79dncU1xttefz21/Gw1nYjHyFm+KOOa5+5EreIT3bvYbe6qd+VCoOQjCCTj
	 dWwAIjx/xqCfnr5CA/jFA/7W+Ffgf5TfVTxvgRrr52wb/vo52t2v3n+ykwzmUn8X63XsT
	 GipUtzkvXqh0eHyN3WcqtVne0E2o6W6QLGFHm5X3/wbPq2b25XoJx/0Zh4+z4dcx1nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5Z8SPxdj5ODVAQEi7lg+Gv07rpjrRS53E/dvwi0KsyE=;
	b=tsgwi/s0E8zy9D5tEzXcS/mbG8/hznGTnZeaY4tNiaEjfWHdgHUurF84Rnjcmi/2tq9d
	 mLFbzCtHVA3iqVIZVdgPjA2J7qcvZ53JJUibzGRRAtFwHKnbf3rT9xpf2wDyYLpT30Ty1
	 utS2NLv3FP+wuVqQAiSaRlPJTgPi7COugaRk6h32HQmRILl1u6YjPOpwR7PrlIEWkGai2
	 vLMTF3EtEuRjZqRRqhNSXk0YK7bvz0bI8C/R3C1M8DZ02ju4795BN67NHYbppp++PKwwc
	 tak3vDRHOjNcDn2uNlLyYV0ks4gBqf3N13n8dIkSQ0r8I79uM6m3mouCXOs/9gYfsEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IZ4J+LuN;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7285C606A334
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7285C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IZ4J+LuN
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5ead9f60e26so129354e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029095; x=1795633895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5Z8SPxdj5ODVAQEi7lg+Gv07rpjrRS53E/dvwi0KsyE=;
        b=IZ4J+LuNRoCdDh1bq2eYQalMEzO6WAU5vWIAqGtEPPQ+OT7b3OAs37+7wsiYiWqTST
         V6ZmxQrYUrRlx+paY2hsIs/FZESnPLux6kwqlurA8Lx+NoYQtpM/LeuE2stXO/F1V4Cm
         ltp20/EKPvEmXyN9xBQesTUoxzvuR65psG63Z9CEnR8jcHrSPU+00fsEbeHqT9X5lzES
         JDcB6thKysc4WT7y+iQV41FbAec+303NwbJ01WW1dSa7SmdaJD8LkdFC4QQQZYWTGbzA
         EbuwZBpfCNVNXDVvg7JsHaa6Dse+sJ/amDjIqvifPdAJXX1uBg1e45fdDkRc8gCCmDcN
         0lKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029095; x=1795633895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5Z8SPxdj5ODVAQEi7lg+Gv07rpjrRS53E/dvwi0KsyE=;
        b=MxFc7xm4Vp/lDbS67zTYdTME+HnUTVqJCGeyJ6wDcsvGp2qOe3Iddp183aYxBNfycw
         VEnGl+lYFPkJuDliokp9v6t45HlxIqwG2hIY8QYifXCVLEXNvC3+ziMG1GsMrRYSob4G
         OHTDB3FxWdgnOxDdEtb+v4899UhAln6wTdtJGlo1NJO3MISzk7WsnCF4xqkfyFFRO9ei
         IQDYWcTwQFW7tHzi6PZPss9QDOgMBMSviibudb+VLNAxx61SITAFxzzsvu6qVmWldFJJ
         TVboVy7bxLxvqgIlnwj1JP89kZTFKIq4xXK5hN/cVcQ/4X9OyAelsROWfh4wdASm3TPX
         VVFg==
X-Gm-Message-State: APuU4Z91+5bYkYPo78R0lD7jKcEqNJ6RsyC+9+Dc/Ucq70HOnxn2l00D
	MCTPkgU4BHpPyQZbFO5ngxZao8KsJQFzkyRYDx+dNvpezh/RLSNT6FyIDMZERAUc
X-Gm-Gg: AYBFou3UKkRFbCo5Lh6lw+J/C1XOc8GdHPMvic6l/qcvVakgrtIYYiZcdx7P2+uPiAx
	VMe6GxVhBJjOxozfNzDl3OpAkEgzzjAL+hGVG5H0ud+ceDFUulZ05hn68wDqg689mVcj6thI6YU
	rteRK5MLpNmWMMPXYFR2KAuAJ5ZJ/LB3jXJCryupubB20ZA73MlyCgYAhRkKfzCiOrorZQpr0RI
	laGTxu+mz22yw0PHwNq0y1YguluB0wn4nfFG08I9VnpD/fIwMt+VJS/RZ1XRLF/fMeOCBF10Hed
	G2R7ppnupo1KBp+XRmsXG1qWbNHKy0CbRs670h6ZKVjFmFTjzIzjbWcEWjSvUZy2vOWrM5/KScQ
	myORYzUGs/cg8mOwrlrRjuDKMEmQ2MzPdz4zuCmjfDrkmSSjYpvQrbuqiIgopXbzcKxe/10NvVF
	ASTZttAW5BUvyr6VCFalzkZRIVF2a5PRcmjFbPhQXKFx0Xqrf87439/rthMgEde8vzi3qbeL8TG
	wp4JcayK34FyF2h0Nq0c+OrRwTtJ04GbFdR51+GKP3G1kue5xpEH/Hp5ZyThh3TX4CSaUJ92seW
	u0deaC0o5pUT283+iz6j1O966iD/qVlGISFkVwu8N9X4TXW7Rr4tULt4M3DBcHQb82kSuz7Nv1+
	mVtKCC6H7r9pJ2F09DTGcCbT8+tYE9pn1W3Z1oU5uNSH3lle+pcgc8vazF489eScqOnaQFZuGSO
	AfZtk=
X-Received: by 2002:ac5:cb57:0:b0:5d4:3376:f42b with SMTP id 71dfb90a1353d-5ee719af023mr151880e0c.4.1795029095402;
        Wed, 18 Nov 2026 11:11:35 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64c1801fsm2479672e0c.0.2026.11.18.11.11.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:11:35 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 15/17] Bluetooth: hci_core: Hold hdev->lock when removing advertisement monitors
Date: Wed, 18 Nov 2026 14:11:16 -0500
Message-ID: <20261118191118.318779-16-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118191118.318779-1-luiz.dentz@gmail.com>
References: <20261118191118.318779-1-luiz.dentz@gmail.com>
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

hci_remove_single_adv_monitor() and hci_remove_all_adv_monitor() only
require hci_req_sync_lock, yet they look up and free monitors, modifying
hdev->adv_monitors_idr and adv_monitors_cnt, which Read Advertisement
Monitor Features iterates under hdev->lock. Take hdev->lock around the
IDR accesses and the freeing, but not across the HCI commands sent to the
controller.

Reported-by: sashiko.dev (linux-8b358899-5ac9-4687-af16-58420a4d9bba)
Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a6bf806b9206..5522d4397682 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2129,7 +2129,10 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 	if (status == -ENOENT)
 		bt_dev_warn(hdev, "Removing monitor with no matching handle %d",
 			    monitor->handle);
+
+	hci_dev_lock(hdev);
 	hci_free_adv_monitor(hdev, monitor);
+	hci_dev_unlock(hdev);
 
 	return status;
 }
@@ -2137,7 +2140,11 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 /* This function requires the caller holds hci_req_sync_lock */
 int hci_remove_single_adv_monitor(struct hci_dev *hdev, u16 handle)
 {
-	struct adv_monitor *monitor = idr_find(&hdev->adv_monitors_idr, handle);
+	struct adv_monitor *monitor;
+
+	hci_dev_lock(hdev);
+	monitor = idr_find(&hdev->adv_monitors_idr, handle);
+	hci_dev_unlock(hdev);
 
 	if (!monitor)
 		return -EINVAL;
@@ -2153,7 +2160,10 @@ int hci_remove_all_adv_monitor(struct hci_dev *hdev)
 	int status = 0;
 
 	while (1) {
+		hci_dev_lock(hdev);
 		monitor = idr_get_next(&hdev->adv_monitors_idr, &idr_next_id);
+		hci_dev_unlock(hdev);
+
 		if (!monitor)
 			break;
 
-- 
2.56.0

