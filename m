Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D593085D5
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750273894; cv=none; b=NJXnE2kY6vGjBVBdG+XFvAv+d0bivVwCRRwIkI1uMX6GV6snoe7C23fgZA4ZMiRlvFVWh1/YNZwe0My2AfqFTO0tnpAYt2WN5c9isLMVQOOcLqDf97kIuvLATVPO/NQjFZAPkApSfOBQLi8AGU9/ZkD7JZKvMHdwNSosOwJ08i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750273894; c=relaxed/simple;
	bh=fiOJFjrBGbOqPNqiH5be3fXtYSvqcWgMATGBOIuySCE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCuUrUZZoqexZKc28GJrcNWJePE0e1h2fUJ2cOMPo0QAdx5txrTC8ZslwjJIyVRr/bTlHW9j842P7D0sKyCFm1HWdYMRvNq/cvCHmQQs/EHckgjgGLB8TAkU4XqBIXB51oDT6Y/e6eymDNlwUb7/H+5FEnlzCHc2wtADsSkPA8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHYbRhKT; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHYbRhKT"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4c6cf5e4cd5so29924137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 12:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750273892; x=1750878692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMpSw2AHfQaIA/QmKU8ZXukdqO3yvpIkbGZ958bblrs=;
        b=lHYbRhKTfn65XBzze/997t3EejgYgPt0M8x7itQhzhK/SlRSN4l8SDw7dnqc3CF66c
         E3gxyWZ6AQvyhwLnZnZbcOSCLt9YXyFRwVE6WcYD8TXRpKvWNB3nr3x7Y/hFKi4ktCeL
         7k28LLx9JqDfK4+G/iDO/YArqBM3MEfA8+qPNPhXHMkxckg+owGTkr9PHiJniKAJwL58
         /CTJFRG1ELVGMwHF+QbC+CPIN5kYb32yT58DY1qWIIlgSuWBJcI8AIWQgtn1I6Bp2OIA
         R+f1GPb0/k3m1JcJEM5z8bKqlxJGgVgn6FIrFlKgq/WYJCveTnmbbt+kDMajaZrqk18F
         24FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750273892; x=1750878692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMpSw2AHfQaIA/QmKU8ZXukdqO3yvpIkbGZ958bblrs=;
        b=W0OQQpOObrH5ahV6N1LlpQ2UA9T2PchAvmO/3Jne12mu0nUPlZhitOxJTbhNkahiHb
         hJAJYi2nRkujITh5yPYru4mN+nwEIRY3KT+uo4f1eKppk71Kd5JSD7wuS4x5mVTdQVuV
         nISatmZJufFDw6Nzjn5sZRfjizPVq9kOy7NmeGNkZLSuz0Z+2LpvmJzwooO6vb3M4/C7
         y64ssFODvhqYJ9IZ/LICYZA4UZmNJlUarA9NhOAezFdJRy+Sadyc34d+jDgXNgDrLLD/
         n7MASEYx8rHd5nV+5nIX3pG9XX22qUZlLN+zALm/hmpTs3u8jDSDzBir1wX7bL6lyYnd
         CfxQ==
X-Gm-Message-State: AOJu0YxLo30eGOuRUzMToT4aJsBGBZztBJllG+GI9UkxjrMpgVlZ1m19
	542U11l8Wdp5TbryI3OZ8QQ9QWSBCa0gefFc3LU/GA/HIMlyytPXqdZKietVSA==
X-Gm-Gg: ASbGncsUH2+Ggvw+AiL1LUx6KaSWPwfAgiShZqBZVKoiTeOevED2HuiLOWOnVsFfdWZ
	pkQrkEqv11uTFGf59inasrxIJiciYVov4mh/tESLSrsnS2H67CO+qpzhjkXaKKLCfo21YiZZ+wV
	zz5xB3yEw5cFc+FQDt3qj1WLJ32XjxNpy3K97Fm9XCL0SYYoi0/tCCcVfwWuIXCVVlPlQ8tZjmi
	znVCoeKVD1Ip0BIRT2Ve2M9UFxLS4IpYE6rNIJqqVxAHkRqgjaNC3DLqB2YK8o8FeCouU0Zy+Xu
	Ij3lXJqkUErcOfehFpUGWmuy3K3aZ8SS6Xo8UROg4lzBpGKKkZNRtLav2x7kZjkEXa7KxRceb6Q
	V5jIuaISeJaM50kFpPEDfQPaKNXgriVw=
X-Google-Smtp-Source: AGHT+IFNpv4Nn1Pf9OTelxHtrUoQtfJNvJI2seUn59059o0P1qFu5JlBkt2HUSSJufnck45CEfiayA==
X-Received: by 2002:a05:6102:cd1:b0:4db:e01:f2db with SMTP id ada2fe7eead31-4e7f5f6d18dmr14498792137.0.1750273891559;
        Wed, 18 Jun 2025 12:11:31 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e979b63419sm695910137.25.2025.06.18.12.11.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 12:11:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] test-runner.rst: Add documentation for USB-passthrough
Date: Wed, 18 Jun 2025 15:11:24 -0400
Message-ID: <20250618191125.3123951-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618191125.3123951-1-luiz.dentz@gmail.com>
References: <20250618191125.3123951-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This documents the newly added option -U/--usb and adds a dedicated
section that explains the required the kernel image to build with
some extra config options to enable passing -device qemu-xhci in order
to use -device usb-host.
---
 doc/test-runner.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index 423a9379c0ab..1b4eeb9d4c1c 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -22,6 +22,7 @@ OPTIONS
 :-l/--emulator: Start btvirt
 :-A/-audio[=path]: Start audio server
 :-u/--unix[=path]: Provide serial device
+:-U/--usb=<qemu_args>: Provide USB device
 :-q/--qemu=<path>: QEMU binary
 :-k/--kernel=<image>: Kernel image (bzImage)
 :-h/--help: Show help options
@@ -176,3 +177,18 @@ Running shell with host controller using btproxy
 	$ tools/btproxy -u [1]
 	$ tools/test-runner -u -d -k /pathto/bzImage -- /bin/bash [2]
 
+Running shell with host controller USB-passthrough
+--------------------------------------------------
+
+In addition the above kernel config option the following is required:
+
+.. code-block::
+
+	CONFIG_USB=y
+	CONFIG_USB_XHCI_HCD=y
+	CONFIG_USB_XHCI_PLATFORM=y
+
+.. code-block::
+
+	$ tools/test-runner -U "usb-host,vendorid=<0xxxxx>,productid=<0xxxxx>" \
+	-d -k /pathto/bzImage -- /bin/bash
-- 
2.49.0

