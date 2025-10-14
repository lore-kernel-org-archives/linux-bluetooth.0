Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC5530597E
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474063; cv=none; b=t1XbAOCdKtxJavikljBXiTEs0FttYp2fe4dX9uQdIY73etcZLbNyqeOtrdbj09IOR4/IZK92CZBFyE8jvrI/v8n6P7BFxjCFx+Lx5Swj1Z7FLT8XAbGaCmTzxAQAIkanwamusrQZPdaBIgA/CpPlO29/+Sb2hiHuIfmuCA9fFtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474063; c=relaxed/simple;
	bh=VC4BA79jkAws5rBhv0V6zsvwHDamBX4bafQoPdfriNQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jilKr9qYQ4vbacmzqDaRC1ElXZFBcyP46+Fo1RyKzjnIAtIThoKs3PUZISa9Z6/zbkiQHHH4VGjHicSkhVF5rMzsq+ynhxbjIQ23li1GPQvSXJXs79eoobF5SHad2zk/rEuMDvVRUB1go7OVe7aqhqQYfj12Km3Rjn67lvTMOL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4ZhPDlz; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4ZhPDlz"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-54a8514f300so2822137e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 13:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760474060; x=1761078860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b590lxRW34u9LRawro47mf8dybau8//Lku731cmgABQ=;
        b=M4ZhPDlz6tykQQQSBqbSdmgAx5Y02fSrw5pyALoLwN+jja75XNiq0Nlf3iV3VELZ6L
         532o6rIZhqzDXBnWYAr1n8QSD0xjvXLY2i5z/Joxj4A3nj4FDkTYGiNnrvx1gTB+J/Rs
         S5eQU5tTrVAMZ7MEn56IV5+r4lztUTlxy62/jPTOWAzPE5nC9xeMiHpI6Tuug1JxsVns
         gVybXXwgnlXA9LvGjLxXV2rvTwUsgfS8SjwUxdI3jMOZr9owyEOUbER0yIgiryXiOoMZ
         Ft419ls4BshCZkiVEjJmh2tYF/t2oywtEvnJtP250JNNmysWd4NmWcT7mrsbl6iAzAaj
         Li5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760474060; x=1761078860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b590lxRW34u9LRawro47mf8dybau8//Lku731cmgABQ=;
        b=oVs8An3NxuzOODW360KLAV/rpLGU/3bhi/SkSDkUJMrkHuex768Vd9diGJJIgTrCWu
         CBDaCK8/QxTbRDY+RrcyGcucViUcAR2yvroQxuXHNbqB/bLK39EuOzfBm6ceH4ylr7qK
         +pkoGlodEZD2WaEZMJ3WPqrZqzzA4v7WxqLj8pCwzX5s9VJm9GSAas56lOX0Z/2m2kuB
         +pj8znYKWbh7/722ibgHFsbFDvXByBg+ManEq+6n0sUO82aTn/H28WkwBm6vxmXsSEwZ
         /E/b5cLbVMabETxuugpmF1Cx3dACzWLM+WTikhYBVuLe2+WxlgX8kLyPDuAzJuCzesM4
         DKgg==
X-Gm-Message-State: AOJu0YxIZti6tSNwqA6vZrSgGbpTw7YEOrfiaKIT7S6CvrH4931n95Fy
	1W+mT/tu2JAXubisdpZAAUUkgYro8kyenDU/u1q1aeHHPD46/2L1sj0M1fHMyCsx
X-Gm-Gg: ASbGncukDAFA16FTAWDWxUl4+eIMOgmDDE9LHoevF5cFEp15imXMmzPBigiXm2gNXYk
	NqrZXCNx+J54AXKNl5eGLHBI/17f5ruFkvm3JZ+kHlAFv/+gktLzTAZ+nvvDYE7y+TrHaZpQjsC
	u16bs08vQm+4ZrqTAt0CkCbwEYSSnTU+9j3S0iOaDgGXdfCxSRecR+8iHEi5fJ2bzXU1kSunQfK
	crJIG0UAkOuFUPod4pEAahB64nP2mse45rKNVYACM0vHaaXYsFsoNuepvjSXOQAWfAtmjYM32bM
	cOm8htH1vLFpp0w7tQZ/7WRyqQVYZ2dp79yns/wFvdbw8/fpSidcpWeqZgrpa7fwqdkaI87kHVw
	HLxh+lh/T3cULWvdx2UiCZdkFl2Z3/pehl7JDdz0Zu+8G
X-Google-Smtp-Source: AGHT+IEn3vFj6mQkj6T1JWQ7n+X43SEnjHqwNVIijkZIGHnZVSRfj4lXKP8CwcYg2vqhztN4JR/FVA==
X-Received: by 2002:a05:6122:1823:b0:54a:9e47:7625 with SMTP id 71dfb90a1353d-554b8b89863mr9235427e0c.11.1760474060309;
        Tue, 14 Oct 2025 13:34:20 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80a456csm4434116e0c.14.2025.10.14.13.34.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 13:34:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/6] monitor: Add support for PAST MGMT settings and flags
Date: Tue, 14 Oct 2025 16:33:58 -0400
Message-ID: <20251014203400.453454-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014203400.453454-1-luiz.dentz@gmail.com>
References: <20251014203400.453454-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds parising support for PAST MGMT settings and device flags.
---
 monitor/packet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index f7db1cbb88c6..dd808deaa79f 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -14424,6 +14424,8 @@ static const struct bitfield_data mgmt_settings_table[] = {
 	{ 20, "ISO Broadcaster"		},
 	{ 21, "Sync Receiver"		},
 	{ 22, "LL Privacy"		},
+	{ 23, "PAST Sender"		},
+	{ 24, "PAST Receiver"		},
 	{}
 };
 
@@ -15852,6 +15854,7 @@ static const struct bitfield_data mgmt_added_device_flags_table[] = {
 	{ 0, "Remote Wakeup"		},
 	{ 1, "Device Privacy Mode"	},
 	{ 2, "Address Resolution"	},
+	{ 3, "PAST"			},
 	{ }
 };
 
-- 
2.51.0

