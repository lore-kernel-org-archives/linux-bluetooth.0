Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A418D8F6C
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jul 2024 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722153398; cv=none; b=nnPv5ioX0Po+9YLjwjI19c5QeU77rydKfkmsW2wif4A9xvprPtgzT5m5u5RVdkBgcM39o24sqPSRFGUPQt34QO6XaKCnfnBg1HH643WgeR1hW5SGRlBxF4YfVBdmRF/yXBLegTUfsVb4/TqbCArog9XNzzA6FjJl0iEXudt7vY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722153398; c=relaxed/simple;
	bh=YfzWHva2Xx3MBCi7A4RmryMUvL+7fsm9EWGB5Tb4vBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Srguh+iXlosN8R+1s4iJ1kDamYf6KpFBy14HYKiucFAJ4ugDi2sdpf6IOnlDLO3BQZVZ+C5+dj6tJbBgsNhQTGcXjxrSeJ2uwxx+ZX75Gx+s416hz2eGOl8HPIYVWNDgUr/2e8wqh9NVdc8/ZOQxXRe9PIpJQrtQECmCcD2/RZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrdkHpGe; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrdkHpGe"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a81bd549eso245963266b.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jul 2024 00:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722153395; x=1722758195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oa0JC3Mroc/GuvIjMJOeY/179SghKFKTygFRtE6Fw/E=;
        b=VrdkHpGeTMkVSVDIQ2q52ebRoHz1ojtkSZPInuhwJuwrpbdpCv9Y/v2Y8nejqHWVrv
         EAmAbLXvHBDU1SY06836PI/loOS0jFbysQKxY/HuEOhcvo8+NUrGp6l/f7mrtYgp9Pcf
         96YgRKzZVAve8ALz91XlmBWRo+s+rmfryTs46AKbdPh5OLaV4AIC50mgkqLifx+hPBZN
         Bc7SwMLy0TXIWFfQFlxSy7chzsp6ZaG9no9N6IFkjZaXBT0cv3BgXPpUG2ZJvlV3Uxzy
         5+CidSdCZnXb6nnxDCBRXdgyLIG1ja8dLHyKZDEfVVOYKddDDbNmFxnpKJaACp9ZBVEo
         zxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722153395; x=1722758195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oa0JC3Mroc/GuvIjMJOeY/179SghKFKTygFRtE6Fw/E=;
        b=EEw8poy0cV6S9kSgc3RRI+QhRCGpLiVqaXdExT+ArjNpoPcMDBSskBl2DFnSFrc8vB
         0VTGwzdJEUQtplPsMs8BRK4HzY+hZHSQe0SEYwWXvlmtyDoymtNNpDtjs29WyawRqkvG
         aIUxahwCKu/eTFPty8TyMjkytO419MZw3MkPjpKGnc7ejr5THQt2G8FBX84sTY3ihra3
         nXuAvdF2gRPBKCaDYtByN1SDC9GSrZEuZHX9zFbPDkutohasOa/z+Fal4tRd3f5TPjdl
         S5VKQkqln4Z7Mcot5VO4aVgudcTK4cazB8txOdHHxtuheIGS8xuOZrrJcESKDqSwiZ87
         AVhA==
X-Gm-Message-State: AOJu0YySCPNazS9DenKv87etvsQvkCA8lQiKnr6TDDgWveyGZWUc4KiR
	vrDR+5vYOOp2AJB6CxUWiA2NHyKscP3KkLeDWWUpF24vpFJXyT12qt70CA==
X-Google-Smtp-Source: AGHT+IFxsDwk3S/EOOw1KM5GBowr4HXeH0pjswg4LPnDrVL0Mm8VgOe6EAq5ouAG3NGpuqhTUjVmWQ==
X-Received: by 2002:a17:906:d263:b0:a79:7f94:8a73 with SMTP id a640c23a62f3a-a7d40003423mr258334566b.20.1722153394420;
        Sun, 28 Jul 2024 00:56:34 -0700 (PDT)
Received: from x1cx.uhrm.ch ([2a02:168:4f3f:7:4b00:1bb0:11f:418d])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a7acadb9dd3sm361795666b.220.2024.07.28.00.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 00:56:34 -0700 (PDT)
From: Markus Uhr <uhrmar@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Markus Uhr <uhrmar@gmail.com>
Subject: [PATCH] Add pattern matching for service UUIDs
Date: Sun, 28 Jul 2024 09:56:22 +0200
Message-ID: <20240728075622.333056-1-uhrmar@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit extends the pattern matching capabilities of advertisement monitors
with matching for service UUIDs. This functionality was lost with bc2ab4b
(see #652) and not added with b0656c2.
---
 src/shared/ad.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index d08ce7af9..4a76d42ac 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -1362,6 +1362,45 @@ static bool match_manufacturer(const void *data, const void *user_data)
 	return false;
 }
 
+static bool match_uuid(const void *data, const void *user_data)
+{
+	const bt_uuid_t *uuid = data;
+	const struct pattern_match_info *info = user_data;
+	const struct bt_ad_pattern *pattern;
+	if (!uuid || !info)
+		return false;
+
+	if (info->matched_pattern)
+		return false;
+
+	pattern = info->current_pattern;
+
+	if (!pattern)
+		return false;
+
+	switch (pattern->type) {
+	case BT_AD_UUID16_ALL:
+	case BT_AD_UUID16_SOME:
+		if (pattern->offset != 0 || pattern->len != sizeof(uint16_t))
+			return false;
+		break;
+	case BT_AD_UUID32_ALL:
+	case BT_AD_UUID32_SOME:
+		if (pattern->offset != 0 || pattern->len != sizeof(uint32_t))
+			return false;
+		break;
+	case BT_AD_UUID128_ALL:
+	case BT_AD_UUID128_SOME:
+		if (pattern->offset != 0 || pattern->len != sizeof(uint128_t))
+			return false;
+		break;
+	default:
+		return false;
+	}
+
+	return !memcmp(&uuid->value, pattern->data, pattern->len);
+}
+
 static bool match_service(const void *data, const void *user_data)
 {
 	const struct bt_ad_service_data *service_data = data;
@@ -1451,6 +1490,14 @@ static void pattern_match(void *data, void *user_data)
 		matched = queue_find(ad->manufacturer_data, match_manufacturer,
 				user_data);
 		break;
+	case BT_AD_UUID16_ALL:
+	case BT_AD_UUID16_SOME:
+	case BT_AD_UUID32_ALL:
+	case BT_AD_UUID32_SOME:
+	case BT_AD_UUID128_ALL:
+	case BT_AD_UUID128_SOME:
+		matched = queue_find(ad->service_uuids, match_uuid, user_data);
+		break;
 	case BT_AD_SERVICE_DATA16:
 	case BT_AD_SERVICE_DATA32:
 	case BT_AD_SERVICE_DATA128:
-- 
2.45.2

