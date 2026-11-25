Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625952;
	b=yiI+UicDeyk4herJoL47HeltCLvcEYCQ/UUfdMOIJaWbHXs23P1/JDx3O9wDuvL7UXg/
	 1Ot0RDNDo5Hp0pME05QT5ZMlZZ3+o+oFZyP4TGTsNzmrSCCOlb0nECOp1Yd7IsUbIzKn2
	 FX6/gC2rF594gkYs9yX0U3YGjEW+/u+yS6VBBwVl2FC3WtzkUZSDPc/CT8XnKBgXAFj8o
	 0rGBpe/19vNQlI4U6KFXNkMPZQn3G0vu0U93SlzsAV1jLSj4ynhfu2guL1Q4q3/uGZ+2H
	 AfGJgueY8fSFOlzwoKkRr6jR2iHH5DMZvHG8xn8+I7euuy4qpx6ATyEOWVIcmPlM7BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mdld0D1yE/J63qgOC2C+zzh5Ht1TFl4rC872bUAhPJw=;
	b=q4lcdTZrLw02yA9fhRUbceinSZVdU5Xt92+TYrQF3zBPE4BXGUi10DMkkGw0erATxBbg
	 5uUp2ZiD1TIjnKDWShfH6V6cfUcbIJmsvJPLGGvg816ovC8GuI4+QxMR1cSEF7Na6QI5/
	 DxqAkvUi12d8I3vQdcPC+po5x03ZtaXZKauTOQYeqjatZjAbM9+7Xq1aJ/+VJwc9Kv/Ce
	 jE0jVcD8MFhmHIvhOlfOjcRuvgOacUY3guJ5KmNhnpQRkFTOZCfy/tmhV8bbjqJiclQhj
	 SC1XGqj06Ku8i6PsH5njvx0HK+Yu8/Q9ReziiQZqYsM5BxljLw3h9tcqeRqd2tfVkvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=0pUXMSbC;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2108606A335
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2108606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=0pUXMSbC
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so39296215e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795625950; x=1796230750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mdld0D1yE/J63qgOC2C+zzh5Ht1TFl4rC872bUAhPJw=;
        b=0pUXMSbC5zIqg3hDAPEVnOLtAPER96slmBibpm/1zkn105pCc+qDN3MRJS8fUf+arY
         dCQM8HY3lqBtIbmUAScYBEuGUIhVCMtrxG13L8GRxH5SwQxywRGQkMCyPrwOGDyd2Bio
         ejgei8bmvvp0vQ1xCWMKWCaxddyCXg1PYHa1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625950; x=1796230750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mdld0D1yE/J63qgOC2C+zzh5Ht1TFl4rC872bUAhPJw=;
        b=VWqd0fXKLrDZo/Yn12JkI9tErqIb6kz0pYmKbdCyv1brPbR3uZtVWRr7jEOOuC+fjn
         svt7H4tNbZy1DbR1Cxz7946kCQbIRyZ3kw1kRhWz3z9gaiGPaJmdsLljPRZBLekCUThd
         Oy3pXQ9V41sZ10EpD4n3iZy20mN1ZuUTUCVc8t8CKexIRnoz05Basps85l4VaFm0wW8G
         1G4jZIjORyBI7ttRXNIeUNOqp4yOJhUZYKBc1L8uaAe0uye1Myjtk+2hIepiKhhLonQ8
         CNYSNXOT4SykA+XxPi2gAaMnX60IJT+zCRvRZmSV7RS2DXi+yKDUL+NQZZ/1kE1Ypoxs
         +dnw==
X-Gm-Message-State: APuU4Z8/TH62LoeSkn7gM4eepfuQQkUe+dZewbxQnNpCEuZ3ePKad0Dx
	pGrNajJkjp5fSYvkEivTECFgTR3L8fzCTyOKDsos5e0rCVvO63FpDhTNjKkJBK53al1sbrEcl7h
	h1Hna
X-Gm-Gg: AZFdTZe+k06m4Hr+q+vvmGadfLZaXxm2kIKCp38aBdK0F70PSsk+dJpnPVcQi6nmuWr
	nqlbh+TJo7BoMbmIS39EBPRzCkWt9jxA8XVwB9boNpgaZQaFAGgBfLIw6oesb185GQohbKzXR+B
	0F1FbLm0Livsed6lzTInRqZoa2IdLAPKACIOIFB3WI+k1DVn6wT6vFE+uO4N3J/wn9b4Xxhql5g
	q+LLmsfhC4k37YYnvWEdCAUsh02a/jgaqptgCkVRlb6KG9hNn6WoSi/ej70AYTMAWLOa84kUoTU
	sU4h2SdV3RRLJWuaj/zIylcubuDC37FZSKtosJf690Rdhrm5LiM7Lw0OlVZnvEQnvC76bLzBzfE
	VjAM3sSqrmW5eSrfmCG73FOoZKuYqPHnf16AnfeoYwQ//UEjQsTTDA4Yb3v9ZYkNG95yk7iL7l2
	SmgSDzEsQ3U3lal/edZricKMs7+JZBYF7NOmfst7MozYRw8a6+Ycvb+gyPE1Hvlsl5LibR8gk3v
	J7tEl7sElI8RfiW3yze57i/G86rvNhYlp+wQZa7jbW1AUKb7He80jsB34hMFAHQfSBqVp+inD3m
	GLHSePZ1cwQoEumoEMNqSx8BkRBYQLqFCiCqYO+HxuZTW5k1Dg==
X-Received: by 2002:a05:600c:1548:b0:4a1:e00b:a10b with SMTP id 5b1f17b1804b1-4bb88800020mr403230685e9.7.1795625950169;
        Wed, 25 Nov 2026 08:59:10 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm754943945e9.13.2026.11.25.08.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:59:09 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 4/8] device: Don't resolve services on GATT over BR/EDR
Date: Wed, 25 Nov 2026 17:59:02 +0100
Message-ID: <20261125165906.1645581-5-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125165906.1645581-1-simon.mikuda@streamunlimited.com>
References: <20261125165906.1645581-1-simon.mikuda@streamunlimited.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When GATT discovery over BR/EDR completes, gatt_client_ready_cb() calls
device_svc_resolved() for device->bdaddr_type. For a BR/EDR device this
marks the bearer resolved and runs the device_wait_for_svc_complete()
callbacks while SDP may still be running, so they find none of the
device's profiles. For a device with an LE address type it resolves the
LE bearer instead. iOS opens ATT over BR/EDR right after pairing.

Over BR/EDR, leave resolving the services to SDP.

Fixes: 4b5bb941c380 ("core/device: Use shared/gatt-client for GATT")
Assisted-by: Claude:claude-opus-5-5
---
 src/device.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index be3267368..7a85403f0 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6423,12 +6423,15 @@ static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
 								void *user_data)
 {
 	struct btd_device *device = user_data;
+	bool bredr = bt_att_get_link_type(device->att) == BT_ATT_BREDR;
 
 	DBG("status: %s, error: %u", success ? "success" : "failed", att_ecode);
 
+	/* Over BR/EDR, SDP resolves the services of the bearer */
 	if (!success) {
-		device_svc_resolved(device, BROWSE_GATT, device->bdaddr_type,
-									-EIO);
+		if (!bredr)
+			device_svc_resolved(device, BROWSE_GATT,
+						device->bdaddr_type, -EIO);
 		return;
 	}
 
@@ -6436,7 +6439,9 @@ static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
 
 	btd_gatt_client_ready(device->client_dbus);
 
-	device_svc_resolved(device, BROWSE_GATT, device->bdaddr_type, 0);
+	if (!bredr)
+		device_svc_resolved(device, BROWSE_GATT, device->bdaddr_type,
+									0);
 
 	store_gatt_db(device);
 }
-- 
2.43.0

