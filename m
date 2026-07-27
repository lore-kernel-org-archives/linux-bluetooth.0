Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DE5389DE0
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167554; cv=none; b=aTpZJY5UwxI53NJCkijjqkrga/GOdCl2gnUwedJag1O7MifHzSju2bqFFrAHI7gOwLZHqBbPzTXNm/FAO59OucvasH/L8p3MNYTFJvho8p0T4IczhCl68TUmthySpeXSPzs1A4DJh0yfQQYMLQYwA+HX6nuRFdoSp6v/83SF2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167554; c=relaxed/simple;
	bh=kzbOwDoIQccc/vmXk10i4bMS/XkPcDdFLODAuPx/f60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RlMDcuaLN0oSxJFK0XTnqV1NYeNs9ClzaiYBWfK9YtXnmUW56EkuzLjkzAH1GfapKHb16NqR+k+VUrbIHNG4J1u1jMXbiuCmNAlCnL51tCM1z1crTcx5Mbyik4nXSu/KZOPcAp+Bl1HC4/NQKh+KGcwKB3U6EfpUT/5X5U58ERA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=MN43CIhn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="MN43CIhn"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49548aebcd8so21671735e9.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 08:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1785167550; x=1785772350; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yi9zpNI9ss5GZB7UaZ2xVdwfzZIpfrC3p37S+/6MGgU=;
        b=MN43CIhnkRkGGKF50XYXKA8X7kQvPAnklPOPz2jV5Dw5sn/josglIEkl6ZiumVPzAi
         /gMlWHOILy8t5/VEKkWZH7rCESbv0z9/iphDs/9ttYtriFJDmvOjbwGHOrjosJf6aY1g
         /MPRBRKKI24ncWDP2aQPO986/XaRVF20MvkHLPPv/G7I+Qfe+15pSsctUKIhbuJpAmUE
         Q3t0VwVMxQJB4kQjV8YnzfROLPWSZgeLOvRoxeUeFsB74v8kJYAOLIG8ZxjR90u7vYHS
         a/6Mb1ZgZBiQUgx8ZYaGtbVybqIudpHtBxkOPecMNvG0vzy0/QK0xPEBtrcrzVbzVQqK
         W9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167550; x=1785772350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yi9zpNI9ss5GZB7UaZ2xVdwfzZIpfrC3p37S+/6MGgU=;
        b=BLsCFQ/HFHyZmMzkx7nAJ69C9UYzxvrp+aY6R+0cimi9thzAvKhTWRC4svRajzzxqe
         Ls6cWzWYeH1BGVTfwyL1uCBa6tuGprAog1ZwD80kbxtV45wK6kVUHBqdgpLm/KaR9IRv
         nuGCM+3hEq2tatih/Aa1HFK0jRVpkveduUxwRVFAptTrGVe2pWakQFypCxWGtaMyeS3l
         5uiY0ik4dv7HF0NldtPpmf6Hp8mrcqzQ/5ofiOLUncVwUeJfZadjaXK3vQ9m3bf3ghuW
         ckltl5o4oI+Q03w+M7NjdVdwlzqSjcHY1sQPkQ4i3Le3frmOlFdI5CBCAHzwfXwuuxX1
         KbMA==
X-Gm-Message-State: AOJu0YzUlfCNPeS9Jx2RCGYRZZS+k7Wmch+gJFDI9QiqXbmMPdOBP7bO
	dfOGt8/+HfweHqEjwoihvy0TaSlVTuygTAD4im67CHnPVZP/hyQO86sVbX3jDfYBeKg=
X-Gm-Gg: AR+sD13VWPMn2fKp76RZslSeZi4eYRo/ESyfZ6eGRQruiUfIvMMJXB0aekqB3tXqNhX
	OyurMgp5XML0FmwxPhe+NYCCwRZyEAzyix/wNwvGk2fCkxtZppNKBSbc8rkrUiFGsZPE4UvEg0F
	RQXxGxtWj7OrNxFhgybe1u/5uWOGKZvs7lMcvpgj0uJiFxetiozWU0koVcDK+HgyByzaowtxh0E
	kBLIY3e5LRqM7cHge/E7mL5zKseCZ4Q8v3NkDrhBI++aKfid//UMCBZ1sskl7TtQ8fdwpVjMswo
	P/buN76rUidrKxbIoFnnBP8qop3MHRZDAY2btFw6/2xrbT/EUA1Hr3G9n/nvPKRVl4Mc7kK5/dw
	uRb4pLKBN22800diN9UgrrEMwQbxq0QGUOlUHYx2CtUEQsFIaoqNeZAFqvNr1ODKWLUKBenGZd/
	d/h19pvlCjWA6y6X9f2ag=
X-Received: by 2002:a05:600c:a20a:b0:495:472c:208d with SMTP id 5b1f17b1804b1-496b572ee46mr71194445e9.38.1785167549849;
        Mon, 27 Jul 2026 08:52:29 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:7aab:bc55:e039:4aac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fa9sm51005161f8f.20.2026.07.27.08.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:52:29 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 27 Jul 2026 16:51:52 +0100
Subject: [PATCH 2/2] Bluetooth: hci_intel: drop unused assignment of
 acpi_device_id::driver_data
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-acpi-bluetooth-v1-2-b5558d53e6e7@thegoodpenguin.co.uk>
References: <20260727-acpi-bluetooth-v1-0-b5558d53e6e7@thegoodpenguin.co.uk>
In-Reply-To: <20260727-acpi-bluetooth-v1-0-b5558d53e6e7@thegoodpenguin.co.uk>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785167547; l=989;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=kzbOwDoIQccc/vmXk10i4bMS/XkPcDdFLODAuPx/f60=;
 b=F/kqOyVs64baHfD4XL+UqtL8dkTvR6Rv4KJmGRykOlVGsfFGiNWB2TKsryoqymwjGI0QmfHnW
 /p1MxYj6BOIBz2tDJZ8LDuhRvvCugViZtiZtaK8SUlXTIiXiiH/weI1
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

This module sets the acpi_device_id::driver_data to 0 but
the field is not actually used within the module, we can
just drop it from the table.

While we are at it - use a named initializer for the
acpi_device_id::id field and drop setting the list
terminator fields explicitly as well.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/bluetooth/hci_intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index c31105b91e47..ecf597f3e201 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -1057,8 +1057,8 @@ static const struct hci_uart_proto intel_proto = {
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id intel_acpi_match[] = {
-	{ "INT33E1", 0 },
-	{ "INT33E3", 0 },
+	{ .id = "INT33E1" },
+	{ .id = "INT33E3" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, intel_acpi_match);

-- 
2.43.0

