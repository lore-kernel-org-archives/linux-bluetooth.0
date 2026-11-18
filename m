Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029098;
	b=1+3f93fQPKXYhR0BHXxgk0pQXlAHyWr66jMRMSbuETaE67gm4kFfd707zHgJwUqzmGWd
	 8r1T8/PwlPkD6K7xAZPIIZw09OW1NCHI8iyufEW9cZPTUrDI80oWWqQAOOwX5k5DVexhV
	 H+3zBxEL4JEtcunCyBEwVmAKVxAJpJo951zskLC1NxG0v36/ZpZ4exErk3nds1zHKdpEe
	 hfujx+Av1cEKk+ODynUmXxg0RgYYSU/4RtGQpj29XGFEltrRbcrbhHaD5i/6oNsiYKS0i
	 xXja62ciVEDwff+5/vA4rWdtuWstel0F1BTneh3NVJwTvgiF3+pmnxOOHOI4ogjYO3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uhEC/UOj6TVVZOcxeoIaB5iLf8swhIFH3WtiXvlWqGc=;
	b=vpkfNAbeqNbGAiffDfSpsDzIqq2FSLMbqJx/OOhSocSmZ4IlNOHlKb8DLB7aG/Nd8tfz
	 XOEkr7N0YRG/QWjAGJwwC5iXZjgJaaNEGqBFTmjYSdbgRZAADfoWiey9wnjkTKN+M8ITy
	 vbJDvHsPM6yf8XNrrzuk7JkSTu0bpmnrSNMgdE4c/faHPM3UBJS6MVOPBWyd++ZG+OOpz
	 C69S2kkVZZ3lwxTZC3Ru0tJyApG8JYny1GPJe8rD0T0etpySVGI7XOXcB3LdFLZfd/uEB
	 3LDXQdxLHXn9PVxiEJvehkq7SlLZ4F91S0Cqe5mLfJsnmayvmu5h2/FufGe2BzSBhzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YS7ixoIc;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EC8606A32F
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99EC8606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YS7ixoIc
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ebf39def3aso501661e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029096; x=1795633896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uhEC/UOj6TVVZOcxeoIaB5iLf8swhIFH3WtiXvlWqGc=;
        b=YS7ixoIcNI02neDdK597MZHdLsbwdasw/iinwY5QwD/+JrDSxd2dqLvz5XBzenDHz8
         Qcv8IYkWXddRqLUlL022PYMfwQOzY7FKT5M840+p1++lL+XvUh2GHfaMJZjbYetUvwk+
         ZtxnwEg6tbnm12dZ4PXf4Kh/tzpdcgyzIlH+nvj0gdOaaWnI5u30Z+Zi0lVdNPkU8rVo
         7sOTa61F6Dn2NYqfWwFAstH7iI6R3iPn/5RPSevAG1RtQBKJNqmrMDHDUMhmr0WHy6IR
         /Ffe6E5fcULunzwfMBjzPY5qGcu4iDgFomsgGtWYjb642pgB5hri+4GJ5el/XUCLkU6V
         AOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029096; x=1795633896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uhEC/UOj6TVVZOcxeoIaB5iLf8swhIFH3WtiXvlWqGc=;
        b=WS5l5Q3O2cy2croLXeB3yNCDXkd5L4I/KrxJKjcgUeJpz3iuDAnDZoiJgA0UizWxzA
         h0ZThMfOcd9r5fUtWCadvjhisLBQElZeEi+XusiKZQJJQ0BDQ0SHYRHsQ9S4A8ek8i6e
         AvpELDauT01ViItbvX9xLuadziaHI1ugz2dDicULKA4xF05ZubqXXAOJ5IHEJnB7NOGT
         RJAXCtccZi/MZBIMvVQs1XKEacnkrPCZbwpK/D0EvpjuS5QXmIxLZhCNHwgc6btZ0A2+
         U0aJJ9GWDpJieT04GbJ5Xc0/VqJ/7g+E+lqwO63MnyuWr4BVf81FGX5UXXo8Yt9rcjul
         wCAA==
X-Gm-Message-State: APuU4Z9xHG8e1IUXNaI3LdjwXy6kngofpUU1nn40uB6llF2ilOMxO1ES
	VmB874nveinrEh2EgKRrZPX28NUCQQSllsZYs/HGFPw7/NcThxkfvn6ZNl7Bpt33
X-Gm-Gg: AYBFou2q94WH4AbAME0C1oeOq1W1vKY2a5OSmozTpwJXoNgFuGyoUrV+cZ1b60bn8VI
	2YuQyffJxFiSjE7XtHkGt/yv8KeE3+ay7dP34pl8EsknRQAs0EQYz07ifforsxF16/9LzixJ7z+
	2swwGZFCjqLDm9ugKMMN+MQb3FIMAPtRkBxFfLQCGRpUKZtauwBF7ZsO0+bdL58/bbY1KELqmfp
	UV6U+dpm0RK2iGU3TOib2Sg0jkZsYV4vtiH+MTDTSJw98G/UELEC2zb1iNL3IJUlpSkKoAc4Gou
	dBidTZiurhA3T5jCcRFd06n7HAeARxedeazjkNtU6m4mtomV8pa332DZ1zKlnwBbjboA1wBC4eS
	/3oIFrkpNyZumEKWsYQR/KjaDWoMacJFp42dtEgJjLEcNR5upvZQrjfesVPZvLhAi0zRfQT7mQv
	/nzMlZ+/HjtTmCw78jnNchZH9Rxeme30AlhcsYD/cKLoHeI6KfwowqioCrZaxd1xISGkG/9ELHy
	oqN7apCCj0RF9clpjqSnedcIG+Iks1s4R7oqS9MEHKshrELHP9PFVVpeyHk4vy38Dj55qiAS0UC
	Ri6d/3xPJspyC8dbrGiVKxZO+6g6wIEm5R0ZPC87F3vVYgeY0Ej+w7iR706urU7kgsIpt4nXBsW
	vKBK6nPLSRianXd/rnWgzl12UNpuabj2FdG+GvDNdCVcR49t7Nql99lGXfzKkD4txXjte9HC/FY
	WAtjE=
X-Received: by 2002:a05:6122:4f93:b0:5c9:66f7:2f23 with SMTP id 71dfb90a1353d-5ee645fdbeemr1827546e0c.2.1795029096530;
        Wed, 18 Nov 2026 11:11:36 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64c1801fsm2479672e0c.0.2026.11.18.11.11.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:11:36 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 16/17] Bluetooth: MSFT: Free the response of the monitor commands
Date: Wed, 18 Nov 2026 14:11:17 -0500
Message-ID: <20261118191118.318779-17-luiz.dentz@gmail.com>
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

