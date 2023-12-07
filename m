Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixneQ+k+"
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068F7D4B
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Dec 2023 22:19:20 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9e1021dbd28so63244666b.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Dec 2023 22:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701929958; x=1702534758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QfqKIRQu6rjKFO4WkAMHCp+409DJOMDz3Ddv2QbrLPo=;
        b=ixneQ+k+qvowoTNvmKYd7DUsTtpcG7rn8eUqy76CIxu6nEvkc1GEUF0Dv/mNgSBiKe
         k02mbvHJk14RXmcKA4ghYX3YQSYSvyjcDDstnSnbLKIDCePonCpI16OLjMFBO5P70ZsD
         pkoK/K+VbQ/qBR5kDIBuowkS56rEYSXf+5tbXiiXcd/vKeKp0vlOlwx/TodBUMUdyZKn
         t6fHKM9CE3Z15szHFW1mBCKrYhGwwaTOEuPL+ASiSW4Jow0VgqhsoIvEs6b9vClJohbR
         fSSyUSB7vk6dMzOEVeHI5+CTTeQ1VpuhcISgQ4QpCBRPsHOuHhReiaEgFxz2fpTG+O1i
         dH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701929958; x=1702534758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QfqKIRQu6rjKFO4WkAMHCp+409DJOMDz3Ddv2QbrLPo=;
        b=Z/yf3zpTqlnvknX3hcZZeoQTIXXk0ITnQnwmUN/lRV+FlyULgoBM+ZFLt/gGcpDlL/
         UPS8a9p3tcudiLGOvT20tdIX+DWkUF7c31F1vo6zncoXnLyhV1fa5i42/Z5j526e4RBa
         Iust2qfCLXxUqvEc14FZutBc9QNPIQy9DthsfTrMTxRMULC+/1U0Spfsr1ies1H6T4m0
         MT5Joo6PGDTYLBtla0SDFaV2Qh+Y2+GBlBEEmFasxX+13JPpI2Ir26lwDPRY9Peq8ADN
         qFc0hF5RNFNTIMloIhY7QII9Knf2dWE0m4fIAttc/FSVFsNS2MfAO/q4ApWSAH4v/SdC
         dSUA==
X-Gm-Message-State: AOJu0YznYf5d/Ly5QL0meop2o/h15F3FaEyoOwENFDmlZ4demPIpXKZ9
	dW4JK13HchdjKslS4Cu4Rt2YpH39yHC5Vb+O
X-Google-Smtp-Source: AGHT+IEfaDZGAu+fvrzzORs2TTUUvdaNtc8rUdSLBBT4Lar2KyM47Gs5Lbtnmt2LCFNy0xy+icWUFw==
X-Received: by 2002:a17:906:e8b:b0:a1d:7f40:bebe with SMTP id p11-20020a1709060e8b00b00a1d7f40bebemr1158475ejf.126.1701929958156;
        Wed, 06 Dec 2023 22:19:18 -0800 (PST)
Received: from localhost.localdomain (212-181-210-217-no600.tbcn.telia.com. [212.181.210.217])
        by smtp.gmail.com with ESMTPSA id q3-20020a1709066b0300b00a1c7f8fe581sm360740ejr.221.2023.12.06.22.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2023 22:19:17 -0800 (PST)
From: Sebastian Forslund <sebastian.david.forslund@gmail.com>
X-Google-Original-From: Sebastian Forslund <sebastif@axis.com>
To: sebastian.david.forslund@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: Sebastian Forslund <sebastif@axis.com>
Subject: [PATCH BlueZ v2] Pattern match on service- and manufacturer data
Date: Thu,  7 Dec 2023 07:19:00 +0100
Message-Id: <20231207061900.194-1-sebastif@axis.com>
X-Mailer: git-send-email 2.24.1.windows.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When advertisement monitoring, manufacturer data and service data was=0D
not being matched against. This made it so that advertisement monitoring=0D
with or_patterns did not work that type of data.=0D
=0D
We must start matching against the data in the manufacturer_data and=0D
service_data queues. Run a different match-function depending on the=0D
type of monitor that is being matched against.=0D
=0D
Closes: https://github.com/bluez/bluez/issues/652=0D
---=0D
=0D
v1->v2: Pattern match using queue_find() instead of queue_foreach() so=0D
        that iterations stop when a match is found. Shorten the name=0D
        of the match functions=0D
=0D
 src/shared/ad.c | 115 +++++++++++++++++++++++++++++++++++++++++++-----=0D
 1 file changed, 105 insertions(+), 10 deletions(-)=0D
=0D
diff --git a/src/shared/ad.c b/src/shared/ad.c=0D
index 951c56c60..2d6fc628e 100644=0D
--- a/src/shared/ad.c=0D
+++ b/src/shared/ad.c=0D
@@ -1324,36 +1324,110 @@ struct bt_ad_pattern *bt_ad_pattern_new(uint8_t ty=
pe, size_t offset, size_t len,=0D
 	return pattern;=0D
 }=0D
 =0D
-static void pattern_ad_data_match(void *data, void *user_data)=0D
+static bool match_manufacturer(const void *data, const void *user_data)=0D
 {=0D
-	struct bt_ad_data *ad_data =3D data;=0D
-	struct pattern_match_info *info =3D user_data;=0D
-	struct bt_ad_pattern *pattern;=0D
+	const struct bt_ad_manufacturer_data *manufacturer_data =3D data;=0D
+	const struct pattern_match_info *info =3D user_data;=0D
+	const struct bt_ad_pattern *pattern;=0D
+	uint8_t all_data[BT_AD_MAX_DATA_LEN];=0D
+=0D
+	if (!manufacturer_data || !info)=0D
+		return false;=0D
+=0D
+	if (info->matched_pattern)=0D
+		return false;=0D
+=0D
+	pattern =3D info->current_pattern;=0D
+=0D
+	if (!pattern || pattern->type !=3D BT_AD_MANUFACTURER_DATA)=0D
+		return false;=0D
+=0D
+	/* Take the manufacturer ID into account */=0D
+	if (manufacturer_data->len + 2 < pattern->offset + pattern->len)=0D
+		return false;=0D
+=0D
+	memcpy(&all_data[0], &manufacturer_data->manufacturer_id, 2);=0D
+	memcpy(&all_data[2], manufacturer_data->data, manufacturer_data->len);=0D
+=0D
+	if (!memcmp(all_data + pattern->offset, pattern->data,=0D
+							pattern->len)) {=0D
+		return true;=0D
+	}=0D
+=0D
+	return false;=0D
+}=0D
+=0D
+static bool match_service(const void *data, const void *user_data)=0D
+{=0D
+	const struct bt_ad_service_data *service_data =3D data;=0D
+	const struct pattern_match_info *info =3D user_data;=0D
+	const struct bt_ad_pattern *pattern;=0D
+=0D
+	if (!service_data || !info)=0D
+		return false;=0D
+=0D
+	if (info->matched_pattern)=0D
+		return false;=0D
+=0D
+	pattern =3D info->current_pattern;=0D
+=0D
+	if (!pattern)=0D
+		return false;=0D
+=0D
+	switch (pattern->type) {=0D
+	case BT_AD_SERVICE_DATA16:=0D
+	case BT_AD_SERVICE_DATA32:=0D
+	case BT_AD_SERVICE_DATA128:=0D
+		break;=0D
+	default:=0D
+		return false;=0D
+	}=0D
+=0D
+	if (service_data->len < pattern->offset + pattern->len)=0D
+		return false;=0D
+=0D
+	if (!memcmp(service_data->data + pattern->offset, pattern->data,=0D
+							pattern->len)) {=0D
+		return true;=0D
+	}=0D
+=0D
+	return false;=0D
+}=0D
+=0D
+static bool match_ad_data(const void *data, const void *user_data)=0D
+{=0D
+	const struct bt_ad_data *ad_data =3D data;=0D
+	const struct pattern_match_info *info =3D user_data;=0D
+	const struct bt_ad_pattern *pattern;=0D
 =0D
 	if (!ad_data || !info)=0D
-		return;=0D
+		return false;=0D
 =0D
 	if (info->matched_pattern)=0D
-		return;=0D
+		return false;=0D
 =0D
 	pattern =3D info->current_pattern;=0D
 =0D
 	if (!pattern || ad_data->type !=3D pattern->type)=0D
-		return;=0D
+		return false;=0D
 =0D
 	if (ad_data->len < pattern->offset + pattern->len)=0D
-		return;=0D
+		return false;=0D
 =0D
 	if (!memcmp(ad_data->data + pattern->offset, pattern->data,=0D
 								pattern->len)) {=0D
-		info->matched_pattern =3D pattern;=0D
+		return true;=0D
 	}=0D
+=0D
+	return false;=0D
 }=0D
 =0D
 static void pattern_match(void *data, void *user_data)=0D
 {=0D
 	struct bt_ad_pattern *pattern =3D data;=0D
 	struct pattern_match_info *info =3D user_data;=0D
+	struct bt_ad *ad;=0D
+	void *matched =3D NULL;=0D
 =0D
 	if (!pattern || !info)=0D
 		return;=0D
@@ -1362,8 +1436,29 @@ static void pattern_match(void *data, void *user_dat=
a)=0D
 		return;=0D
 =0D
 	info->current_pattern =3D pattern;=0D
+	ad =3D info->ad;=0D
+=0D
+	if (!ad)=0D
+		return;=0D
+=0D
+	switch (pattern->type) {=0D
+	case BT_AD_MANUFACTURER_DATA:=0D
+		matched =3D queue_find(ad->manufacturer_data, match_manufacturer,=0D
+				user_data);=0D
+		break;=0D
+	case BT_AD_SERVICE_DATA16:=0D
+	case BT_AD_SERVICE_DATA32:=0D
+	case BT_AD_SERVICE_DATA128:=0D
+		matched =3D queue_find(ad->service_data, match_service,=0D
+				user_data);=0D
+		break;=0D
+	default:=0D
+		matched =3D queue_find(ad->data, match_ad_data, user_data);=0D
+		break;=0D
+	}=0D
 =0D
-	bt_ad_foreach_data(info->ad, pattern_ad_data_match, info);=0D
+	if (matched)=0D
+		info->matched_pattern =3D info->current_pattern;=0D
 }=0D
 =0D
 struct bt_ad_pattern *bt_ad_pattern_match(struct bt_ad *ad,=0D
-- =0D
2.39.2=0D
=0D
