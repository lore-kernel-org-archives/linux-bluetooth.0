Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6Z/hlAQ"
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF41DC
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 11:56:53 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50baa1ca01cso3260178e87.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 11:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701115011; x=1701719811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D1mSn1T21HuxV5S/YUOooxjYR8gCEKehobag3BUdW/g=;
        b=A6Z/hlAQIwMe1mKh7+HVhkrbV3xwhAQoWhs5GrGePm2wnhJcOzqOXZoJgxN4ExXN17
         uBIKXMT71KJejyApBS+VCwWTAS9afC02kG6Dg0OIm1++94BftPVOcuFwCqGBRh7j0byS
         aGXzt1cgqlnnSJCmNkvgOGGtba1OKli1iYPxZ/0Sj5OWfjw05Fd6Izy8sekf5WRIfq1V
         uKwLFoUqpI3Uq/35DNUoVgMTTpwpJp4vbL4R9o0vVt4gpIwFgXfH5r7G9ER+NDoyYUIC
         GM+3JbC3GPKVGYQFV1RQxZd1T59JpE3AW3NEF+Bat+m+thCe/vdxrsu5bkcdd6acTe47
         BNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701115011; x=1701719811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1mSn1T21HuxV5S/YUOooxjYR8gCEKehobag3BUdW/g=;
        b=T/jLnZxu+ei6CpBKil1tyW7HWslgFIYxdKMnvJNKO8yzyg4MDjAqm+baSLNjZxeJsW
         VHXv3g1yBq5fOOLuap72E7Rn8T2uZTqnnRFdDn/SCIE5C3nGcdr+hKxM70xYJ1NkAHWZ
         dudllzh+tqLndtUVj6+oWs/j6P1tTfLFZ1KDnie8ARH7B8D8drLY8fSPvYv9lvBs/Y7Q
         txzQN8oXcDG5QXlJg3WJg2uykRPtwoqjwK0lQRj9MNiBREisyZDImxtwxqePTVbrXXX8
         kArVeTqpob6ENNufCAD/ZOiiZrIDZpheuZ+1RBwuGivsjCWWERtOQKaFOscxG0VRNEDP
         X9kw==
X-Gm-Message-State: AOJu0YxWJ1aSV/ExQxjFRTuO6ejWlIfor6gTTxXLkfB6ZJ1cWpQzjXnK
	FC2+eMY1fWycLoIY7RYZHLaUiKbADq3dxKd7
X-Google-Smtp-Source: AGHT+IHeE6dq6E85CII0Q+rvhRlyG32jkZO7myy3Xqs49m5B1siThAXe5YcgsPBgBnirWwWo7/96VQ==
X-Received: by 2002:ac2:44ca:0:b0:50b:aa9a:6691 with SMTP id d10-20020ac244ca000000b0050baa9a6691mr5497264lfm.51.1701115010744;
        Mon, 27 Nov 2023 11:56:50 -0800 (PST)
Received: from localhost.localdomain (212-181-210-217-no600.tbcn.telia.com. [212.181.210.217])
        by smtp.gmail.com with ESMTPSA id k7-20020ac24f07000000b0050aab2c5e58sm1604719lfr.25.2023.11.27.11.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2023 11:56:50 -0800 (PST)
From: "sebastif@axis.com" <sebastian.david.forslund@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Forslund <sebastif@axis.com>
Subject: [PATCH BlueZ 1/1] Pattern match on service- and manufacturer data
Date: Mon, 27 Nov 2023 20:56:32 +0100
Message-Id: <20231127195632.445-1-sebastif@axis.com>
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
 src/shared/ad.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++-=0D
 1 file changed, 77 insertions(+), 1 deletion(-)=0D
=0D
diff --git a/src/shared/ad.c b/src/shared/ad.c=0D
index 951c56c60..7cfe47291 100644=0D
--- a/src/shared/ad.c=0D
+++ b/src/shared/ad.c=0D
@@ -1324,6 +1324,70 @@ struct bt_ad_pattern *bt_ad_pattern_new(uint8_t type=
, size_t offset, size_t len,=0D
 	return pattern;=0D
 }=0D
 =0D
+static void pattern_manufacturer_data_match(void *data, void *user_data) {=
=0D
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
+static void pattern_service_data_match(void *data, void *user_data) {=0D
+  struct bt_ad_service_data *service_data =3D data;=0D
+  struct pattern_match_info *info =3D user_data;=0D
+  struct bt_ad_pattern *pattern;=0D
+=0D
+  if (!service_data || !info)=0D
+    return;=0D
+=0D
+  if (info->matched_pattern)=0D
+    return;=0D
+=0D
+  pattern =3D info->current_pattern;=0D
+=0D
+  if (!pattern)=0D
+    return;=0D
+=0D
+  switch (pattern->type) {=0D
+  case BT_AD_SERVICE_DATA16:=0D
+  case BT_AD_SERVICE_DATA32:=0D
+  case BT_AD_SERVICE_DATA128:=0D
+    break;=0D
+  default:=0D
+    return;=0D
+  }=0D
+=0D
+  if (service_data->len < pattern->offset + pattern->len)=0D
+    return;=0D
+=0D
+  if (!memcmp(service_data->data + pattern->offset, pattern->data,=0D
+              pattern->len)) {=0D
+    info->matched_pattern =3D pattern;=0D
+  }=0D
+}=0D
+=0D
 static void pattern_ad_data_match(void *data, void *user_data)=0D
 {=0D
 	struct bt_ad_data *ad_data =3D data;=0D
@@ -1363,7 +1427,19 @@ static void pattern_match(void *data, void *user_dat=
a)=0D
 =0D
 	info->current_pattern =3D pattern;=0D
 =0D
-	bt_ad_foreach_data(info->ad, pattern_ad_data_match, info);=0D
+	switch (pattern->type) {=0D
+	case BT_AD_MANUFACTURER_DATA:=0D
+		queue_foreach(info->ad->manufacturer_data, pattern_manufacturer_data_mat=
ch, info);=0D
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
