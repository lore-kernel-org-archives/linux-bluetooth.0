Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7739113B7B2
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937045; cv=none; b=TSMYFDuDnVydlwCmCAvJyw0MBGB59/TMmWi8XLgoh1l76lKoXd2UumZwy5uNeqAsdvn4PY3gq+jmQRNXW6AHXl+H4DHgb+n1bdm72F/yTNbIIgc3Txsz33Nky2VUVp/hOrhItT65EIuKVxPjR6K6ZTTXLUtml6jlIsKo1elfGms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937045; c=relaxed/simple;
	bh=j13zusx1iNy1VSpCf0/7Uh5Vuxv9p4qo5PlC9S9RetM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrS+QgN9dAmgAHJRw+4RqMUB1l2rkQLr9Xd1SPI7WVidWY9j0xIwccRvM5aY3FvCEqracovFnbtB7h34WDSuTRC7uS84jPYpdNQqt4nC5lAWy29IW4REaPNHu16Gh5jUMwUgSerTk7oiHwqVraWyA+rIYK/WdQHfvD6ytnkqiQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIK33Txn; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIK33Txn"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4c015883a13so24337e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 10:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707937041; x=1708541841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kAGhHA/F4F4m8PaN/GFfvTrWCN3YPm3thn164WVswE=;
        b=fIK33TxnO2PjuwGdyecEUzqPv8VGzlCd7xgy2WUX+djNuvJJ9a76qLiqU54zA20kkC
         Laxq/Bsc6fIvyVjfpX/ZsIbC3bA2YR08tBhsXYn4fxG8fLQC1LMz0vXDSykdti/ZpWGj
         MzU6qC16PBNdbaC3j4zJFpTOQlKd0i82GKymbM88e7b5TZZgiruh8QMAvlWT0UewRjA8
         9BgTqwUVK55h0VR5JV4D3FU+EvwtebqBnDQBvzT3RIgh1e/mqiDzn0/g6pmZbBJgPHlO
         zj6tNnKrIoZP31bYjVf6Olvp1C7vSNMXnqrlmjbF7hPw+pNlhtcX6yJ56wDrTd/A3qQ+
         aeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707937041; x=1708541841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kAGhHA/F4F4m8PaN/GFfvTrWCN3YPm3thn164WVswE=;
        b=UkHf9zHmx4Ue7Zy8h5L1mBzLHrfd713HRNxDsQONPqLoo1gsUVSp+IP7kkTBjaTybw
         OKAdFEUl7U/IqqBeCSYGw8FNo6Qfwmzl2QUcyAkb1/xTGfWIbLPBakQZ9jahQN4SXuWc
         Z7vpK/Xc2k2Lhid74oQqDcQvKYDA5mVuz/BLhmWfyqCs174R66gMCLu0e767kxrimOqm
         z5XkfFTY+UaXif/j0ehfOtftuWgPfsCrtXpMq8GDdUdTKxxg+/oQMkxVR15J8jY7bIW6
         t6pSFVrB9kfaHbxF8CaEGqQ6stPfBYshRgtDyOmLiSOfzaBEFrgXp8cp0Xm5us+tPFKT
         9yGw==
X-Gm-Message-State: AOJu0Yyj8MESGji1OXy7bJXdLu6Kxw6/Ts8VtJqnEd2Q1R2RVlrXhda4
	JjPMjPtpnncwb5nAgqRVtdkkaqAKj9bvZwS3+sWJ+3ZKla8a8bpuoO1TQVm/
X-Google-Smtp-Source: AGHT+IGhFo1OrpLyMnQ9TC7FCWXhlCgDbkX1eus1RSp5UPPUYhQaMdbJPIdjGuU2K+aL7/qOUa9e2g==
X-Received: by 2002:a1f:dac1:0:b0:4c0:1ab8:ac8 with SMTP id r184-20020a1fdac1000000b004c01ab80ac8mr3485478vkg.3.1707937041390;
        Wed, 14 Feb 2024 10:57:21 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id l5-20020ac5cda5000000b004b72c016c0bsm1309545vka.5.2024.02.14.10.57.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 10:57:20 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 2/3] input.conf: Make UserspaceHID defaults to true
Date: Wed, 14 Feb 2024 13:57:17 -0500
Message-ID: <20240214185718.536748-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214185718.536748-1-luiz.dentz@gmail.com>
References: <20240214185718.536748-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes UserspaceHID defaults to true so the plugin has more control
over the input device lifetime.
---
 profiles/input/device.c   | 2 +-
 profiles/input/input.conf | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 6c64ff1c1c52..ff7e3482d0eb 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -81,7 +81,7 @@ struct input_device {
 };
 
 static int idle_timeout = 0;
-static bool uhid_enabled = false;
+static bool uhid_enabled = true;
 static bool classic_bonded_only = true;
 
 void input_set_idle_timeout(int timeout)
diff --git a/profiles/input/input.conf b/profiles/input/input.conf
index d8645f3dd664..00a34eb63de1 100644
--- a/profiles/input/input.conf
+++ b/profiles/input/input.conf
@@ -9,7 +9,7 @@
 #IdleTimeout=30
 
 # Enable HID protocol handling in userspace input profile
-# Defaults to false (HIDP handled in HIDP kernel module)
+# Defaults to true (Use UHID instead of kernel HIDP)
 #UserspaceHID=true
 
 # Limit HID connections to bonded devices
-- 
2.43.0

