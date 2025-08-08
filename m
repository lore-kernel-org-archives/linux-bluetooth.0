Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3846182D3
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754672808; cv=none; b=KEJpy3pMsL5UKFeKzRvM7BDhTI1+ZUwdMYu5UZD0jJGVml51jDcdUw5xzdnYcmpePrtShOOzDmd670QfDwANbzjcuPY55uyaYhva57pO5s4oRi8Qex0YGnSS6hyuRoHbIGwrqIXFV142Qejjkn4vIT6QNgbo50666jx8ExaAYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754672808; c=relaxed/simple;
	bh=6EQ8lSjfuivXKzRDFQu2W/QEqBhsODCvTulMzBlYLI8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UvYyc02rrfczUbDEzMzTP0alA1UY25oKXAg+3dv87eCKvVoh6oztyrl6IZboxe6zl1NFDvGxJ+eW3HSai/gmaIPXesyC3eVu2On48TqQumMZ3hI/PaAAZgTpxu3J+genb1pD9tTt9eYW/BtxlfjHG2X71upOppxByVptnX7iBtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9/wf9WH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9/wf9WH"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-af98b77d2f0so443767166b.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Aug 2025 10:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754672805; x=1755277605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yfk31cYWogVyd73oJ/nOOzJ/oFu/r8czTH0T8A6v/Q8=;
        b=d9/wf9WHzEN0gwONkB69NrNL3xa+eh4IYRW1dNHb4deVlb9sfVj/3xNvFu4VFy0DQ6
         Clj0T5jAMQDu4nUWe8AvDC+t1hrhIwE6h7bP3BSCdIgSLdesFwwiK+WN4yJpHLdF1M8e
         KUyKs4NK0v41UKUZ1bASFGkEqAuTjI+ZCnezTAj4zG4Sww2p4R+28VPFxbhLkniSvppc
         cO4oKzIgPAwAMY6UyowJ19Ew5PR66KJyZVlo96gEY+0jFvAWn5AMd697/7l+VLOc93rt
         gnmjAB1Y8Xf8bOju2rOLSWhwLuBmN9jWBC3aq2KmsCtvThzLatFCNA1U+ppTAlP0QI1Q
         rG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754672805; x=1755277605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yfk31cYWogVyd73oJ/nOOzJ/oFu/r8czTH0T8A6v/Q8=;
        b=rly/9+WrBk1cl97+CDRUWyLeBdJ8zVN24XPFSA23G3XSJvGpcHOrvMy4K2Gp6QoJiZ
         xuFGGtyRKjWsSAE3G642myWstOdl3L3BS0ZQMi3LX00AHMoRQL5S7gZu/dgfqJ4zkf/9
         /bonw59+xTfXyf3JlOmVIbfIa1ghrPzb3sEg67QqPjG07tt711EM+NxqLZUlJmQox0OV
         odh/ail13wqOPSXno60f5Q+CAHxivbZNJFby4zvRSMN2pd4eqLqQyflctl1yMR45aIfI
         oYzB81uzwoynx14BbSSkWoGfBg1ajhfd1vGQSQQGpz2OBxbeoBFnSkN76b1/K0QdqAnc
         0esw==
X-Gm-Message-State: AOJu0Yx+1WLwMOvdUuuh1kMncaZTfx37PV1inTFkzFF8FtfjFmDPJung
	H3j8J0V9rhOqC+xbTOOdhLJKh5v/Bc9dTqIIwhR7Xgy9BFQndFmuXsNYWxLkUWZm
X-Gm-Gg: ASbGncvOkwxy5w3ioeYp0SXDB4WEzPXLr7S2rKB41f7S7tkMXodrFjsqS+2wOkOJMU2
	zDh8YH1mYJUltRIQaVHw0lHCT9iKB5mqQuLZkdSSd4Qubvg0O/VC6EVjuC+8rv7JBz8KJpVuaG0
	j8UnGwlneRhwVZf7p0MfJ8n6itlyPMiDpSvAgyDZcelBbspj7r2DVFkV98QfHAYpMTcB+M7s9Zv
	AcZTxqf/EAyqsAQ7CA8iSXXQe9d4mrnXGgdajti6kqHg5TNTG3LIhyYgB4m5aCS0a0uRWYn5nO7
	5eqkQtyYq81nxxsi7LHX4n/9MaEcDaOQ4E/OBJ9U4Qk/GaZzCuK608sO6D9XFbX0VQUxmOWYsCf
	dP+3Q5eErZpm89Zoc6aDGfanHyQEc/85TD+6H/saEnCqm9Vszkt5S0GuZTIeRsDq4gCvwe0tHXE
	3H1e2eWPcebRUg5CaTKg==
X-Google-Smtp-Source: AGHT+IFiA3ywzoEYzNbFZCb94iPMLqBODjxyMPYoSUUCh3WAOpJar3L7zIPNkyUBEPhWT4o4jIIVOA==
X-Received: by 2002:a17:906:f5aa:b0:af9:7f4f:775e with SMTP id a640c23a62f3a-af9c655d730mr345369666b.51.1754672804527;
        Fri, 08 Aug 2025 10:06:44 -0700 (PDT)
Received: from localhost.localdomain (46.205.200.232.nat.ftth.dynamic.t-mobile.pl. [46.205.200.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7c88sm13777941a12.41.2025.08.08.10.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 10:06:44 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH] lib/uuid: Do not use mixed-case letters in UUIDs
Date: Fri,  8 Aug 2025 19:06:30 +0200
Message-Id: <20250808170630.202336-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 lib/uuid.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/uuid.h b/lib/uuid.h
index 479986f06..67cb1b92b 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -50,7 +50,7 @@ extern "C" {
 #define BATTERY_UUID		"0000180f-0000-1000-8000-00805f9b34fb"
 #define SCAN_PARAMETERS_UUID	"00001813-0000-1000-8000-00805f9b34fb"
 
-#define SAP_UUID		"0000112D-0000-1000-8000-00805f9b34fb"
+#define SAP_UUID		"0000112d-0000-1000-8000-00805f9b34fb"
 
 #define HEART_RATE_UUID			"0000180d-0000-1000-8000-00805f9b34fb"
 #define HEART_RATE_MEASUREMENT_UUID	"00002a37-0000-1000-8000-00805f9b34fb"
@@ -164,7 +164,7 @@ extern "C" {
 #define BAA_SERVICE_UUID	"00001851-0000-1000-8000-00805f9b34fb"
 
 #define ASHA_SERVICE					0xFDF0
-#define ASHA_PROFILE_UUID	"0000FDF0-0000-1000-8000-00805f9b34fb"
+#define ASHA_PROFILE_UUID	"0000fdf0-0000-1000-8000-00805f9b34fb"
 
 #define PAC_CONTEXT					0x2bcd
 #define PAC_SUPPORTED_CONTEXT				0x2bce
-- 
2.43.0

