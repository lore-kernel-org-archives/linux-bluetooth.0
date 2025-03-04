Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6192152E02
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 06:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069213; cv=none; b=X4oNOqyX9dRVWAxlZTQDqs56ZgTG5A9SQUMZ0G/rkKlmH7e5rA3vDB6rf/wKZPuzkgtfJpYfgG90rIVVHN+Uxc4dbX3NkvP8ReJQ4of1ATDQ/NVhdJBSPmpz4OnCLTcnfe+2gVdfXQNeX7WO7x083WfXNFOXrx/Mw/d1FeaDPA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069213; c=relaxed/simple;
	bh=/3v50MjACHqJSIQ6sGqUqW23FxE+6uJ7VqbJpdhEk9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z/y0oO9y5a8jeImLY5xg+RHl6GQD/gmBa5GbvQ31LaxoCl+15jsbkaAskOHdmKYeY/FyAjMtTAj00SkP/D7QfKIJX4DRKVzDEWGt1C6olehl1evUhWCh8iH6Rb+HQgboZtEV0nF68v4LVwtjyJRGJmNVud7ob8DM60a0qLaJLnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmAgE5Tf; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmAgE5Tf"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so6059285a12.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Mar 2025 22:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741069210; x=1741674010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slTRLPIsI0FSy9erYvSOEpbh681SCuOBNN0HLHCN390=;
        b=NmAgE5TfIauqTctZGDv8xLNG2Ad/IqIqbkD+RUbH9P6R9gRod81xZHM6/S3ppBg9u1
         5YjNI0lFY4HKUbmoA9VaxpY5+FybctIWw6dP5QP+Rll/Z2NCW6+qYEmqVhrk+ZZlkwDi
         zfJLcHCzGWETGuBhhJ0+QR9RPrND9BYPQxeu15lrU9tjpJpQj0i1yylZWwyXNNtMVrNr
         EpvBzOdghwW0Bq4ck5Q23IK+QHPVsKeU8M0cS+zKuVVRQUbtWT/WCJoipTQNoXHAUzG2
         gW7lGXYAxn6DgnMFg6MWKXJoi3kppjxfSLTWPAamhVYA5jah4W4osRaUCdZn1l9c/VKW
         1Rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741069210; x=1741674010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slTRLPIsI0FSy9erYvSOEpbh681SCuOBNN0HLHCN390=;
        b=ppb8xfUzZK8h0NFVzURlcck1RPrJcc6JgQu14qn4HWPd0zK8bpto2Cn09GLuqLDSBa
         7CZ9SZ9k8ww9JBCSZk6Iwkv7Wvf9Cb+PoKB2xlurId4v6tEx2fgsPkFbJmQhnHdDwVRt
         JekF201gk+CWc2HwVkB1rz6knlkRdvb3FBuhTKC5msXBX/VHjZqkBPT1Z2yC+7A6NbWp
         e/VSvsfOekCL82ireWn705P4GeHgLe7yfRHkU2/oLCvWEZxIEdJuztIoTSG/zLOZVWfu
         nO19IcpJzlPlCm+Pb+AtCacwNpIE+LG5zD08AIpC+B6tjCQ8AdRXFOGVChb4psebClGm
         j5yA==
X-Forwarded-Encrypted: i=1; AJvYcCXYzF4oW2Yc2FbLRKmS0xFwO17vLFThI9kChmRtGrtw2cZnaX5pdb6CBrfeA0lGmm8Z3A9W98vFWbAaFEcE3oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNPd7SL+nNOiKUAvZ2mIhaDOftvssDZPgLy7G2+jv575faC8UC
	/yyaFlbpiljkM5gAJP7M4+F80fzdNHi7OLL9qqeFSa0o80J9ckJ+N58MwbYJ8DU=
X-Gm-Gg: ASbGncu0SElG9Sx6ZEbsmUl2WCzkvvPc/pZSC7equUnfgEe3DdTLzyvDzvCEhIyoOF0
	ghaIbAGgpFOsvN66PPU2ts70v1Ev8s2glgVgMUNv5eGqpz715gQsIg+RRvjFH34L/VfzEy48xXV
	Rqvd73FIuRXjq09pHlP8djf1tmQGzHqkaZIxeiksWBuWCtDgcvjfYK/7p3eJGwZv2EacFga+yH9
	DaMhw/V7UlVMZEk/4ET6YWe+1Nw9Pv9XLoq18A91raJXXCXcgGLyoo47bfdCRaqUty+vd6J2jl9
	6EC3tTBW51ykJTgdYVE+opCpjOWI1fxC5UoPNBlFTSneLh4C75SnKnxb6h34Qy/EQUK7KO+NDHJ
	R7gxBe7dhfyHhCvLxBJiuSzhG5dfh0tJfR8H1eg==
X-Google-Smtp-Source: AGHT+IGyF2AiPFdGfapjywzJEDykADX49ZZbdevCtKn85Um2+nw0n0v9LoOSLvMAPhrL5KXCkj3pgw==
X-Received: by 2002:a05:6402:3493:b0:5de:b438:1fdb with SMTP id 4fb4d7f45d1cf-5e4d6b629b0mr33982850a12.30.1741069209879;
        Mon, 03 Mar 2025 22:20:09 -0800 (PST)
Received: from localhost.localdomain (46.205.201.86.nat.ftth.dynamic.t-mobile.pl. [46.205.201.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6f5363sm892708666b.123.2025.03.03.22.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:20:09 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: luiz.dentz@gmail.com
Cc: arkadiusz.bokowy@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/3] client: Document connect/disconnect optional profile argument
Date: Tue,  4 Mar 2025 07:19:59 +0100
Message-Id: <20250304061959.34839-3-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304061959.34839-1-arkadiusz.bokowy@gmail.com>
References: <CABBYNZL3UsEQk7t2rff8gz7f=-=VbrbAvWGPkx5Kn5Mq79rfuQ@mail.gmail.com>
 <20250304061959.34839-1-arkadiusz.bokowy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 client/bluetoothctl.rst | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/client/bluetoothctl.rst b/client/bluetoothctl.rst
index b6c2efa35..fb0999626 100644
--- a/client/bluetoothctl.rst
+++ b/client/bluetoothctl.rst
@@ -9,7 +9,7 @@ Bluetooth Control Command Line Tool
 :Version: BlueZ
 :Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
-:Date: November 2022
+:Date: March 2024
 :Manual section: 1
 :Manual group: Linux System Administration
 
@@ -262,6 +262,13 @@ Connect device.
 
 This will initiate a connection to a device.
 
+By default this commands tries to connect all the profiles the remote device
+supports and have been flagged as auto-connectable. In case when the UUID of
+the remote service is given only that service will be connected. The UUID can
+be either a short form (16-bit UUID) or a long form (128-bit UUID). There are
+also some special values for well-known profiles like "a2dp-sink",
+"a2dp-source", "hfp-hf", "hfp-ag", "ftp" or "spp".
+
 To connect with an LE device the controller must have an active scan report of
 the device it wants to connect to.
 
@@ -269,17 +276,25 @@ If no advertising report is received before the timeout a
 le-connection-abort-by-local error will be issued. In that case either try
 again to connect assuming the device is advertising.
 
-:Usage: **> connect <dev>**
+:Usage: **> connect <dev> [uuid]**
+:Example: **> connect 1C:48:F9:9D:81:5C**
+:Example: **> connect 1C:48:F9:9D:81:5C hsp-hs**
+:Example: **> connect 1C:48:F9:9D:81:5C 00001108-0000-1000-8000-00805f9b34fb**
+:Example: **> connect 1C:48:F9:9D:81:5C 0x1108**
 
 disconnect
 ----------
 
 Disconnect device.
 
+By default this commands disconnects all profiles and then terminates the
+connection. In case when the UUID of the remote service is given only that
+service will be disconnected.
+
 For LE when disconnecting from an active connection the device address is not
 needed.
 
-:Usage: **> disconnect <dev>**
+:Usage: **> disconnect <dev> [uuid]**
 
 info
 ----
-- 
2.39.5

