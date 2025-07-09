Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DF123B623;
	Wed,  9 Jul 2025 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048220; cv=none; b=ASKEst+ayalGLmNr9pJOT4qdgWoUad3xFiqWj5aUqLssNXvhd5fZ1d32IvVg11Es5hZZ26tBOjt3BX9OCNDdTdn3xuztUTNx8cjtRrRqYEVHQWDy0qVTJcVtoJD7Pb0ofcRrETS+uGKVnlXjBLKQklRXNNiZNj6RNhw2X/85TwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048220; c=relaxed/simple;
	bh=ZbJuY2w6S0ZKOiudl4xFyZaJbCfeyjoKCSSFafM4XUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xlh/JDjrmRWbBFOd1byirZDvIJ0FSDb9rELXunxk53IV9/qgri/KwqnT26vIrBZQqUqmOhcx0qZmZXfPeIhoq1IDLg0xpSe5X7kFAoUJCYAH6lWjenoW9JllQZKbH92TVeMcMdVeARu3xtiwDHD80DuFAFc8ndcAPDd96VIhIwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/iS1FwI; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/iS1FwI"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so884719666b.2;
        Wed, 09 Jul 2025 01:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752048217; x=1752653017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gjyXahBwtFgBsa3qFScKvEvg+HQpdIyBIDTLSsuZUbQ=;
        b=U/iS1FwIPZHdprSlXapmKGzauNBiazxjrnCc5VcoEEbyXDvkHFa8qZCZ/8IqaMtDgE
         mpqIwWNTexiPG4HP/ggIhbh1dTeUQBTTA7d/bvlG7yFXk7l/JUzbK9MqN/AkNA0BeFpZ
         vW7xP9ZMc2labn27kQvKeLBdDIjulcnTn7bzkOOiinkj8FRnCvLlWnZpCjPaE0TsUFNb
         81TW1bJYj7i4vcTwmL+3GfBYeiqbuaI9rNDyEgRW3y5Dyzk9qw374ytioMs2Ig/peQXH
         Qx8qvvj1d5egx2cijJObw88CFdAdA5EiEKf0MyUxPVrQnGv6FTJgUekmJ9sK86wyCMDB
         hpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048217; x=1752653017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjyXahBwtFgBsa3qFScKvEvg+HQpdIyBIDTLSsuZUbQ=;
        b=f8qF3jAu7jJVRqj9q52vztlSTJaFJ1RkRGbLvbd+VsNTpzggfN16/JmxEFFqvEsPOA
         3+KJ+DYd7OOBJ3hVAwsqoBmPMqaI4ZT+Ne5bdgvnYEXoo9fDdl3zWCfdYLny9xKQbxY0
         bNwICFG9hw22y+CWQImlGwPqcb1k47eeRQb1lQl/UnEQMIiYDzeM5EOQr6IfE54QYWKc
         i812xY6FV4wVjoXNLZniOshFWxAChXLL750W/SiaZhcHPYkePZSvvi7PIp103nJ8+tEO
         0qtywiC3LwbqvkL6UwnnNNVeeJjO3PX1XXoQ0ckMI0G6DeYhccaGgcOCfHgsl0tPXI3T
         TIiw==
X-Forwarded-Encrypted: i=1; AJvYcCWAse0HdXseaIBNonOiReIsOT10FaA/wh3468tUtRhx/D6D/NLIqV05XQpmbe3ndBxmCleDkVhBIqGEDMr8@vger.kernel.org, AJvYcCWGbX4HIHZ14JMwAWkVBwe9nviXxhvXm8tdID0aauuxIF75GlrD0liIBScPcTv0y6c2oAGMof0+wAx7u+FZFsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcQxxeuX+Hq43cKYXa5LmC3QBlUTIP6OPIkIw1OgQgQPqgCqL5
	IUHuRmyj4o+sSompb5AULOe9BYvx9lVIEeKFxb9ZJ/tv++ZFQubiz4Ar
X-Gm-Gg: ASbGncvNLRajggoTX6WGuENIU4sxzOygVn4Gl0+IydxcWbjlOV22wjM7iCSUrGsxtPt
	CDiEZu7zfVUA8S6bELrMeQjL4rHFVxYlcl75V3Qkr5pQg06vJe4kEZd/43Yg1i4u9s84Oa9gzHN
	RUxCqHiS5JEQ7PYEnQY5/XVSu5rcxO3dQkJcFoDKm/HVni9RLLqRXviwI7++6zgftSQXToXYRPc
	iTFTf8jTjdD0YyduYYMyxxJSvU16a13U/jGKpvpkEP6Gsp30A/24UurMhIpV6hszvRq1DyMTMMA
	2wjyhy01tpqeCPSL+PF5Rm1zSHupW/WRlD3yNbuVNACBSXlyefKsMPNWCZ1felGY6Q==
X-Google-Smtp-Source: AGHT+IG03JDNE8K/VgQg/FWOJp812SfmaFM9YLa63SOGdEP1vIQZPct/+H/iLfa9Mg54rCVetO34EA==
X-Received: by 2002:a17:907:c283:b0:ae0:db23:e3e3 with SMTP id a640c23a62f3a-ae6cf5c0132mr169437966b.16.1752048216939;
        Wed, 09 Jul 2025 01:03:36 -0700 (PDT)
Received: from yavin ([2001:b07:6474:515f:faac:65ff:fe6a:e677])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b02794sm1054330666b.110.2025.07.09.01.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 01:03:36 -0700 (PDT)
From: Alessandro Gasbarroni <alex.gasbarroni@gmail.com>
To: marcel@holtmann.org
Cc: johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alessandro Gasbarroni <alex.gasbarroni@gmail.com>
Subject: [PATCH v2] Bluetooth: hci_sync: fix connectable extended advertising when using static random address
Date: Wed,  9 Jul 2025 09:53:11 +0200
Message-ID: <20250709080213.6097-1-alex.gasbarroni@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the connectable flag used by the setup of an extended
advertising instance drives whether we require privacy when trying to pass
a random address to the advertising parameters (Own Address).
If privacy is not required, then it automatically falls back to using the
controller's public address. This can cause problems when using controllers
that do not have a public address set, but instead use a static random
address.

e.g. Assume a BLE controller that does not have a public address set.
The controller upon powering is set with a random static address by default
by the kernel.

	< HCI Command: LE Set Random Address (0x08|0x0005) plen 6
        	Address: E4:AF:26:D8:3E:3A (Static)
	> HCI Event: Command Complete (0x0e) plen 4
	      LE Set Random Address (0x08|0x0005) ncmd 1
	        Status: Success (0x00)

Setting non-connectable extended advertisement parameters in bluetoothctl
mgmt

	add-ext-adv-params -r 0x801 -x 0x802 -P 2M -g 1

correctly sets Own address type as Random

	< HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036)
	plen 25
		...
	    Own address type: Random (0x01)

Setting connectable extended advertisement parameters in bluetoothctl mgmt

	add-ext-adv-params -r 0x801 -x 0x802 -P 2M -g -c 1

mistakenly sets Own address type to Public (which causes to use Public
Address 00:00:00:00:00:00)

	< HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036)
	plen 25
		...
	    Own address type: Public (0x00)

This causes either the controller to emit an Invalid Parameters error or to
mishandle the advertising.

This patch makes sure that we use the already set static random address
when requesting a connectable extended advertising when we don't require
privacy and our public address is not set (00:00:00:00:00:00).

Signed-off-by: Alessandro Gasbarroni <alex.gasbarroni@gmail.com>
---
V1 -> V2: Addressed review comment by reusing pre-exising function

 net/bluetooth/hci_sync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 77b3691f3423..a01455708e4c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6815,8 +6815,8 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 		return 0;
 	}
 
-	/* No privacy so use a public address. */
-	*own_addr_type = ADDR_LE_DEV_PUBLIC;
+	/* No privacy, use the current address */
+	hci_copy_identity_address(hdev, rand_addr, own_addr_type);
 
 	return 0;
 }
-- 
2.50.0

