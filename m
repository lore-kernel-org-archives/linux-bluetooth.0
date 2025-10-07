Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFC33A1D2
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759876347; cv=none; b=dVVT26j+yezgw8Cg7Bxpl+e4D+S26VrEbQsm6yfP+xjfjjxVo0hryDkeDTT2Yhr15GYn0LQWrY3uP/15+lTPdhRTCdmvQxLCSuNr/QsuqyjdP7XdIbVrNjUYVwDM+ZIismHltQKroDZrRNxBRp6DOcyjE9PMwEzqXszFRdC7I+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759876347; c=relaxed/simple;
	bh=JoH3pdOYhe1gtXdYZDtJ053/aEeR3gmPrqcpUGTjRk0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npqUJnM1U0Vl1vgE/xVirbZBhRodEk9p8rVilJ79v9/Fm5RpUti1wrtqCmE+Uk7jO2gIf51vh+43pg3OX8Ika5VHhZspL9Cr5jWhYPotzjnfTgzp+n/5gUeF/AdaXXwesMHbJg8amdLoRhoDlqPR+eC0pKJ9vwSIaQ/0+2iXOQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNHZ4rI3; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNHZ4rI3"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-8fb58f2b820so4173099241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 15:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759876345; x=1760481145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=juyZgXv8HadGLFnYHn3OcgB7dxjnZnCPpyBctYkAdNs=;
        b=hNHZ4rI3T53OL0B0b4EYqoB9LBHppcUcmna2PSX+7XY1s4xagYkAeNc73geXU6WZd3
         sbEX4qjGhP+qNS6C37eHNpSeUh7DQKWhf2ESRppjo1Cb4A7rl93eXnvdjEiZfnHGyqxx
         /oDrb4pJklng/+syz0Z4ya2LTOSqsxKVZWQ8vITN6tqNTlyeGdEsl3M2lO4M/axodaiL
         +y6CAnn1Ce+fFo19wmslFiRr/0ArGhfVHYgb6iloc9/DE3wmGQK06He6rt6rH5tjjEZK
         DxaII0AiMzzMAWu3Rtq6vdzEhVwr1+pBAkfpFTds4exS47StbKIqEi/8wLwR0bW65FU/
         RjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759876345; x=1760481145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juyZgXv8HadGLFnYHn3OcgB7dxjnZnCPpyBctYkAdNs=;
        b=fmP2WYQOrj7nKc3Dr+5T7jOH65VIAbVfLo7HcHg7X5N5geu8x1ulrKnbtBuf591BkN
         TFERm6icoBCyRM49CbPj0zCRAhzsxIdZTILZC1gTLn5Rai6HmlF8O+5ATXoaJfyVg/f6
         k4R/Wu+tDSYEKa/8NFQVAezE1c5EdhZNjU5vM3Q32qA8+nYwR/naS2+cuVp/acfuZ/v/
         DrwGpFjaLc4oMBT4RFrKHUgOHVz9YDFLXNJXTgX2GD0tb8BRWgsFCx1PAcKgbI31DkFk
         i8jdrLAvaOdgKyR2ByEsz5jRUvUheqxv1ShdyBFX5jd3BLLEPs4A5Rlo19ci13snGYSZ
         mjeg==
X-Gm-Message-State: AOJu0YwXIPKhz4Qe8Gk0nuaN3dXuUNir957pLf4prAV28xSQol+6MYs3
	x7Qja5vAOFAkSrN84XdomLFe7C31XmKGNaKbePxtrIgYqRkWssVSHFo/622sGS3X
X-Gm-Gg: ASbGnct6GZw/yhmhRVA/pmvr3CSPe4tWHAxwuwi9zb6XlPZth+bmNrHoP9JOzja2cqu
	J9nIZ8xbw+mgUG5Q/RdmNz6S1kuFpfftGbSkDGAR7KlzADnke/Kj1av18aV12s3FXyLvgPwUffi
	c1zqofB3c4PqXwqHFxFw+k2GC0dJca7qRLln6AAul8aq5CNEQJLEGwoePDHcfGTngqnykpXeNny
	eyK550I8X2qIW0QveMqoltPay2Aa2z3szNOEPloanBtRIQ5HNALzC4/9Ybq/PJywuU1hiqvo3nA
	tx7mFGDKwlPxaFIp9mRZeRGZQbo6cqYlw48QwRv/iwAB0/4mUkAn3mmkuTSYmleGSKk/HDSu26b
	vWDMAp/KnFhHfedC2RwPK4wP19OuKOvwpDsIwb5Gvjel1l05cAW904CYOAP2pblJyUgVsaJ+czV
	2svUJS+yXYUQxMTg==
X-Google-Smtp-Source: AGHT+IHwcHDIbQIkICqsvPHj0CErCzLZRUf543X/UEBBe/fy2ERKzdUwxV4WRvcXkhi7RoDl9OqGlA==
X-Received: by 2002:a05:6102:1626:b0:51f:66fc:53af with SMTP id ada2fe7eead31-5d5e23a4727mr574699137.34.1759876344654;
        Tue, 07 Oct 2025 15:32:24 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-92eb4da21c3sm3859567241.7.2025.10.07.15.32.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 15:32:23 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 7/8] Bluetooth: ISO: Fix not updating BIS sender source address
Date: Tue,  7 Oct 2025 18:31:54 -0400
Message-ID: <20251007223155.1539954-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007223155.1539954-1-luiz.dentz@gmail.com>
References: <20251007223155.1539954-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The source address for a BIS sender/Broadcast Source shall be updated
with the advertisement address since in case privacy is enabled it may
use an RPA rather than an identity address.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 3283139b3e7b..a8986c69bd19 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2027,6 +2027,25 @@ static void iso_conn_ready(struct iso_conn *conn)
 	BT_DBG("conn %p", conn);
 
 	if (sk) {
+		/* Attempt to update source address in case of BIS Sender if
+		 * the advertisement is using a random address.
+		 */
+		if (conn->hcon->type == BIS_LINK &&
+		    conn->hcon->role == HCI_ROLE_MASTER &&
+		    !bacmp(&conn->hcon->dst, BDADDR_ANY)) {
+			struct hci_conn *bis = conn->hcon;
+			struct adv_info *adv;
+
+			adv = hci_find_adv_instance(bis->hdev,
+						    bis->iso_qos.bcast.bis);
+			if (adv && bacmp(&adv->random_addr, BDADDR_ANY)) {
+				lock_sock(sk);
+				iso_pi(sk)->src_type = BDADDR_LE_RANDOM;
+				bacpy(&iso_pi(sk)->src, &adv->random_addr);
+				release_sock(sk);
+			}
+		}
+
 		iso_sock_ready(conn->sk);
 	} else {
 		hcon = conn->hcon;
-- 
2.51.0

