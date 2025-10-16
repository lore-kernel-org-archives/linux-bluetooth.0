Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B62F21CA00
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648434; cv=none; b=LAOqiP+Fv1UUuVoHtJvdYhF7V/J2M+ktXnLTfG7U5dA6dAyOtoCFwX9X0BuYFnoCgc+H++YPnP7YiZRaT/7yHDuM2OIakVP34N4liWpGp7dOXPHdAbhKXdKfV36Agp2NjHxFBNvwwEQ6i1UAh5Im+XsyL4IL1Cm/CQUoNUiXl+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648434; c=relaxed/simple;
	bh=Zhx6I4Ef4aK31jccG4/OyNQNBokh+PDk5duKrkzys8w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsIH402zHQQ8V+OqbvcfAdVu1DkaZ2ZNEQkiSqNEfdnqqR3lgKTRBmqyzXtI6x5tTcmPO2lPKDIP9/Yu7/0pOJ4DAR2KNwGPV/vykLpKm9OMh64VAm6/he5PebdK41orcng1zelaRllm09z1pz2B8xAJruSc8Vy0BK9kdlW+0zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TE/6STFn; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TE/6STFn"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-551b9d94603so392023e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 14:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760648431; x=1761253231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EfdVVKoj2sADQBQjrXjKVAOeL+Zvfw2HqUcCJQjjBts=;
        b=TE/6STFnu2WL6OsJoG1SeF39IDHtdN945SVmw+8llGqv9FhTvnSPfapAEGJ+A9n/6o
         whyLrDb1QkdXz6OlQNzJx8wuAAEFtQViQSOWQzAjb/+k5Zcg30p5jwGlHp2WojWfflN8
         3NxLMnH9zdAsygr5CmN2qblSqvlwNfPKEXBeGrf7gJVTg+5PuINiZXxvuBlj2R4QUgis
         JlB0FYNh5GD8w0grMQ6iUkXaEvWMVvh0+xEC6PReX12ILBJ7aFXOSN8/YCUMRXZJi91G
         BX5oG7/tpxKBhTuOxSeyUiNtfHQ64B2WLY1gzjHcoOFl6Drp2JF0rxy5ki7tiU7G8LN4
         0uLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760648431; x=1761253231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfdVVKoj2sADQBQjrXjKVAOeL+Zvfw2HqUcCJQjjBts=;
        b=o//bGlY3LduFeNHKr94p9QbK2bdJ1j9gQwC7OJNdSWrJ+p1JgmcAF5M+5yVmtHMGn+
         IIVoPt8koARa0/mQp8pmDj2jx8QY5FplNwdJZXLyTwAWVx8qE/OFqdKaGErSkMVxtfCM
         C4miWjQD9zj3dWiD++KQ6Y9qGmB7zEGeCaVrpjSh3VlnRaB1tuCnkWVH0MeseJNMy7K0
         9vijDf46put1CZjcxecvsgFCI62vfSh2/OEMdN0a/uhaD1POshbB880Kxg4HfgLN6FTm
         DY97sY1eUPSV5NXb1V2E9usTd4KGqZsyMBg2HLRwiQNlJc2doAQ0e9IffJRHKqlnqkrN
         NPqA==
X-Gm-Message-State: AOJu0Yzs0/JF3zOUXqCARDI2MKW5GoasVtOMd5ABwecFFTPPRl39CRkZ
	rI9fB0EAzKsaq7HXZt37WWCelNYM5/c4iIJ4g99uNCOR0jJrN86r+mYly1zROTks
X-Gm-Gg: ASbGncurpxZipvTivmz+yGANc3+eTgPy5iGAIF2OGNqvyCc7KRMoPn55Yo63NvqJbCm
	h0tEbSf4jqBYKzHhml7M0CpyG+nsB4907DFV1DVwuUg0SHQw6KrSBcnZdPMiy9ZZhBvCNoiY89e
	+IhPxrzBaHcNPDvZ9Q5rq+snTdssjD37kq5/ygSyPgCKSyC60E4qsw5+U67rUOycndE0+oytLMm
	eNPad+BeXtwfmgHbRJXICDXOJ3Ytz/7Z74FjgBQLJj9SPCVibahm4aJWzRWj4Rmimd/CLsu59WQ
	Fi9UXOC2sGn/QIiVKHaVxWNf6dZFvfqnb6Lo4OblDioVv+50/4fdbOI/tOrC+dqzjdLoNwLt8Tu
	SpBNXJfE/9aNFH5/JZp7ON2rBDOcPJjDQDvXPMG83I+aBk/uGgOtlHaBjEocI0SSs3yT2WpFi/2
	H6YPadNnz1RmIfIw==
X-Google-Smtp-Source: AGHT+IGfhmRSpD5gBq6fP5YPBh1NK+2JkIIHYkRZrJ3/Kpbq/ZjaRsBn8t6pjRl7rajPmN4CI5PAUA==
X-Received: by 2002:a05:6123:2e6:b0:554:a881:c198 with SMTP id 71dfb90a1353d-5564ed887a0mr835431e0c.1.1760648431180;
        Thu, 16 Oct 2025 14:00:31 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80d9bf0sm6590304e0c.18.2025.10.16.14.00.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:00:30 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 03/13] bass: Add support for setting DEVICE_FLAG_PAST
Date: Thu, 16 Oct 2025 17:00:09 -0400
Message-ID: <20251016210019.191878-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016210019.191878-1-luiz.dentz@gmail.com>
References: <20251016210019.191878-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to check if setting DEVICE_FLAG_PAST is possible based on
the MGMT settings.
---
 profiles/audio/bass.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index e4d343a1fc02..73bdf52128f9 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -30,6 +30,7 @@
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/uuid.h"
 #include "bluetooth/iso.h"
+#include "bluetooth/mgmt.h"
 
 #include "src/dbus-common.h"
 #include "src/shared/util.h"
@@ -1253,8 +1254,17 @@ static void bass_data_add(struct bass_data *data)
 
 	queue_push_tail(sessions, data);
 
-	if (data->service)
+	if (data->service) {
+		struct btd_adapter *adapter = device_get_adapter(data->device);
+		bool initiator = btd_service_is_initiator(data->service);
+
 		btd_service_set_user_data(data->service, data);
+		if ((!initiator && btd_adapter_has_settings(adapter,
+				MGMT_SETTING_PAST_RECEIVER)) || (initiator &&
+				btd_adapter_has_settings(adapter,
+				MGMT_SETTING_PAST_SENDER)))
+			device_set_past_support(data->device, true);
+	}
 }
 
 static bool match_data(const void *data, const void *match_data)
-- 
2.51.0

