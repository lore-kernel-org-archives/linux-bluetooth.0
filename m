Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC9B15C13F
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066288; cv=none; b=MsakyDwYlbC3KUlS9MmrER8G2LXO18o1vCN2rOGxq0RmKMCBgNLPAOxjNoqXRJho5CIUEWmDeewuVbwwoO7RRnQzjTdfHb9vhlSGHSP1O78bDFgG3uYpYL0xBXD9ST7IzNuhpDrFaEkdn1QRPOPyDjLX7XUX/SQvZS09x/NEqFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066288; c=relaxed/simple;
	bh=2tp5hsJygUIqTiw+g1uyzx4IVqCdmVgfMHKU5D1QNqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpAhIboR2Pga2GqhRiqGgo6FyNy4Vu5OamLwvDgigivDM7mayCba1qlW7k00WLpJ5cOdBn4uZjZI0vg+dGLxxnB5Yj6MW3IyyFZm/9h7ppHC9UTwa1XPSt/PQKIM6DMnxYR0TbK5GLeSAwWDCCALX/LDUhTed2NmEZr1t+84170=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPF5G8YO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPF5G8YO"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-374d29ad8a7so4443090f8f.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 07:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726066285; x=1726671085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpzyWQnslR584DCuyfWDdVfKtdiscMYgLxyWHUHTklI=;
        b=NPF5G8YOXcV/WQxiPwBovbmulRGM1jNwC2l5dpOr8eiq6s9mCkJQtZ3Cf3Aq+xCNEZ
         GMmmw6wXlCwvSYT+XPj1h4PXjCOXj6EIgyv9uNDYVMzS8VmrlQIbQXwNC1f0PTEwD90W
         BBioHXqBR9a8ibpitE2zb8OP56C3+zCiRV+/WC9vEX9Das5+KxiRGz4hNGv8P73jW86x
         FRXkUcnBSF0KoxZUhU+D4PnJFwqM5HY/3Dg2bjuBcn2KJ7BNDKx6FwwPKT0nsheYKim/
         1+VOVtiE4DZ+SVM6U2FjFNkypGSMoQt3OVCEoRkI7zpxy2LBGMcL1PngJ+EAHoyVD97v
         yx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726066285; x=1726671085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpzyWQnslR584DCuyfWDdVfKtdiscMYgLxyWHUHTklI=;
        b=LQCF6QJbpI5w0vxabBni2WlH7FfS4pvOSzpTVa7XyPZuO41ILVAtpPOzjp4Z0giOrl
         BIec2o+vBmRkaFIaa9JxPWH2ZTl0LTjQ9w0hbVAEQx6ZW0nhIbXPVb5fd7Yo3e7z9jBD
         iUZit7apCN+qvaYiyAvYPw9vDGGET540l3Sgnb94UctKpTesuvEYXZclLE4NgxIbIkEn
         ONQ7f5wiYihHx0zDGovNp6x69YjAiadaIL2BSIwL79V9KdgyKeMIYUsNtjmbWraS5C0M
         JNFT8pCtDKBDW07SByC1oozGqxNBKHSdjyYitMmO8G/jK8Z3oSSOShzg2qKAFzoaPEnk
         vNpw==
X-Gm-Message-State: AOJu0Yzl/p8ccIz5tLmHbCSxNL1i/iz23Frvwlq1J+jdq3+YgRW0sEX4
	HsDehx6Xba7TC/nnpRLv/pNq59Z9ar7laJye5ACR/wgqVgf/kuC7q4suHQ==
X-Google-Smtp-Source: AGHT+IFG2IAd2fJoKOkADFxyfbhZXYSx/JHBSueW6xQ1E4vX+Tx/88Fm0J6aX0i2I1gb9FEqfoxtMA==
X-Received: by 2002:a5d:424f:0:b0:377:6073:48df with SMTP id ffacd0b85a97d-3788969b01amr10231543f8f.58.1726066284907;
        Wed, 11 Sep 2024 07:51:24 -0700 (PDT)
Received: from vibhavp-an515-58.lan ([2401:4900:1c63:4161:2261:f710:6aeb:b934])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665517sm12081277f8f.36.2024.09.11.07.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:51:24 -0700 (PDT)
From: Vibhav Pant <vibhavp@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vibhav Pant <vibhavp@gmail.com>
Subject: [PATCH BlueZ 1/2] adapter: Add support for the Connectable property.
Date: Wed, 11 Sep 2024 20:21:13 +0530
Message-ID: <20240911145114.103340-2-vibhavp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911145114.103340-1-vibhavp@gmail.com>
References: <20240911145114.103340-1-vibhavp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To not break previous behavior, allow enabling the Discoverable
property even if Connectable is currently false.
---
 src/adapter.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index d6c058196..f5a876382 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3180,6 +3180,11 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 		param = &mode;
 		len = sizeof(mode);
 		break;
+	case MGMT_SETTING_CONNECTABLE:
+		opcode = MGMT_OP_SET_CONNECTABLE;
+		param = &mode;
+		len = sizeof(mode);
+		break;
 	default:
 		goto failed;
 	}
@@ -3576,6 +3581,24 @@ static gboolean property_get_version(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean property_get_connectable(const GDBusPropertyTable *property,
+					 DBusMessageIter *iter, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+
+	return property_get_mode(adapter, MGMT_SETTING_CONNECTABLE, iter);
+}
+
+static void property_set_connectable(const GDBusPropertyTable *property,
+				     DBusMessageIter *iter,
+				     GDBusPendingPropertySet id,
+				     void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+
+	property_set_mode(adapter, MGMT_SETTING_CONNECTABLE, iter, id);
+}
+
 static DBusMessage *remove_device(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -3917,6 +3940,8 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ "Name", "s", property_get_name },
 	{ "Alias", "s", property_get_alias, property_set_alias },
 	{ "Class", "u", property_get_class },
+	{ "Connectable", "b", property_get_connectable,
+					property_set_connectable },
 	{ "Powered", "b", property_get_powered, property_set_powered },
 	{ "PowerState", "s", property_get_power_state },
 	{ "Discoverable", "b", property_get_discoverable,
-- 
2.46.0

