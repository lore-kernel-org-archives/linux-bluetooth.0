Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCA419066D
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739564494; cv=none; b=iRiZokREjSyZvcmYoSr8QmUOMjjnYH5V+AYg7AChRGITxslDPBOYZUd/nGINS3akGNvQQLLiMnqyHtImcfkpEJwCOWZm1xeGRGA6/r9j33pQjRTuDCWTSC7gaQvg5rBEN22iyBCMb1LdAY9o2ZC1r0l1tk5hv77M5dFwjx4j84c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739564494; c=relaxed/simple;
	bh=trewjkiGSrR6vaSBRKsfhdFmSTJPaZ/k3M60+UHSLYw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EG2E8N+epf0XH1KHT97knNVzFy1eYhBBge3NdoxaXTAO4YHC0sQnLVmJ3qHPse3rb/hQGhj8T8W2a0pea/Ut7QXtFSqwVrTFvlWPk8zdrdeM874ye/R19zvRr+6QAnGvGjOUDHqJxxsFYZ1hXaPOoOdW3r9nF/iNXktMyP1xxRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPw5izsF; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPw5izsF"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6fb2a0e4125so19009107b3.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 12:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739564491; x=1740169291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zn9KA86rmGtsFQa3ubOX2J/z1TAl7JjwXNkY7Zb6EII=;
        b=MPw5izsFATCvyLdjSaO7XyFvgABZ/iGGbdBQG/cJIRIu1DoLPu7xEO/Bcyx86krF+S
         H7u1QTf2oPis6J4lbp6IGip1SGq5qDwrZ+11+W9hYz8uijcysN+qaqlqJZrTVuDHzNgp
         Rjlr/aU6LgLrug1MrQBfFwsUzdhQ8BtQZgPK6rlYEm1nzNnm6LI2Ix4Y4on6HfIW1Gs+
         7AQ+GHoFZLftGvjFbPFuhTcVaDoGchRjBx1QSyx/McSJs1npK9lVDwdzAnYUHBkJ7Nrs
         MUjTT3g4EIWj2m/tL8pXW4GNxElqFf4/MfnLn4uDql5+vUbHzOTgmSd7Ru5nByblzp86
         au3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739564491; x=1740169291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zn9KA86rmGtsFQa3ubOX2J/z1TAl7JjwXNkY7Zb6EII=;
        b=MmewmG4TAbFgVb84s5tWImHB0vPPb4+yqdXRnqa+eB5IJ2jjfb8JfMCDwzMrLByyXC
         +wuF+H1sixJOQkVuKP5ukc9BGWSHz+K5NdSp2AozT+sOWZxUQMKehm67hecBbmBaKY37
         QvjwnwJHswuW6YJNiQMIBCswtxUC1QT0fpAxRCjFKLKi2/BzDtHEf+qWiwbGSjPpvk7c
         1U5y/5wREvAeNdgSuA7iqhNGJkAbmr5+Dn7qS7ysGCoECSegrixRxccRkTJfbhh3enHq
         waulgMpwPeuiEXQSzG0NPfUw1Ss1NlxsSH8e9B1XdrbDoBmpz+pJXQIWcViVBdRByofz
         rm3g==
X-Gm-Message-State: AOJu0YzNvATrLw6s5J2UFZSUbYqgQPeAfqwNILNDLItT3SCRTuQZX0t1
	mEQBAk11FZlQmbk9eMR1YNyWbL9G5lwIZ9RHTPj/HnbhhkObk62XwJBu+LMN
X-Gm-Gg: ASbGncuIJ3vWrMQ1qnWTCF4VeTIIyDwmb5qmGIOJwWtr0XaDmO350AMcXgN3OyBZr/Z
	cEjUZ0h+pXQSe4bYYlP4M2QJbP7tHnvywnevo0/BwHlFjwzGhRXM1P1AmtkDOvM26GMnDaLL9Hk
	43/kvNCz6rcsqeDx1Og/xAF6XsoZ2Rlh/w6LQeScI8K5iNKZtgyyjEpld9Z+fgpOX3lzx8xzGnM
	T/p1+l2F3dnpXAQvReLKnLp53NJ4v8uqreA4ZY9htCltnv4mbe4EUHWTwJInczCK7sQwjyBI0HO
	bY4Hz5Pz0Nhgus0Gx062/X3hkgDD0xWQx0318ZKIcc3PQI5qsLVOB7wkB1ipFag=
X-Google-Smtp-Source: AGHT+IG6T4bFTNKbUQP/X7sQWetpt6Ncux+utvvpFhBsHpc9nSf1MoShRzEmSBZjjMEkMBKFa/Wdhw==
X-Received: by 2002:a05:690c:fcb:b0:6f6:cd43:543c with SMTP id 00721157ae682-6fb5835c44amr7728997b3.34.1739564491035;
        Fri, 14 Feb 2025 12:21:31 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb361d6258sm8940367b3.114.2025.02.14.12.21.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 12:21:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] org.bluez.Device: Introduced PreferredBearer
Date: Fri, 14 Feb 2025 15:21:29 -0500
Message-ID: <20250214202129.968369-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces PreferredBearer property which can be used to indicate
what bearer shall be connected first rather than just using last seen
bearer which may not work always since it seems some devices sometimes
advertises on LE bearer but expects connections over BR/EDR e.g:

https://github.com/bluez/bluez/issues/1092

Also with the introduction of LE Audio this might become even more of a
problem since most likely users would like to select which bearer to use
rather than using the last-seen policy.
---
 doc/org.bluez.Device.rst | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index f8d4a68a6b41..e3cf4d12b173 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -40,7 +40,8 @@ void Connect()
 	are skip and check latest seen bearer.
 
 	3. Connect last seen bearer, in case the timestamps are the same BR/EDR
-	takes precedence.
+	takes precedence, or in case **PreferredBearer** has been set to a
+	specific bearer then that is used instead.
 
 	Possible errors:
 
@@ -346,3 +347,23 @@ array{object, dict} Sets [readonly, experimental]
 	:byte Rank:
 
 		Rank of the device in the Set.
+
+string PreferredBearer [readwrite, optional, experimental]
+``````````````````````````````````````````````````````````
+
+	Indicate the preferred bearer when initiating a connection, only
+	available for dual-mode devices.
+
+	Possible values:
+
+	:"last-seen":
+
+		Connect to last seen bearer first. Default.
+
+	:"bredr":
+
+		Connect to BR/EDR first.
+
+	:"le":
+
+		Connect to LE first.
-- 
2.48.1

