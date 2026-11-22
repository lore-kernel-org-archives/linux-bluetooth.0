Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378434;
	b=wQvQ/FqUhEv7dJu4DTEWJOr+sv9qe0XEQotf20IfHHK4Rqx6egZn67GIZVjrv8UbBV4J
	 GwZEVXODznbprG1DqRg0mGi1HSDxceF35bq9j079BUAMb5kAEtutc2TSE2UsmNrWcT3xl
	 ovttYS7Uu8nbD6VFe/AuIHhFq7H1Lcanxq7jkUJ0n6jmLJtcFc7+pAryLpfAj5F6VkOFH
	 yDcvK+0XXmsKgibeJl7/0ZUZF96AzxnZZoDtgl4AepU+o/ePd6G1g3Xw3K4GEtn+HWcb9
	 xIlSUaOhDfw8RwPlCfT9Q/BaBQCR4Z5J96RBRdX5J+XPUWB8EPXcrGnmGLN9OiDshaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Efr09ehXeGlnIbbvJtgzBNU6Lb426WICJY+8I0p2V3c=;
	b=R0hzOsshwL79dN5zh3Zv4VnmvcRgVwrdLCPJZhxzaGL+AmnQxuigDleXdIRUJ02H36ke
	 A0vVaySFkNgmpGnX7aR7cgKRVXu7s0LKj0nCbSDnUbr4GLw0uD7y5vTfKTohkI9b1jRRl
	 PBqwZ05o45WIs6oec4j5VfaCuguBqxfcUyer0Bp8ma4N+WfZjCcQjeiGLriX3I5TwYbIT
	 0pBuNVya1ISy1oG38RUdokrMqmWOa8L3Onn2cW/uZwUY/I0/x0Lj8Ge9ch6FNRG6juD9a
	 rwEvB/Zj9wMx/L8jEvtqj4Kj4is2Kb3ED7SMJN33J/DTd+AUhapsZ3jNHsV5StT1/CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=gardkd7v;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A2C606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 20:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78A2C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=gardkd7v
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so1420225f8f.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 12:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795378433; x=1795983233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Efr09ehXeGlnIbbvJtgzBNU6Lb426WICJY+8I0p2V3c=;
        b=gardkd7vIh218J6mopECCCHMCRtGmcC6ZKcuuUpv1gDCJsA6xp0VLUJXphMxfSckD0
         95zZn1TPzDJqUIJney4BbM5Sv8Lf/6DqGPIkZysiawbYXKw/Yr081H06XGG6ghbEGRWv
         uymdsdhIRdafkr1ZBtH70ZaplLbtmD6wvCOEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795378433; x=1795983233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Efr09ehXeGlnIbbvJtgzBNU6Lb426WICJY+8I0p2V3c=;
        b=jdZuBCLHSGO+DTdcPbr4se4iLDCPy73BaW4ZJL6Rrha8eA1l7ALbGtsV+LjdRn/qOO
         HAD9Z+vnl6VHjtGGpaeifK27325hI2ppybzKFdk8+C68O8QeLO48/CgbXM/p4cnEsNX1
         wByw0aBGj7EVJ993K0Jfg1ZL9dEULxZSRj09J9Cufnfxq1RFV1g2bCQ5I7azH8Mc7G8j
         0UA8AHWSi31l1ibU8SSYZFZo/a1FLtK7TEoQa4V66vNa6Far1UmYYccPfiUHzHCwxOHl
         UmzcbDZSwNoN9rZue3P+nDGNwo7tX+0Vi1l8fyoqzi6GosLDnB0IMvgxJ012qLxRJQZP
         Eang==
X-Gm-Message-State: APuU4Z9z+Wq8v5YbhRMpoEJ0gnJBGL5nNFoON4eB/nVlJqYEgvC9O7Jf
	/fqiA5ThZ+s2KfG1raSZzYTcBiHLA77kU/ivYhuZWJ7tEOJVrOPEUhh0N5DZXwosnKV6F1DuKQp
	G3cN5
X-Gm-Gg: AZFdTZdJCeDwUhUjcknSowoUPTQAQvEsanB46+j4qrfUjCYrho2DvBVZB1A+Iq9qoh5
	GFc5sG8+8UP3gUWuviAOwgNAMBpJxS2cjEMAhbbsxty9DQGuy3Wy6gaEeUSDtIBL1CTB4mKzoqs
	W9D/8MSCHM9ubQyGlzqrquq1Wiw8RjN22hScvsm69JswKcXAn//FixUdttZbbn2NvKWs7U8J0oe
	XqSkl+DIet58zF9IeEv6F+XWwGmlwVgNu/oSXA6Dn8xUs3wT8cmBMQT7FNC7qY0MrE9F+koNUKf
	qrVjUVdX6OiwE1JLNHlgrnHVp8vZQHLIpeAyT00NUzprTeZBfvU/18Im2UFHH7jLzlc0fGHOXrt
	+m/aZa5Q6+Be2Zup9MgFf24Ujns9E+60xIh5RWRK4Wgbz6KOskFqP8zpIM8NQSoVNCKp1xu2pBr
	3XbwRPG5514YXe1znprGH1vZfBAIlQiXQqm9NYQ2adrHSmAD6VwZlSYmWOc8+P5tlccEuvhmVmn
	RcXtLXhD3uTgLapxnELqgxDO0ur7qE4RI0NrvCsBIWWex56oKjWe02RRNhRWlVEuFBmJ6mmJPCW
	GmyMTVLcOPe7gE/b2Difq012jlvgO9mJ7Fnjm+GyW9jPuoXdEA==
X-Received: by 2002:a05:6000:27d4:b0:4a7:ed95:7c95 with SMTP id ffacd0b85a97d-4abb560e21fmr12882237f8f.51.1795378432841;
        Sun, 22 Nov 2026 12:13:52 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm18812737f8f.16.2026.11.22.12.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:13:52 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 1/3] Bluetooth: hci_conn: Fix BIG cleanup while BISes are still bound
Date: Sun, 22 Nov 2026 21:13:48 +0100
Message-ID: <20261122201351.2854661-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

If a BIS bound to a BIG closes before LE BIG Complete, bis_cleanup() sees
no other BIS in use and terminates the BIG. That removes the advertising
set the BIG is being created on, and a Broadcom/Infineon controller
crashes: it sends vendor events with a memory dump and answers no further
command.

    < LE Create Broadcast Isochronous Group
    > LE Broadcast Isochronous Group Complete  Status: Success
    < LE Set Periodic Advertising Enable  Disabled
    < LE Setup Isochronous Data Path
    < LE Set Extended Advertising Enable  Disabled
    < LE Remove Advertising Set
    < LE Terminate Broadcast Isochronous Group

hci_le_create_big_complete_evt() connects every BIS in BT_BOUND, so count
them as users of the BIG too. They were counted until the lookup of any
BIS of the BIG was replaced with lookups by state.

Fixes: d36349ea73d8 ("Bluetooth: hci_conn: Fix running bis_cleanup for hci_conn->type PA_LINK")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/hci_conn.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7f0250653189..8024fc4223e9 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -927,6 +927,13 @@ static void bis_cleanup(struct hci_conn *conn)
 		if (bis)
 			return;
 
+		bis = hci_conn_hash_lookup_big_state(hdev,
+						     conn->iso_qos.bcast.big,
+						     BT_BOUND,
+						     HCI_ROLE_MASTER);
+		if (bis)
+			return;
+
 		hci_le_terminate_big(hdev, conn);
 	} else {
 		hci_le_big_terminate(hdev, conn);

base-commit: cf357cfc025e7f72851479ed3fb60d5f16413c1b
-- 
2.43.0

