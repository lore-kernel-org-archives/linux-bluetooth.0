Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJUlC45o"
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570611A1
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Nov 2023 12:14:06 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-778a6c440faso300474385a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Nov 2023 12:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700597645; x=1701202445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=S9L3RVtYohgGGbQz/96kvey3bQHCTTJXpo42ThDVUdw=;
        b=XJUlC45o/wIfUBm7zt8IESa0D/akcFJILpKrUlQk+0O76w9jyeWOI8D4LawLi/ikn8
         OMVBjs5r4ke+smeb0reM1sy4xbluVWgq+yKsniPTK+En9s/zqbX8E6BtE1C5DDqNxTko
         sqECKmqrXoz35Z6h2KilGig/zB8tMix517yDhIwoQPFhci6pPKlTtRg1FXDOpQqPO5qh
         MHzeo0HJG9HyKBtqAmNjWmkaczHxFcDNF1gkgw+kLUZdyUXRTgJeaNRHYF2PuZm9jRSY
         SpQUOkpd4sx6OO1ELgSzCz/4I3lqODbrfhE5BR9Rbp+ajYi2r7yhvLtkLaP+SpFqR1ZG
         Btqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700597645; x=1701202445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9L3RVtYohgGGbQz/96kvey3bQHCTTJXpo42ThDVUdw=;
        b=kLVcVGDOJ7k514Q0bAYX3hm7g8ZkKjx8Novpq7+W9jexSXn9J8pZvv0xU7SuAaReYe
         JJBtsQprA7AaSjJ2NVMS/Bgqq9wQOWxVAZm6tWgvk5mOfUF8K9YkPvm8kZ0ppQPDhV49
         FNTTOj68lpBAsyhsG1Ez3FCXWeQFxZgHh10IipPzFEhvi/RBuGhXGul9BB+eWbCt/5Dh
         1NIHUxZ0/7mdQo/1gztx1qB72V5s8V4SewTaW2DmX7BlGKbrLE8VvMbya5+fUYnZH9Qa
         y4t3RZ0CIdd0ukXAS5CTg5Sd0TqghXM0sa0d4XLcD1xafRpxOzIyrrADJh7g/6yXMZwk
         yE5A==
X-Gm-Message-State: AOJu0YwmTUKukp1GwwgP43tymj5MxfXJg6wi9VGO+LKvmey1HgN0YrOD
	WZxHd3WNVxS9udT3lOVOA04pZxzNpRK0kQ==
X-Google-Smtp-Source: AGHT+IEB9JXZT96MN8sgSkPH4/2Trm/vK1Hd3dgK42GSq/CDcyDpIPfdSq9TgBHPLvI3KxMRrh/Aaw==
X-Received: by 2002:a05:620a:2f0:b0:77a:148a:3d69 with SMTP id a16-20020a05620a02f000b0077a148a3d69mr125820qko.43.1700597644750;
        Tue, 21 Nov 2023 12:14:04 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id v1-20020a05620a090100b0077d63ac6447sm40382qkv.109.2023.11.21.12.14.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 12:14:04 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] shared/util: Add GMAP related UUIDs
Date: Tue, 21 Nov 2023 15:14:01 -0500
Message-ID: <20231121201402.617067-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds GMAP 1.0[1] UUIDs following the assigned numbers[2].

[1] https://www.bluetooth.org/DocMan/handlers/DownloadDoc.ashx?doc_id=576496
[2] https://www.bluetooth.com/wp-content/uploads/Files/Specification/Assigned_Numbers.pdf?id=3
---
 src/shared/util.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index bf37fce364ed..47efff750e30 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -773,6 +773,7 @@ static const struct {
 	{ 0x1854, "Hearing Aid"					},
 	{ 0x1855, "Telephony and Media Audio"			},
 	{ 0x1856, "Public Broadcast Announcement"		},
+	{ 0x1858, "Gaming Audio"				},
 	/* 0x1857 to 0x27ff undefined */
 	{ 0x2800, "Primary Service"				},
 	{ 0x2801, "Secondary Service"				},
@@ -1081,6 +1082,11 @@ static const struct {
 	{ 0x2bda, "Hearing Aid Features"			},
 	{ 0x2bdb, "Hearing Aid Preset Control Point"		},
 	{ 0x2bdc, "Active Preset Index"				},
+	{ 0x2c00, "GMAP Role"					},
+	{ 0x2c01, "UGG Features"				},
+	{ 0x2c02, "UGT Features"				},
+	{ 0x2c03, "BGS Features"				},
+	{ 0x2c03, "BGR Features"				},
 	/* vendor defined */
 	{ 0xfeff, "GN Netcom"					},
 	{ 0xfefe, "GN ReSound A/S"				},
-- 
2.42.0

