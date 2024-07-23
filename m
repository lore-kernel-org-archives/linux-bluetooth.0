Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B8C8814
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 08:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723354; cv=none; b=CV5AKEOMaewURa13/zoZA244L1AJn7KykznL+dcoQop6OEXzgxod0QmcwPiy1HdOHa5wLJg6FO4iD5R4a+8ovaniSOEfIZaXY/XGUnWLQ5z9U+ik6eV80NFuYo/aS2bH7t277EDTE69XJrUw5doSW0uMVu81OoTwHs2OnvMrIe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723354; c=relaxed/simple;
	bh=sBnlHZFCtXOeBoVMVI/HVoKcrZqa2iKyurtsMtTD7TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9QB+dyCC6/XAvQ1dCdEn/giou6Ju1i0hOoJgEpI5fThS9vxWU0zKtDkXAvaiMljXWlbMyyMvmCuS3SZj99yImX3EjCf8urFtr+W9YxbsOP/PYKmKjWDQKVikHot3M88Sl4RnEmkoDKi+pLQDS3O5O/7ogq7aOiEqlF/vQXRzoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bu6Mxart; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bu6Mxart"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3daf0e73a62so1430584b6e.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 01:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721723352; x=1722328152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RO33nwV55QSuPUfS4D9FAtjGr2L0hqBVbmQFawCAo1s=;
        b=Bu6MxartF8I7J6Hwl0Idp03CRmSNSO+Tfc7UwUMeSnM99NrYCHW4hJDNnpXWmFcM8o
         87LYOpa8Oo9jj0TovuEJKdGLhQE53go9UAtAXPxRz0NK4Q52MPLJd0TOLfzdf0bOi6+W
         bZiPC4/vZ0EjPGOKMSHll+ykmYx/trR6b6dQcyuGz91wB3YV+GHY7yqfizYYek57+ZvT
         CsGE+Bj507SFX8ZXsJeExK/t9Q15uOhl9tPjDP6RpTbxKl55IjjmMGspaAcB+Bpo4rPg
         nl3K7d+uWxSP9HKmVz3Q5ajSH5WHjI4kyJUmHrsyD+pxz1KFjf+r6Sp03CHfIVvFJh19
         3RKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721723352; x=1722328152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RO33nwV55QSuPUfS4D9FAtjGr2L0hqBVbmQFawCAo1s=;
        b=vg889k1l+c3uvjKON0BLXchjt3mtHx84z4inmIIGpd9EwvMZtjrUp9omNy/VFojtUZ
         5MkorObkUAcWlPsRnNPvDuV384k/liIw9HAzmifsSu8e1fj00OtNw2IexS4pFHZUNG9Q
         5mOS8waMIl5jaJFi5Ye1GAP6DEw4tZAe1F6bHgS2mlVux40xvRnlM4aM72CMtHRYGxOZ
         uecYG6o0kdcr9ASz1xrLY3uVG66eR7uJONe8+3OlyoiQDPFV+dIE1yE+PeWgtvybFcis
         T34GlYbYSRWJY9/5OdcKtkmC495xLkJiQqySGIeYv80pN0PXJP/mJ24jbGal01JCaUe+
         K46Q==
X-Gm-Message-State: AOJu0YwkUSVWT4qqOMGykf7zcqEDqIU/yOVJIaIwmzz2QGJhP1jcEaEQ
	YRF0VTGipo0X6c7H9UkDKVbEvBNFgDjiDMeAUlIqct06kvMOTyhgXXg0fA==
X-Google-Smtp-Source: AGHT+IFRqzWBfUJ+NKgkRbuBVtLItJ8Rn0MI/l03guVIpCpmZDYCQipk5lQEvaQ12tAT50DfzHRkiQ==
X-Received: by 2002:a05:6808:189a:b0:3d9:3e2a:325 with SMTP id 5614622812f47-3dafd0e9977mr2175123b6e.22.1721723351705;
        Tue, 23 Jul 2024 01:29:11 -0700 (PDT)
Received: from localhost.localdomain ([192.227.249.122])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dae099013asm1902743b6e.25.2024.07.23.01.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 01:29:11 -0700 (PDT)
From: Yancey Chiew <yanceychiew@gmail.com>
X-Google-Original-From: Yancey Chiew <YanceyChiew@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Yancey Chiew <YanceyChiew@gmail.com>
Subject: [PATCH BlueZ 1/1] profiles/battery: Fix batt random lose percentage
Date: Tue, 23 Jul 2024 16:28:43 +0800
Message-ID: <20240723082843.184915-2-YanceyChiew@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723082843.184915-1-YanceyChiew@gmail.com>
References: <20240723082843.184915-1-YanceyChiew@gmail.com>
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

