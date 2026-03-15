Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B31623D28C
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Mar 2026 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773571911; cv=none; b=MiiPyi6x0bVlRCLe9QtDF1ZYewjpRNKGbcLO/JTGA4lI/Xu6BaWYfXd2QSnOWadP0j6JCfcLktVy7eY+XXMtYA4tHkYxF7UQAMQBpLNdGB+LQLI8BnEsQ7EqZ+TMFsmcLK8Wms0TYRy6Oxq1T19pYzf4UqNFyldpL0aKquL4oEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773571911; c=relaxed/simple;
	bh=WrjYdAZ1gpPUidP+ex11mExhhOG06gOKsCA4QYX1FA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHQ3mrwr+wgNX29R1/jY8NoOXBdo6PZMTAR2VZOdIDUaP3JTNP2N6LfMOYCUH8PQOVDVisTDrKXYqHkRIlZo5gRGpeYAIyfUgYpaMUSWVQnfUvdHd8dIwBv/KG27czqBj4lVN0AnOUrKJIlnirs8nqElskVhsDJJUy5jQrQOb8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGYpYSu9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGYpYSu9"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae5636ab04so40662745ad.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Mar 2026 03:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773571909; x=1774176709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlSTVkt2Hr9uFmMrTVFBqTieBRyNKp6QC6tkoO2VILU=;
        b=GGYpYSu9xCNfE4em9I9TlKESW+25C+UQ5F4lkkYe8wSqbe3zesvQ4RlakPsEx3xadV
         /PTFqpN3LStjbz4NHrlsl3KyVobUCt/MKt/epXk6KS8Ruetwx0xYGGYtvnIUFr+zy8HK
         wLZ3jWcurslBFW5xVT9AL8+r9u+vJTTUp9xT89pl5xm1bG06xy2dYsYMWaHLHZtPpLRL
         rFdpx4gowGKAIMM85s04pGhqhTKx3iZZkveKreTa+3va6hsHg7/3MVpRPq5FbXZebWp5
         pbm8tIvxe3CK6M4tQ0rAADbyANRduiHOFm+1vljAHk2MwkVsMe0KzxGgXuHsVSMuU6x9
         aTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773571909; x=1774176709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FlSTVkt2Hr9uFmMrTVFBqTieBRyNKp6QC6tkoO2VILU=;
        b=PaRoVRMILFQQ87BrN6vO1xwI99HXElAZAfTgGp2xw8tD+dL3U8njZrgi1rSiSQ76w4
         hVW6X4CYFP0iC5qfcEtpTD8tCwbIe37+C6yVOfMEMedH3NnMdZJsGN60cdxEUg9w51So
         u4dKNvxvO6Q3WrAbvlKK3N/VF5Jx4HBchk75X9k3ixeQphDj7MlknPTf0u4JlJkd1hIU
         TlRxm85m5N6MN5q8UHICm3JdOcTKh3hOkx6yZLUoywh/BdwTmhDOFymTFS3/OWkdgnEJ
         6S6NdM1EMC0/BbpFrppQWcwt8mrUpxFbd3KOpb+aCNTZ3ZJw2AYbC09hN/7fkyh5uYhE
         Nazg==
X-Gm-Message-State: AOJu0YxLMukZgLv7deps9hnoiHfb6CSBmuKo9eqcUcy5UH/Rhs0hoL4k
	SqNHz9C6E3iwaEaiDqNce7BDfxRnyjUair1eazXa8if20g4mO7BaYKhe04EY1/dvaeI=
X-Gm-Gg: ATEYQzydf8MhjtuwsrFkEDD0Hv9/5H0T+52bcdfueidGoMemuq4MTIC/EH9oPbZu4Kj
	gRa6fepmcqt3FNVci+yjDb7tG6z6J7avH1x6MNblCEeIajv6CdrY1Jp/az6HdEKdH1OlP1m6bVf
	1tcDmxmwLBmdan3+c5fIwFsBqfyDrx6iBkElRpXT4DLEAvjz0uMi44lwMCSWRPRLNnNMQcEgfgL
	AHhJoeW/7W2xBvpjkfp73bmYzt1xz+XEzMWojW2bTSyw9MVB7gCiBdEptfyM9lsTZrl3i8kJG6Z
	iZnUpPSLUkzgTcRydoiX4UGe12jnpmbvdOG+tzlS22cINaeLibbhM1cGIHPO8TaNVfk9s7JsWf2
	XIrfXOZ+364NFA17n5iwyP7XYIAjvsZGPLozGrEzCZ02/tNmmruXlq9pwW1FBhcAqHZsNYTL9MK
	4fWZHb7nhnpQh/u0uLZ3xsS2/9Qps=
X-Received: by 2002:a17:902:dac9:b0:2ad:d5ea:4c89 with SMTP id d9443c01a7336-2aecaa7917amr104151925ad.22.1773571909604;
        Sun, 15 Mar 2026 03:51:49 -0700 (PDT)
Received: from ubuntu.. ([152.58.129.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b04f40f515sm21885085ad.74.2026.03.15.03.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 03:51:49 -0700 (PDT)
From: Anas Iqbal <mohd.abd.6602@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	pmenzel@molgen.mpg.de,
	mohd.abd.6602@gmail.com
Subject: [PATCH v2] Bluetooth: hci_ll: Fix firmware leak on error path
Date: Sun, 15 Mar 2026 10:51:37 +0000
Message-ID: <20260315105138.1693-1-mohd.abd.6602@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d735e9fc-4b77-4880-95ae-12f2a00b23a9@molgen.mpg.de>
References: <d735e9fc-4b77-4880-95ae-12f2a00b23a9@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Smatch reports:

drivers/bluetooth/hci_ll.c:587 download_firmware() warn:
'fw' from request_firmware() not released on lines: 544.

In download_firmware(), if request_firmware() succeeds but the returned
firmware content is invalid (no data or zero size), the function returns
without releasing the firmware, resulting in a resource leak.

Fix this by calling release_firmware() before returning when
request_firmware() succeeded but the firmware content is invalid.

Fixes: 371805522f87 ("bluetooth: hci_uart: add LL protocol serdev driver support")
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
---
v2:
 - Fix grammar ("content is")
 - Add Fixes tag
 - Add Reviewed-by tag from Paul Menzel
---
 drivers/bluetooth/hci_ll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 91acf24f1ef5..91c96ad12342 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -541,6 +541,8 @@ static int download_firmware(struct ll_device *lldev)
 	if (err || !fw->data || !fw->size) {
 		bt_dev_err(lldev->hu.hdev, "request_firmware failed(errno %d) for %s",
 			   err, bts_scr_name);
+		if (!err)
+			release_firmware(fw);
 		return -EINVAL;
 	}
 	ptr = (void *)fw->data;
-- 
2.43.0

