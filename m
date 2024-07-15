Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637E818E746
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054856; cv=none; b=my+yfcKjeRX+snMDMU5DAJh0oyQhvaA5xb7xSwRnrOCehCo7aRiM9CoSyz1PXD+M1LKw1wP2wDUFojWCjSg3d3UMfxgbWZBm+2hMa0ykHWY+k4zgkDppWCO6C9EoELcYP1kHbbosivEmXifBbkloTPxz9QCpFEQqZV4QwAiqXcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054856; c=relaxed/simple;
	bh=ygrZey0DUAYLPxQwsg6FbJeFCCmXoq20lh7rLeTPqF4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eRvfc9vDqDDE7Zpi7J70EM+KxSOdm5IfFp8ldGnl39ZdTn1UHDgKu7zKcBtyyrg+2T2LgveOObmQYUdUNPCNikxZJNivhI6f4hH2SVAOFpBPq/jVSkhCj/ff552YMBJDh/TbVXI6GEBMaCv86i1nifzXEgqC3drRXvXwjxbZYJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcgvTR1D; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcgvTR1D"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-48fdf2d5309so1698440137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 07:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721054852; x=1721659652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uXT3qeSYOkxdHA6SCZzYsx6+LU+a5yywtqCIOcEH9Cs=;
        b=GcgvTR1Db2Y4xW/aqPwh3QvmiblLFPJl7Slk1+/L3p248eehHyjGfIar704Doyikkf
         dbj8pLD/pmNDiowNLPIOKC3+B0yzOy0VI8U6DmqoFNv4pXR6IxdGwMPlUAGt0rbsedEQ
         gruxVYIeoHnznMHbzM2uqEcfwF/GYpywhpcfxEbaEcvjAUQoBMkhWjEdVMnKjC5ZDEWz
         xQ9/TuXhY3/f1Al3gqEP2NWIF7LBSadiaC3qtpXv5OFwbtOg8bZPsZdqHbQ7mFMQIh0J
         FJ4XwwiS6PrELVlRVng33xK38oGDFA+CX3l0u17vQ8GtqZKyPhduOOvncCnFbHWtKa+S
         ViNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721054852; x=1721659652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXT3qeSYOkxdHA6SCZzYsx6+LU+a5yywtqCIOcEH9Cs=;
        b=jsa+gaY+MYmaXBAshAdMb2kG9Tcj0ioypZGV4cfjoJZzWrIldAX60LU7vZeoisUDua
         yyGnAS7bxR2BiE0nCNFIxHSwuA8obdXaISvvJpfhAiHMAK6HpTQ76p5rqf5qd3uCYyhI
         9NwdLMfxNU8fjz3efP8joSpDerUMmeJW42V1exXYr8DFacS74Avz2kXLOh/w+d0iW0AI
         tB5aovNGyyWckR7S5YaduLBpf7wu49QJYPxJN9p7pxWP3DFruEl5y4cFzH2/T/mWv2vU
         LABFNm0TqrQ5IX3z08KwWq2F/HzqETfT9AOCmY/uC8KleoAe9HCj1sz2i/4VEup1TBvR
         cTkQ==
X-Gm-Message-State: AOJu0YzyBm/7XrVmjszZict1hMuvfSDvWwY78PZKTKOBFIYPG47MiaUj
	eaBGiW09soGcRYv2LYxR2Q3ErgaGrJ+lNbfM7IooWqbMtWta2vDO9FcBeQnZ
X-Google-Smtp-Source: AGHT+IH2rfqZOGlEGrRE5HCx8u5ZA0w1Z4FPxXsRupc9ZFjR+T7N+n0sJgXEImjJH5atZnzmN2HPCA==
X-Received: by 2002:a05:6102:3f8c:b0:48f:e742:40c6 with SMTP id ada2fe7eead31-49149b6bcbbmr161047137.23.1721054852439;
        Mon, 15 Jul 2024 07:47:32 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4912b1d9fd0sm960792137.26.2024.07.15.07.47.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 07:47:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Fix suspending with wrong filter policy
Date: Mon, 15 Jul 2024 10:47:30 -0400
Message-ID: <20240715144730.311392-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When suspending the scan filter policy cannot be 0x00 (no acceptlist)
since that means the host has to process every advertisement report
waking up the system, so this attempt to check if hdev is marked as
suspended and the resulting filter policy would be 0x00 (no acceptlist)
then skip passive scanning.

Note: This disables remote wakeup for devices using privacy when LL
privacy is not enabled since that would require the controller to
resolve the addresses.

Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index cd2ed16da8a4..0996f159c675 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2976,6 +2976,13 @@ static int hci_passive_scan_sync(struct hci_dev *hdev)
 	 */
 	filter_policy = hci_update_accept_list_sync(hdev);
 
+	/* If suspended and filter_policy set to 0x00 (no acceptlist) then
+	 * passive scanning cannot be started since that would require the host
+	 * to be wakeup.
+	 */
+	if (hdev->suspended && !filter_policy)
+		return 0;
+
 	/* When the controller is using random resolvable addresses and
 	 * with that having LE privacy enabled, then controllers with
 	 * Extended Scanner Filter Policies support can now enable support
-- 
2.45.2

