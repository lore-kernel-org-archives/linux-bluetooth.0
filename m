Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1D23C8D8
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741806606; cv=none; b=tq4yPqj4q3dnJPUjIpp6CYilHiWz7VxcDFTV+C42Ej87yrJxfEQwLWM7+/+8rRI/wu8dpFdJEkneDQLeLa2HtPIgAX3qrztTk2n212CPTG826QF/UM4laf4NQFkSgCGCSTDlNVKmiXMVQqK+/vE8gFiFJEbhDeBiWqmU7yMEs8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741806606; c=relaxed/simple;
	bh=nacuLeDWHeMwH/yYMcfuI/3/B6s+DNywG+FtUS7Mz5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W0gsIit7kEky5tjYkG4rTtP1FhHcGv/gUQXOEaDyhdYiAXBYMCrIfSuiso3ttVlCvUF5Iz4ARcv20ROt+CjgDNYeY7n3WErMchZTz6rQo6FVG7ILIXVA4jJ1gUpVD0rI0rVoOk/44f9aK1BVtXWsedoQ+4zD4Y8MQlY1YtF7310=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmXs6Dq9; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmXs6Dq9"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so206622a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 12:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741806603; x=1742411403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MBF4BCZTHR2T16vylqmIDSL5g+RHo03Ps8PXZXiFuoo=;
        b=OmXs6Dq9C/YqiqUOCpzXldgB99VklG7klASNVyy1fG1FXYejpeDFbFSEfgJszmgZuZ
         dMnvXFTZCw4gHhqck9m3HrGiLwoqdxWApS8TQkPi3tvxgVXrZ4f8O2P6Wi2mhteDIZ6k
         J8wZBx5q4imEGMYN9vuKnskyuU9w+glozpT0GaZjMGGLaeXw5Oe0nFsZ1Er5ITMPbkKb
         GOk37ax2nD/4UK2wleXmKmQK3Xm30IYvlm8LDwEPOOTNQedFroWVOedlZdcqvQFqt5T7
         JehPIrCynXUMKqeFXze/bBUBeTah1G90Yxl9VJqRnWTO4YwSET13/bISWC+mo+faR+M8
         eYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741806603; x=1742411403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBF4BCZTHR2T16vylqmIDSL5g+RHo03Ps8PXZXiFuoo=;
        b=oCgiczK8wlVmqBtAKlLD+mQiJpucgfT9+4ZrUp4PztaJ9NT0pJX0BYo3QW28cN+Oa9
         tDgVZMNx2+9WETGZ1I/T1qvyVPXcRtGS+4qvZu1wL7K6vubmPvx7p0Hjh48m7RZIqmld
         h2wbb6U6SujlBHQ0qS/i4krxVJbLokwMyILO4Tqhioc05xqQYvbctASzh5VwnQtvc/3w
         XZYPfNWo0tiFyRI0nJAcKxhjIf1h915i8H/PTLPdLfT/4l1AWzRYdIzVm8uwHf7xzV8N
         XAtAnp+UD+0Ac5W9jVM71C4rugSoQRCRXIrZKW4Q3/GTO1IShnnsXQzXP2J9Og6n1YaS
         OVbw==
X-Gm-Message-State: AOJu0YyqgJzFkwF0lujjOdNUnSWCr7/f/p/hptPT372TsdhhpKoHdS8y
	hJZCvf0OsXkFYTkqRHMdXj6X8no4TB/N5xMnO2pX/6PYqg32jsElp/BGvx1SwYQ=
X-Gm-Gg: ASbGnct/HtccN5Zo8fAKLi+o/Mif0xXpJ7J+uG974Mh5OxuorX18kigrE1udhet47TX
	MmUOxRIgzcQ8ebpypWZ26LK7++P/IcxgO7mug6A6zDmx6Se0kPr7aEQ9apRZWQspFAQJhVV2Rwm
	OlFbtoy7EXcFVBZWqX3DWAkSKPWhCiwkmksFQWXdcQbp3nAMBNOP5ILyAHH3bq3tnfBkTRPGVi8
	rZ7mIoSSVmoTlUNW+qD/6XSx3aGnxTVQODKD9JWrCNy2YeIKuWESII1vW0nO99Th4vo6QXKF0sw
	XNoj6oWUXeTGWHsewabyonFApNkFFRSxyRFLDyqEYmrtaCOkTwowhDLejGuKBEwn3eFNlzXfYsv
	Zs511zcIVReO8VscjNtmQWuZiJnCEkOYJx6Dobg==
X-Google-Smtp-Source: AGHT+IFsC68Hut4dlyhfmjlUsNx/OnYa6gpl+68cDeU80cgRIuzLqeVorqdS5pR0MMCszaRgRjjf5w==
X-Received: by 2002:a05:6402:2353:b0:5e5:c0e7:f428 with SMTP id 4fb4d7f45d1cf-5e5e210296emr60545648a12.0.1741806603092;
        Wed, 12 Mar 2025 12:10:03 -0700 (PDT)
Received: from localhost.localdomain (46.205.201.86.nat.ftth.dynamic.t-mobile.pl. [46.205.201.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c768ef30sm10065871a12.69.2025.03.12.12.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:10:01 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH] Bluetooth: hci_event: Fix connection regression between LE and non-LE adapters
Date: Wed, 12 Mar 2025 20:09:43 +0100
Message-Id: <20250312190943.152482-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to a typo during defining HCI errors it is not possible to connect
LE-capable device with BR/EDR only adapter. The connection is terminated
by the LE adapter because the invalid LL params error code is treated
as unsupported remote feature.

Fixes: 79c0868ad65a ("Bluetooth: hci_event: Use HCI error defines instead of magic values")
Signed-off-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
---
 include/net/bluetooth/hci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0d51970d809f..3ec915738112 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -683,7 +683,7 @@ enum {
 #define HCI_ERROR_REMOTE_POWER_OFF	0x15
 #define HCI_ERROR_LOCAL_HOST_TERM	0x16
 #define HCI_ERROR_PAIRING_NOT_ALLOWED	0x18
-#define HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE	0x1e
+#define HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE	0x1a
 #define HCI_ERROR_INVALID_LL_PARAMS	0x1e
 #define HCI_ERROR_UNSPECIFIED		0x1f
 #define HCI_ERROR_ADVERTISING_TIMEOUT	0x3c
-- 
2.43.0

