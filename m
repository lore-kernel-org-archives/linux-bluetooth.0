Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbs3U1fx"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B474FC4
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Nov 2023 11:57:59 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50bc36725bbso1942008e87.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Nov 2023 11:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701374278; x=1701979078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mRHn7roAGlLrELW/CgS9/3XIZ2n0xJCNo3eMlBEE+x4=;
        b=dbs3U1fxdYsNhG0cdk3cUWCveohpnSf/vbzQ9ebFOVJHeW/kf/+wE4/b16I+ONUz2V
         K1aC0lAEGWk93t5tEc5MV0QQRwiYoM6yKFgIbJRqd1/98GPZyjUdilp0lAWzxbJMScCz
         FRR/5AAVbn2fb/370yRfGHR8lqrUClsoV4ig4J6UZxG4VCJcEIIw2+3u3cxHv034Tlu3
         oq5UGV4YySskJiUQaiFpSqP0oQI/CDqFZ7H1bqapCFVuQzcmvNM36OXvznhQkm3ZTZvh
         k/xLhJ6QtdBgoGVnTOGq77U5++BP45DdE96bMWb1+nPaAZNCGiZgzKmdz2wTMMZZQzgd
         VzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701374278; x=1701979078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRHn7roAGlLrELW/CgS9/3XIZ2n0xJCNo3eMlBEE+x4=;
        b=Hz17CfwpwXZLFbMepNfPJSc5idmtJJP1q9Xr8JXc2XDf0YTs0G6CEzTEhntPiDICHX
         2kGtJGGAq7r49h/Ts1MNyF6NvHSqIJEpr/Q++ld7nAilwi9sBqqMAxqnoTkMuvGLYmE5
         YQvlZ6Gk7GSwftRZgSINj+ugbkeQ2a2XH4ZAj0td/muNpNYsjlcM+MG+th30weLFQS0r
         tf7b7H4yuo0cKTl1d6PKJ2QCnOZnHe7nn7MkKjPP7pCQ/SdfoQi/luMts7xckNojlkWV
         EDcbQ6vyA9lslIOOJelBWFsf54spXcd2o0B3G48D+whX8bJaMooCyzRuU5w1qjNNfCYS
         NLQQ==
X-Gm-Message-State: AOJu0Yzx7hYX9EG1zZXIx7CTj0gz0nJRoEM5YAlwMc9mId9sRS7Ykkd7
	PqLg004azeIZegcAKjRvIk0=
X-Google-Smtp-Source: AGHT+IETEexIfME3Mp7y6FigpLUWktq9o/2300eU5xX0NYB1hwwZ2rvwTAfD3Uf6SQrXQrGIkuAhfQ==
X-Received: by 2002:a2e:8716:0:b0:2c9:be1d:5e96 with SMTP id m22-20020a2e8716000000b002c9be1d5e96mr50847lji.5.1701374277499;
        Thu, 30 Nov 2023 11:57:57 -0800 (PST)
Received: from localhost.localdomain (212-181-210-217-no600.tbcn.telia.com. [212.181.210.217])
        by smtp.gmail.com with ESMTPSA id lb7-20020a170907784700b00a178b965899sm1026888ejc.100.2023.11.30.11.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Nov 2023 11:57:56 -0800 (PST)
From: "sebastif@axis.com" <sebastian.david.forslund@gmail.com>
To: sebastian.david.forslund@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: Sebastian Forslund <sebastif@axis.com>
Subject: [PATCH BlueZ 1/1] Pattern match on service- and manufacturer data
Date: Thu, 30 Nov 2023 20:57:50 +0100
Message-Id: <20231130195750.1732-1-sebastif@axis.com>
X-Mailer: git-send-email 2.24.1.windows.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sebastian Forslund <sebastif@axis.com>=0D

When advertisement monitoring, manufacturer data and service data was=0D
not being matched against. This made it so that advertisement monitoring=0D
with or_patterns did not work that type of data.=0D
=0D
We must start matching against the data in the manufacturer_data and=0D
service_data queues. Run a different match-function depending on the=0D
type of monitor that is being matched against.=0D
=0D
Fixes: https://github.com/bluez/bluez/issues/652=0D
---=0D
 src/shared/ad.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++-=0D
 1 file changed, 80 insertions(+), 1 deletion(-)=0D
 mode change 100644 =3D> 100755 src/shared/ad.c=0D
=0D
diff --git a/src/shared/ad.c b/src/shared/ad.c=0D
old mode 100644=0D
new mode 100755=0D
index 951c56c60..a95079dc1=0D
--- a/src/shared/ad.c=0D
+++ b/src/shared/ad.c=0D
@@ -1324,6 +1324,72 @@ struct bt_ad_pattern *bt_ad_pattern_new(uint8_t type=
, size_t offset, size_t len,=0D
 	return pattern;=0D
 }=0D
 =0D
+static void pattern_manufacturer_data_match(void *data, void *user_data)=0D
+{=0D
+	struct bt_ad_manufacturer_data *manufacturer_data =3D data;=0D
+	struct pattern_match_info *info =3D user_data;=0D
+	struct bt_ad_pattern *pattern;=0D
+	uint8_t all_data[BT_AD_MAX_DATA_LEN];=0D
+=0D
+	if (!manufacturer_data || !info)=0D
+		return;=0D
+=0D
+	if (info->matched_pattern)=0D
+		return;=0D
+=0D
+	pattern =3D info->current_pattern;=0D
+=0D
+	if (!pattern || pattern->type !=3D BT_AD_MANUFACTURER_DATA)=0D
+		return;=0D
+=0D
+	/* Take the manufacturer ID into account */=0D
+	if (manufacturer_data->len + 2 < pattern->offset + pattern->len)=0D
+		return;=0D
+=0D
+	memcpy(&all_data[0], &manufacturer_data->manufacturer_id, 2);=0D
+	memcpy(&all_data[2], manufacturer_data->data, manufacturer_data->len);=0D
+=0D
+	if (!memcmp(all_data + pattern->offset, pattern->data,=0D
+							pattern->len)) {=0D
+		info->matched_pattern =3D pattern;=0D
+	}=0D
+}=0D
+=0D
+static void pattern_service_data_match(void *data, void *user_data)=0D
+{=0D
+	struct bt_ad_service_data *service_data =3D data;=0D
+	struct pattern_match_info *info =3D user_data;=0D
+	struct bt_ad_pattern *pattern;=0D
+=0D
+	if (!service_data || !info)=0D
+		return;=0D
+=0D
+	if (info->matched_pattern)=0D
+		return;=0D
+=0D
+	pattern =3D info->current_pattern;=0D
+=0D
+	if (!pattern)=0D
+		return;=0D
+=0D
+	switch (pattern->type) {=0D
+	case BT_AD_SERVICE_DATA16:=0D
+	case BT_AD_SERVICE_DATA32:=0D
+	case BT_AD_SERVICE_DATA128:=0D
+		break;=0D
+	default:=0D
+		return;=0D
+	}=0D
+=0D
+	if (service_data->len < pattern->offset + pattern->len)=0D
+		return;=0D
+=0D
+	if (!memcmp(service_data->data + pattern->offset, pattern->data,=0D
+							pattern->len)) {=0D
+		info->matched_pattern =3D pattern;=0D
+	}=0D
+}=0D
+=0D
 static void pattern_ad_data_match(void *data, void *user_data)=0D
 {=0D
 	struct bt_ad_data *ad_data =3D data;=0D
@@ -1363,7 +1429,20 @@ static void pattern_match(void *data, void *user_dat=
a)=0D
 =0D
 	info->current_pattern =3D pattern;=0D
 =0D
-	bt_ad_foreach_data(info->ad, pattern_ad_data_match, info);=0D
+	switch (pattern->type) {=0D
+	case BT_AD_MANUFACTURER_DATA:=0D
+		queue_foreach(info->ad->manufacturer_data, pattern_manufacturer_data_mat=
ch,=0D
+							info);=0D
+		break;=0D
+	case BT_AD_SERVICE_DATA16:=0D
+	case BT_AD_SERVICE_DATA32:=0D
+	case BT_AD_SERVICE_DATA128:=0D
+		queue_foreach(info->ad->service_data, pattern_service_data_match, info);=
=0D
+		break;=0D
+	default:=0D
+		bt_ad_foreach_data(info->ad, pattern_ad_data_match, info);=0D
+		break;=0D
+	}=0D
 }=0D
 =0D
 struct bt_ad_pattern *bt_ad_pattern_match(struct bt_ad *ad,=0D
-- =0D
2.39.2=0D
=0D
