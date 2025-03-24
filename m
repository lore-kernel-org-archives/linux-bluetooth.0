Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9E925D543
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824178; cv=none; b=qgg8NrY6UsPq25RAz9ZmwK8I7ha22dLiSzsKFv103Y5jC+smiynyIheojWAWkGqM6beFqyuLSA8BScuvuAQItSCt22qKx/vxypuxWFffFP7iBjEnSA0SenCBwgwm24B6MjgUtPBlJ6+aDlrN6f1p8VfXbTdetj21Olm5HWzlX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824178; c=relaxed/simple;
	bh=6M2KwkVehYTn4tKLU92RILSeR/qXao2q2Sq6wrnF2vI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3kXujl9oLheSOlKOWTp3n8uDahD/rqwukWGLzDIeh3LW94Yz8+o3SOiZJxr2TfphoMyK6l3j6rtNc4rPWO7GYzhmEUSaPfOyLv4kCp+6tGbNhd1UWdWTPV8NkJ6af4Dp+Q+ao9H4GCVNkCTzd4KLrDOQGJ5eogsynQsJVQvTUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIMIHr2h; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIMIHr2h"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-524038ba657so4352626e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 06:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742824175; x=1743428975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuYRLbUicIv2IY5VaipSHbaYdhol8Fsaq1RRboNi1jE=;
        b=kIMIHr2h9yWf3e68cmvyp3osEO0ElP1w/Xy0vpg+5hJYtxgRx2eDOKDRMz3mIixLjU
         lJC43+LsK+0GKwU6IgAf/t/kwPqQsPvj31UVDGKnkUVxHS66Nhwf1wuXuoVHtKamIdtN
         +QQHX3D40nCKuS6Nl9cJFjaEKxmL0FXbKw41CPD1tpyQR/Mh2MHDT37yv8owz7g1PfVA
         htLOSAzV995095+xzUqL65J26EkEoT+3DAPZ7HJAgNbaYVwEJAY0Da362ccASahVC7SX
         jRtUkoZcJ49diKyk6h1pkMbtyuqhs0wbHYMZwV3sIpPPCsVBtqp9uuvzhUzl3O0akc9l
         keAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742824175; x=1743428975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuYRLbUicIv2IY5VaipSHbaYdhol8Fsaq1RRboNi1jE=;
        b=H4zXZf/ZbUsi0/gUwwQk410kC0EVzyaha04AWxTA0Mzf4UQCygYNEyTf5eRm81y92e
         0S/fTZSYXQIcAvd0es8I6TeaJeW3UIcQhSAPvZHagCDm1ORYP8mpH1z1N+oEGQKk5npu
         0JrblwSfVwIAjDL3p7dTknFqv+2Sa1wXVMCYFCZuX1CQl/NXy07ik0TUU6mD+LXzoxHq
         /s54hrlseKbcXBdKbypEIG57eSOkBd5gwtNTpETwgTNEltE6lDT//iGMeM48jK/M8Z2U
         T+QumdMNUHcSBR9R4kuBbRPSQZdIfWrSXQclHj/+7ijOd/9BY35pfyK57iNDpzEtjen1
         REJA==
X-Gm-Message-State: AOJu0YxuK2uOw3YAJXwSwfc4/yslX46mX75ST+QF14NE9L8mgPlW0MCK
	CGiCigVKclPeVn0lh64G4KzZ51UWKIBh34G7RQkKaAZ95UXwSMMQrafBdyHB
X-Gm-Gg: ASbGncs1cb3nwISwCOM0iIuBk+t/tdjmvMa8DE37JaNLa08rPbwrNU4el0T24IvDLhI
	kIIpfyUHrEjLT5yNFF18TgmN+ZcxvR4FDHM6VOfZGUztD2NUji8MnxmV8crJphG09yG7b7dMsrB
	xU+HaVy9cfGUDcwe9uhPTUI8GreikMKC9nFbFndBXNwAKK+OoWIWwR/ApgUHAfMDMEasPVVOqEH
	QZFVI5VxdaSReCn8VuYavQpCcNJrdTj0OQPZWONd3Trjzi4khief29CDt2V11Xj2XuWtSX3rNfM
	AKbn5bgZE6iyaQp4xlpqzhMGDbloKRXzj1r/8xOR66zVakes5T4TuAwetsid29JwSqcrYnsgGI6
	yHrpSQqyNjiGksw==
X-Google-Smtp-Source: AGHT+IFTiwwa48O9GOWMTaxQ0EA2lbKgbUhLh6JMPYT9AQjn5LjwyDPb7SFMK5Khy9MQddmVMmYd2w==
X-Received: by 2002:a05:6122:f1b:b0:51e:ffd1:67f3 with SMTP id 71dfb90a1353d-525a7ff39femr8436910e0c.7.1742824175104;
        Mon, 24 Mar 2025 06:49:35 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-525a73ed878sm1398381e0c.26.2025.03.24.06.49.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:49:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 5/5] monitor: Add decoding of MGMT LL Privacy setting
Date: Mon, 24 Mar 2025 09:49:20 -0400
Message-ID: <20250324134920.2111414-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324134920.2111414-1-luiz.dentz@gmail.com>
References: <20250324134920.2111414-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds decoding support of MGM LL Privacy setting (bit 22).
---
 monitor/packet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index b186431cf135..15f741c61489 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12999,6 +12999,7 @@ static const struct bitfield_data mgmt_settings_table[] = {
 	{ 19, "CIS Peripheral"		},
 	{ 20, "ISO Broadcaster"		},
 	{ 21, "Sync Receiver"		},
+	{ 22, "LL Privacy"		},
 	{}
 };
 
-- 
2.48.1

