Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1582EB0F
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786215665; cv=none; b=mHVWpKDB/WuQ2VPZhofmqYeT635m2m9FLSouAXkpEbbHaNVvkZMmE3llbGYHG66tVXqaojyb++47mKraWSJDSsQbXp9oYWuCe56piv+h0OV4MTg50841Hmw0DQWz1aQiM+6yhISftDzC4prFKOlTd9BslRVefrZr+8hyHkKGw3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786215665; c=relaxed/simple;
	bh=EBYV28a4adOQG4PnD8WxG0ls0R333viiMzQgI3Da6jY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uw3TC0VXZL3MO6NTiu3/fDgiMQGfSjsXAicangOrnupQLWUGExY7fX8hepKji3iTza9LFMgrBPB/n2n51FQdp33EVfc/bg36C8l03iEVcBWFFPDM+ptPBnPEhtwx0x3Mn7Mlqqai6P76t4as5dYgV+2LmhShSMgHUJAqaz0vB6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHLxvinB; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHLxvinB"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47528970fbdso215427f8f.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Aug 2026 12:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786215662; x=1786820462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8vmgSYU9fFYc13LG+DPnBuwECXS+YeM0P6qSkkrhDK4=;
        b=UHLxvinBi5+lWxje1exAOtZ1tZD4G0U8H0EMCMBgXnV3e/m7YBpX8PECQiWjBrqcA0
         Ob1OfGSYM7QjbaDso9T4G5brV+w5MgkWOqWBkPvfqAd5VVhQ/NjUxAWrOctm8UA7+8bS
         1rqRKjMAD+DbaWmwGn2I5zZW9vZtfyMDT4evO1mAP7dW7UicAefC1jM+5yX1PfYY/VfE
         dkHnH4gmAr8iFpKSaDVcWtVkFYl61PiHlIPyv0pZTG9V6mRPdKrYC2tKcFsjEkRWRcMz
         eqpFHsbz7MoIVqA1xvP1p4JnxLrzgawn2KoVDsNfJ8aqlwAzAAYTIjYsUDcIu3QJBi+w
         U6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786215662; x=1786820462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8vmgSYU9fFYc13LG+DPnBuwECXS+YeM0P6qSkkrhDK4=;
        b=PCCqgxVqEoEB44YVxevwaaAUEu0roRIl0PET0N8mf96fjYQA8SYzzBpfXEsLZ0AT+Y
         9GC7EyOE1UccGOveOPuvP2dJKI+HvGe0DFgSKJyo1FtEZO6BEHNwFnMKX8bQZdUjW0jd
         X48XKVDjprDfu+qoF9A3MceBDkbJMQjPMSncz8cw1QVTNQKED51fId/mNHrLVBEXcrX2
         yBqi/S/6LqSLYgjguJwFxzhtXCatxF4IsAxgUk4gaYu61oRDLq2HeDvM7GnnWEl6CK5G
         BFSDF5efjskBvILFvhKqWMIoh+WFYgv0jkTKFWcJuHTNs//rhkVa+DHpU3m700AUTH7t
         O30g==
X-Gm-Message-State: AOJu0YzD9YuaVwcgXvuxk1Ex5j16ml4X/cMbfbftPZWNixn2EER2p+2v
	e8mE6K7CPGktoK60WC6FJuOSDBu61WX2PKZ88hShv7Ynj70JFpA9db6xUnKMhNzkva9tbw==
X-Gm-Gg: AR+sD11HfvO1hp5ozj0HZcZVOxA28DoWjK0u2tk4kLvY5Gw+L+XR/6jmDpXkSDxQJ44
	KEUX1XXU9hFPLM2blfJn2nBLS+TnAko6HHpIJjtbEI3IDkp+lQjxFKGdJZmnugkxh2hArBBCpPu
	5+ZnglKVvSQ2P55ScnRzXn92XLZnEp5bIZh0dhNDVx4jGOWkQ0HWV1fEnpXJb2rA4rA55Op5KEN
	QbyjtuRF/ZO3JVVPmeEIBlYJ3EDNbW/f08pw9fz9EutpFjse3u7vxrzEjwzbP13x7hM29fYwNSX
	h1Q1Gqsm2GbhZWN6Fd65rqJK5XpmWDZCOYCA0LQSt+5gR9I7SJmv7n8MSVuE8qvf5D2U7nelDRq
	AF0yQlUBmveeg40/1DyqMdjhbcBt6e8EQyV5AizPyKtevwMPwVno9g1XQSVbmFR3wr6YUT+Vvqa
	ZY8516sKWerZJvqWJoEk1y2qH92IuQYsuQmpykMW8xHG1kvLjXAMMQL59b14R5n65mvyou9j8Kl
	vptYFTQwdCUDUXl04derTdGFk4hoosYvteIbJqCJGPN
X-Received: by 2002:a05:6000:24c3:b0:47f:eb37:fb7f with SMTP id ffacd0b85a97d-48130edb085mr11648233f8f.16.1786215662197;
        Sat, 08 Aug 2026 12:01:02 -0700 (PDT)
Received: from arch (user-109-243-3-173.play-internet.pl. [109.243.3.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002206effsm16122756f8f.32.2026.08.08.12.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 12:01:01 -0700 (PDT)
From: z4pdy <z4pdyy@gmail.com>
X-Google-Original-From: z4pdy <305461556+z4pdy@users.noreply.github.com>
To: linux-bluetooth@vger.kernel.org
Cc: z4pdy <305461556+z4pdy@users.noreply.github.com>
Subject: [PATCH BlueZ] client: Avoid scan prompt when discovery is already active
Date: Sat,  8 Aug 2026 21:00:57 +0200
Message-ID: <20260808190057.125743-1-305461556+z4pdy@users.noreply.github.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the adapter's Discovering property before prompting the user
to start scanning. This avoids prompting to scan when discovery is
already in progress, which previously resulted
in an org.bluez.Error.InProgress error.
---
 client/main.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/client/main.c b/client/main.c
index b5cad8afc..b8087c449 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2297,8 +2297,20 @@ static void cmd_connect(int argc, char *argv[])
 	proxy = find_proxy_by_address(default_ctrl->devices, argv[1]);
 	if (!proxy) {
 		bt_shell_printf("Device %s not available\n", argv[1]);
-		bt_shell_prompt_input(argv[1], "Scan and connect (yes,no):",
-				      prompt_scan_connect, strdup(argv[1]));
+		dbus_bool_t discovering;
+		DBusMessageIter iter;
+
+		if (g_dbus_proxy_get_property(default_ctrl->proxy,
+					"Discovering", &iter)) {
+			dbus_message_iter_get_basic(&iter, &discovering);
+
+			if (!discovering)
+				bt_shell_prompt_input(argv[1],
+					"Scan and connect (yes,no):",
+					prompt_scan_connect,
+					strdup(argv[1]));
+
+		}
 		return;
 	}
 
-- 
2.55.0

