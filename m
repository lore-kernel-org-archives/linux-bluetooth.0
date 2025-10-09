Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBD1155C88
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760012390; cv=none; b=Lp8vW4eCosQ3QLi90XqvMtqaB/kpgo9KSY48iNHQEB2EJI9WLSQn63ptqNLYoRcps6Y22+mQPfEFVePehKHecq9iQucYasDA6bb/KoqZwjgwRXDMlG+ypD70Pbf6Cn/RncdLDVKCe/gGWBVIuOflvnwA+KVwjh23vXn5f/b8YLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760012390; c=relaxed/simple;
	bh=g5ePS2VCnW8Z3hG6IEV5qEAovjhuwJ2SCbAeCnD8dsY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RH9lRfdNkr0YiCjsh3doq++2iGXbpSJZIqBiMubkYWEVRh6Wd3VKH1yRFAizC4rhfBWgD0F21MTAPVT55yelzzSTLLD6Q2ngCRHLTShEkNdwQ0ZrbHkJgFVw1k0VJbka2ZgGadfxj4MOuZrGNYTbzBQW+uns9EPsT+z6jmarlNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4hdp25v; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4hdp25v"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7833765433cso1200584b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 05:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760012386; x=1760617186; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aYExOgPSFyCwRFLxNFSzTO4s2MMnrvox3PXpV5kQcS8=;
        b=V4hdp25vN4TtvHOGbAmsUNXx/B/3c5BrTl603B75bI8vdxAcu246ALdVesypJ1LLVx
         8hI0w5mT2+QXBGGFvod+jCzizg9RhLO4H0m7MKvWIBuo6oHizm5MgKJfMi6uVTzqsAlg
         Pxk2rsbNYlVKhhXrVG30lCY8mJ/BUQ/3X182zOG02LXSCbQ8n8Q0On0Ki0UJbU/BATD8
         8nsDBwC4h5Mjz0uYMVHeM6NiXJ5PEYu7nGF8TEpIRdGH+/i8jP5Mq/RFUmj+UnoC7EUE
         X4kWnf3TNzN+LfVTorLgMiyK+R893EpWd2MQzZqUi5tnQsBd8xpgaFQSVprDlJZ7UQkN
         /7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760012386; x=1760617186;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYExOgPSFyCwRFLxNFSzTO4s2MMnrvox3PXpV5kQcS8=;
        b=sMpuhdnozrSpv3XdjUoaighlntU4C75t0TjdFj54TVjV76Z1iY0INzIcdzJGc1HdtM
         t2e64siMmi5muAYKDeJrNRhrmcfQR3HkRTwgtiKu6hIL0WuSRwD/AsITWFRctm/xDDc0
         LeVo8SWk4fnBWOXwSbu1BMjLKuCo/1bauSC3Cgi8hB0V4E+YL/umr1JULWk6uxbTQe0P
         4B+MVPoYzndWfmYaIT+COePGPYCNBOt6lP8ziUv4WQ5lSGaq2r19WY1Vipn1n5nwFz7A
         vbdnTVEFGbiTFTaGg/+dZ5ULpd4EOcxImYMT6XTsVsy26SqygEPFoNwKHNtaWZhOdwZU
         eOow==
X-Gm-Message-State: AOJu0YxGZnYOBfInr14coYlwtHc27lX+NIaclfT40C0KukaH0c+un4/3
	9nlh8elWJoKezXuZYpK0iRBoy2NYs4cdHTFBMJV5hL/V585Wk4zuiabqfInw9A==
X-Gm-Gg: ASbGncuAzLNqoabykUeGx+98A/vpDwin8H/OGYSOT/XefHa5yHuj+EXx89G6M/ki4Fr
	sQjNTYL1O9TF4Yd0xqj2icD5qh0fbbTPekbI2WFeJMair9hhGkiyO2p0vKBVTVaQFiykCJFZh+G
	6e6CE7p+WvnYjlmC8KcDZwMMb/MXQHdlHec0XuM/XmKY1ipDi7/cCSStghev0UZimpzmMN5N01B
	XD3dV5DVw+yx9+IVoZ8bnM953JqVS6A+V/DPfImw3ZBGnuCBf3SzZ/Emp2L+00o4bcPgu0PgW75
	4wuOpNLxKmSxTpsvONY9aSQvvJxiDjaPBu2lBQ1u5iJwAjZzCZtQKWeXUBrfNlFF/x4ZTMfFKc6
	SIF9xA01btGP2f9wjt8+nOwBDT0D7AjFJSTnfbz1LWUKDejPHFYu+
X-Google-Smtp-Source: AGHT+IF4n5A6ZOyFKv96Vv+5ryhEnDXQTYN+7cXUTDhmK7CH+99YvUhWUeEdS04NMH3r6cI69RzVZw==
X-Received: by 2002:a05:6a00:92a2:b0:781:16de:cc14 with SMTP id d2e1a72fcca58-79387a23b05mr10184603b3a.32.1760012386042;
        Thu, 09 Oct 2025 05:19:46 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.154.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794e33efc46sm2741016b3a.74.2025.10.09.05.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 05:19:45 -0700 (PDT)
Message-ID: <68e7a861.050a0220.338c7c.9272@mx.google.com>
Date: Thu, 09 Oct 2025 05:19:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1631993766327198764=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: build: Add meson build system
In-Reply-To: <20251009103554.2417973-2-hadess@hadess.net>
References: <20251009103554.2417973-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1631993766327198764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1009682

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      17.85 seconds
BluezMake                     PASS      3900.31 seconds
MakeCheck                     PASS      20.16 seconds
MakeDistcheck                 PASS      171.32 seconds
CheckValgrind                 PASS      227.49 seconds
CheckSmatch                   PASS      268.55 seconds
bluezmakeextell               PASS      120.66 seconds
IncrementalBuild              PENDING   0.41 seconds
ScanBuild                     PASS      814.83 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1631993766327198764==--
