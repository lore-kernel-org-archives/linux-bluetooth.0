Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78613280CC1
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760045407; cv=none; b=ZbY1uooLbc12TKGdzIxwUTHC4oAUn1FjXgZzBz7ZmfSY+ICexxT14mx5FEH6xF3vyqGAh7eH5lARpD8qmG6YWqBUcnmATZXzv4NrDLRE7VYLcyEuCe0/0xc3JD/66tgOSrKbExZgIaenzz/zivIu519jZKq638D/e+tl+E4kWqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760045407; c=relaxed/simple;
	bh=llqDBDmOJK/CKIPTIM8yL1+6QhVHbwgrXQi40KhoIpw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbAMhKQQfHUi+5uOEVI15s2sH455LaiJZBtf+4Ic1SN7akcuAGnpwZOUv53Trysh6ElRIQKimDbztnY6GhD/XEr/lkQYbQ/eeJQgTNO8vRn9FrsSPi44nCfpBfV05rNTi2h5r+MQroHZLaE643U6LDSfelQNmSZgeYxZDKCwrsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2JYhcz1; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2JYhcz1"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-89018e97232so375280241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 14:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760045404; x=1760650204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEUdPpa50PFjMbWXhvz0VvuyCuuWRmBGJYgNoclhc68=;
        b=L2JYhcz1ETAWvzRbHyb05DHiYqSv4CH8sqrKmtSDMJe6TL6HbAYoW9hzzi89E+d1IS
         DFAIHzvTC5KoBaxRXpHIPkbxo6EtuDjyyF9tOuqpTnRKiXG0QFwhuWJWLUfm/lVWyd/z
         hOSVLoNaR9N8iaOW0HQSHNUExRlGJBe1vwS9dv9SZXTVreaOHrweA3drRG+fEf0BXQjQ
         OVymLoLBQgxuxabB0sl0S77L0Bva9UR3QHsXdYADUL2zD4L9oqX57L+D+ao/8ebea6m9
         X1645bXPNk4diIzfhSJnKPhaMeOHBlOTbIRlGHpdpM1QU+Ob6F11TDXNqERfU9+79nzi
         dK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760045404; x=1760650204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEUdPpa50PFjMbWXhvz0VvuyCuuWRmBGJYgNoclhc68=;
        b=DjPLUF89EaITfSGuXSuN/dMBg81eizMvLCRFC6pDABAgs8OOTKY3vsR9YDQfPi5uWz
         214PCsZaUwQNTiu4oCi9negvCbTElTorlA8pVn+2i4VoffFmabGF7z3jurBWfnPIcAOb
         hwFTgXx1oJnGqaUT9AgRG9X+ar4SD4huF08j9awJ6gTtJpg6QVjN+SPpj+Mha6S9ywUA
         VAwUp0QIC8QeFKWC4c3X/Dfm/iVkmPzhverUvXAtPL/iwJU+rOxnLH9DSGoil/P77HvT
         s0xNn9xZyn7SGvCipFvAhyhEoskPeNBhz/kMdug5xPgPYVc86gs3df7g8wK6IMrU8CI1
         QpTQ==
X-Gm-Message-State: AOJu0YzuclfwcL6+wze0RpVJ+GGkVfo2FyaHj69uf/7RKkTRSlEsFUXN
	BeQMEg/Fw/Vjmtw01Jb7Vm+SkBYkhMy26kDzZgPXfbnuMuzluo/w9kwrgR5b5S6t
X-Gm-Gg: ASbGncvDLjqFkJagRoxpDrwhI9Zil2xY37/KLjs4YJsE7Vsiv3VOsLHuUzEUsTt4ZyI
	vZube6wIMbaKRk7dGha+vgdc4mh6TdaIP0Pf76MPCf/m+9s5w9pdpdrz1ZymbTK66t7kam4ciM2
	y2qhflOyqj/8jj2HA+zKIfzL96w//0SofzLzxk0aTdCxHq/Hdrm2kgJFFaPLvEloGgcia7rwpKN
	vFM4pZ0gzrbnHurc6FTSP+vQPPyr7/+TXdbBvJud9cmwt0mhtIjqsZLqMZqpphZ7zFgPEEJ7UVb
	Y8sfVqkvylIYome8rwgc+z6vQ4Gg0PUD5imGgLNroYZSmgM1eaif1OOFZuiW0R6fr7ndCBUfECn
	Rtf1Cy8eZSdncbZa+p6Pdr5oGm8Ct1/14+NncCYUdq9YBgz6XobNbwn0XwlJZFVve+Hm84rAQRT
	wIg6xpRAvI3Vu5pStbR3g7M1SNMREwSZHS3Lw=
X-Google-Smtp-Source: AGHT+IESPbHfOlFWnxMg5M7xND2gMNr2HwLTPuiJxULDhPCdSt17AmHZ8u2ndIOvcG+Jt4qLik26sA==
X-Received: by 2002:a05:6102:809a:b0:5d5:f6ae:38d6 with SMTP id ada2fe7eead31-5d5f6ae3be3mr1364361137.43.1760045403637;
        Thu, 09 Oct 2025 14:30:03 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d7f01e3fsm211224e0c.7.2025.10.09.14.30.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:30:02 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 10/13] MediaAssistant: Add Device option to Push
Date: Thu,  9 Oct 2025 17:29:28 -0400
Message-ID: <20251009212931.445719-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009212931.445719-1-luiz.dentz@gmail.com>
References: <20251009212931.445719-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables MediaAssistant.Push to work with local broadcast sources.
---
 doc/org.bluez.MediaAssistant.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/doc/org.bluez.MediaAssistant.rst b/doc/org.bluez.MediaAssistant.rst
index 64e689f8621d..8650d8abb379 100644
--- a/doc/org.bluez.MediaAssistant.rst
+++ b/doc/org.bluez.MediaAssistant.rst
@@ -40,6 +40,11 @@ Values:
 
 		See QoS property.
 
+	:object Device [ISO only, State=local only]:
+
+		Push to a specific device. Device must be connected and with
+		an active BASS session.
+
 Properties
 ----------
 
@@ -52,6 +57,7 @@ Indicates the state of the assistant object. Possible values are:
 :"pending": assistant object was pushed (stream information was sent to the peer)
 :"requesting": remote device requires Broadcast_Code
 :"active": remote device started receiving stream
+:"local": assistant object was created for a local stream
 
 array{byte} Metadata [readwrite, ISO Only, experimental]
 ````````````````````````````````````````````````````````
@@ -59,7 +65,7 @@ array{byte} Metadata [readwrite, ISO Only, experimental]
 Indicates stream Metadata.
 
 dict QoS [readwrite, ISO only, experimental]
-`````````````````````````````````````````````````````
+````````````````````````````````````````````
 
 Indicates stream QoS capabilities.
 
-- 
2.51.0

