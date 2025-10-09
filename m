Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E50284B36
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760045393; cv=none; b=arax+EYkmHgJEzeeNMFTxZbyrLoQi7m7ZuB+F1Wjg9J5AejrCC07E6k2udc8a43LwaHJGpzy8IOF7ey1x4iNsuHAgL53Tow5/au7n8lkF/xoQ0b45l5oxNuMyvi02hEZHKIo6t97LvgeyfHV6IkXgMIMzOR38T73zwJ/dUbgBXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760045393; c=relaxed/simple;
	bh=VC4BA79jkAws5rBhv0V6zsvwHDamBX4bafQoPdfriNQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auCNhIItfzZZDQhK88fiJ4CtdMWw6eBIdzCBmrlpH5jAJRPndBZCwzcG2yfw2coFsa2UNC1U03f1LRm12pU2kg02l8TbPxGDnnF1yDJk27syhu3VdwbY4CG/NrJxfYXbIbRdL4FWa5jKHKWS3EHWxJemd3wnA2rsbt8AyhO9ybM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9DmUmrs; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9DmUmrs"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-54bbb587d6dso843571e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 14:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760045390; x=1760650190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b590lxRW34u9LRawro47mf8dybau8//Lku731cmgABQ=;
        b=a9DmUmrsAJ9MvTLeSdAb7ru1B4SiJxdQ9DKk2ACHpmawtEAJN1Peo9RUd4fP6G6/Cb
         OT4q4vLyxvt6DCiFR/LkVsbTkgBpTJpwq5bMcnRx1IVG7LLw82QOgOS1IqNRlW/xAuRd
         DMJEQSZHtBQSN1MYipz3J3e6L5SJwv/GlHcLm8Zlq1hA7F/L4bQ/DhCGfqnoP39n3mIx
         K4fk5CVFI44bpIOXWczjoen39ZWwQfG7/S+VEhjV0DGdACT9hXs2YsxU1L4d4OqOEkHP
         VAddXJc4XCzUm5HQX01NXvtKnSpgt2MPD37hJNBH8Q3ajYnNYx4khPZMpP9M0EZj1Dl6
         qbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760045390; x=1760650190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b590lxRW34u9LRawro47mf8dybau8//Lku731cmgABQ=;
        b=HNFXXC7ninxdX0eO+O0sWDIQEhceHsrVsytgaAPXnFrKVJbb/9G+TUy1RkhhC16vDl
         dBeE1u+Gj9u2SyilEPhiiWM/HoNzbc+WX2/j97KfnqEnVBSR4nUXliymdxYq32Yix3J5
         gcgMvdzBqRZOcbrbTaB5yDqh0bcQwi1oK2I6E68fCEi8V4uTlT2iGI5wV1DFIz9FoOhi
         sVvX7B+suqI1a9yjijhzLcTAsQRWd6a+Pfz29uIyi8lenyu3UFOgmweW1bL00IkjuMjU
         mgcVlouturISDcrOC5OTk2iyXO/4hnekQv5bwtmogF44BMqaDi3lGYERKm+oy5xsFlPp
         IAxg==
X-Gm-Message-State: AOJu0YxwolPwbXIjgTh2T0ET8p7BUIPFY3HMfF/EnMcKQnzwNVvAFvkZ
	yznqx4ipgk2XZrS8BL1uDVWBr46/WzTaJQ8YorUgGpUOivokXj8NqPYW3mWqbtIQ
X-Gm-Gg: ASbGncvot8uFOkeMssuONr8rdUrsvUZsDA1oz/7eW2e7wuDvnbL9VY7oWmSNi1GJ2hD
	C7sGM1nhJ2AMJ5ULnPw5MuHVs83H5EHXGV8UYZQlJNsNZ9M2AFqIz7eMXY99mdBtSPe79QbGzav
	AKKCoLmag5QMrTKYfpghvGjpS/KiooMpvKzNUOGSXNDTOubDPSX+lrdNUYfPCLcpd7pCJkybwFE
	JOdnNZ/coCDHMO2fYuo5Fc4OauETzkPyAydU1ifHXDSDGQNrgwJjiF8wLeC/TGxvltCzkcCgk/m
	gPcdKHkRzLqcIAOnrTjT1eYvNSnr271VEZSv45/O0FZW6KmYfWiP0s+IQtFeu7tnD/PAJK45+GG
	Ox2eETiNHeD1yUb0XuACDakQW46BhJUD9DR1QifMMw7fE3aiOn2v9Ja7/P9vRIxUqz1dA2YkGVp
	mEzpXB/eujD0y/+Q==
X-Google-Smtp-Source: AGHT+IEWn2h6CKNAIfTA89bW8kP2SZ/DdoLTGqNhv7HKeN4Y7AGSiUZ5yIb3ElfSpUtjC/zhe7aueA==
X-Received: by 2002:a05:6122:658c:b0:551:c3d0:acb8 with SMTP id 71dfb90a1353d-554b8b1460dmr3984869e0c.6.1760045390196;
        Thu, 09 Oct 2025 14:29:50 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d7f01e3fsm211224e0c.7.2025.10.09.14.29.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:29:48 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 04/13] monitor: Add support for PAST MGMT settings and flags
Date: Thu,  9 Oct 2025 17:29:22 -0400
Message-ID: <20251009212931.445719-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009212931.445719-1-luiz.dentz@gmail.com>
References: <20251009212931.445719-1-luiz.dentz@gmail.com>
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

