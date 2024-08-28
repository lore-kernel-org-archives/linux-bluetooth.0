Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59F21332A1
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 05:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724823140; cv=none; b=ltrpznMRW+Kyzq0FTiuTNPv4cjQ/HrxnMUCwAw+YtpfglXEbYo7z6snDQQ3hBP/k2j/xPKruNiYB/ZTrsLXo1ELPafHSvQVhqLCgcbENS3s67bCCCLlkENiPUyi8bPNU1phVgmLxajaV16HclZwJlqEMF3Wb4xa5sIzTtq2cgo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724823140; c=relaxed/simple;
	bh=XqtXLf0UfYmBVCQ5yRsP0Ab/Yvf/Qa9JGsmVlvtDPAE=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=fRlboaLALxXX2j5fDgaBdR5ZNxP0BdMcG7eqa0ckeEPYIi6wY4XEJek+fHVWVXUGoLgtfumNlnUIZUG9AY6MJ6WhgVOSt3OzFKeMyLUqVp0nzXZibU6T9yunOwZmNvIwxv94A7X+rS483ytwdXz+sWqgMM5LeLBU3dvbZxPIOMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMpBY2/+; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMpBY2/+"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5dca00a72easo4912110eaf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 22:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724823137; x=1725427937; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6STms3wTcgK3z61oG88gl+CmShY+lwg4Lj/K0nRR/s0=;
        b=VMpBY2/+OphhUAIbATQi6i7Q/mk0I0Mxox5cud3tVLwjIgKgDYJ0fNCFTIU1Nb9s/Q
         ITMrgAwsUlyuSba4C+XcZVuhgREHSNRnWWqQJPrjCkfU/IyYDnIkzr2uQS3/8IZp5tMB
         IFxpRYTizqSqiT46Gy/M5JhOHSmOC7uSnWnQ2PLGJb0W4W9rHsli+6jomMufNJ9j0AW+
         pHKkEA7RZfzsqMioU9a1tijG/wv/sqQSLbW4xOWV1loUfQD29hsxLgasNWPHvoufNW01
         RxPtK8K/MDSRVXtXL7X6XJFSDDrasJHijzEY+SIzTngQb5I+NMi3XLPbflL5tZ4syA39
         kwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724823137; x=1725427937;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6STms3wTcgK3z61oG88gl+CmShY+lwg4Lj/K0nRR/s0=;
        b=JgRibmJADTjGidD1q8csDwBtNlNsnlS2R1FWW0OqnYOB9Ej9Eu6xg9WTYfGFf1ZDCl
         9fXMF5HspXYdAXKcquFWKsgBXx8gGczowTZPtZXzgY2bV32v5txU7iFH8/wX8Idx0Lx8
         e7hi5XiSTHEE7v+xWEyDaCmiSEqnF+6DjFbz/z+nArk9C+VlcRVZssALGJBc+RUHv+hc
         oHG3x/6mMelO4AJ6YEpBJkiJC0atAfKwelJvnNPtHXsMh1dvu/jkBuc6PLv8RaV5f5++
         L/TNYtgh44pifCako3YvD9w+Dweid1oN1nUEqByRA4uSBf/r9lrXLUoXHIrjfWnqpg9U
         i6kw==
X-Gm-Message-State: AOJu0YwQ2nsJaCFjF9tgx7HGQQg1l18je40C6st2zRlsF2tZCQtQJclF
	HfHEtmsIzBQba2Q+QUMcx0UK7W7dbCqfDZzjTbiU6+uwPjdCGE1i0VqstA==
X-Google-Smtp-Source: AGHT+IHLU4gmdoHcuJEzydi+g66J2/adNVo0nwuPNw9PB27i14HGXugj7ztgFLn1il8cOIUopx09ew==
X-Received: by 2002:a05:6820:229a:b0:5d5:d7fc:955c with SMTP id 006d021491bc7-5df8682a733mr998637eaf.5.1724823137116;
        Tue, 27 Aug 2024 22:32:17 -0700 (PDT)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d220101894sm612292a12.45.2024.08.27.22.32.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:32:16 -0700 (PDT)
Message-ID: <66ceb660.050a0220.214e3f.28fa@mx.google.com>
X-Google-Original-Message-ID: <Zs62XtKM3TFBIplC@JUNHO-NEOSTACK.>
Date: Wed, 28 Aug 2024 14:32:14 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Add provisioning algorithms config
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I added the Algorithms config to the conf file because there was a
`TODO` comment waiting to be added to the config file, and it was a
mutable config.
I also removed the duplicate initialization code for Provisioning
Timeout and Algorithms.

Signed-off-by: Junho Lee <tot0roprog@gmail.com>
---
 mesh/mesh-main.conf | 5 +++++
 mesh/mesh.c         | 8 ++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

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
index 91cf25175..49d252e5e 100644
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
@@ -262,10 +266,6 @@ bool mesh_init(const char *config_dir, const char *mesh_conf_fname,
 	mesh_model_init();
 	mesh_agent_init();
 
-	/* TODO: read mesh.conf */
-	mesh.prov_timeout = DEFAULT_PROV_TIMEOUT;
-	mesh.algorithms = DEFAULT_ALGORITHMS;
-
 	storage_dir = config_dir ? config_dir : MESH_STORAGEDIR;
 
 	l_info("Loading node configuration from %s", storage_dir);
-- 
2.34.1

