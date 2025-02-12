Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7171EBA0C
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739398321; cv=none; b=I14avZESJ4qRwyUOPRu8EeWMQBWpVz0+FO6Baf0JI27y0YfC/eCCPJDfogHxk4W8OLtK/UK06H9T41d3koIH+tVMgNOMGIbagE7ksGaPwsJCvZBYLwG1fTTzbLQEV7mkZIHGvS/voTy3uEEJeDo82AeIOHAA5E3OwmJ67CBl13Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739398321; c=relaxed/simple;
	bh=73kaWHlbTXmL+kCqWbN33D6cmnr3EDYN3k+74m6tt8s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UtvO1fQghY2K7NVHtstdjMvkx5S9xjw9VluyN7bs7jQ5hZgikb2xATFLQznO+wWq/uu+cNXOz9vEdv74klzRqxjEI4P9i58xkcRBVInrMiT3u37O7bM+wxS+9ve7JvR05XQ6N3i7/m1H2tYT6CLEjPi7KwlJnwkTbnsVJB/7WFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUethPqD; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUethPqD"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f6ca9a3425so2256007b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 14:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739398318; x=1740003118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rPtDLNJlRvKcFQgLp3XmdesALy6I7yHzTWrQP/m7EMo=;
        b=EUethPqDUNOkFVmbrR2Q2MJmMTTbGaWXMnT460AYqb5Qho/Oz92vtWe+8gYIXhPOeX
         eFNoUrTGyZsI1Zs1iqbQryR0P47CogbZ4rYPiTLeF2jX47lwvZRMcB3iiM71fmZcxTxY
         XzqFJLkQlmYjzMUVmy+NVzKLFkfdx2zcFFhlqTS5eg9gWjV1K+O+vOqeXSRa18mo/XrZ
         vLtcoUPKMWLqIdkn6YV483enLy30mOv7DQdFxCsrUkMc7Nhrscymacy+rXvtnMdYoCA0
         peKuIJo8j3rpiv7aATfeaf83uV6j5MW11PI8GvzUAnO91UlWzEdZG7x8trWj8csO2H27
         lJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739398318; x=1740003118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rPtDLNJlRvKcFQgLp3XmdesALy6I7yHzTWrQP/m7EMo=;
        b=ZqqBzOB9nojUXTINgup1P93Cf6AjCT+42Hl+M8S0Zxh56Mrsg3kHe27VV4z5bOtlpi
         QXkcfP/8v4lE8LzQ0wISqcUppRZG7jafE2RLOT1JYIPk6e0IvLd9U7uMi9Dvrzbjb5LG
         YT70uDJhUsAzHHYXYjHuajTgixvXRP1HRMmbYbOkEuhrJ8qKkXgjjBnhE2OMZpik5c9e
         gGXlC6k49E8oG/uWawCQH6VjCECvI/OuEBSCwzgvLAVokBfGt3lZ7W911GsOcs7oKqHu
         FL5QTFRZJWVNqYRwy7V9PBThj8sVyH5oxVpBts+AkiprUa4QklxiJjLLRAyMB/WsYA2p
         RQgA==
X-Gm-Message-State: AOJu0Yyt4eENgYoPzjql832SqlUl7YB6E7S4dFr+AXMjOn5boV6sZ1p0
	2YF8YK/LXCEe2h2LlQhfaPfgbE5ELgaejBWY5znw8znofgRIkmEl8JU6idM8yFI=
X-Gm-Gg: ASbGnctW3NsFbSxgA7p1urADf/Dja+G2L99f8GjYEBApgpfBrrrRrY9CGX8LwkShiSJ
	gVxYZWQ8OlB4T7DYIWa4C8DpyuLndGspoy2/PXIRcq2Y3JACGGpk0hoFGNtBpMSBrjZrwGK3PRr
	+JGhTaUvbe4ObOcy8IekSuvgRaj8XYacvIBeSrjgW9lICo+ou91rOXASTsDD2/99NfPMjsJ6qzk
	l1Wi6ZpUkBFJ32n3E0N6uyuf9PbaIIfwycZz2UdSzw9YfrQZOVYzld0BcDadoRA9D2EYK+8Pj3J
	O9OYnKK9Y1R3CwVzVMxojU4lJLeH76rWa+oMpZAFeJHk3J9sb2BhXwl9soBYoSg=
X-Google-Smtp-Source: AGHT+IHGYoL+uveg8DYCLz/KkGWXYy8/682uzLsQpOxJtCjHAJZquXyTP9bh6m0AxV5F5mTCZmzHOw==
X-Received: by 2002:a05:690c:62ca:b0:6f9:a0c2:3707 with SMTP id 00721157ae682-6fb1f6c6bbfmr54557927b3.30.1739398317815;
        Wed, 12 Feb 2025 14:11:57 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f99ffc073fsm28433537b3.99.2025.02.12.14.11.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 14:11:57 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] build: Add alternate configuration for enabling LE Audio
Date: Wed, 12 Feb 2025 17:11:56 -0500
Message-ID: <20250212221156.486006-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds an alternate configuration file that enables LE Audio by
default, this can then be loaded with e.g:

src/bluetoothd -f src/leaudio.conf
---
 src/{main.conf => leaudio.conf} | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)
 copy src/{main.conf => leaudio.conf} (98%)

diff --git a/src/main.conf b/src/leaudio.conf
similarity index 98%
copy from src/main.conf
copy to src/leaudio.conf
index e9c7552a2c2d..5cde278adecb 100644
--- a/src/main.conf
+++ b/src/leaudio.conf
@@ -124,7 +124,7 @@
 
 # Enables D-Bus experimental interfaces
 # Possible values: true or false
-#Experimental = false
+Experimental = true
 
 # Enables D-Bus testing interfaces
 # Possible values: true or false
@@ -141,7 +141,7 @@
 # a6695ace-ee7f-4fb9-881a-5fac66c629af (BlueZ Experimental Offload Codecs)
 # 6fbaf188-05e0-496a-9885-d6ddfdb4e03e (BlueZ Experimental ISO socket)
 # Defaults to false.
-#KernelExperimental = false
+KernelExperimental = 6fbaf188-05e0-496a-9885-d6ddfdb4e03e
 
 # The duration to avoid retrying to resolve a peer's name, if the previous
 # try failed.
@@ -263,9 +263,8 @@
 # Defaults to 517
 #ExchangeMTU = 517
 
-# Number of ATT channels, 1 is mandatory since it is used for ATT fixed channel
-# index 2-6 are used for EATT which is optional.
-# Possible values: 1-6 (1 disables EATT)
+# Number of ATT channels
+# Possible values: 1-5 (1 disables EATT)
 # Default to 1
 #Channels = 1
 
-- 
2.48.1

