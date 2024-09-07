Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE79166F0C
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Sep 2024 20:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725742193; cv=none; b=hDms+50pTKSGCHmp5hVfgTcNRY31n3MT/FzGeOOdXff11uAVowbqVcbJvG/Kj4WhSXFXBBryT8BNakEW8e/37YdtarM44WYZdCyKxilo5lYHAkioY6aErjHCCoxJ7+tboj8L3tJxm0CDYSo85xIEShIbkk5SVKK0j4dXMywlNZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725742193; c=relaxed/simple;
	bh=F7RRfgvr8DE4+z/p31uILT00fnTp8gu/QZvApCeJKwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PZ6XmEi9lkGTb0cBxQYGzDoot8MBy/3J07Xvl1HlrAx0JIFJ7o0ocT6zrbObVwMlU++G1naOKK+gSx0lbTu9Th0Niinhe48YtttsaunKhmmpRGXmSvcDVXRTx9f8QVNEARBXcR8LTy5bUrI5Isl4oDGqQOeQCJ141ZrHTxzy2Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzGoG0Fn; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzGoG0Fn"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-374c7e64b60so1746628f8f.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Sep 2024 13:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725742190; x=1726346990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bpvdD76SgdEUjB7HbU4UN48WgtwMtCq3ktG5BLJX0n8=;
        b=IzGoG0FnbS0HrjprE3HNKpBTiQdB0muy2vayGTLfJYg3YFtmBx+MeZl8nZXwZ3T1uX
         xqLFy5ibtyuHsKkPvv1Oj74mU7kt5EeMt1LyGGF6Q/3eBmDgw8TgsLniwehRgTDjVpbw
         VY8DbkZYk9IXCzzazIBawX5KMWBnOydZssDXgOdJt04Dn8vWcVcUonHkRh3kPM1wO8lf
         aWqj9OVCMdxJF7OqU2c30r+bqBErvdgf1DWShxE/f5TpORqQ1N08Gsd3rQHIdKnFq5nG
         eskEEH0IeGI7zywsQKN3o1tAV3UtiMqKpK4U4hNWNJvXe9NDdpuIiOLSKRPJFLx7bNL5
         Vsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725742190; x=1726346990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpvdD76SgdEUjB7HbU4UN48WgtwMtCq3ktG5BLJX0n8=;
        b=C8+CVeMZY9hyr83AoJi03NTMHIClnK5HyyztikrhEdF2FxRejI30LJZAnOWB2bDBdY
         nLbRxB1ywblsZLlC6+Rptd1m4pan7x4JoB5L4ZgYIDWshvBgVzMw0g3nX+B23//uneHz
         0mHBG82Kl3rYXX71tcxB701WZbp7DmuaFs0cdknQiq8CPZGkQOKYUzyAr1WnyVJXXlHv
         exDvGRLqTTKjKrIFZ/f5H42vL9Yq6k74Hwjix9WvocDoAmI9eJ6HScxjlAwmuCdHW1NN
         0F0lAR9uNyP+y6k6g8uIDTnMSGFS/ZgtRrDtfudBaME+43ovCCzCd1N2dhvUHziNSJXf
         s1Aw==
X-Gm-Message-State: AOJu0YzvdVekDFg4pLV2HBM3jUCnHw+/xolqPzzpbO9khoFgzCQW50dd
	Y+P+QuDtMWGWaoqY+CtwsO55pn0AAjE4XZVdUGDKSYfDS/qfXjCw3R9Nuw==
X-Google-Smtp-Source: AGHT+IG3+++ZD32lk1WmXWVEVxSNDc8Lde6me1P+b+xb3z9w8CoFfxan6TSwzPbzjcl+KdKmHB7hSQ==
X-Received: by 2002:adf:ffc9:0:b0:374:badf:966f with SMTP id ffacd0b85a97d-378895c4b83mr4485459f8f.7.1725742189421;
        Sat, 07 Sep 2024 13:49:49 -0700 (PDT)
Received: from vibhavp-an515-58.lan ([2401:4900:1c62:13d2:d7f9:63c9:9aab:1368])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956dd9dcsm2053698f8f.92.2024.09.07.13.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 13:49:48 -0700 (PDT)
From: Your Name <vibhavp@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vibhav Pant <vibhavp@gmail.com>
Subject: [PATCH BlueZ 1/2]  device: Add ConnectionType property.
Date: Sun,  8 Sep 2024 02:19:40 +0530
Message-ID: <20240907204941.8006-1-vibhavp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vibhav Pant <vibhavp@gmail.com>

---
 src/device.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/src/device.c b/src/device.c
index 0f18c8c7f..fa149f1d4 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1003,6 +1003,32 @@ static gboolean dev_property_exists_class(const GDBusPropertyTable *property,
 	return device->class != 0;
 }
 
+static gboolean
+dev_property_get_connection_type(const GDBusPropertyTable *property,
+				 DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	const char *str;
+
+	if (device->le && device->bredr)
+		str = "dual";
+	else if (device->le)
+		str = "le";
+	else
+		str = "bredr";
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &str);
+	return TRUE;
+}
+
+static gboolean
+dev_property_exists_connection_type(const GDBusPropertyTable *property,
+				    void *data)
+{
+	struct btd_device *device = data;
+
+	return device->bredr || device->le;
+}
+
 static gboolean dev_property_get_class(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -3234,6 +3260,8 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "Alias", "s", dev_property_get_alias, dev_property_set_alias },
 	{ "Class", "u", dev_property_get_class, NULL,
 					dev_property_exists_class },
+	{ "ConnectionType", "s", dev_property_get_connection_type, NULL,
+					dev_property_exists_connection_type },
 	{ "Appearance", "q", dev_property_get_appearance, NULL,
 					dev_property_exists_appearance },
 	{ "Icon", "s", dev_property_get_icon, NULL,
-- 
2.46.0

