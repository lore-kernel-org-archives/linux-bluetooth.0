Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A89984D0D
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833953; cv=none; b=Dz1+QsvDDe4xlAGVpgMwKK4BZwPETyd/fe2df9qwgCu9hBTkfNFMDZNzKRHRPLncBMUFjGdUZpulVsZGpTZ8MaCTU1RqoTnJQjS27a9/YzBgYywYzLhX89OluIGj4TC/l+b+ySQB++SyBjVMHgtTllCkXamgvibOf0FWsXbZWQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833953; c=relaxed/simple;
	bh=4HfIXDtgYdE3nVjCWi3qzvOxU6WSL6YJw1rBDBUhy6o=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=B2NmRFkDU+nONjbOFQbX5D3dUbqa6DRV935lP7cyOh59m3caX3WzvmVXXx/jLJLDkdYlcrYHdfxzEHyw6q4Lt4stptZwNWxOntsOFgq7LPUhLirFMZXKbmNDs3KG3mzNF7Dc9A3v9oN2q6t8YpOJjhTFFlqJoqIkCoBNV3V8wh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMjF6pzz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMjF6pzz"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-202146e9538so58054465ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 01:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724833950; x=1725438750; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jpx1bqf0YFMxrS1p3MCTySkTsKSVu+uzLSCUKZT0QE4=;
        b=YMjF6pzz+wzRgF/t6EGFtHWOtVjGX5pkGONWWIFfog3mHkzCMqRjfCZZUO3M213pBp
         Fn8SeGpeZhgKUZmsliSef+caJ33Jq0dAFQsTKNhuZTYlhx6I3d3Utgob6l6eBNQIkhtN
         91dcTZo4ZfHCwn1WYUKROwlN7XEEEMvLJaOdpych5AqhL8WGLmPgr+27zGpbbAlfk7Yl
         GH//KHh9oxFoZwLHssV0O3yFxrNHEaGxFLrXVNbOFpD7pKlysXeuD4f/0XSnmQhIZRfr
         8o21uTOuPJk6PH/LZcwMo31JKxlB5JQp0P7DK1OTjVY6Hrf85MW+H8p/mu+2yh05BO8l
         xB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724833950; x=1725438750;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpx1bqf0YFMxrS1p3MCTySkTsKSVu+uzLSCUKZT0QE4=;
        b=SB3JjnWBl+VviEAuKWlpo5hMHnskHSMYL5TK3R6vGoya7kRqsuKzFCp/QP2cPnLrsL
         pCamfZz7XSszS808zQ7El77ZXkhqyIjmKONNJTn4fJb+NPUZZDHvjnsfMWixi0Z9nTQr
         x6BCiaa7ovEpo9/lf66URu6GDNZJuIPStmiE4o7ghFLRLvlSeR4hbQUCAOLRubjM/S0v
         WNKv6YJi9fmesSewQnZ5WB/cvERr18XA7BeloQoacfTmJTXO7KEEwYOXWSTZBK0Q0D9n
         32672Ulx1Chq74uk03LxHT+1IONECBydDX6lFf8qSRaVFN5Vgd3BLr0kFc7FIkbWeVOu
         5Tmg==
X-Gm-Message-State: AOJu0YyqAQolDjNAYV4V/biOKKgmco5eehMSPQ9FtSYS/j6808czXgb2
	A6267wQdlhv24qNzxi2UN8JWYIp7NM89xbzG6sckXtYQmOnTyyGfHF2B+g==
X-Google-Smtp-Source: AGHT+IEwgIwXq/PenQAPzt8uJCjlMYcKOXGoCVdRTEwT7EaeIF3Xyq3CfDPM3nk7stlNF+RHuMaGoQ==
X-Received: by 2002:a17:90a:de8e:b0:2d3:da82:2728 with SMTP id 98e67ed59e1d1-2d646d5eba9mr15806275a91.41.1724833950008;
        Wed, 28 Aug 2024 01:32:30 -0700 (PDT)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d844640ab6sm1080356a91.42.2024.08.28.01.32.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 01:32:29 -0700 (PDT)
Message-ID: <66cee09d.170a0220.239498.270e@mx.google.com>
X-Google-Original-Message-ID: <Zs7gmv0Yllh40Rvu@JUNHO-NEOSTACK.>
Date: Wed, 28 Aug 2024 17:32:26 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2 v2 BlueZ] mesh: Add provisioning algorithms config
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This added the Algorithms config to the conf file because there was a
`TODO` comment waiting to be added to the config file, and it was a
mutable config.

Signed-off-by: Junho Lee <tot0roprog@gmail.com>
---

v2: Split commits because the previous commit appears to have changed two issues
at once

 mesh/mesh-main.conf | 5 +++++
 mesh/mesh.c         | 5 ++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/mesh/mesh-main.conf b/mesh/mesh-main.conf
index aca9e6fa5..72154493e 100644
--- a/mesh/mesh-main.conf
+++ b/mesh/mesh-main.conf
@@ -41,3 +41,8 @@
 # Setting this value to zero means there's no timeout.
 # Defaults to 60.
 #ProvTimeout = 60
+
+# Bitmask of supported provisioning security algorithms.
+# Valid range: 0-65535
+# Defaults to 1.
+#Algorithms = 1
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 91cf25175..7b670e40a 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -245,6 +245,10 @@ static void parse_settings(const char *mesh_conf_fname)
 	if (l_settings_get_uint(settings, "General", "ProvTimeout", &value))
 		mesh.prov_timeout = value;
 
+	if (l_settings_get_uint(settings, "General", "Algorithms", &value) &&
+								value <= 65535)
+		mesh.algorithms = value;
+
 done:
 	l_settings_free(settings);
 }
@@ -262,7 +266,6 @@ bool mesh_init(const char *config_dir, const char *mesh_conf_fname,
 	mesh_model_init();
 	mesh_agent_init();
 
-	/* TODO: read mesh.conf */
 	mesh.prov_timeout = DEFAULT_PROV_TIMEOUT;
 	mesh.algorithms = DEFAULT_ALGORITHMS;
 
-- 
2.34.1

