Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795509227;
	b=jwmPgc/30L2LTOfORFoD8seGV9P6803bRoyFA3FiAf4nn7eES2Q1rWcBzZPnjibossSm
	 15zSaP/SFJIoSuwfDv8D03wljodWhzOtqxeAsbACka5dztJqHpuhIcvHBxecXbr+6XxfH
	 4/F+8XAXOjGbo2W24/dLQzKoYxhsDRHskE74itlh3Yz9MxemA8Zzr69w10GLcKHKXxZZz
	 SjFQYya169NZWV/eCielDhxn2Iu5vRvkRF3p0tkFdKU6juTZKRmigIqNrqw0qAtB9Ndyh
	 vAiBJaSpRY1uoSOLXAj/ss34YrXGUby/BSCuJH1g7fzF1Bk94zsZ/CBgkemYzxB1OoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=aIpgxvObSzedqAPTjQfd0RbW9WASKTJvaJTRpLLmmLU=;
	b=wlQa6u9UgFT4mAsk1AQnzLt7sI0tbT0KTMgwMC7PNRyvb2fSU8KIU3ao4M0BSmSbuFTv
	 yO3IX51xT5gK8PWCkpwuzIkAc3kqGEAiSNTN3m0oQDdzA5uoqUPtNVj0pWpR61P7lBb6O
	 lsU1D2NsxCsg2562U7WduVIyuNBOitPlABIK6B/7OXA51Gzb4n2B6zPA10rxRLHhMq7bs
	 lMcnGVQi/T+NL12YAkdcCiNxtS6L60sEFdXawRqJ87YW8Qz4kntgSLoYf5UQdcOLzPzXv
	 gwq13uUtmrPtzGogmJwlItNqu0mY1gRZw43wVvtvqhEFQ96+YpkgMFqg6oMYgybY+1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=D0H4qzEK;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452CE606A33D
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 08:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 452CE606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=D0H4qzEK
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so40412055e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 00:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795509224; x=1796114024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aIpgxvObSzedqAPTjQfd0RbW9WASKTJvaJTRpLLmmLU=;
        b=D0H4qzEK32mqSFP7X1+cuWeEII/c9lOQwDZeQpvGlWNALr15HcR2lfBI4DUskQIQzp
         RWqZsPhELGmVX3hzwvHnvzgTGkWX/zbbdhpHeyH0R/THXubkhpF6yhqQwoql5Du6aF5o
         ouXycl72tp2xJNWr55ubwFmlLkzlDa1m/8k50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795509224; x=1796114024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aIpgxvObSzedqAPTjQfd0RbW9WASKTJvaJTRpLLmmLU=;
        b=GTUa2lk6oau/G/OPXuwdxJb3wsP+BbIvWrObfzDvqlIKaW6d8pUSPHRbhzU3GfgFEr
         6YFCLEiW9bal7wzpnc8UiEZihiyJUb89Wk0a+Em/hhRTA5j2ysZks4ULUzgshmG/TkZu
         YLiTi9W974pQTu/xdLEPaAsxLf6+hWC/qkxV2laaM8Odvl3jdzxq2WCXOfetjkdysf/2
         AHCUCLmbKdflkQ5WX4HsA3ZCaDRJ0Bh8jkzpWLnrsD6AaTTS6sNBxuWtfE5xhBeEEdIt
         rVpznukw41qi4559p7xdIzxR3OcbvAI+lQKOvqep/YXyXGKAbaAAgaXPzZJQeLzfm7en
         aJbA==
X-Gm-Message-State: APuU4Z/kp4vMuv0V3FKz+fTDsnDtRMtwsGTfFCoD+UhHn5OzM9DUn+Gm
	WMJCgiORfUjPV69jIoC6PrjQkqqzIZfQ/gMLV9c+TGUYy8dNRNugdTHb+Ds/wA/Nxx9VefxnTdC
	NAQYw
X-Gm-Gg: AZFdTZfr5VwpkiKcfZOTAaYaJPvzI2Kza71R7/xdY4eWP5ot7F2l3rQCLfZ56dUvl5N
	ftCbcZb63UgJMMPIl1/zVl6W2pgpMWRB6MrFxnAx1EgAyzGiGqtClhffBolvUyma/cOMx+ibPb7
	OQ0bHM4p1cW47z31I2uNJk7XfqxfrkAoXq7MwzORahhnxGF0UpSpSvGaOjUni6pBBHDRjHX7r2y
	UWn2fMYHaLYVJx6jRAKP5lRWiuno2EtYXpMeaZXqYpRh7sVogpCXrJ680gSFipRFvH1v9X2EnUX
	bBNb+FRVjCETDw36wR5WyfvGEB7qQbfjDl35OWg5uu5x4ZqmVzpF0ubVlThpgIh89HL9MdOT1cu
	pZ4OdoTRLyD3rxZmjc66lVA7Gaj+ek4rQ+BKQxoz5+Iq+Sv896FVW/P/AR/tmdZzigoZbyQIoa1
	leqG2D8oYSfwoJbHdzsVYaKH6GMOtnil79af1C/fTOwCaFbML4GPcrAvwOcMnlIOIOBiiAP5N3R
	bjczJgDbyjDI2aip0Uz45liKwTgU9ShxMc/m3S0d9ywrzmN0JySIs3S6NAWuueQZGAP8pcLns6r
	j4sm/te1HKtvyEsq3irocTvTQtrqGDBI0OYZRupms2y1Yuln/A==
X-Received: by 2002:a05:600c:83ca:b0:4a1:9661:14b5 with SMTP id 5b1f17b1804b1-4bb888176eamr282429505e9.29.1795509224556;
        Tue, 24 Nov 2026 00:33:44 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884865a2sm422692765e9.3.2026.11.24.00.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 00:33:44 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] iso-tester: Accept ETIMEDOUT for Connection Failed to be Established
Date: Tue, 24 Nov 2026 09:33:22 +0100
Message-ID: <20261124083322.1032061-1-simon.mikuda@streamunlimited.com>
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

ISO Connect - Reject has the emulator reject the CIS with Connection
Failed to be Established (0x3e) and expects ENOSYS, which the kernel's
bt_to_errno() returns for any code it does not map.

The kernel patch "Bluetooth: lib: Map Connection Failed to be
Established to ETIMEDOUT" maps 0x3e to ETIMEDOUT like Connection
Timeout (0x08). Accept ETIMEDOUT as well as ENOSYS, since the tester
also runs on kernels without that patch.

Assisted-by: Claude:claude-opus-5-5
---
 tools/iso-tester.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index bfc905643..92a937ee5 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -678,6 +678,7 @@ struct iso_client_data {
 	};
 	struct bt_iso_qos qos_2;
 	int expect_err;
+	int expect_err_alt;
 	const struct iovec *send;
 	const struct iovec *recv;
 	bool server;
@@ -1417,6 +1418,7 @@ static const struct iso_client_data connect_invalid = {
 
 static const struct iso_client_data connect_reject = {
 	.qos = QOS_16_1_2,
+	.expect_err_alt = -ETIMEDOUT,
 	.expect_err = -ENOSYS
 };
 
@@ -4096,7 +4098,9 @@ static bool iso_connect(struct tester_io *io, uint32_t cond,
 		tester_print("Successfully connected");
 	}
 
-	if (err != isodata->expect_err) {
+	if (err != isodata->expect_err &&
+			(!isodata->expect_err_alt ||
+			err != isodata->expect_err_alt)) {
 		tester_warn("Expect error: %s (%d) != %s (%d)",
 				strerror(-isodata->expect_err),
 				-isodata->expect_err, strerror(-err), -err);

base-commit: 1608f836188610aabeff5a3164169ebe0360e443
-- 
2.43.0

