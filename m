Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8694F7CA1
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625682; cv=none; b=Y/Nxb3+1C1Gzx7TARDvkpvwWUWo6HzUOjDsGCJEf0lAdHXQrlbypARx/sE+itKn3jmGXNTJudA5Weu0m7PKy31ic6GBYrtcPevjZx+F2agSErWk/6Vq+s5hO14ezsBAct29bd48s7EVdfn/P4s4O+hvtsnK33KPyzehEuPXcE9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625682; c=relaxed/simple;
	bh=6F2wGlcLFdi5e9+GY58oy+JRIYpmOylnLyvKYoSAoXc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogoT0+gf9DWlHqFQylNVIzpvdd0/ZGplZwmt0uMzM/ItpDwzlXfMM0gGpuAwO2n8m1IURjE4vJprhAxlsoaYZgj9K+GI3I3Lnstw6/wzIxcsm+YR9VPcjSyZKg7i5fqKBVe7aoRwY+OMcvtN00fSk8uCTuIMwO37/CriQ1Yqxu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tdsy1oMF; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tdsy1oMF"
Received: by mail-vs2-f43.google.com with SMTP id 71dfb90a1353d-5c82bb05ddaso2271741e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 13:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625680; x=1791230480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Kdtul5kQ3tdjkQenjhTtE2ahfxZCGeAX7k9lx3BO/a8=;
        b=Tdsy1oMFUo+FhX2JCqxIuPm21FeQIkp3KmRjK6iqQzD2Lfc6QpG6n4cIpwxSsoi/tG
         8ZEYR+qPdw4UMi6oODIKviVULyGn/iQuErob6Jasl6+VW8NQfhtYbwMq0hxkjJhv1c6p
         dCOoacn7wOilrzmylhOt7k2tS7ziR3DusZ1DaUiPRds8beHYtvV+QJfJvui6BHrZ9dpG
         7LYAgoV52AlQwIhNdxEHRgZAtUROvOD9sj4dxyey4WM0xm/AbLrRwDs4JR6LRGaDYLV+
         tzKWsjQTiCGxuDv/OFGMqGGval4K3glKdOwQPMDvMVGyn37QWWKz+YwZ2CVhVP0j1ueQ
         UrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625680; x=1791230480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Kdtul5kQ3tdjkQenjhTtE2ahfxZCGeAX7k9lx3BO/a8=;
        b=oa6W/vdak61oAU88XNS0N3NZXsl93pv5OMR60VkI9EWF4pqBwoaxaBoDVq4cA9H2ZB
         dEI9H3YWwLWreaGm4W5WkUoYJKbGlWFeUQ/eYkm0GdQtT+yu922GlWC1cqOv9rbE4l1T
         Id8WEmtHaV0DQ9iXPY0+fHk3tbmYupkvtZojPoW7Ar0lDE1i9wmy4giuJyYki7J7fxH0
         NQYE59eLKEyk5EkxMiLBusCbgvDFM5vu5q+HcelztaZeB3hq7St5Af3fVX7mgZeTp70m
         1sR6adXhbGHORTt3NnBAYACgdcZ5ixLEaCZjisfE+iUJJCyoc/lVnyAILj1PFOoPtF/E
         e2TA==
X-Gm-Message-State: AFq9FYKtI4cKg7DJ+xTe72t6x6pHhlmXF5knAY4CUGOUKPbLG36bc+5w
	+p5jpf0Sg0SpY6oZIUykUwJLyuS33xytCTUoK1vLdOONmA47+Qhd6DRQtWS1M2kNOJA=
X-Gm-Gg: AYBFou2PST8pTGkoQF/uLfnXXptnYwNQBEbpM/AEzCk/dST2E5ZW6UsTz+f2ywY9QwH
	cz5d5BBJM1aEQCiHC8yiLsHnomD8TZR73bUMLduhqzZXJ/k11465vggOWwnI85Js1e+IMUnKz/H
	n+h9X/MXnfbay3ROwvCNCI2dUMFjR0ax8N016BpldV3GUdnnve9LgvOSPF4sHYJw7U9Y6oAwquc
	dcw+KrzeYO+Pe/SPGpFsOQnQCSApORYfOtfmGBfarD9Q/RPLMBIcLXKlZCvWNZPVI3SKo38gxrl
	bDmhxJSL1PZt+EC52jgKV++7aQHIL9srphNX9o2zs6zbcI5nI5+uvAY7JEkhqrcfxZH2uwkZjEd
	VhJdVuvkDzyGDE99BQ3CUacfl0DrVw/ihZxgY3Y0EV94Hl8WVfap+yVK+nbJepL+bxRYxz3/clr
	HiOtsPgyDCJMsEdBLxJ1sM2gBzhBWKVbkJ73FgyE/kFSOJcc66Y8cphTV6YLnO5JeuuuU/+Is3A
	Oy0cL0GSKcMFFZBmgmYJisq3fKJM7yL6nOgkYQ5stnWwlUMZx75s40iGQ3GNOUQ
X-Received: by 2002:a05:6122:310f:b0:5bf:8c77:e89a with SMTP id 71dfb90a1353d-5cb09217797mr6647851e0c.2.1790625679517;
        Mon, 28 Sep 2026 13:01:19 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d1d23f8dc2sm749638e0c.6.2026.09.28.13.01.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:01:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 19/23] doc: Add CONFIG_HIDRAW to the tester kernel config
Date: Mon, 28 Sep 2026 16:00:25 -0400
Message-ID: <20260928200031.1209311-20-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928200031.1209311-1-luiz.dentz@gmail.com>
References: <20260928200031.1209311-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Enable hidraw so unit/test-uhid, when run as root e.g. with test-runner,
can request reports through a hidraw device, as HIDIOCGFEATURE does, and
check the replies to the requests the kernel sends to the uHID device.

Assisted-by: OpenCode:claude-opus-5.5
---
 doc/test-runner.rst | 5 +++++
 doc/tester.config   | 1 +
 2 files changed, 6 insertions(+)

diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index dc1e51305c51..52178244fce8 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -205,6 +205,11 @@ Bluetooth
 	CONFIG_UNIX=y
 
 	CONFIG_UHID=y
+	CONFIG_HIDRAW=y
+
+CONFIG_HIDRAW is used by unit/test-uhid, when run as root e.g. with
+test-runner, to check the replies to the reports requested by the kernel
+through a hidraw device, as HIDIOCGFEATURE does.
 
 For 6lowpan-tester, the following are required:
 
diff --git a/doc/tester.config b/doc/tester.config
index e68740dc0f44..34f1530e174c 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -54,6 +54,7 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=y
 CONFIG_UNIX=y
 
 CONFIG_UHID=y
+CONFIG_HIDRAW=y
 
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOCKDEP_SUPPORT=y
-- 
2.55.0

