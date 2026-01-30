Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88D42FE074
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801999; cv=none; b=TbGhIGjxPWVbhzpBIQ3U5J+zQPOXe6TbsG/yTomujwkLhS3FebOXL/lCwK8/kZ5poASCFwV6NyHefnafwLZV+J1ESH1o2R/vzPEptuPkdR9Hqw7En4O+ZyHW42NKBGK8bGS/o0TcaNd9ZJ8J8KhtMzLqSuDXRD5qw1IpPV+dH+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801999; c=relaxed/simple;
	bh=SJ3L9suWDavgyRPVmbE0X05M7jLQssFGkVvY8S1rgxY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcChhScS+VT8m2EdeBNkRiqKZk6WVh/JqyJoJCSw5x389TVGuIGgCR/aNoPtFU+Jlzq9pzFqCxlg6veY9xI/3PQtscLk4cHrbMUbPcNosAH2A2zsXWf05l3B9epk5vObQWjQbcpJsIqRBNkayUdubmYPUw/WkbPrizzftYKDL7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQo35Yd7; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQo35Yd7"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-55b09f54e98so788321e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801997; x=1770406797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQqX4PlbvX3MdjlYM/n+PoOQhvWQyd4gwNUyg52wW9g=;
        b=MQo35Yd7RV3u3Ao70enyRL198pnz2lmx1fZfmWDUPE5XnwRdmj/xHqcWHU+qcbef+n
         IGOh2V34/rM0hQYfyJ4yadSeJqbki5GpvtFndh2KtS5Ll3PaxcnVAVhfSZBEo5Y4WKb/
         zOfMPGz92VUdGvy9B+fYK/jgjd9gx50FVj+uo6qf9nTOtvk+npTDHrWZGfB6sraec6KV
         ax19Ylzo3geZekbiFt450ZTbkmENDYdNPDeyQLVe0IyIoM4UmtGndQDNscBxocjXRV/N
         Z/QtF8HX1W/aGfzp81XmqQk0FCCt8UlWjpBXb/6siJD3qPa25IFFYFhrvbYEaPsBCcK3
         Wb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801997; x=1770406797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nQqX4PlbvX3MdjlYM/n+PoOQhvWQyd4gwNUyg52wW9g=;
        b=QQhlJNWoTERMxMXTAYpMxzD058+nTTjoTB8kdb4T+Qni6xbGbvJcAJWVGsDS9wolwJ
         B4IYNHw0VystuNuzM5E6Ldnkck64zU1RlzNCRSOqa3UyEzmlU2aMppKl7sA/lmLgBGyo
         hO8P0y2tev+dwRUOz6RIMiNcwZqDZSjnP4QC4+bW1mIM9i1PRGKlaETARwse8wyuiaOu
         +fIBGk3Y8++Oa+xY4LQ+cyJ7LMyWcvZ52AujK86Hi1ftwl/7mpoaltDoyx4P2nQrkZG0
         JUEaqdssqiQeWUMTSGzoY4wyokX0F0KepbnWxfxGjjN+DMbiW4NaeT8w2Hlut45xAYXE
         rrJg==
X-Gm-Message-State: AOJu0YyERl4e3rZDF82zJ1x824+VqUhV22aMks/OtUBSBJBESSE2ihj7
	m31zzwHIbG6LRJt/MFzkty+ivTQirEuRgNxppgRWae0lS0YZAkuWVzsicnY/sg==
X-Gm-Gg: AZuq6aKWdWXLLatcqqbfe+9zwqzDIBcz/2YSJVQRSlm4K9OO9eLygg7E5z7zK8mVKqu
	2sDNCtt+vhA5r5g96xSbOR73lOylipLfq2lOsmmR7WioIHaUEzr/lo64qG4yx12CJ9CZJgmPwhi
	rB5LmkLa5Arv4CFZmA1oR1UGmdr8KHfs0PC8kYfTzo+RA9oFC53ON6c7jLyG5KU6wRe7bnEvsNT
	YIrqpOYzgXybhG6IkyudlqJ54yjxSi2eBo04BaxsHPPxBfVlj5/Hp4ZEzB9f7p/DFATpE4hR/Nn
	omZM8uVw1DYz66icrVM6zCh4eSS1X+gMIj5UEpwKePCfb5nIszZKWV2+OyvziUKwolPdOJcuuWd
	kyljF2ttQxGE73a5aEHTGE3ER/Hb/xxGVHq40hA4ermadJ1n+LxqS4RnhfJZUU0hRwh9mf+L7X2
	XoRt1Muy36Dhj/Ugo8gzIb4ybRGLv60ehC4u0tOzufHb/GyRLGjjodzUIcCf7WhI8C3FEcB7/Uq
	yeLLA==
X-Received: by 2002:a05:6122:2983:b0:559:ed61:4693 with SMTP id 71dfb90a1353d-566a00a642emr1480530e0c.10.1769801996722;
        Fri, 30 Jan 2026 11:39:56 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:56 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 27/35] doc/org.bluez.GattService: Add Used by reference
Date: Fri, 30 Jan 2026 14:39:09 -0500
Message-ID: <20260130193921.1273263-28-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130193921.1273263-1-luiz.dentz@gmail.com>
References: <20260130193921.1273263-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Used by: field linking to bluetoothctl-gatt for this interface
exposing GATT service properties.
---
 doc/org.bluez.GattService.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/org.bluez.GattService.rst b/doc/org.bluez.GattService.rst
index 9aba1c166f74..04228b9b3665 100644
--- a/doc/org.bluez.GattService.rst
+++ b/doc/org.bluez.GattService.rst
@@ -31,6 +31,7 @@ Client
 :Service:	org.bluez
 :Interface:	org.bluez.GattService1
 :Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}/service#
+:Used by:	**bluetoothctl-gatt(1)**
 
 Server
 ------
-- 
2.52.0

