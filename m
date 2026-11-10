Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334374;
	b=bGLe7jKdOsWOLhYKpUDuAyLGbpJi/EFgcCGSSbmgzYAxTQtiDtT7BdsN0iW5q0ug3EEl
	 U9+XNdSH+vseoZbBz3KuXLO+PPgzOWhb7hZKpV+Ya0mpQSijgATM9NBUOzGurtvgpNrHq
	 3D0tuRfoBFIy57HLK7qUi8R0ejDva891QTMN63pP+ntJMc5hEnVleq7p55Hw10LxILGZ8
	 wGEa5eq8O/Iq6pteASzZR21w/Wr7JpN5NMHQ1QH546Yx9NEezHKSIfSoFAEV/ru2RqWnZ
	 0mtO2XYkNYi6yZqcmkBlxBCNxEPzCZ4ZEFEP3XVJQb8I2w8c/CsiLZjv22Bm2m2Kc+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=68pKDA1p2LdEONMliWN80HdZe29k8kOJYDnRCJeXxak=;
	b=RZN+c6ao/EY11dykqN+JXN36tgLsJY9I9qov9EYWmaJBsmc5KiMJdxBiQYQMCSwMqKFC
	 x0ml9Znc9Lqj7cwb83GKhib0u2SP+QPmPIR6tn8HKcD5mTemxKbxb12CgfzY9EI7EF5PR
	 iHkXw97d4JU3xhvf/yMznGFE9EIP21ZMMiKS23FTjgzWNde2cRMb0Fge/6/PGZsczW311
	 StOCZ2fVPuM34HRiz7D6UDXx3sgkLs4R9YVh9VHcQI7qu8T3YKCz2nE77hgxkPktG2G2t
	 +9t4/n1P31tj7mGQi5Kw7bZJ0lXWReI8z7JSJq1hjlue9LnJbXwAERYGbjP8/XNMd4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tS5pn8Yi;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADF7606A323
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 18:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CADF7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tS5pn8Yi
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91eb5559b34so17728066d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 10:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794334373; x=1794939173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=68pKDA1p2LdEONMliWN80HdZe29k8kOJYDnRCJeXxak=;
        b=tS5pn8YiT64Zd9lexBBZTQYgUn0ddUenE2ATM8vMaZ1MPspNzyROAIXQHAXOUwIrac
         5FpzRX+iTDtkR0zhccjnG59AFXZKzj5UpgnP1iJEC7nuuC0xu4MQ+0Bd9LfClbfc7uzf
         IMovpPts3lyTygm2Ue1nDT7LhW2xyvsJBoT9t1XlD7OD9gf8XGs245NMk6TLlfaA5Cmu
         xwKxenpVK3Xr4KOyt6vXpwBuiKn6psxaZ0Y+AZf8RVc611D6x4COmbVGw6l62uSOxQp/
         i9Vg/iUhtOmE+rJlBiF/9c4q7ZO9RzeqsPBF0emRYoDIN83Wcx0wOJAbsg56/bI0AvQ0
         j5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794334373; x=1794939173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=68pKDA1p2LdEONMliWN80HdZe29k8kOJYDnRCJeXxak=;
        b=B3Nk26xngzlTPsMoiFHPCFl5yOydsPZQkvZo1mtMYvKcI92leIrYDTMCmkXWv40K+J
         hUzQS5vKmYTJtVgAZl2XflpsE4LFy8GwZeD6uaashn/tvsw6R68nOPY3CL1ZdbsqBC6D
         az8SysAwIen1luOTrYK593RTNsj4hp+fSxYG0/votZI8al3QzHrIdutHtMuS/xaL3HiN
         0GH+wzmMYQ4ZflNHJxDSBudEqsAAu/XHodkcU9artSY1TnnifFgnyqY1+tQn2sY/1FBC
         lg+6KHJB9YMLiKSVD10Z5WloibBhoKUerIocfKUUn9c4mlH5VuA3bPgUxh4t/O+4KcfG
         RKwg==
X-Forwarded-Encrypted: i=1; AL+hErHp/my3RXUv4wZ2AOsBhE3BMFJyncfZdD8H2wWHp45IDApqhLs7T9r5bg/q2W1MjwtEX/ffult2muEOAvTWzGc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9McmfiVAjUCoHV51ft4wcnOv6cVEvZ0ht0TE55NQvgrBVtKjiF
	5QxIOLMZKrFVG+9XH+KIEzahsPbCMuoqNWeG/a9E6HvdT9WvRvkSLUSd
X-Gm-Gg: AYBFou2fGQYTSapcd8s6VsgrS80Ra2TbrsVXgRaDJfEsNfKCL2j0rxUex8HoVZowhTK
	58+5EzvIOh/1EshQA7fnN70BHSBs8R+yCgMuquhVAovYHcm5lvGtlZ+jLa05gsHV0sgY/ZljSSh
	PtLv2mNxM1Zl/c61KQcdLiDnD9Wt0hHVK1vFBa5G9zEpETHvC9RHsu5kkXfuUZEebDQXReCYQ4h
	vxODndXJTG4Z5Y0Lk3Of9XqqzS1Yawb0v2r4qJOlwOXKgaC/eEfwAhBkJxCZR3QxkwqazT9bWYG
	9i0rRZXSMsFx/nnusNlMjP0hTz5/PkBNJIXqM0U46mS7j1ZWMhNyl/a7V/Vu5euU7EXv1HU57qj
	MZF17yEyQjT4cc22K3NWZieuUVw9sPhzx1vU3T4rPMpobXeWc1BOo2bZdzhpSeoAuoAjZxvKoq6
	2OH7w9Bo5G8Bws/6SO6hcrp9+G4UjOBasHOeHIO17+yFRyL+RuYSC79KiUD8ZKvrBglYsXG8Dio
	m1lL7h96oY9XXuIkyhIH45shRt9lSqt2gFuBmArBhu6ajvvdxDbZcEfp7+CEmsB9yps19okB5Zu
	AQBjoxfdOjoM5JKjq7FjizGDqbZcdGcINr0Gm8ku2QQE3k7is6w3Ja/JVUixo79wG6mNUwOxgQn
	qlfVoyMPV/qDBvB+qIwmik2xP0tEtDKfKQcHO4H5plF2tEB1rOsJj1fHJQ9HrCbcl0Qsg9/Lnbe
	/HR3yyjbX+dj3yVFA5vqMigF773nDq//ra+lXhoX+Dqtw/1x0Iq3ko1ruQJ85lKM/KbqE9IMzuL
	APzStGsd79/4XA2jV3dYcy0wAtsKdT8XTNEaLtz3B7OqQ==
X-Received: by 2002:a05:6214:238e:b0:91e:9db6:c324 with SMTP id 6a1803df08f44-91f041351bfmr1113006d6.40.1794334372476;
        Tue, 10 Nov 2026 10:12:52 -0800 (PST)
Received: from LRMS.tailf8556c.ts.net ([2600:4041:5024:4b00:940a:c6ea:f292:3644])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f017737a3sm4800156d6.8.2026.11.10.10.12.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 10:12:51 -0800 (PST)
From: Jesse Casco <jesse.casco@gmail.com>
To: Rahul Samana <rahul.samana@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Rocky Liao <quic_rjliao@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	quic_mohamull@quicinc.com,
	quic_hbandi@quicinc.com,
	quic_anubhavg@quicinc.com,
	Vivek Sahu <vivek.sahu@oss.qualcomm.com>,
	Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/6] Bluetooth: qca: add QCC2072 support
Date: Tue, 10 Nov 2026 13:12:50 -0500
Message-ID: <20261110181250.47751-1-jesse.casco@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-2-2d100f30e202@oss.qualcomm.com>
References: <20260727-rb3-industrial-bt-uart-v2-2-2d100f30e202@oss.qualcomm.com>
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

Tested patches 1-3 on an ASUS Zenbook A16 (UX3607OA, X2 Elite), 7.4-rc1
based. The controller (product 0x20, ROM 0x0101, board ID 0x17) now
loads ornbtfw11.tlv, ornnv11.bin and ornbcscal11.bin instead of falling
back to ROM firmware, and a phone pairs and plays A2DP audio.

With the mainline A16 DT (M.2 E connector, no Bluetooth node), patch 3
creates the BT node, but the card only powers on with Manivannan's
"Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq" [1]
applied too. Without it, hci_qca asks for a "bluetooth" pwrseq target
the connector doesn't provide, W_DISABLE2# stays asserted and reading
the version times out (-110).

One of five boots failed: the rampatch download timed out
("command 0xfc00 tx timeout", "Failed to send TLV segment (-110)") and
the "Retry BT power ON" never completed, leaving BT down until
userspace powered it on. ath12k was bringing up WLAN on the same chip
during the download in every boot, so I suspect contention there.

[1] https://lore.kernel.org/r/20261005-monza-wireless-v7-1-5a6de7662dcb@oss.qualcomm.com

Tested-by: Jesse Casco <jesse.casco@gmail.com> # ASUS Zenbook A16 (UX3607OA)
