Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27701C1AA7
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173904; cv=none; b=PeeorORAqnSifB8UibVCHzB/Ps3fmpyIV6Nmw8y/BuIbVrQ28rZOh3gDvQR8Kf2g30lXwRS92JPvhzMFirnLdsJzcEdA6U3YcabSxVn01tOlzJb1XUYa7Z5rRE3VVosry0pJMmwG0+8uxMovi4kkQ2ADZGkyJ6B6KpGa920wCvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173904; c=relaxed/simple;
	bh=fS8darwhZEKjazmUr+SxaP2VL9LkgRmTDmMThlKIRT8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sQwlrY/Vxz/ffe5NsOZOgUC+8TEMEF4TexBxH6KJvUbkIngsUdKw9ZZ0bqWhn6qEjZl+FKigLyZuxJQRkFuVf3G4vx7sLKHHJyaKDjGQsJfOETQarcm+XrXnplYNtd4I7MAuHW767LdDEq22tNOAffi0g9zbLy8yuFSb7amDzEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOFnZiQ/; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOFnZiQ/"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5010861905bso1117383e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 13:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726173901; x=1726778701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=B3maRCkXriOwNRsToVGGBax0Q8NsC2y4XqJ7drQS+j4=;
        b=kOFnZiQ/V0kyjuaWbMkjFmQB6q2npR88H/KprOTYOAflfMcL3PEm9VBcPYPLS2wf77
         Z6fbwyrJBF0NwKj+4+YIW49b5ZtUBcMEU1tEdkSkcXAhh6v8JDu90WJoxdugpkclc3k9
         Qvj+3bt19NOyZcCuNDyvoMdDUxr26Q6Kz0SE1ulcoODya0LoQRpWS71WnL235eYmqij7
         kUechQ5U7Bt5bJp/GKK1S1o7e0/bdYsfnIhW2F6uKyRupl1cwOEuE6tPtss/yJTqS46K
         8Wmi5oXqOOrmrVIS4BNGU7qmt16CNaq9i5CRfOSZfgktdgNG5s6I0hMu3Zm+qxkaISWE
         cOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726173901; x=1726778701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3maRCkXriOwNRsToVGGBax0Q8NsC2y4XqJ7drQS+j4=;
        b=cx3NpNMii8NafOHp8+eJV6rFgeV/96u+zlU3CGYEbY4vQVf7CrarYbJJ4paDwA/8mN
         tCcoNiwvTUX7p9YrXgiwZ/uGEvURegkCQ3PPv2c/5xPYonhafoDH416cIkobmnRZZflf
         6PNJhjGGPx1TG76HxKHAYZ0sTc/Yo6XTuhnY84Rn6eD7/QYKPJjALtszxtWwQQihzMVl
         j9sWYtAKYivwk79gafCVG13+3GRYn+XxxcxZRayWxlq/kvzvcfddExIRf3hj00WSnM6N
         twyW+H4Ab2PnoY0SIwWQIZpLYTMQsCUJG15P4Riym2q3dETeD7e5WbTfd73wKQzroib8
         oLKA==
X-Gm-Message-State: AOJu0Yy/Zg0fDODvzyAfwNxGRuoLpWDqV4re0Tz5zFkkT6fC+5ChFbGV
	uVrR/K+p5lfNnxf78SP6n3vGQl6YXO6me3uYIvAGuoQ4D/t87ThsvvvNng==
X-Google-Smtp-Source: AGHT+IGY/3krUv7sECnM6f06S9/bM69VqNw9qH5MJGp95J/SLoWqixjkIa+g80QSLpb7Q41gGmVX+Q==
X-Received: by 2002:a05:6122:4584:b0:4f6:b302:5c50 with SMTP id 71dfb90a1353d-5032e3a8508mr3528444e0c.0.1726173900731;
        Thu, 12 Sep 2024 13:45:00 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-502f9a9a484sm795067e0c.23.2024.09.12.13.44.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 13:45:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] client: Print a warning when setting discoverable without a timeout
Date: Thu, 12 Sep 2024 16:44:58 -0400
Message-ID: <20240912204458.3037144-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes command discoverable to print a warning if
discoverable-timeout is not set(0):

[bluetooth]# discoverable-timeout 0
[bluetooth]# Changing discoverable-timeout 0 succeeded
[bluetooth]# [CHG] Controller 4C:49:6C:44:F5:E7 DiscoverableTimeout: 0x00000000 (0)
[bluetooth]# discoverable on
Warning: setting discoverable while discoverable-timeout not set(0) is not recommended
---
 client/main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/client/main.c b/client/main.c
index a96a4263849d..2a5c7527bc6c 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1095,6 +1095,7 @@ static void cmd_pairable(int argc, char *argv[])
 
 static void cmd_discoverable(int argc, char *argv[])
 {
+	DBusMessageIter iter;
 	dbus_bool_t discoverable;
 	char *str;
 
@@ -1104,6 +1105,18 @@ static void cmd_discoverable(int argc, char *argv[])
 	if (check_default_ctrl() == FALSE)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
+	if (discoverable && g_dbus_proxy_get_property(default_ctrl->proxy,
+					"DiscoverableTimeout", &iter)) {
+		uint32_t value;
+
+		dbus_message_iter_get_basic(&iter, &value);
+
+		if (!value)
+			bt_shell_printf("Warning: setting discoverable while "
+					"discoverable-timeout not set(0) is not"
+					" recommended\n");
+	}
+
 	str = g_strdup_printf("discoverable %s",
 				discoverable == TRUE ? "on" : "off");
 
-- 
2.46.0

