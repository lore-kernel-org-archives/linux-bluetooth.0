Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555FC2951C9
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869894; cv=none; b=bgAce3lMfb31v/Y9CwlN8vBwj/MJBQMLNLkm6WvCff1fgj1m33uiKZ/fv32iypFLBaV56f/zV5kcN8B6LnBANPxwjjXQwwOjatWSsCdCYT4rhfISvmlH7IqsDIGv1/Zlr8p2qcJNIRpQSJPySlFHHNNRjDusXGUYT54Qr+LTqEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869894; c=relaxed/simple;
	bh=JJfipXQk1PyQD/mEXr9AggEJthLLp5N4AI6Twj8Ouro=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBvJ4iLtUo238nML7oN5gSXXTYsUI4Oio3ruxXq4yN5tHmaNu/JDgNH5yJwnPOi4daA7Al5wJ+8Ya+lx/ZAj197brBleIw9GR2j0cj5Bz60cZmyzgfJUDncQ1T7ao5bVg7YaPXdK2P97S4nyN0O34P7JkygtNJVbS9Bg/Jtn/6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9xUW3Eh; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9xUW3Eh"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5241abb9761so1908981e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 12:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745869890; x=1746474690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+qHI0gVWEFa5ZQBSlOOTvwkkqU6pVunKHNS9oPVueU=;
        b=R9xUW3EhzmVxU62cInBHgv986CHTEHp/Jz2sr8ulZWLdNUG4dJAQeioHDrG1yWKooP
         p/Wk9Mm5heChquj1kr2dbeE9/PZKe5rLffdZlXWrZ9hvmEoGiG9feivtPbdYrYkFcW4l
         5a51E7yV7LDsZ9GcpllHjma+kSd/+BWtqbI7G99kN5ZwhTwnwZNB/7lJKhRwMnCr4TzS
         rFxJFlTKyPzxijeNN/67JlSo6G5s7xIGEY+cVrC9g0JplMn3IAZpIbsfQdt6mZcDrcyO
         0FZlmkvzYXL3jp7sJj5TaG+pBc4XjH+Ru4z+cvrPd/Mn+fRxBEq9XjHhH/p5++7KDO3r
         QGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745869890; x=1746474690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+qHI0gVWEFa5ZQBSlOOTvwkkqU6pVunKHNS9oPVueU=;
        b=qmfpub+dP28lOHbJ0GIdqYl+cY9RhQQ900dxGVgaPAxCAKlxzVTc/a2up80x7QpPNi
         36zGBeI73Z1t3FuBzb+eODg+O4BLsGqhP0ytH6OFuT8Mo33v6q5wKgej5rlM+sC/7WGJ
         GB9qV0PkZDMP3hKk/7icNSNAOlmErChqQX1WxOWPbyjAJ8b32dq+TEyDMRzIL9rJtIkR
         GQmCTJIQagi2jaZbuYqQj/RX7OsS68fg54P/SE02JcNeSjGSsOSSVJiLLz5+URyYP8sG
         tbgOrGjhpzomWmhV+f2kAj+fT+i5isDBjgq25UdLgEp9q5ouEBYigCqHK5SYmGD17mxg
         ou1A==
X-Gm-Message-State: AOJu0YyE8tip9Hcj2tXO6De0OTgS8hCbnFBzQFtuvhfcXm+MUy1IjrFx
	aihczM4vLGu184LaNiSwQjkzAptJssd78zDxFACh3WPbB0Tdh1CH8KffIzvEEk4=
X-Gm-Gg: ASbGncvl7RztKceRepXdV+svXVRQEnaCQWiqHR4GjGht81NgC4rBOG9fY7pjw9QjIek
	JHbspz0iV0NyW/ybxvto1uBHzQBBxTPhQeE/qidt206nV2lFSulaaqHoh9tICNf887vikWnB9NQ
	N8ZMWtWus6ExIvkaxy2rLeV9MjiccASxHkYttDB28Ek08rnYhSWB/Qi8uqb+9Fd0nciqIq+g7bB
	sPBTJid9hTHC5oGuAfs3Liq03+rqn1g73jwgCsc1X0iL0U9ZWWcJ529lM4i5YntNNjFvd62RrYi
	UuZsFuIjAU+ogIJ0IBPWa0zb10g2x4QVbXSGiKOkVTvF45Pb/xJ8UaUL/cPxthHQ94BNADQ0eAF
	KJzwW5l9/YA==
X-Google-Smtp-Source: AGHT+IH9PNZzupj8Gp/PVRgQKknjWNUPlThwPqCx4ujPPdDLNj26++iYeHx+Os88vFcQg2QHOAEAhA==
X-Received: by 2002:a05:6122:a1b:b0:529:2644:5eec with SMTP id 71dfb90a1353d-52abf1d62b8mr597363e0c.8.1745869890528;
        Mon, 28 Apr 2025 12:51:30 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52a99279c2dsm1067669e0c.27.2025.04.28.12.51.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 12:51:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/5] test-runner: Fix potentially overflowing call to snprintf
Date: Mon, 28 Apr 2025 15:51:20 -0400
Message-ID: <20250428195122.2000808-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428195122.2000808-1-luiz.dentz@gmail.com>
References: <20250428195122.2000808-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The return value of a call to snprintf is the number of characters that
would have been written to the buffer assuming there was sufficient
space.
In the event that the operation reaches the end of the buffer and more
than one character is discarded, the return value will be greater than
the buffer size.

Fixes: https://github.com/bluez/bluez/issues/1215
---
 tools/test-runner.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 1d770330ceaa..7c9386d2c3d3 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -261,7 +261,15 @@ static void start_qemu(void)
 
 	for (i = 1; i < test_argc; i++) {
 		int len = sizeof(testargs) - pos;
-		pos += snprintf(testargs + pos, len, " %s", test_argv[i]);
+		int n = snprintf(testargs + pos, len, " %s", test_argv[i]);
+
+		if (n < 0 || n >= len) {
+			fprintf(stderr, "Buffer overflow detected in "
+					"testargs\n");
+			exit(EXIT_FAILURE);
+		}
+
+		pos += n;
 	}
 
 	snprintf(cmdline, sizeof(cmdline),
-- 
2.49.0

