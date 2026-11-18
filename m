Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010734;
	b=0g7gcnlbM1JK7JcJSjvvH/li38YsHMXuDa8OUhZpP3wq71BRNwvKs0/JYfVhueU/PU5K
	 VVzzOMIzeLIOu5dX8Dxk6Z/S8g3u2Hoiv4Po+HBIiqfaBz6MEz27Jk8c+uPL6FT8b1Uee
	 37yiYSWcVzUC/vJy2n29bBQXTgNMpr6DBOYtVpcett8GR7NutSomdDzrhtmgyZUk4DbGn
	 jmBjyzVonQXOFgTbt38o+G5TnVlhntACys5qMQDPsB4xxw7IbCIhShWRNJD0d9IHZ78dA
	 LCkM7VdobQTyVQsVgy6vFN38KLk3jhlCEr0/eBx3GU8ASD60cK1XORt2+l+b/MFG3yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5Z8SPxdj5ODVAQEi7lg+Gv07rpjrRS53E/dvwi0KsyE=;
	b=OiX6Or5+NNk+FVcZ/I1BdOYSJctQRUHqB1mbSEpGBvcHWCoA+sUebcaYVEMNm1S1D6KC
	 urN6yea/T1R4PKb61CbGoMgGUP42W3p075LAF0pTlUoC5vjFFodwvaJQgCq6wvC4XQHte
	 8LPQnwrRe6Me3o3JRaRnnUSwOjOjjSqdGgrzMrXpRUac3bKb+QQp0PekkZc93TQRNmral
	 r3wtv7XZ3XiPWqtYRSnp+WngPS4IfUVj8oJqVAx8G4As/OcF6nGqzoe6insAeu79+saKV
	 PgnJInf//Ywkqe7onAkuhPveG3bAfGiRKrHEDVFW4axKdKvn6wzQ5doIy/QNAJPv08g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZrqyvuZw;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDCB60A260F
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBDCB60A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZrqyvuZw
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7d2da166818so548671137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795010733; x=1795615533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5Z8SPxdj5ODVAQEi7lg+Gv07rpjrRS53E/dvwi0KsyE=;
        b=ZrqyvuZwob06PsB5ua5XZMEz9lYMatCW+QH7ix2INFMhlVQVLF3kS9kQj7dDjvbS6s
         vqJmx5be4ZhX+z3WbunUk0hcHLGUr6ZGB1Q/vFZXntnbnPO6xctTMOAUyTV8jOqqolcg
         Z9CvsX3uG07iYAN0Op76cBVG5TmP7o/5YPdM77UlwxXf/R19xA5TRuBzl8LAEJJmVx2W
         yspv3YcOJHkRZNNXD3SdnCcPwLEymLsocfBIB7z0DScMMuYEbTNedNp9tSfTtN004vg6
         20MSY2BNgRJdn98vgoltIe49gp3CfC0oUbfYTRdyGT22fgRTgZMDjReU52SW5rfekpJA
         dPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010733; x=1795615533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5Z8SPxdj5ODVAQEi7lg+Gv07rpjrRS53E/dvwi0KsyE=;
        b=aUbOzjHCggaVdZqSzC7lR0tZlZwA+U3S0nFuOyWsJzK8wFzFlvbcxayPUhI6UNEkcH
         SI9AIw9WJub+22CXdPegvMWYC5fFaVU1xnjk5B4WKD0AdV8VKYsJz2cN7ID8C4OXd3RZ
         Jj9oljPL+d7GRUmAJn5522bbEOsAUY4jmF4Ewi3ctXFR4evOst/jBlzoCHIyb4iuCv+Y
         bXW3hLRoWlLTgNJcq9HGV2f+7YSR8zgpGNtyWkUbu2WeBMEen4HNTN0nc/CPM53MoOom
         wBb4YjYyCxWl2C+4lQDQhg1ORkjQvH69Eg24EiMct+OXVNaIgEjCDkp4buL+xC/BDsUN
         kJ9A==
X-Gm-Message-State: APuU4Z8j+LDWEX7DOw40xvza0HbETblGJBryxVf/VRh2T9mIDyMvoeW0
	oDq/BJgMLsf5fzQn70IIwVRIjDZZPRQt2hYd8Ns8ImvnPenCH/udYKEbm1luJV5N
X-Gm-Gg: AYBFou0WpueMjRnLGuJOqVa9gekT92V8xBph8hiNdGgpiBOCw/zEffnHdUdpqNcA3jY
	UYROGCnDnj7TzVY+9cbwSvf+yxwm4dyIce6MW6+2X1cFYMtivra7Xcz2izcjR8QYo0y15bFNM71
	kgAGf6yiDAoENJvm2fWXWaNb2+6pbLpfXgCS0XAfwI+mL2S/EzPrPcQOaEcUL89FCowyZfSryH6
	iQavnU8vxXqX91euOzfwyIgrWBBUayLhCknN2trJdmLU9ejo46GnhY1VXqgcTIUne3ll+OZkPom
	gN3OGv1u5YZrbIQ6NRPx3vZBCI7EplLD/Wo4VMC4N0Btd6+Fv1jPAW1ohr0GXlzFGhcw980eNTG
	yr2HAla26l69AtPDRDV9QTzhvmUB9VB6/UDdYIH50MaoQEKWq7SfU9x4u/6qWFQjnlWU5UtgkbJ
	zKwIuwHDVzeepiJh+Gli9GvCEKe07BUmlH+lf2Sd45MCQDDu5QfRwrSDbyyU0c/MqNowJJiS3TQ
	TxfG0Xb747DWfEuuqo/nMruvp9vzmG6BnFg/0D37lsVnskmknINQtRs+Fi2j1mpN1LYvMAZk1xW
	gp+Y4AChDPWRr+8n+yP8iHh51rRCyIVBFJTM8g1Kiyz979QC0uFxXSGsuRNB57N4H5isfp0Zpda
	xFHPDK8Jm2rP/ScrmcTyGd/ptJG1BtvTuoc8OpszqR9XUMlLzuOkKkVdULfjHpPvodixKLtFHe5
	qV1Sk=
X-Received: by 2002:a05:6102:4448:b0:7d2:7266:2c8a with SMTP id ada2fe7eead31-7d6ba4e3cdbmr772510137.32.1795010732630;
        Wed, 18 Nov 2026 06:05:32 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b914e10esm1697639137.3.2026.11.18.06.05.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:05:32 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 15/17] Bluetooth: hci_core: Hold hdev->lock when removing advertisement monitors
Date: Wed, 18 Nov 2026 09:05:16 -0500
Message-ID: <20261118140518.59878-16-luiz.dentz@gmail.com>
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

