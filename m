Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEC3221DAA
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593498; cv=none; b=JKJV9fCjcLyGmDpHezmqsb6Co9laqvVIIBKvamw93rOR5Wrjc1aZqzuDX6I8V9m2jzRcPkki7vZBm1ys2eEVNvxezF1cXXA1MXheLMml7qEGKUZdoLxsJBzPpCtw12rMH/8xg26UlVf/o1Tuk8uDP4adFCXCX0DzuBy+86caU3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593498; c=relaxed/simple;
	bh=u4D2ysouWFu5bTZIUpNIs3fhNumzbXtmogCIuiOZa5Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=h7mhJ5DADjrN/Whx+MNhClxSExUw7xGW1ZuZivZC74hWdt3ZQ+VnfIrx7+flF4SU5kzXiqwLLOqhepnZfTgXcP3WQCh0oUQhAGCu2vMI8WNOODLi51gLsIkJJZouLV/YjUIQLlDDl6w27wNN4/3IN0tG+YpQSjuiIOONE8ICX0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDYh2lHd; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDYh2lHd"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-52099627b5aso88491e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 10:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740593494; x=1741198294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DtVsiCTPXcLKZohphQdspl/F7ltUoceFtEFau8xmyg8=;
        b=GDYh2lHdKCqJZiRYLVband5puz2Wq3kFUjZEj1qeVHpS8tnVBdB8cmvRh+JmY9rFim
         AgulzpM6nBEv8C6x3cKAk3lL/JhxvU28ng0QTeIBMdIdKZxyn6eZ2UpFoT/QIJp9eUMk
         lPPDN97PAUbLMmmmQblmXJhJNWeNfG9MkXarJYuwwYM52UW2W2U30TDPygNTKhOhZiz6
         G0MaV8Qt32nE0rNpa2KGaLSDDTiS9z3BQgqhwBDwh84ebPAOBYCp9HGxaLg9PLnxa0CO
         pREPa+35R80A9qCfFEhetTOOmdwOnyP+rTqomiZ4O14Thb8g50O5JGB2WDT/moZVeP34
         KRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593494; x=1741198294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtVsiCTPXcLKZohphQdspl/F7ltUoceFtEFau8xmyg8=;
        b=CQ4rm13gbJw/so+CP+BfQGmIdayB6FRxF9EI54gYohv7wEImtQli2vEyPMVeH83zS9
         dDZy4axl9VbEU/SlV4XCL3X8Bk66swRZAHVYgzy49aD45zcRsv0b/qBkOQtOogmR229w
         ktFi/vF27iJXzSp4tSIEQxydOyrUqPV7a/KeFawlYP/PJbCllGwhWq592becynvT5OPu
         Js2kP05ripYSE3TK/IvIChz21yDS3R5grt4zv3sHYhoQ0shpgOOcn7jDikdrommjQyyQ
         cBZ9K6ziL/S6WoA0rt8vB63zMTU+hk28WTkgYm041IEZZBvxIftPMZSDO823DpytKsXl
         AAXg==
X-Gm-Message-State: AOJu0Yy1qcnDQz3+o8cRTchc6MOblnjIVSUiu7yphod+X9o3837sv6XI
	TppuWTe2bJFOzzbMRnR/DLMmE7bHQ0djYPEX5G/5tKsCpsJniTWUQx93JWti
X-Gm-Gg: ASbGnctCxGFgQCnziWeX32iu6Xl8NgpTchTiW5ZnKaojeiS7YThNOK154qLOo7fxe9E
	XJtsCjGew4hJZii0GLmGRk4BAw6qkk3nYpNY10W5xfuoDRDDVxkc+InnJpEBTVnw01IMwBAw2zp
	C2GRIo3L+gCxM9eDIS+S0ZtcGs4MgY7WgTRiLpN5HLd5oXEVA682hhtbXzPDyeDRkS8QV4onSEr
	YnoNlx84Bdde1vXw5KlfzJIicm73BGZjIlk0lJ7BNEwg3Lr/G4ZzX6BriL4PAu/zgYgDwpNoYih
	4Ar3DynJ6jGu5L0DIX01UTSFQgfpuqLtqu0JpuEO92Rrf5rqPVY3oUYsVPrqzfkKm94pOkk=
X-Google-Smtp-Source: AGHT+IHBL7e+Mm51CNt9pJm4FXKqDvyl2TBZ5757KUpFDSx1AcsjQIpfvuXJJXhTZ9t5cVoZ9g+3UA==
X-Received: by 2002:a05:6122:3213:b0:520:a84c:1b59 with SMTP id 71dfb90a1353d-5234972a094mr325547e0c.5.1740593494134;
        Wed, 26 Feb 2025 10:11:34 -0800 (PST)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86b1ef052a6sm857744241.27.2025.02.26.10.11.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:11:31 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/4] org.bluez.Device: Introduced PreferredBearer
Date: Wed, 26 Feb 2025 13:11:26 -0500
Message-ID: <20250226181129.2958079-1-luiz.dentz@gmail.com>
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
 doc/org.bluez.Device.rst | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index f8d4a68a6b41..13328249b0b0 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -40,7 +40,8 @@ void Connect()
 	are skip and check latest seen bearer.
 
 	3. Connect last seen bearer, in case the timestamps are the same BR/EDR
-	takes precedence.
+	takes precedence, or in case **PreferredBearer** has been set to a
+	specific bearer then that is used instead.
 
 	Possible errors:
 
@@ -346,3 +347,29 @@ array{object, dict} Sets [readonly, experimental]
 	:byte Rank:
 
 		Rank of the device in the Set.
+
+string PreferredBearer [readwrite, optional, experimental]
+``````````````````````````````````````````````````````````
+
+	Indicate the preferred bearer when initiating a connection, only
+	available for dual-mode devices.
+
+	When changing from "bredr" to "le" the device will be removed from the
+	'auto-connect' list so it won't automatically be connected when
+	adverting.
+
+	Note: Changes only take effect when the device is disconnected.
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

