Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9922E2822
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648436; cv=none; b=UlDtkO48g92vVe909ks5kj8Iz/s0F3iH/EHB91JE0b1uy9O6+HCu5RYJIsU082oNuuQMh7DizDozNrr7f9w6tK3+88xfw/f+SG253BXDdpaAGpb23p7BeGKETh26Jsh6wjJvZybnEQFZ4os2jcEFrsifN+IvZZS8p5OsgA41t8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648436; c=relaxed/simple;
	bh=llqDBDmOJK/CKIPTIM8yL1+6QhVHbwgrXQi40KhoIpw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brq0sxqKpf8TwAWCri86ucMuZhMQp3qq4UxwTdkbP2gPc1RnxwKLgIuU44vwgbyf9C9XMCN+FBZHjZlDM/YoaKPgUceuj4Bz1IZb/jPqRRbFbJuzKhYS2qjDe0N5F1KDBue/jkXt9xGGaV9crjV7/uBJVnSBh3VGEpjOBfI2/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezru5K7j; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezru5K7j"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-54aa30f4093so430168e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 14:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760648433; x=1761253233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEUdPpa50PFjMbWXhvz0VvuyCuuWRmBGJYgNoclhc68=;
        b=ezru5K7jWwYzEboQnRyHCGDn0JOltyDO9ityCoZetxLEUUCOuOe9x5FrAfXjsg/wOI
         ZFDGVS1ajOSEIIt4YxkcS0+idMX4Fe92uoRuzTnH2o4/qRcmHsTKMjcZQoSve9PhkfPX
         8Yg6CZRZYKHmisymFowpq6Vsxnt7kt2+up9Uc3PRWgvyUmrjojuth8OK37IaaxBEZmYw
         fHXW1o6rc0Q3nv2aRBqzsyZzbysciG4vkvaeM5pgaS+/FywMaXyDEfy08BJTuArT8aJR
         ECMFnwvlLI8KBS0CmvhmUoEWxQJM4hziNM31yZolvT4mVLYNqPNvONQBX9HaFTKGkRVB
         JEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760648433; x=1761253233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEUdPpa50PFjMbWXhvz0VvuyCuuWRmBGJYgNoclhc68=;
        b=UvOtp+aPSAlAclbUCzGeMJDwxfpgvkXOWHt09+iG0lpoZFKHkOLTlqrSlm/N2dOb4Z
         HrMb7xHF9620Q5RmTht+b3bOdJvM8fu+XLg+8kF3rXP2yrYzrfgJjrpGyrUcygjl78el
         PBTLjzxDv55gM4H/MXRDI10Ls6iEPphAB9kjy+laDGkAyyv0q9dor+NwiThaWLrGA3TR
         vtDtAAgNTJFd4RjdJvAQdMBasQZYpxKj7IpN4UFUVQwaENyQC0Ef4aM3UFOD9o+uCjOD
         tFpv4yOds7C8EwSP68/qak02h/9YMpoAMuSvaSHDfgGIh7Rj89zYvfnjE8/Awc6m1jqp
         U4Ig==
X-Gm-Message-State: AOJu0YwlR5lmUElmBJvSsZTVwrqKIBAUfuXojTodlKq7gP1uvJLDVL6W
	/AIBvUsnqDq17mHxuAaVv2dHoMvxcMqm76ozbma6tWVEa7n7AikLQ3SjlwOws+74
X-Gm-Gg: ASbGncs5nkWTH+eTDRGORx41ncDgj0y2iky2/zhahIfJerZHQPsv5ljI8Njl84owZvM
	xL34TSoBfJeZnzYiJ3Rf4nPWFedKEl60u0DmeKvWxP2WHpihLYmBZINdEWKV4ihTVXb7Om/o1Vi
	i8fhOzBu8Q73RYO6Xx8V3qoPS6U3aG2+jeYA/Hv1TJghMAmEeBpiAy+NFrFMP5nZNxVxZFaNPzP
	/c251zyp+PiJf2u2LHlu29FkTgKOK6MVKIsw4EGsd2wHhraBiWy5GBb6cYjPpTjOzKEYPWMW7bT
	1zf4M0YjbQmcAAnu5XGVpqdopo48nPi2zKso3Gejb/q5P54AsW7axEuj7rkq3JZqpyaVGOEvTYJ
	xmArRvUKoYi3R69w2jUht/BN/AVwMGR+/ZQIBnVyOF0K2P/AHfKXUmLVAQLBj3/dlHqj1XWY57o
	f3irs=
X-Google-Smtp-Source: AGHT+IGl+iUEdnxqZYrJKw6rvV9EzJbjy92xbFZ9rR+yp6qoztOdfHLmBB7graxVC7CqYCofEmsaTA==
X-Received: by 2002:a05:6122:30a7:b0:539:2a2c:6efe with SMTP id 71dfb90a1353d-5564ee44526mr800029e0c.4.1760648432990;
        Thu, 16 Oct 2025 14:00:32 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80d9bf0sm6590304e0c.18.2025.10.16.14.00.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:00:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 04/13] MediaAssistant: Add Device option to Push
Date: Thu, 16 Oct 2025 17:00:10 -0400
Message-ID: <20251016210019.191878-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016210019.191878-1-luiz.dentz@gmail.com>
References: <20251016210019.191878-1-luiz.dentz@gmail.com>
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

