Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4183542F7
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810597; cv=none; b=cK2+3+XMqogfhNPq+o+NbueIN0K0h8Y6PjQTQS0uxf/H0L7p8P58dnZNC7nV/0jrWXiego4ma6xI3RztlXzcCcFpGFlOs7EaVe3ZfVEBvJdMYaQDjP2ftnm4P05gHgfU7WbjzWg2dMoHOANKk0m3/1ICSOF7gaD+yzqx5gUW3rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810597; c=relaxed/simple;
	bh=TD+CuGcIvDaPimwKINOlRGTuQL15w3mnDjMjl0/s8nw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meDx2atKQ9Lqnuoagqu4aukwKs8Kv7YN4WcGoEsXxNk1Te3oauExg1Kq0taCyKHXMbw4xOrSrhorpBtMT+gK3kcZjQoIgVcx0FNYBgHNQbhfgThPbGZ8NYn/mxOXWVpBWw8++m14CK462tbMMbXJmr0sHh+fQNSi4L1dlg7xPig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bikBbXxA; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bikBbXxA"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9489fb38cbeso218719241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810595; x=1770415395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhTVuwCX6gbfp2NtwUfGwE0PiEoOY84bpBrCc/ARsVU=;
        b=bikBbXxAYTQnlCxjOQI3VCmTJtleDmKwz8iCjlOOebwvHQ7L8zsmFBwUGovXhv/IEo
         yyTjv3HjU1weKlH7TieyiNWgewsauSrCkCuTjXD7UcUYPrqFqToy49SB+gkgDa7rF2Pw
         0i8CCGh5AQ8u2sASzYmqtAIPKHpqBV+GTac1nQxQeiESyYYYyMWGOVGHOAEk5Ky6kEHs
         7aBW4vXTkm3icjgiCM/F/8LT1LpItS+VlbNHwmpb8L3+zsp/X8m1hVoq+4q2P6MTrVi3
         1x4AyiOu5j6ZXnyoeG8eZFbZA+NuwudJnVWcWObWGByIZvRCruCjm2YM1hgywcKNk5Ia
         9dkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810595; x=1770415395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GhTVuwCX6gbfp2NtwUfGwE0PiEoOY84bpBrCc/ARsVU=;
        b=TAw24u9ihLGfs0y1FPe42OmksugUx7WvLMHHe73tjdIHWVjJ2KJbqBl718yqF3loji
         2Y6JMG5ev+4yDYxT7/zS0ELp4aR1gbaVbW7ymBj1iBN6pPxgHYsT1QTE+CJfRnIF8ft2
         BJ4Gcd9hOn+bu5e+ilKJCQNH+L3U/EB526WmOyc9RKar8w3d1qgWynGnlZifSy6UHDdV
         KFZSzndhlV597hL8ZWH+4WNbQ4lile/3rF1nzt9yKbaIFQVwZb+/jNFvt9+5z9zjhEK6
         tQ2IaKmQBjLvPHqUqXvBFXLBusyP+lktx5M6sur0ZcUrT0YsGlTYjSfaauwUXRiWoq8R
         GwWA==
X-Gm-Message-State: AOJu0YxoxUOG3OAtgepWtW0SLxpKPuLY2LcvX5Gq9nZ2ci0WIlLS5Ip/
	+tVxiZ0m+Rt4PC/2HdSzRtv0eczT1zr003dUJNPZtRkRl/PwHwWvHIJw+11yQg==
X-Gm-Gg: AZuq6aLWhuci50LS491ZOdn6GT4RmkE0Egb9rUFjPmul+SLis0yxv7Uf3QcYjy2lnyn
	wBQCrfbDb9MpT8lP7KomB2VKAX3kGvFZVuImtd4sAL0rZ+8ykj3u8tVfS/LW6jt6PEChQMw7EkD
	Mf3bICgWKg4e2D/dmnQTamR3Oiv2LG9aAUZoFvptjMYQtYHnpe7GOfVS0dz9o4UkhGo85r/7BEZ
	74061yQk5SH9RVml7wl8fK2R2mFEcR1QvJV/tXxRMg8DlEvQ13ff3lwCDaDwRB/58WCGLdQjtlG
	a7u8GFPcQIAzCpTQkvw/8+x/a+/y79SSN6ndd6vvHI/e4pW+X2ejhpMwXsa31MDRRW6XeZ8CHGz
	tazJoFoe3/hr56aGzE+5ExKKtSpmB/ZoeadYJsAgYj4JzUszwqvD+EAgCmsM1w9XIQWA9eHIxLJ
	dHr7N9CKCweVBC26TUcMQforBBiF6xOlxPgmJYo8ydy8EWggyzrIwB7M3RuIeyztAkNrZT+7Z6l
	McPZg==
X-Received: by 2002:a05:6102:440b:b0:5ef:a416:be63 with SMTP id ada2fe7eead31-5f8cdc8e1famr2859131137.22.1769810595240;
        Fri, 30 Jan 2026 14:03:15 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.03.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:03:14 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 29/37] doc/org.bluez.LEAdvertisingManager: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 17:02:20 -0500
Message-ID: <20260130220229.1346261-30-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130220229.1346261-1-luiz.dentz@gmail.com>
References: <20260130220229.1346261-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Used by: field linking to bluetoothctl-advertise and Examples
sections showing corresponding bluetoothctl advertising commands.
---
 doc/org.bluez.LEAdvertisingManager.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/org.bluez.LEAdvertisingManager.rst b/doc/org.bluez.LEAdvertisingManager.rst
index 464a2e5fb726..c7f575f7991a 100644
--- a/doc/org.bluez.LEAdvertisingManager.rst
+++ b/doc/org.bluez.LEAdvertisingManager.rst
@@ -21,6 +21,7 @@ follow the API for LE Advertisement Data described above.
 :Service:	org.bluez
 :Interface:	org.bluez.LEAdvertisingManager1
 :Object path:	/org/bluez/{hci0,hci1,...}
+:Used by:	**bluetoothctl(1)**
 
 Methods
 -------
@@ -52,6 +53,10 @@ Possible errors:
 	Indicates the maximum number of advertisement instances has been
 	reached.
 
+Examples:
+
+:bluetoothctl: > advertise <on/off/type>
+
 void UnregisterAdvertisement(object advertisement)
 ``````````````````````````````````````````````````
 
-- 
2.52.0

