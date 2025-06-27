Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE926192B66
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751037520; cv=none; b=MrNQkLToBMveJkbfHde5IYHnBwlTW+ATLz9mWbJoCTuGIr0Pxv2Wz4lqauSmMyPtcqumHiZZ+5BpLXJB0PzjezlGp2KP1w7Qfwj+JZw6uRliP0MM7oeDFu7rHpKhcUEFL30Rx4NHWviy2FR2acsPGy3Mj76wcJ6Vc4MVOOfxs0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751037520; c=relaxed/simple;
	bh=6itN8qvQfiQe/xM/GCQK5nx1r9KcQeffXBIpZmB6YoA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ofNQCxnPcM8bSny+l3xCBAvmuX2cljIlWIkJ8dIvftVvdK8PpWYYO2d0cztrVdNNVMinFKwmfkQ1SnRBfg923qCPDrG6LI+OpttZOUu/+3KYOJM5Xqtkp5hTfvi8dsXTsdOWxGOu/mD3eoHMJxRgqoF9HHV3n54wzCnYAPsKz58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXoTpz+G; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXoTpz+G"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-531b4407cfbso651497e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751037516; x=1751642316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbHv8ExlcezM82sZjGUNGXOf4lOX984AV5MwGfhzjbk=;
        b=HXoTpz+GqpQrF4cMnasOWYVwdukSGaTVz/F4PQRJtXsaYnGpfWIEn2WxeX8jlRtFQ2
         b3Y4X5/wesM/jBitKtJPvt8wtLRYBsvPLtYcTGaRegv8iMI17t7MF1isFo1iOTDjhoeT
         /iv6cK+1BlyYrXQuaGaouoAthwXDV4RECS3BVoZLIlGxyo3YcUERZDuVveKhb9pwLxb7
         ia0XJbjMu/X74IK1IqqWnRWf/Y17yWCMVy6CzIBJuigIN4O/WLMpuCr/Zg74HhsjU/jK
         b7Fp/tNQEHqUaKzh6Zm4FNR/fN7ROYyCHLmpAvTpWhgwkIP3dDU9tRy457Py+fWofrEn
         el2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751037516; x=1751642316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbHv8ExlcezM82sZjGUNGXOf4lOX984AV5MwGfhzjbk=;
        b=ge44doQUIZUeaqWIfTpsgiJtGslI7tq3QvAcgnySMiGTR2d6KLP0GCONihyng33t54
         Dg4NmqGQQwg0PAtZFmF+jYb76xlABD7iGZ6qMo+KDt8tj9FumXd0RR9d6llTJviV54l0
         bwbooxam3WfZa37jeykoLgDBAKuKrlzpSmDP83ezz3sNfoevBOdgj4XOqzI7EImg2+Bc
         F7koqR3SglS53o2oe9IJm0v3EBE79LMjKtI4CCEiK3VfIo8/3i3gRuQLeXfFI8VYfXsS
         wfR460DAEFmYR9o/D01iRIJRKrmrvH6+2sQaAFQaFHp/KT511JQuOKJFBrDqIlQhHtrC
         vnuA==
X-Gm-Message-State: AOJu0Yy/5aSfMQLD7MN2hs7CoOeckOwCTfYDlcrcqrIdECARA4ReOldh
	LC3ML9WOwaDN3qOHqIFb4Yc9g1JZ7L+arnGOPKazI7GSnJ9SMJD/ur99+mmR8zkl
X-Gm-Gg: ASbGncuNU7I0w5Etjg0ys6NJSEIjU/nnLMf1zdyLgA8fDY+mVUHGp7tlDX33QFCCeqH
	wp4UG++WmtlDa2gJvMQjdIle+tgeqMXDhICQmp3CXDjkmSB1VbYCM8QGvpSz0Miy3B2HG990u8m
	AaXw2BTrIpxYWxvQG1pHYPOXOH81b5MqflxzgB3Vz+2SrFb4iNSNpFuF7P08oKB6wjAchEBFu4K
	PC3CWE4a4hebk3sllJPp6YUB+iwcHBtFXJmkvp082tfgmUNafasFeQfCvMLIINGkwQKEh8g6TcE
	j0RkRAdWaQx35fcFuBeg1awG4Q5VOnezDXBkO7Q1b7QTZYHkU5hZtfqhI3cBVmt14U0X45nnnKA
	jA9cS9ZOhrKnM5vkF7OvuYHiuT7gvGas=
X-Google-Smtp-Source: AGHT+IFBWJ/wbAIvpdF8hSlq9jucamQsLKKZ1dN30uYB3fpdFJ73Jf/uENyKSgARkAYGS/7AIvOXfQ==
X-Received: by 2002:a05:6122:2514:b0:52c:44a6:4801 with SMTP id 71dfb90a1353d-5330bb10275mr2966849e0c.0.1751037516311;
        Fri, 27 Jun 2025 08:18:36 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-533091c252csm407318e0c.27.2025.06.27.08.18.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:18:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/3] Bluetooth: ISO: Don't initiate CIS connections if there are no buffers
Date: Fri, 27 Jun 2025 11:18:29 -0400
Message-ID: <20250627151831.421443-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the controller has no buffers left return -ENOBUFF to indicate that
iso_cnt might be out of sync.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 3c2c98eecc62..370ea69e9f0c 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -458,6 +458,13 @@ static int iso_connect_cis(struct sock *sk)
 		goto unlock;
 	}
 
+	/* Check if there are available buffers for output/TX. */
+	if (iso_pi(sk)->qos.ucast.out.sdu && !hci_conn_num(hdev, CIS_LINK) &&
+	    (hdev->iso_pkts && !hdev->iso_cnt)) {
+		err = -ENOBUFS;
+		goto unlock;
+	}
+
 	/* Just bind if DEFER_SETUP has been set */
 	if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
 		hcon = hci_bind_cis(hdev, &iso_pi(sk)->dst,
-- 
2.49.0

