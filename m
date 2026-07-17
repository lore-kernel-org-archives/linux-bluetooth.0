Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE2138944D
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285619; cv=none; b=PNY8URHlV59WuF4ui1r5hc3IXFKVgQ34MmYsELZ/4Q5ypEuQp07WJ2/PNKlcI5koOzgpywjAh43y52wPyaxxwewbT8X4aUojRq8ADqLtHj81sNPJuXrLqwAAKW71XLXudRV6RSExvSytcisx3136epIBXfkFw2FOHoBsroCDQ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285619; c=relaxed/simple;
	bh=a3s6XRckzNfW0F0RdseO46hqrJjAZSXr7uAJeRj1VO4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=l5f6od00WWMyrzbhjonJBJSJLIeAN78wFC/77QfPWeex4Ic+YFDeEO03IvdA/bEj5mgF1F7/ll4Xny+Pf5R14GSRAIsYwJpCzBS/vc3QsfJFBE6v+i+HCAZsXrmvhVGV1SzEZs9AjzATYXp0yWRG3MhLS4OttaQbXRNT1bFrgeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGRgYhUa; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGRgYhUa"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb1dc6bd53so4119826a34.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 03:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784285617; x=1784890417; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=11XwrcTL9qA27bhmgpxkFktjpmXF05G1UAan9BYRQ2Y=;
        b=fGRgYhUa+ta0XaM+kkn4GOxVm6gCla8MB9KisqAtPRTpF3tsA0IoveUijB7sQhb5dB
         0iD9Jx6sT9+gyP2E9OLVagOp6OXSUROBNxLiUyL5M2cKyHOX7RBtpw4Vt59XQD46WY1x
         pCi6pVSzHZDw3/3Yx3Msi1twAgHh4HA9fBgMcm9zz6HMvVEhMrZic4FXTROo+Vhk0XRK
         5fS6/ZJUKBr1dQRh82d1TNDM+LdqsArx6FxMz/rl2jp3W32pXKurMvmZjequpIUJPP96
         CwdVJD6rxawGzY1ps1XNe9faE4W4OFyHLpRcmAdFoWYGfXY9Dtm5bbe2fgquOwEGL3Pe
         o2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784285617; x=1784890417;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=11XwrcTL9qA27bhmgpxkFktjpmXF05G1UAan9BYRQ2Y=;
        b=XQvdFhCwp9yQt6UcOWN+QZnmS1P3/TF2C83yzM1lO5Um8SgxHQYMbj6Xcwfz8g9Mjp
         sEvEJ8qkXDffD9+daw+Z9ViOgc3yPJ6CtujGye2RzpVBN66/z7U/8dncvV21qasTI+um
         HUHThaQH03xAKS0+wt5BxQsrCNhTvuwpWXVagCEtvuaMHn1YKIiWR0/D6g3gi78d+i0x
         yNtYpJ/JhmNpK+lBdnSz/ydZYoT3vkzouqxu8mwl4lvKeOHqyS35X2mM6q6FjNpJDiCW
         hDdiug1dgeH1iWqfyXDuUW56khuyRcJ4McmmgZzoj91zVJrSDXZ+nTSw5Ir3WOVFGQyg
         hFRw==
X-Gm-Message-State: AOJu0YxG2yRsYhcqgM85k4NSRbhPgzSmXESWCtqsv54MfNE1QH0uGuYz
	b2yJVcB0s7qtvEHBX/1035byWPY/mi3RLqi89mvmQgLx3PUd5Fcules+G3VRTw==
X-Gm-Gg: AfdE7cl9upRshUPtwXBNO8cmxVRtLrAoI+UyAiR8X9rgq4xvEgoKj7QvbyMq0FG3X38
	M8X2W+a7KrzMJRTQ7Zq/iz8FVY/Z810KTeN+SVxoUSizuEyKNkv3pV6bVtBhqeC+Dfzl9kr9/Nk
	mWMi5K01vmfM8+/dxR20+ayGVtHjMBZYc/p0RwKLktnXMFMMpukZ5gwVCCCctJzBviRzLF8Ggdt
	0AAQ1+wKlW0cXTnOUnogP91zIZJSkQA5CdR3dBKsR3T6o/rcvveV7s6xdplyeLFgNF+yqxkk0VM
	Q/Xpt0Da0KZcywNoq41JVANPVH/VdG302eaEQiVjS1MjZc/Mtb51o8uTGh2xIY9LMo85/SXesNM
	UToaQx1Dji20DC0CoN7F2lX0SVY2Bb9s7sTA6qjsf6ESZ0yGK7tTt6HVR/OaS1CDkRbicLZVg2L
	9891MboE5n
X-Received: by 2002:a05:6830:81d8:b0:7e6:ed97:ce52 with SMTP id 46e09a7af769-7eda0964a03mr1034977a34.20.1784285616625;
        Fri, 17 Jul 2026 03:53:36 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.38.196])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edad9576a5sm979133a34.9.2026.07.17.03.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 03:53:36 -0700 (PDT)
Message-ID: <6a5a09b0.668c49bf.36852c.5b79@mx.google.com>
Date: Fri, 17 Jul 2026 03:53:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5016363967049119892=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pip@pipobscure.com
Subject: RE: [BlueZ,v2] adapter: Infer BR/EDR only at public LE addresses
In-Reply-To: <20260717082347.8429-1-pip@pipobscure.com>
References: <20260717082347.8429-1-pip@pipobscure.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5016363967049119892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1129413

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      20.18 seconds
BluezMake                     PASS      517.38 seconds
CheckSmatch                   PASS      295.30 seconds
bluezmakeextell               PASS      95.13 seconds
IncrementalBuild              PASS      484.94 seconds
ScanBuild                     PASS      870.81 seconds



https://github.com/bluez/bluez/pull/2326

---
Regards,
Linux Bluetooth


--===============5016363967049119892==--
