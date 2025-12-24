Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5062A26FA6F
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 01:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766539574; cv=none; b=dS4QAQWPKS0i3DxcNDDaUgnxZLqH1MEoZx+i1cUaG8YYCE/isKcYjh2vYSrILilVItYP8+h/erKdfErF/6xMMInu8ZkYNCLfhEQvFfK+5SSngDc9rBPOvR+VcIX6HP2X88fnfeVAL711wuX0jkDUoocaNPWdIusiS7jc/NS9QUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766539574; c=relaxed/simple;
	bh=dIqizQJQbaMGsHLNbGIbALxap8MkOs+ioRUBW78QYIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OzuCW7ap2NSnGv1XwITsusPDYk/N7kX3bCZ7pJn924Zo0brvYDnXqm29UK0hU6RQfu6uOZFqrNuzjxLN2qGEdddrRCQg61lQ6GSyvwNJxJNulsfEx+9asmrL8GMeSooZnkdibi1M4jWdmSCPU+tcqn8O3dxC8dj9nSem31XUaYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6nSjsnR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6nSjsnR"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso4631667b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 17:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766539571; x=1767144371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RrbMe4KCNKv7ptllr50wizKiNNMOZ/7GfiJ4FjTiIhM=;
        b=A6nSjsnRRLrnVuCWCcTWf1RA/jMqBmtENiUB6W8sbDTCMXtpmTjEjZaDVcsg4K8lal
         qsx7DKZCQy3taM3fwtMtjmSyZLPjqNzOO8kpMyPN72N5n/NMr1QxZDhHuIe5g/LKMiGO
         e7miv9abezTMG+IleDjjTRq6FLMoZdf6N2sI4VZR9MKwLZwRBxgkLMEdPs3gVRyNzh5W
         +qRscKNpe4iVNEMHPKQHr1TKQmlOmgQcXc/0nwmsGmq/4xfAZhJV9oO5WQ3QDYcMeKLO
         adcAwqMWky6sbcNJRj3QJ1+XB4+O9YO+QoLtU/qaXuowPRaQD38NPjweRzWCVrzg4dv8
         on4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766539571; x=1767144371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrbMe4KCNKv7ptllr50wizKiNNMOZ/7GfiJ4FjTiIhM=;
        b=GWLQ50vUQUaivtTK5SSz3udXfOClh3doiQpBVoD0ndApqJ6GhYYZzjNBu3gJmuWv8L
         OUnXeWwuUxTKlBUWpIzvcjwRL3RsXX+7A9YiMVDV3pTEg4QEx6etn2ezkAsW6YKBhhye
         KfI/jkZ64ogQZmKEPA1aE0hZILdueAkKVWax8KaSU6hRp8Z9P73U/bOvXPCxOnsBgVLj
         u9XwO82HiXu51mgKmgt6EvOKu1T+JCq3g0wqjzNtONoifUWJM7ZZ5GQiA83UdLD3pGeZ
         dNjsJm9donLrKnUrwAzll3LnxjXCEVUNXv6p8HzfcH0N6omwpLxO+v7ClYX3FW4ehaRj
         mmtg==
X-Gm-Message-State: AOJu0Yx6l3CdE7yXkUB3peLayu2Ye+I+BVn0TIkFtbtwHBhUQf6qKjVF
	fA+Kw8dlKHyNIRw32R7RFVHyj6NR0tNmiwqgA+a4TtZKX4m49YllkREQ4vat5g==
X-Gm-Gg: AY/fxX7a0mJR9JwjmpRTQQL76O//+lRv/ymIGCsSPvnZCd5wRyXanXJeIt8LlhsPppw
	ZJBxczVeLOWDteafZdBixPyMniy1JSIOvjAi2x1y+/HPE92T1n3eMPdXPRQkU9nTi6Dn+a68Iu0
	9CU4zzO8RtErHZ9EBFZCOf4aaKibImslZ0WYDTabmrYNl/5h3mV0wondH914hxa7Gmdqhtm5rCx
	CnnfrOj6kyrCWdVhyFCoy3bTAqadPxgGXmAHNhQrT44uxxoAHFWmyTLhNRHWVGuqT+u5exo+ry+
	dh4nzG5sW6YIE+1yn0ueR6nJqmGMKuDZ3/U8YgmkhgRHde6a3XpjpyVAHKQMuZWyv2Y0+eoM6x/
	FZGArPqI1HcftIX6Tn9OIHNhIjJAQ6GU5nSDnCgZVt037mxXRCAtUyhFrHYutcCKAAxEzu98JN+
	EizYGaVblr8O13
X-Google-Smtp-Source: AGHT+IFv6hTVfqaxX2/alAwkOtEOxdCUQ5hlwDjzAjNs8ezMW7mYURVJZMYUN4tWty6TS9WvEsHv9w==
X-Received: by 2002:a05:6a20:7f8b:b0:366:14b0:4b0f with SMTP id adf61e73a8af0-376aabf91f5mr14858926637.75.1766539571309;
        Tue, 23 Dec 2025 17:26:11 -0800 (PST)
Received: from techieernie ([222.164.16.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79a164d0sm12981595a12.10.2025.12.23.17.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 17:26:10 -0800 (PST)
From: techieernie@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	Techie Ernie <techieernie@gmail.com>
Subject: [PATCH v2] Bluetooth: btusb: Add Realtek 8851BE USB ID (0489:e112)
Date: Wed, 24 Dec 2025 09:25:58 +0800
Message-ID: <20251224012558.47877-1-techieernie@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Techie Ernie <techieernie@gmail.com>

Add USB ID 0489:e112 for the Realtek 8851BE Bluetooth adapter.
Without this entry, the device is not handled correctly by btusb.
Adding the ID enables proper Realtek initialization for Bluetooth to work on various motherboards using this Bluetooth adapter.

The device identifies as:
  Bus 001 Device XXX: ID 0489:e112 Foxconn / Hon Hai Bluetooth Radio

Tested on Realtek 8851BE. Bluetooth works after this change is made.

Removed unncessary whitespace from the previous submitted patch.

Signed-off-by: Techie Ernie <techieernie@gmail.com>
---
 drivers/bluetooth/btusb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f39e8c2f83a1..df7a452bc236 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -521,13 +521,9 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0bda, 0xb850), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3600), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3601), .driver_info = BTUSB_REALTEK },
-
-
-	/* Additional Realtek 8851BE Bluetooth devices */
 	{ USB_DEVICE(0x0489, 0xe112), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
-
 	/* Realtek 8851BU Bluetooth devices */
 	{ USB_DEVICE(0x3625, 0x010b), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
-- 
2.52.0

