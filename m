Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB4B823B1
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036672; cv=none; b=qX7mPdBGgGyQh/JBf79njIVeQXVOg33x70O1Rrnx70cXI/030PZ++YD0kMJNEXIiqi4tTB3Z87p5KpagbICureeKqabuGZ1Uo1N77Akc3JjQTjTOQxf+u4M7j6kQ91GdRsRq2Xmg2jV7ZQSYLHS+AeV90KhdgLzPPkKbGP0bCq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036672; c=relaxed/simple;
	bh=UGCahzL9j8E6/1+8rATyqx+OYs9FSUt+sPq4nBsIyu8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iI3wvwBKNdn/XMqwrHtnrw3EuV89PheKcCVL8UpPkkQIlv3MVtdvz/joGGGMAOPEiPjMgOyM6/B+2Q2XMzQyo4Qmz+nwH5OtoxU8G1abWtIU65O2cSYCRhmlFu7JH799y/2pOmnyVfZCFTaEMwwzKsrzXkNtekGFi3rsO/Zw3gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfCYrKAQ; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfCYrKAQ"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso2828921276.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 11:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706036669; x=1706641469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FvMoAzW48uPpe4rLWhtOHNstnjZwdQrZbl8AaLzm+G4=;
        b=RfCYrKAQegZjb9AqJEY2wvsuXqEMWoujGS6kTbQL5GY69XK1YNL93TcvF+Frur6Bfa
         S/LXi71c4WPtCcRDN1NG9FTgLKq0CIqfJPypgHitnnON0akZvQEgFOvsmLQG8+kCNALw
         inNBS7T29/h22VlNXiPkc/eG62EsurdSSB1O27ApXQ4X02rFviLjzcoyY+BhxMUYr0k+
         btZUEPa/WpUvYNP2r764p+2eqZo/NUd3SNDS1DYwk22Sy2WqREsaOzP7XrYZSKIQF5cU
         lUA5V/tuR+w9c16nQmTULYU3IOrAUnC5b3/q7v61LYyScJg2cm+OYCxssvQh9UmaZdR+
         gPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036669; x=1706641469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FvMoAzW48uPpe4rLWhtOHNstnjZwdQrZbl8AaLzm+G4=;
        b=FBZEsuK2JRJk/hJXvNCKbIlouHOdABrcpukzo7IE64TtPMbEerZuqJBJZywLoqhuc8
         zbLi5/ioacYkCXwhhWox69z4EhME5OkhsrUyTNWM1DLZ8zXfEwpsDXLKDIXVG/q9NCMp
         O1KCWq/JDwWMHqf5MjJIOwLUsr+9AiWyKS/9/0lmOthsgWJ3ln7FjRUZtnAPzj3YaWWr
         vIQSYBv1uZ+Z5rvagZe+C79kxCjpp8t7xuTE4JLWPdCKJJZQSpHVP6Y2lwPF26zF4qIt
         1rKb2d6HGjb2/IJ5j4Y11IjsUBZoh3me7wmOybRegllemXB4p/p7wZ5b/yAvxyN+61RK
         7l9A==
X-Gm-Message-State: AOJu0Yyp4ogyJdvzcapNO1rvwOh/VWxvtQDNAH9n2Poy8CLsmHdlkJkL
	qs5V0SRWEo6cV9PMqNh/Tl799PLe5d8c/btHI2kIRtSMo9CSQjtupB2mPFB4
X-Google-Smtp-Source: AGHT+IGx8HmIvYr6hNFvZgARcYazLIjShqqgXyyDfjmWqEAqW/GrWWEBWKimVS9QXThGJ+yAzTKb/w==
X-Received: by 2002:a81:53c3:0:b0:5ff:32a7:a31a with SMTP id h186-20020a8153c3000000b005ff32a7a31amr3325971ywb.84.1706036669181;
        Tue, 23 Jan 2024 11:04:29 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id x70-20020a81a049000000b005ff5fc95e2esm5590109ywg.142.2024.01.23.11.04.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 11:04:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] bap: Add missing Metadata property
Date: Tue, 23 Jan 2024 14:04:26 -0500
Message-ID: <20240123190427.3031698-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds missing Metadata property to MediaEndpoint objects.
---
 profiles/audio/bap.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 63bdbb52a53c..6184c9d178a8 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -255,6 +255,39 @@ static gboolean get_capabilities(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean has_metadata(const GDBusPropertyTable *property, void *data)
+{
+	struct bap_ep *ep = data;
+	struct iovec *d = NULL;
+
+	bt_bap_pac_get_codec(ep->rpac, NULL, NULL, &d);
+
+	if (d)
+		return TRUE;
+
+	return FALSE;
+}
+
+static gboolean get_metadata(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bap_ep *ep = data;
+	DBusMessageIter array;
+	struct iovec *d;
+
+	bt_bap_pac_get_codec(ep->rpac, NULL, NULL, &d);
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &array);
+
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+						&d->iov_base, d->iov_len);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
 static gboolean get_device(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -360,6 +393,8 @@ static const GDBusPropertyTable ep_properties[] = {
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Capabilities", "ay", get_capabilities, NULL, has_capabilities,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Metadata", "ay", get_metadata, NULL, has_metadata,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Device", "o", get_device, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Locations", "u", get_locations, NULL, NULL,
-- 
2.43.0

