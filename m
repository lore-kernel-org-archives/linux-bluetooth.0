Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB98D37DE99
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779267717; cv=none; b=UeCwXB7lPCcaG8pztsLIA+zCtj70K7Ohc4PknEZKSb98C9wEDF8XvBPFSgtP4nw8IFn+eFp5yTbLBM73QdCDRI2PlQ2QGpBZ9PRqCL6+J7AM6O9QADPihhQ3NvLWoeerxEydVDTfTRKtAjsmvhOciPHgjKXBmwVsGX+re+NdBp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779267717; c=relaxed/simple;
	bh=ChwTR5AiRVPC/c2tzwEy8EnDuXsozHmf3I05jftIBZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWo4hPhL2xGsfjMpu6fjOJLZxlDKukUbqk2JTBFkQBxwj+ujgP1A9sETRWwrf1mFcq5cDeB/f+ZbG99nEab76T9DfQoeOTg/2V3aruohnVhlEpLcnz2nVBgxZ0U47eCbXM77RgpwpZ3vcsRPzYij5f+xsH6o69x+fs65PnhGPo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=FHGDF+NR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="FHGDF+NR"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2baca4df358so26218085ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 02:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1779267714; x=1779872514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54955ku5EzMLqQnNBltUtUtWhXQWPPT5ALZtomeGanc=;
        b=FHGDF+NRXpbjuhk1EYFCLJqdm0b2J855hFJmzoF7KkW0VLIkzEF9WlkFeaXl7fREvH
         fcmDo9Fs29NTnbQUdYgYXXA9doejJkO0cBhm0EfGF1wKkUwR6BpIS1BbVp0FlqLvGzxl
         y/bURvqdmoF4XqymEou2FeT0itqFWUnJ664qtSxI7HqmjYO1wwaYfHL7ZzMqi/PYl5Ng
         4yRlGrOzmE9JEFxEzCdxk/zzaIz5sp0BV70RPjShxe3LqWvbh4oZRaOl9sS1GvScaJRQ
         ttBcn7YsLZf+mJSvB0wxc/338KWZcXBgyzgzlqnt0Rbgwcv3WG3z9hu6ycCShzTom/wQ
         E7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779267714; x=1779872514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=54955ku5EzMLqQnNBltUtUtWhXQWPPT5ALZtomeGanc=;
        b=RvM0/YAtaPAPNSTTKs4vzyYhkbY2BowZREvrZnVttcPAXESGK5IuoDKPYmGLDdMag4
         pUW7BBDiq0HcQTfQRaKt3tzIwuXs/vfauTINO35LbYAjHwABkn5N7cLmFOmouDNpOjyI
         3lmm0/I7BYeZ2tXPws2CwUMlr9qpUI6u9OK9sV+7ubXeoE3FxnHwvmJ6PCn6+njVOvlD
         zfX4MjDFuR6sqPbsZLcM+jpsqHlpySbe8pMGmN+DdqvrInFRTKN6R9WYSMgLxNaab/4o
         VvxhdoC49dCqgxNHJrFlWHepaBYM2p0a95Y7qR1thmPx1tThA+o6vMLXNgQ4AwWIUyOj
         LRBQ==
X-Gm-Message-State: AOJu0Yybq1JRQ8OHsVwPdROqyDQ2Rr7E0pdTsjbpIBaFLpZvYHG7POlB
	Ft7hOYqjldjOg94IKO8VGLagZPT/WQZKWpoayVzsk6bJ64nat3uIcG0g0rMB83CmRW8fkuAMgSU
	yRJyQPA==
X-Gm-Gg: Acq92OHvCKs4uab3ORq7ayxWqHzVZ5GVdEcgruzQuz25e/hs4X9kVujyxB4CF/paqDe
	qIHs8DjZqq5JgNe9DAudcRhNgH3SLiQ+uZO7KXy2CG1pk65AJs70NBo8bjWqKB6wH61suSwRK1Y
	p/TfYi9MTwY7gigNHgUAQbdYuYdecAZ998qeGYkA+BLkfHuqnTK0PwzlbPpR6Df7zRKYKoVjAxM
	Knvv8pST48fDla/7B75QOs9HIZnG2X5+n+aXL2CJ1ce9Ho7JQ3ZbheNASIhlCd+PrYpZBZNPmL7
	bmhuAgf3Ki7sIQfu3Z3uYwTDanaNEO6dKB+Y35yn4gDIn31WqtfZII1tu5mv6/NzPArUZhN30j+
	pl98pxcc0anUk4+gj/ontkQ31WL0RHj9cnn42SiyZJ3pX8Q28aqwzkYhldg0sBovYYNC26fYhrP
	4chVESLEcwQKEj7mE+N9dqAI7k+UhDs28D/qaQb0q6uyOB17BqSxTYJxkZjN+RT19qkQExQBmVp
	sDghOTzHAXzmd1wH9F0mNx8SpfLe9eDQd6wnLw=
X-Received: by 2002:a17:903:3c6b:b0:2ae:825b:49a5 with SMTP id d9443c01a7336-2bd7e415675mr237007945ad.0.1779267713690;
        Wed, 20 May 2026 02:01:53 -0700 (PDT)
Received: from TPE-build-server-2.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fc47sm205333065ad.10.2026.05.20.02.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:01:53 -0700 (PDT)
From: kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
X-Google-Original-From: kaihsin Chung <kaihsin.chung@synaptics.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.von.dentz@intel.com,
	linux-kernel@vger.kernel.org,
	kaihsin Chung <kaihsin.chung@synaptics.com>
Subject: [PATCH v6 0/2] Add Synaptics BCM4384 Bluetooth support
Date: Wed, 20 May 2026 17:01:29 +0800
Message-ID: <20260520090131.3505676-1-kaihsin.chung@synaptics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408083217.1915419-1-kaihsin.chung@synaptics.com>
References: <20260408083217.1915419-1-kaihsin.chung@synaptics.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the Synaptics BCM4384 Bluetooth
controller.

Patch 1 adds the DT compatible string.
Patch 2 adds Bluetooth driver support.


kaihsin Chung (2):
  dt-bindings: net: bluetooth: Add brcm,bcm4384-bt
  Bluetooth: btbcm: Add Synaptics 4384 chip support

 .../bindings/net/bluetooth/brcm,bcm4377-bluetooth.yaml      | 2 +-
 drivers/bluetooth/btbcm.c                                   | 6 +++++-
 drivers/bluetooth/hci_bcm.c                                 | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.43.0

