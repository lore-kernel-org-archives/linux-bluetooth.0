Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017570;
	b=eHj/3qPHi1Esg2hu8VJy5mW1lEl6XsecbbFVvFGMvZK8L22/MLY+TU+PO31GggEY+On5
	 d0I8jdXTJaidwn3m96Sd34v8nER3SlDuo9GVBLXqcSzFzRgcoujukngbNe+Mko/P2EfRj
	 Vt3gddFNLgvy1u1klfCLMAgC+gNMaFn8sUemxRMgIWNR7qw6P34v2kaSSRUwRweOXVF2p
	 j1dC0COsnAEquf8AKgTeN7ChOYwWRfm5boh0Z7DI2Ha3t0wtbLezv0MVai7tLjsMX40+Q
	 3e4949UWYh/5kkCDVm4zKzN+iciIolBDQp6ZWH8X5c3fittTnAtb+Bcq0seqPVhjD+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uhEC/UOj6TVVZOcxeoIaB5iLf8swhIFH3WtiXvlWqGc=;
	b=zrklCqHFMgBGV627Dmriyj2OOvVTSpOSbD2ofBMTYz0gctVfB8oyOHNtcHgcRR7OY/SK
	 Nazm2lX8u49yQw/9SurUl13Wgwg9hSO/NCTK28kyem07Gw1+tkw9WhmrSOQrHKmK980kd
	 thYZggxmEvOLLLqs5s9Ce3myK4tp187YdhTxflMO9S9mTtmndd32amibUcusOdRTdP2aU
	 YyqlkG92EK1tH1T+4CyB7E8j1dv9wu0/13KiaBAmj55jf/MHk5NLq84fKZAfT5QCkmCvO
	 X+M4joh+BgUoGWGcleRdPSb8cdCTUd8S9GlmyMopdZ1zYghBZcDZR17FgeSkmIHuGDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FPgArRNy;
	arc=none smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B4C606A338
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 15:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59B4C606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FPgArRNy
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9905d61449cso323132241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 07:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795017569; x=1795622369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uhEC/UOj6TVVZOcxeoIaB5iLf8swhIFH3WtiXvlWqGc=;
        b=FPgArRNy+Yp74swZrrX9Wle7ids7KRIrW8UDd10uvv76YZLDzmQ8GT9gZjDHzQVxY/
         WtFJ4dxMoTmcMiA2dauaaHn4eVdbbK6wTXys9qAamSieVXY5UY5QmhhlCTLRywpX1OCu
         tzwYq8qrjpTl9jlutptHm/6VtKC2tXlKvSaDt1zx1HBza1S26JEVYjBwDHbbFU1iN17D
         205/ZGmAQLX6Lc9M2e4G6cYxgbXmjULV1IA2B+1KAoV4gtvpECh8YV1eva4X9PPIzEOM
         P2A9S2Oxj6+E7CtqxjY/HZVwl3cAz5+I52cp0GL/a0EfNrxXOEEHGyxQvOzuP3dXG0Zs
         1EyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017569; x=1795622369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uhEC/UOj6TVVZOcxeoIaB5iLf8swhIFH3WtiXvlWqGc=;
        b=nqokdTzNnb7xyP7NoDWJiR/UYikqHDlvVSaBVGRwF6wUulO5R8MFxXxvPQiXKDbZEQ
         GjY92BB59cfWKrPHtkDgUTyg+jWew1GzN0Tzjw/ILXG7tR4lwVLHBpVsXztFsFKH4gsv
         QKnht9hoqVWW6RKGmJGEiRsuH7iFjYdssTc3civCYCOWRKKS1h5Oiobc2lXPwbuHpViR
         jX4T2TbfVOOUPH52UaFfav7W7h15qVv6uhq/RXtXjytexa2LqWnM9OYgZaAypQqb8SzC
         WXqPdCRVh9r7yjTMwMr4SiCYk5QDyyJ9IyY/JSxtP4UJae11p0GTOeIVQbWYM41y602b
         GZyQ==
X-Gm-Message-State: APuU4Z+arAP5bwsPncs3VbldQ06eRkCCbKTSBlBsXyBhxQUE+t8FopYX
	Ox5nu8bm5ImMsCOemXy1YOzuLlW4R0JRDddRWt+14Z5CXnvQ2kgujQ8Xw4laN0Pt
X-Gm-Gg: AYBFou1NvjLPRKgZ+APaicK9mDd34Xmm9FNoH9VBQCbQsXc7eOh8r10lSDGeMIc0/Bg
	QVyhOekRvPVxaGrX4h/5x6Q8eC6Ama6nwR8hg3gthY6TnYljsHyqCR8MjUldA1F8XA3WeihXb6N
	5JkUkKAA5utHFm5DkYz62ovJ/U6efUTwtPjusgmQoG3uZdg/MYEQ293goN/w+Y7d2DUQV4m6kIW
	XCNApoRWXoif74iF1aG+DB+SO0Z++1keBc/EzODvRcilzOXQzqTdYT3qh2pD5vcp/uNJyi6YM4B
	07wAUpxMNFnJFtUf/ECXRyyEu0mSBh7F77Twnk3+Zz8ely4+E6OXJsPodTJ2h2splzvxvnxiJP5
	W4tJXUOmqHePSMDgnpwLcKETza8l5sdyUfz8tL7lHBm1ditzbUV3CzszWkhZlPnEE1fhX5/NAfl
	fNC5EFPMNKVT2dslPIyXte1evejJJPEmsHEKS3+OMwjoDLGYjYki5r4ZtfqrEQnlXGTExEu1/ms
	rvfDu5TdS2asnJN87vw1aHSZbs1lMbeNQbGRQwbkh0T1feGFDv7fnLRNO490gcN1oeozeLiwoej
	tPs78EZ1zvPU1jD5QVJqZfPgw4aeHd94c4G787uVtYqLM8m9HSAO2c1TBmzGBvoQ4jXzJKj4fE3
	vJ7WdMty4cx5Ymotc8D1XQg261F6ApybWgLIC+Q4Rjno1zqURw4l/pFxhExQ2WshnlK0BQ9oNqM
	+MsnsI
X-Received: by 2002:a67:e112:0:b0:7d2:cdd6:6be with SMTP id ada2fe7eead31-7d6ba40ed05mr723740137.21.1795017569312;
        Wed, 18 Nov 2026 07:59:29 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64e4dfe3sm1919266e0c.5.2026.11.18.07.59.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:59:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 16/17] Bluetooth: MSFT: Free the response of the monitor commands
Date: Wed, 18 Nov 2026 10:59:13 -0500
Message-ID: <20261118155914.178050-17-luiz.dentz@gmail.com>
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

