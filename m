Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C843185292
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814625; cv=none; b=Ak/3+HOL7+fyunPwIqYHQMFl2Zz9VaaOoO2NMNWAv9vP+etr8gw1yuFz0XkchOBN5yvyl63hIV1Bb21ll3R0NHsGajsDGaAzo4MnG87j0sMUzkRXrYY3aMek7TZPDIW+kEK1MKaPUfnJpnPSlTFOJc7nap8i4uD3FF5ryKWfvYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814625; c=relaxed/simple;
	bh=J/kS8l2g9RZhxNAzKJ52nEU68D48vn31wNKus36nRsc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8xYQS6JQuzG/rlKrCU+VT6T8zuqWkrZwavTKNd6qiLpD0BBAqgXDipn2GM6qo8ArBBwF1gLnCW6VyNqCp8P3izBRQ1s4rfLK9L9Z+EgMMw/hjmOmJTSSxamIXxFY5hkIcc76McRzWbOvQLo4ykjDmYwG9Zyht/GxWdicg3H+Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azBpCr1o; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azBpCr1o"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bda4bd14e2so1030180b6e.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 11:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706814622; x=1707419422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HC5SdNvCWeKEwtYq4o6Mizban1zGXB05RzkUe4htxw=;
        b=azBpCr1o8HtVe+YGe0BcKXnahnhYWC5bDFUZ+Lt4BGHReI6LL7Fimxr4nP9wVowlFq
         HxQWSyeyNqg0914yU1FAVvvwCnsLQrdBAtZlnG/SuJAuJ2ae0tsfG2ct8C9aEj56Y0OU
         ydANONblHKbo56h1+EGAhW/wEerNdZjGsh9FcusCsZdKF+7G55cxdzBfwTRbzO9qlYgg
         BU7TcKSea7hMCN2sEmMIOLxVRwe7z6cH0Mgz8BfzzLRHkpY7YBMizTwMmguI0A8kVJKb
         MvbZ8gmF1I825UJD9uTusRUXsSmLMI5cyTpuURM3SiIKKE+pbPMzXfcg4uI8jEbj8nao
         pvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814622; x=1707419422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HC5SdNvCWeKEwtYq4o6Mizban1zGXB05RzkUe4htxw=;
        b=mlAJapBMZjxCJ/asEL9XOSTZeQXVdIKqzLsQdVsNOlM6Feo6yGBE+3c8rwze7ikPg0
         n2A7CnRJNXgKzTBa+WqzPQefSNO5NQgJYXPnPZOkidJEwGWFFTsYLRGhzOzfaWmkWkRp
         F95Mf/1PLidMswxWzLeMyLalj4Ebwia0kkzA1ZOxLF4QOinM4w8MofnRfTAyxl7wnIL7
         zrATbK0UsUGOsbIGL/rohi48f1CiNWvHw+B7Z/ldiVEj0B2bocC/KRAa9guAiIRwIP/d
         qAtizBfZ/9E9P6/D2t8yjjDbLQgLqGzbhMaDR5JAb/MNhMa/eSNdvDr0JyEbtMq1uLFP
         aBaQ==
X-Gm-Message-State: AOJu0YwH2VSjFpGejnZLrVlh3uDalewuRgr/nUKR5tYdf7TyXWgemtZU
	IVUGtzHS2M1fsIelcQzHTK68DdVEAKo1pNruA5mXr24bxvEo+GclIiF5tbr/
X-Google-Smtp-Source: AGHT+IH5GHUZzdJ4kl/vW01hOPK8N9AH5bQVU43ZH6jvNsSDmRbtX9tj6qhgf8OcuRY5sNG4Gkq/yg==
X-Received: by 2002:a05:6808:178d:b0:3be:aed3:5d84 with SMTP id bg13-20020a056808178d00b003beaed35d84mr7102627oib.26.1706814621780;
        Thu, 01 Feb 2024 11:10:21 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id db16-20020a056130239000b007d2e2f14bd4sm35912uab.29.2024.02.01.11.10.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 11:10:20 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/8] device: Don't remove object if a service is connecting
Date: Thu,  1 Feb 2024 14:10:11 -0500
Message-ID: <20240201191016.1122194-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201191016.1122194-1-luiz.dentz@gmail.com>
References: <20240201191016.1122194-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a service is connecting just restart the timer to give it more time
to complete the connection or disconnect.
---
 src/device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/device.c b/src/device.c
index afd073c6c2a5..1db96d9a672c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3276,6 +3276,13 @@ static bool device_disappeared(gpointer user_data)
 {
 	struct btd_device *dev = user_data;
 
+	/* If there are services connecting restart the timer to give more time
+	 * for the service to either complete the connection or disconnect.
+	 */
+	if (find_service_with_state(dev->services,
+					BTD_SERVICE_STATE_CONNECTING))
+		return TRUE;
+
 	dev->temporary_timer = 0;
 
 	btd_adapter_remove_device(dev->adapter, dev);
-- 
2.43.0

