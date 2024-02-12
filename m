Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC793E49E
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759558; cv=none; b=o3C7YjCpr9Frq4TjFQIV1n7pwhmHZtEFukF4q6nQhdk3ErAXLlwSEfiai5W95hYt9Z2bH5m+4WX7Yn6FjUTxUJ7xRQ8g4II9T5OSmuQ8mQrtT682PlJ57Ek3TF3tWLHPatEt8kjQI1/aeMoWKmjlcdSGDfjwMrQiDZCwpLwwluI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759558; c=relaxed/simple;
	bh=tlcdzbs0oR5C626fh8DYyDQnu2AI7UqREAWt2ZI0cDU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQiHNF68Z9eCodlABYPndynbkYquY/flfvHSOIcIGFuNJU3l8X+FJc5TEM4DGq0id2nWf6O6y5maHBIwwYjeK66M56CMpETIBkjR4aQjk8feNSY7wlGPEkj4ps2cXfyVFp08pzBKfD5pYiX/chnrG5v/hlLfKNiQ2yowkmA0//A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qg8tGcXC; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg8tGcXC"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4c02dfa01a8so574176e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 09:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707759554; x=1708364354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yh63fJ8pNe/oEDQPYXk6yQ116ueCGKRbDhPhdpyok80=;
        b=Qg8tGcXChBE3o0Y3p3BxeR+KD5/JhUWIycbljFIjQfjkoX5KpbH1BkBR1jT3hsptfW
         4LwPb3xSb9sIo3FNkBnb6v6usWi3FDAqG3EXrMvTXysYWAM8UBpE+UWjoyioEWHi4Tc2
         4xWauDpeeTRJ/pbqO7osq5MhHr+KF1DiKGXIaChb0rYNk1Ffu1MCjadkU39xHYnm+xP8
         GvIZIELODk5Mv8YQUnDeuOC14saWOBuUP0ZYXPaz8Zeg68LK2dKl+GCgbfARfaoMKPoD
         D9k94ERDnrh99Y36bCUcFEKI/WiZTGifAQFVqTVOS9imR+AeprBR0PfanwgJwkSiPaBk
         /Fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707759554; x=1708364354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yh63fJ8pNe/oEDQPYXk6yQ116ueCGKRbDhPhdpyok80=;
        b=KOf62KWx9sY1ZxeVMETpmZ9CuvG0Y1G9ea+NoWsIdR1qFjvJERJsQXVAgMNFf1Hf71
         g6mcwZkVO4nLLNfiE3jUPkCFsNy1ybc6GfVjxcsJm0+UIFnt1bHZsUscPJTxaK/+R4Lo
         5LmDwXcjKoUs2TzBNgV2dALCIanC6f4Fm9g/G+gxY5Udw4Bz6H8xV3MI4rBqfVUOgojQ
         hLfoJudTtiP6/a0fTyqNmySXCJcjANHa12BEgfz5eMFDfXSjGwCC1pJg+NYmAyza/yX6
         y3oPkgGglhbZa5DImCHLSP0pMxViOINVAsQXEPYgxi2kZEuExuKEY45PaYhQnDvjux4D
         Vp5w==
X-Gm-Message-State: AOJu0Yxdt0/ZLEm7QM2NQOOj7cJq5fjSo/FcbwDLtxvdxFvORTH/kwb4
	PFOWMQoZrNHfQFxGWSqP29vVmQ4UZxlBUg3lrMrr3uLC+nQcWN0BAzPlmixm
X-Google-Smtp-Source: AGHT+IEKrN5TKwLge5qNxzJ33a+ETzpPVn8Sv/8Hfi8k7NJS4hUxC9eX0twrCyiseVJG2MCPggE3Mw==
X-Received: by 2002:a1f:dac2:0:b0:4c0:37a4:dbbd with SMTP id r185-20020a1fdac2000000b004c037a4dbbdmr3183885vkg.13.1707759554396;
        Mon, 12 Feb 2024 09:39:14 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id eu6-20020a0561221c8600b004b75720e155sm767686vkb.12.2024.02.12.09.39.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:39:12 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/3] input.conf: Make UserspaceHID defaults to true
Date: Mon, 12 Feb 2024 12:39:09 -0500
Message-ID: <20240212173910.4061556-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212173910.4061556-1-luiz.dentz@gmail.com>
References: <20240212173910.4061556-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes UserspaceHID defaults to true so the plugin has more control
over the input device lifetime.
---
 profiles/input/device.c   | 2 +-
 profiles/input/input.conf | 2 +-
 profiles/input/manager.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 6c64ff1c1c52..ff7e3482d0eb 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -81,7 +81,7 @@ struct input_device {
 };
 
 static int idle_timeout = 0;
-static bool uhid_enabled = false;
+static bool uhid_enabled = true;
 static bool classic_bonded_only = true;
 
 void input_set_idle_timeout(int timeout)
diff --git a/profiles/input/input.conf b/profiles/input/input.conf
index d8645f3dd664..00a34eb63de1 100644
--- a/profiles/input/input.conf
+++ b/profiles/input/input.conf
@@ -9,7 +9,7 @@
 #IdleTimeout=30
 
 # Enable HID protocol handling in userspace input profile
-# Defaults to false (HIDP handled in HIDP kernel module)
+# Defaults to true (Use UHID instead of kernel HIDP)
 #UserspaceHID=true
 
 # Limit HID connections to bonded devices
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 92789a003c89..69ed646727d5 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -83,7 +83,7 @@ static int input_init(void)
 	config = load_config_file(CONFIGDIR "/input.conf");
 	if (config) {
 		int idle_timeout;
-		gboolean uhid_enabled, classic_bonded_only, auto_sec;
+		gboolean uhid_enabled = TRUE, classic_bonded_only, auto_sec;
 
 		idle_timeout = g_key_file_get_integer(config, "General",
 							"IdleTimeout", &err);
-- 
2.43.0

