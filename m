Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com [209.85.221.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB08535EDC3
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608699; cv=none; b=DNK21Gh0mK3S2QqW7T0Qy3g67isdZJ2Ivxqlo7j0XuJHHrLEuzn/VJ27TpKjaYiglPeeqYCd1w28X9jcNbgB3USm1EEk1qSu0VbeT2TIPqZvgHL71DXKs94NZrb3uB45SRl3IYQ2iDZ9M5jFUJvd6kr8/IPPWJxTWVKALhBwIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608699; c=relaxed/simple;
	bh=+sisXp1F1OLLO9roAeqsES7UvQBAdCQewgT6bfSntqo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgDPxF1tmLm6AnWtQetbH/49zgVjiBbv1r0kAfBh1yfpnREptdvajv9v01BBxJP5Zu7lPwRJqg4Af16Bgw6AQgKlxLuXcTp5qSQ3yPGBjjDP2JZ1JGHN2MjhBBlAYfT3UUIqwtWMFvv3MVASPYmc/Y8wA2Cgwu6EF6LjAoIbM9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+/TQ+yR; arc=none smtp.client-ip=209.85.221.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+/TQ+yR"
Received: by mail-vk1-f196.google.com with SMTP id 71dfb90a1353d-5663601fe8bso2120335e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 09:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771608696; x=1772213496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqLQEqUu3gsNHzp2iS8DJU+gGNFfk/dtguTrd3o0NbI=;
        b=Y+/TQ+yRqXFaJb0HQ+73ubWRGMUkksH4CoFdKjfcH4k6MBZq2gUS9qp+xT5/eCttmx
         XpPSNKOWMnKmfPHVVkkznm/IR0McM0PEjQ8Po29e0yhYOLXgtLtOY668o9f3mJHsg8mB
         5ipWkp1y/X7ixySd/xZRR1DktksyXLpw9T4KL2fetOtITrh1nvyjriUN4fGrsBFdQpRH
         45TnzIBTbyMgv6X1tXO0p0KKPzvZ+yYdV5ZZXqpQg4knd33S5KEsp2PsJ2oYijV7rMfr
         DYLDTzT9xpvFAWb/Bzmuhm7EtNeE3MNBV7QhrYqLm8L9ZQrNrlGFaJsLJndgkhwVU7KV
         I0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771608696; x=1772213496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QqLQEqUu3gsNHzp2iS8DJU+gGNFfk/dtguTrd3o0NbI=;
        b=flfoJUeMUyCkyT+GGhv5gGT8k3/9y3XT7h4E2A+iShY3uRVE2sLoIg3j1Igok+zxum
         LTbbe4Rhy0Y1ra8nIrxYlCpMuduDSC6mu7ZiHwDRiXS3dhCaPtc9ZV2AikygIbkhfS+s
         yk7g6dfQOaXZE6i3GRYHP+92Y1hD5NNc5MAZlNzDZM27ERqfRFBICOteW7hdN4/niM/C
         hukre1uC+Cgp7TvTQWX9CbHQz0Mr6iFDGuIQXz9Zb+CtpnyQ3I7xbPoKCGgvsxoBhw+d
         LfzfHL88o0WftvYE7T/zyWmWyLnxOaHy6wHh9wvwr9pFdJYd7gckAaG68/TMrqwKcxf2
         Gebw==
X-Gm-Message-State: AOJu0Yyxp0YFMxtEONbGNcfyZOQOmrlGbi9+fytEj3NRzO6evgc3APfN
	wzPHXO4Kswkrl5zXzHQMmIlDjTmgzT2wsBV9tGz5r2639ablV40HwLiuFiYWjH4l
X-Gm-Gg: AZuq6aJQNYBjg3GD07+nQ1YAl+Rr7DGfXdIVLOE0hi0eRuntc3EcgzTg1raeyVEmfnT
	2xEWoDIYQsO49eEFo4XGsvPlLQ5QEeSt+cNTFHAzcVYumXv7Hc/HV0e35hZswGKvcF7u5CeOxXq
	79s/3yU6fFf0soCqI7w0hWEM+JfzKljbu6AA+XcQSYmfw+cmWvovcU/mZZ5VULbWJrEn5qkQnOl
	AXN9jgzDl5cp9qjendwH6vY+w8RnnuTHtXOsYgx4H6kblfYquIi2XBV0Ww9OqMKEyMHRWetQYkR
	QwZWaVHD8HE6CBl4xP4/509Ovmz3v4apovVe0ulduCrhatHGlUJVOnyrdOozII7LSMuV6oKE1bV
	TBUZdlC8B3T3LnhNswp3GlRXObUgO8mE2ui1/XXuMZ/WuzMlXRfXqWYjwdeK7/kJ6fGyjAIG4wd
	S93LHxwxNoyX75ZiFrsUU1kz2u+a9ji2hHzuO/YrsnWFUE05AxkADScrNHZHgt+gvn5ZRH+WWeV
	r1PmBgIDbIcUkASww==
X-Received: by 2002:a05:6122:169c:b0:566:cd52:313d with SMTP id 71dfb90a1353d-568e48bfc0fmr293116e0c.16.1771608696033;
        Fri, 20 Feb 2026 09:31:36 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da8b3eefdsm77864241.9.2026.02.20.09.31.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:31:35 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 07/12] doc/btmon: Add reference to btsnoop documention
Date: Fri, 20 Feb 2026 12:31:11 -0500
Message-ID: <20260220173120.3418666-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220173120.3418666-1-luiz.dentz@gmail.com>
References: <20260220173120.3418666-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds SEE ALSO section mentioning btsnoop documentation.
---
 doc/btmon.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index 70cdb90e37ab..c1616318a004 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -824,3 +824,8 @@ REPORTING BUGS
 ==============
 
 linux-bluetooth@vger.kernel.org
+
+SEE ALSO
+========
+
+btsnoop(7)
-- 
2.52.0

