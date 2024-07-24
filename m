Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0631CAA1
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 08:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811316; cv=none; b=c+zDrwI6O6dZQRj1ldB2Mu6diVU2hJzGFfmBsfxRWfUrZ1+ke3dOQvdUC232QdSalJERSXr40UaNkPDMuoNA3HiF2PAYOG9ss9Z6j98wNDx/4pWmDVYBdM84+3H+q3n3tOce/gsACkXFjloStra6S/THfVRxeBFXyFhlRKeu7Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811316; c=relaxed/simple;
	bh=534dvhcOHXCR+5M63oAsEp3FJR+gQdmZPviq/d8fOv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEnkko9wfI79zhaF13QX8kmnuQty5J+TLjXFSZBBLEF1OVMhKfMI3oW4lHL8cMGedphtV4Kj+jhK6NmzZAX0S9w80L25URno/bDfnqMyknEoVyelpwKy+hcxHPwn1YphsQRKf1NfVzxvrM6Hs+0YN+gfhrY1WFRJRwj9kRn06+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1CnneX+; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1CnneX+"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d9e13ef9aaso3968303b6e.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 01:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721811313; x=1722416113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RO33nwV55QSuPUfS4D9FAtjGr2L0hqBVbmQFawCAo1s=;
        b=F1CnneX+JR7t9b74ceNtA3b1NCG8DYBE5PTlxtmAdRGIOQZ8huxs864voSNguDg7NP
         UEnkFc7YJrhlCMdyEawqlMbKMMjjdB/xiznU1mBUG0YTUcYVyRjAICz+I5SQjgnvdnl5
         xb7Udl11odwAtSqp6o3C+7rS85ttQVm/N7XudafdarDD3MQ72KV5SykAwRUnxqykw8y7
         ijbGZ+zCJgOugCGqEhSzu6uFpSL8AQKquBpTKldY2/v/gtSO8pfsKl8C4a1xf9iN8oJa
         WSWvtHs8CUfXIlun1gMIgSEH5UwvO/k+hWyDvHyzr1L67Eot0jtGynoXN+3VIlC8N3Sa
         gcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721811313; x=1722416113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RO33nwV55QSuPUfS4D9FAtjGr2L0hqBVbmQFawCAo1s=;
        b=SYvlIWW8bRoilQru3XPI5+RyTwIMDQWS0IJ1KJWhGFuzrDb82mDUM06dHm8BGDn90b
         KcgQHwb1CwSHQoJBiFyBa8po7gLyM94r/12TCOFD4lEmY3R/JQ/YbFlsKx38yogKmCer
         7PDckfDOdd4yCKT6NrLd3rC+vpjxrqXKDZYs0xJDSj5HE60lJkcYZ8bEzwuH+kYOOuc+
         7tpp2Q5ygdtDJGiCoBZbG+BB3CRdC9NgUagxOZ4b5ER8jOkiFpzZUBLuZQAj4XkhY02d
         bT2hs7zujBJWtEIptvv8P4Fnrv06h8Q1tOdg0clrpFXdKQ+BcvIVxPBYlOWaWkBX03mw
         fCeQ==
X-Gm-Message-State: AOJu0YwFjbMdEoHXF36eiMj9v2hfSaO0ynvAClTkwXJuAqOP9jUGKocC
	7UtzNxShFnGmwQb27H0XYJoGGdAMn8xQuu8//vRfp4ztHL07eSNdk9TFNZlX
X-Google-Smtp-Source: AGHT+IH8q661pRNKfk3U7IoPU9pN4K+NHrv0xky87Y3mwixKqciB7etQW+WvlxeErhuw2dysvoXsDA==
X-Received: by 2002:a05:6808:f90:b0:3d9:2e7e:53c4 with SMTP id 5614622812f47-3dae984410cmr15347581b6e.34.1721811313473;
        Wed, 24 Jul 2024 01:55:13 -0700 (PDT)
Received: from localhost.localdomain ([192.227.249.122])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3daf59bdb7dsm1248914b6e.50.2024.07.24.01.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 01:55:13 -0700 (PDT)
From: Yancey Chiew <yanceychiew@gmail.com>
X-Google-Original-From: Yancey Chiew <YanceyChiew@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Yancey Chiew <YanceyChiew@gmail.com>
Subject: [PATCH BlueZ 1/1] profiles/battery: Fix batt random lose percentage
Date: Wed, 24 Jul 2024 16:53:18 +0800
Message-ID: <20240724085318.209318-2-YanceyChiew@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724085318.209318-1-YanceyChiew@gmail.com>
References: <20240724085318.209318-1-YanceyChiew@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an error related to "Trying to update an unregistered battery",
which causes the battery1 dbus service to fail to provide the
initial value until the battery level changes.

battery.c:batt_io_value_cb() maybe run earlier than
battery.c:batt_io_ccc_written_cb(), which causes the percentage
to be updated in the batt structure when the dbus interface
has not been registered.

After the dbus interface is registered, the function to update
the battery percentage is skipped again because the battery level
has not changed yet.
---
 profiles/battery/battery.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 02d024d92..b2699c0d7 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -94,13 +94,15 @@ static void parse_battery_level(struct batt *batt,
 	uint8_t percentage;
 
 	percentage = value[0];
+
+	if (!batt->battery) {
+		warn("Trying to update an unregistered battery");
+		return;
+	}
+
 	if (batt->percentage != percentage) {
 		batt->percentage = percentage;
 		DBG("Battery Level updated: %d%%", percentage);
-		if (!batt->battery) {
-			warn("Trying to update an unregistered battery");
-			return;
-		}
 		btd_battery_update(batt->battery, batt->percentage);
 	}
 }
-- 
2.45.2

