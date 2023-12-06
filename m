Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktdjnBQB"
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C925DF7
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Dec 2023 13:25:18 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54bf9a54fe3so314728a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Dec 2023 13:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701897917; x=1702502717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QfqKIRQu6rjKFO4WkAMHCp+409DJOMDz3Ddv2QbrLPo=;
        b=ktdjnBQBev0XAWiIr4vd50t90BoOHVVDDewa/cW4YVUpUFpzCKyqCrWA0/0BdF6mU1
         kumH64LmztDuLSGVxF7OJ2BxzN7mWhfZZ0OZv/nXJVRA7i68QHGbK7yj/7In09FurZKO
         DqP2mfJ+TgH4VRUobMYvcS7YMonRtjuYB1aYA2NhSFhQsrRgfSskaF/kHLhClbFJBGaF
         ufNivtgeetPa4bhymaJs40p55b170TVegSNGqIbTPwV8A4mv/OyiboHrojMc+Rcyl1zH
         /6DPGFh7fzk3D/4MUvgbF6VEwpFP/40LYAX9hLyA6V8HXzM5yO1YMLvOhDdv3ptpQrM2
         JJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701897917; x=1702502717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QfqKIRQu6rjKFO4WkAMHCp+409DJOMDz3Ddv2QbrLPo=;
        b=UJ/KaK6ljUdFsDuS8CZSaSZNDvhUJkGWz5o6zG24E4Afn8TanVnoPXujtxlziXKGnA
         rdZuIY0CqNOnrPUIw1EJrIxZmOiYNd26I0HdYjMOHAHDJlM2F/HCJLsdzNFojTeFiSZc
         2LrRk+0+p1p+Q5/y4WmsnEaB7Wg9+9llYhromthaNKeBR5LGc/7mvl1wNti1+qG1IEnV
         kJcfsqX6k1zHXYkDx6Qu48JC8owcEnrzmv3bV0v9ia6vf3SM1zLBRydjta5RlAU3YfE7
         /xUsJF9krgHBCR0gCYLu58aByKCnmU05zkhgB1EL6xDztv8XteVzuEIO2GrbTSZZx8X6
         ksGA==
X-Gm-Message-State: AOJu0Yy9gL6I3XaGW49SbOO0TVTLGZ4xaRGOcu3w1yVK5mRo9zxCKvMm
	SFV1ndsZ67KrsjoBiwF6TYM=
X-Google-Smtp-Source: AGHT+IG6SzXYwaARZFEvonFbpxhi5T9KgWjw8w1O+UnnMR5BuRPeayzJ9aAJyEtri3MH/A5dMXVYiA==
X-Received: by 2002:a50:9357:0:b0:54c:4837:9a92 with SMTP id n23-20020a509357000000b0054c48379a92mr973330eda.57.1701897917060;
        Wed, 06 Dec 2023 13:25:17 -0800 (PST)
Received: from localhost.localdomain (212-181-210-217-no600.tbcn.telia.com. [212.181.210.217])
        by smtp.gmail.com with ESMTPSA id ca20-20020aa7cd74000000b0054cac2a0715sm383039edb.93.2023.12.06.13.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2023 13:25:16 -0800 (PST)
From: Sebastian Forslund <sebastian.david.forslund@gmail.com>
X-Google-Original-From: Sebastian Forslund <sebastif@axis.com>
To: sebastian.david.forslund@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: Sebastian Forslund <sebastif@axis.com>
Subject: [PATCH BlueZ v2] Pattern match on service- and manufacturer data
Date: Wed,  6 Dec 2023 22:24:57 +0100
Message-Id: <20231206212457.275-1-sebastif@axis.com>
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
