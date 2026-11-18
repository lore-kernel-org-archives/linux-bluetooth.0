Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010734;
	b=k0EYSqFU/Xvz9W4F4ZO+MFjOpcJ3LlNRF2q79suJDG+qCBP36jNQevLuWFsJpaMeYJnz
	 LOE8BCl3WaondMrDdqP96cLBLda57IkvuhJst5Be5TsDGzorbLRfh/W5/vzEsXE5tzgdI
	 y8/PuG1QmMqZTewE1Gls14w2ixZCNaDXemGxeEbMm2z3gooiaCvR0THEGr+0c3nszHNNb
	 YisjXVfdBZUBj/Wa1E/+F+EbMdE7SmJD1RPS1ntCvI+V3x+GOiaCuiHaob0+BBE+Sei9b
	 9PBSQaYVUqlfwJS8IWrshBAD5S7M6Z3eqWYIxHdUZvpeNm+qmB7+hhkz33siddQPXVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uhEC/UOj6TVVZOcxeoIaB5iLf8swhIFH3WtiXvlWqGc=;
	b=w+RqQOc4A2k7Q1lPnWVnmcmnpIq1AD9sYSSG5sLgNbY9gICFX0H4LSEOlczo4bmA6Q3X
	 ndjjiaSL5V/3d1CYUTUJDKi3Fk80iPTb8O5kv6oXIrG7fSmtpv4vt/po135U+mSrWcdP+
	 CkkHDAL3IWZhxBECR3mHWNt9oeJk6Mo291LsGjvpNxELLUWAxA1jIr7ptOvnpxitn6VVI
	 a2J3H3O22OB1E2kkawWpNZToyLKI+ce1v1NUEAxeZZNaFY/3drK70WMze0/jcZI0g+Soo
	 /LdRnjDaeMSfpPCcA+7TaHPqPDHb5/Cm9X+lyFAF1RiRRTI3ENvU3Q5Uor4L6drA3zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UhYERK+y;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6462860A261C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6462860A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UhYERK+y
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7cc91ddf447so382108137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795010733; x=1795615533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uhEC/UOj6TVVZOcxeoIaB5iLf8swhIFH3WtiXvlWqGc=;
        b=UhYERK+ysx3hIUm1pExbkMfpblqECJNQrFdkF91No89xivRpv54L6xuFFq/snYE7Q6
         KnKk4v0It8Nm0ruvKryF/3++UMgRlE9dwJgIlkKwYJE6U7+Fi4Vg5E0Hj7mu4dNvJmRm
         L8lVv1IFPpp/4DMJ0PLEUOgylhDhWrRzSX3gyOOeznseFYFAzyL+dYCFKZlHFxOFfbnE
         cAPmrCIjhMMLiuq1Y9Uds8kkXkfRc/vBT2rFzPYFVUWkHaR6V1X16bUr75LrfgvTMN/R
         /z2yElwHW+GmveAJuHohtvrx7hmfAtjT/R11wGiDZVdpKDXxjG9a8SsIwo0MepmYrfY+
         7EeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010733; x=1795615533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uhEC/UOj6TVVZOcxeoIaB5iLf8swhIFH3WtiXvlWqGc=;
        b=MkoeNGQUQh3atpSZ9BL0kue3JiOdFm7s+Mrf53mHXGXrjFCMoDKLTDgpZOTnY2vWzf
         QiL6V8yIAvH6BdfBJ0e9T5Yrk7pZ1EzzgvWAstdVS8dcGazo6AMdbLnGh9SY48X17W2d
         7nvnOcvDemXZRl9qp8kMdRdgBI4WHbxwFMkYi0UW78XcZlDZxFzeyuv/TS/dMOYP0LMy
         bx5Kmbh2lt6ksEjqcRvAb30oUu4KoyyKBWVSdkJK4t1hrS/vUjXCKVi74ywo89igCwiQ
         f8pWn73wl5Tc2mfYfPGbq/nBhuqHtbRV56U2qhz63/P56O0fK6+vjY7IIYV3WQjbpv6X
         ktmQ==
X-Gm-Message-State: APuU4Z803Cp70e48ajI+8U4HqBA5Sur2142oyflxtKVOosDEn8Go5CsL
	P2tx1B2hFAtW1cgWHjCdkNp0TYxhi/5jh4YBmy2gSfckJpsUc6PA6oQvn8Ls7V19
X-Gm-Gg: AYBFou0vDWEGXht+fTDgFTSywQsUVbs/EiFBEklaibet3qz/eJxuFlxl1c8ft4ke0YG
	B12q8c86r6M+Dpjg96OS86SlG6jC+StR2rGVvkVSLrpvhB+Dmbs7QlmmE+bPu3KIBF8Q+MXsl9V
	nqqz61fSHZYTg8YAGCv/qglANzbGKmWKZvdVUkaabrHRF5Cuss6QSbvMCzpqXdK+GW1TgIbamsT
	n36ETKQjPGDaVscj43aDzyF+YsEMVsJyxQ9dVd1IF1cP5kC+mka3aqT548tUYrLxnWOn44JKhKv
	r9rULve4wE1I+1dutC/XTJm3kf8ilkAcsTPxzakelREMRnUUHaQ/TtHtsDrkYPIzku+bcxL34+g
	b5MZlfTg+lc/JAQWItjzb2PVit5GQgM29m2s5hW+CUhlj+GtL+dONoeZQV7oKKW3ODJFU+iF5PV
	YHFX7AbjcezrYlu7r0y1XR+BYVjV6g9Jvf0YI59630nSfURo+SkzLSrLNZOQXkGH1gJnkAnvKgU
	rUp1SET3M4A22A7dh86cQYzIpAxJP55Ozoac3UM44e5cJllMtKyHtidMvUGKReLFZPAuEEV7gqJ
	+LZudrRRGOY/Rxf5rcxRhst1uDaFXOF3xU+qurDIOB9leKcNmH2JnZLp3p71VQlgv4oJ9uyQkxJ
	/kH+CuH8EiBcREjlPZ/PeTDLaD7pdDr06ehkG8YMb/kJi6r6U5BkY0POCLjdx+t9F/sd5gH1JlZ
	WCiPw=
X-Received: by 2002:a05:6102:370c:b0:7b5:7cd5:2a1b with SMTP id ada2fe7eead31-7d6ba3bbbe8mr693339137.10.1795010733294;
        Wed, 18 Nov 2026 06:05:33 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b914e10esm1697639137.3.2026.11.18.06.05.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:05:32 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 16/17] Bluetooth: MSFT: Free the response of the monitor commands
Date: Wed, 18 Nov 2026 09:05:17 -0500
Message-ID: <20261118140518.59878-17-luiz.dentz@gmail.com>
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

msft_add_monitor_sync() and msft_remove_monitor_sync() send the MSFT
command with __hci_cmd_sync() and pass the returned skb to the callbacks,
which only parse it, so it is never freed. Free it once the callback
returns.

While at it initialize the RSSI fields of the handle data when it is
created instead of after the command completed, so they are never exposed
uninitialized, and do the lookup of the handle map in
msft_remove_monitor_sync() with hdev->lock held.

Found by the sashiko.dev review of this series.
Fixes: b747a83690c8 ("Bluetooth: hci_sync: Refactor add Adv Monitor")
Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/msft.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index ab63fee3ef59..7a06c2b8974b 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -297,6 +297,10 @@ static int msft_le_monitor_advertisement_cb(struct hci_dev *hdev, u16 opcode,
 	handle_data->mgmt_handle = monitor->handle;
 	handle_data->msft_handle = rp->handle;
 	handle_data->cond_type   = MSFT_MONITOR_ADVERTISEMENT_TYPE_PATTERN;
+	handle_data->rssi_high	= monitor->rssi.high_threshold;
+	handle_data->rssi_low	= monitor->rssi.low_threshold;
+	handle_data->rssi_low_interval	  = (u8)monitor->rssi.low_threshold_timeout;
+	handle_data->rssi_sampling_period = monitor->rssi.sampling_period;
 	INIT_LIST_HEAD(&handle_data->list);
 	list_add(&handle_data->list, &msft->handle_map);
 
@@ -438,23 +442,30 @@ static int msft_remove_monitor_sync(struct hci_dev *hdev,
 	struct msft_cp_le_cancel_monitor_advertisement cp;
 	struct msft_monitor_advertisement_handle_data *handle_data;
 	struct sk_buff *skb;
+	int err;
 
+	hci_dev_lock(hdev);
 	handle_data = msft_find_handle_data(hdev, monitor->handle, true);
+	if (handle_data)
+		cp.handle = handle_data->msft_handle;
+	hci_dev_unlock(hdev);
 
 	/* If no matched handle, just remove without telling controller */
 	if (!handle_data)
 		return -ENOENT;
 
 	cp.sub_opcode = MSFT_OP_LE_CANCEL_MONITOR_ADVERTISEMENT;
-	cp.handle = handle_data->msft_handle;
 
 	skb = __hci_cmd_sync(hdev, hdev->msft_opcode, sizeof(cp), &cp,
 			     HCI_CMD_TIMEOUT);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	return msft_le_cancel_monitor_advertisement_cb(hdev, hdev->msft_opcode,
-						       monitor, skb);
+	err = msft_le_cancel_monitor_advertisement_cb(hdev, hdev->msft_opcode,
+						      monitor, skb);
+	kfree_skb(skb);
+
+	return err;
 }
 
 /* This function requires the caller holds hci_req_sync_lock */
@@ -519,7 +530,6 @@ static int msft_add_monitor_sync(struct hci_dev *hdev,
 {
 	struct msft_cp_le_monitor_advertisement *cp;
 	struct msft_le_monitor_advertisement_pattern_data *pattern_data;
-	struct msft_monitor_advertisement_handle_data *handle_data;
 	struct msft_le_monitor_advertisement_pattern *pattern;
 	struct adv_pattern *entry;
 	size_t total_size = sizeof(*cp) + sizeof(*pattern_data);
@@ -571,19 +581,7 @@ static int msft_add_monitor_sync(struct hci_dev *hdev,
 
 	err = msft_le_monitor_advertisement_cb(hdev, hdev->msft_opcode,
 					       monitor, skb);
-	if (err)
-		goto out_free;
-
-	handle_data = msft_find_handle_data(hdev, monitor->handle, true);
-	if (!handle_data) {
-		err = -ENODATA;
-		goto out_free;
-	}
-
-	handle_data->rssi_high	= cp->rssi_high;
-	handle_data->rssi_low	= cp->rssi_low;
-	handle_data->rssi_low_interval	  = cp->rssi_low_interval;
-	handle_data->rssi_sampling_period = cp->rssi_sampling_period;
+	kfree_skb(skb);
 
 out_free:
 	kfree(cp);
-- 
2.56.0

