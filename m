Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941873;
	b=yI513zlFkGS4ocjJfeTAotVb7zIRNC5L6wKUt93jS7hTYQpXlx+tC34Z9MENPT++Ytr/
	 NlkcLotSvAMusuSBbGwm2EbRhJkme0Gd8UE+GILnL8V8gCaoUU3wlBRtl3tO3PXsjhMFi
	 uTEHBx5Eb/CcNNwCLI0PfIZAXyNyLQV0sHaxULArrRQ5L6Ba/+bnZpotVsOw53XvE9gZg
	 K6Mr/zj1O0awbtM3TLo9q4+sC+iVW52Ggd+5NO2RBOf/0xcKPzLxmCR8IpoCY287idUSg
	 kiz3mo6+W0RIEX98gKorLc2sIY0WqOdqncFioZg0Oym4t/BSTXLDiiCkDmpoUHi+/CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r86lTUXjcf0eczAOZ8fuVGkGNJxzqDZKurdcNgffKmo=;
	b=lxANgPtQeCE1iXMl1YP7UoP5cBZ2658Win5Eu/rbalrjn8XIpM7nKISaOReuRIWbHPHZ
	 BVI6HSJ8mS6oK3Ky+8GA6kwFXUhancLYmRihFQffGEulvRjmyr0VYO13/WxP5AuJDpA2m
	 Ztfbk74qN3WAcR5OtxX/JMStE8ZHj92R3eZqkkvYbJg1F/XundAwYsD40q18ir51hmhVG
	 Ru2R53AjPJdvo570w+l7d/a5hYVhgnteO1OjwBtUMELODNOUVfrdrOIgwcZ2drkvVQm+5
	 kbMycD85BlimvaaTFPOnSA0xrL/hQZ9ZsRxK2FF3x+vh0gs+yQH/YaRfxvKFFcSbF9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e+UiQ1GA;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0057F606A88B
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0057F606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e+UiQ1GA
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9828fee1b4bso53327241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794941872; x=1795546672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r86lTUXjcf0eczAOZ8fuVGkGNJxzqDZKurdcNgffKmo=;
        b=e+UiQ1GA80S0KnO6KxEJkZY4DIY5brb3psVtstbU35zjw3+GCYpwg3nB9Sq9P8/RKb
         1v6ShbsVK3eZR6/FZIvYDZ0Z6RoubVQpcyZ1F3MC6Tt+3gIFfEPbeeXee389l/7bJQb8
         Ux0Pg2OslHnF+yp9svFXwV2zPAStubltSGfjZEGrp8nDkAv5xx3qIeM81A3Zjc8ExvxR
         81/TnXWwRN5w6V0TJO4coxsh30VSSNjGFL0H5QzoIg/Ger0tLes/5TlVIFn/PW8KdECa
         Ukve8pDYXCmgKt723mZtpOFBKlB/5SqNuIKLxCvvs3LfNYiKBn7fz1jBxy7Ncbl5lIb7
         NeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941872; x=1795546672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=r86lTUXjcf0eczAOZ8fuVGkGNJxzqDZKurdcNgffKmo=;
        b=C9FKExGmhFOF/G29/8zEZfPzO+wh7/xCf6IRmDnxefyTSVNEks/8aJWnn/45gtNqm+
         4LmV/umOcFGB/rAR49gQ6s2abqsQ4L9d2fDE/ey//QlBGSTV846vauhG+bDchQhUozRi
         plzcbCAToYUpAOTeCY2bwfD13rTkjoh8aZ6IultiKKmwUKKRmlFFIZIv7MyJebXlk8+5
         +Ki1+NVoS8eCEme0uP4oLKiY/uHOZcCL0skkrJuj43vJDevOcoUlOZL/JPMjt0u5VAYP
         SGacq8Jr82LHeG1julZKEdpn5GuHqdewkmNn6xycMIX4scxGo+GQzq/ciB1umSupYM8K
         l48g==
X-Gm-Message-State: APuU4Z/Mh7FUsy9y03RPKD0RldjZxAFodW1poFoR2CRPwDS6uoWqQnBb
	C8fcdMuXMGXGZDdeYguuudmy1NnbWSTrsZBLqLH0IWnEQ4OxxttTW1X+LxV6FA==
X-Gm-Gg: AYBFou3qGhrOx19gsbcSkZSCAk8qY2AzbnNHho/XnTy0MEANO2y7JvDdYSem9QPIn9X
	E5IVH7k4MYYnCi85XyGlRo35b9lUtcR2HyP9VAuV33/+PEHjAlYawTA04Q3fkckyu94j4vzVfjw
	Lr8aycBPBsZuKMAiN/IJhHSxVLmBhVHtlNIuxDQVs8KR1KeQKQpMoMYER1sO9goM/7o2Z5c/Jju
	hhiGQAQBFeiyoOFb3r+C5cijf7RMXYQvyifSROYNetFOPd6GJl2K0OcOua+FhQhB9nJn5Y+5R/D
	nG7vHBAsWX1QulnGSFbYAnLHPzSvEr7/r2pZNBlBFvswyzJeVTmFq7gFfHDTrROV6kIDZoiZOgx
	AZ27frh+MnzYNORoiR2ddKgh2V1DO/zM04xIasVkYbGwjSVsN8w3pntSQkOl7LrVriRtHEO8Zqx
	Ubq6fVdFXh57AysLvkJLqOj8YqougGswRnbKeILGgmObQ1GcZefp5AJeP1DrsjC5yeZXsWwiCiO
	yDp4EJo6V4bvaDW9cJz/HHj/cR3oL0D09QftbDyUs/W/lzCcUsnUS1zDs0MfwDjIRUDX7jrngbi
	ws8xF67M3giGpRa5yjNXWypql5scyLBRl5WYszRz59JTt0C6SJPvPTHuxH8ZPExDVUy5+ZpxrXX
	96xr7xO27jW8HFdkc+pJsjDuGI1BACX+FyfLtdhg+cPeiUIuWqOBdYroaykNnZt5iyl7XmMZMU1
	UD/OITyhZvYAF3msBbOn5XA4by
X-Received: by 2002:a05:6102:3e8e:b0:7cc:23e7:e74a with SMTP id ada2fe7eead31-7d64d7454e6mr4592375137.14.1794941871769;
        Tue, 17 Nov 2026 10:57:51 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a1b61eesm357064241.3.2026.11.17.10.57.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:57:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 15/16] Bluetooth: hci_core: Hold hdev->lock when removing advertisement monitors
Date: Tue, 17 Nov 2026 13:57:36 -0500
Message-ID: <20261117185737.3758255-16-luiz.dentz@gmail.com>
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
index d543526a3622..0aa7d3f2f49a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2107,7 +2107,10 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 	if (status == -ENOENT)
 		bt_dev_warn(hdev, "Removing monitor with no matching handle %d",
 			    monitor->handle);
+
+	hci_dev_lock(hdev);
 	hci_free_adv_monitor(hdev, monitor);
+	hci_dev_unlock(hdev);
 
 	return status;
 }
@@ -2115,7 +2118,11 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
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
@@ -2131,7 +2138,10 @@ int hci_remove_all_adv_monitor(struct hci_dev *hdev)
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

