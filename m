Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187270;
	b=dWza++wVp3tQe1KCplDJUUSycnR9l66M4uJwntrZ3ZkbF6xuey8knL0Zlvx7ULos9Xgv
	 SIBnwsDCnuNwOpg8dpjIOFPaDFjs48ee2ty7MLPCuddpb8ePDijzAoBuNleAo4gmQbCGs
	 pT5nqR4LLATUNd/Xh3qieVkzDtxut8lOLaQixBya1bjDw4nLFOXlGbOWevbWJANsaUYNA
	 ZEJfEGR1Vjn6WZDXI/HhLRZXkMngZ7rsq3asEvWZ86Eh0nnIki/IRGkHwAx+3xui4oL/P
	 J2Dut29Ux+ZdSm1uT0qQ2bbR6MiRhkN0Ap02JPyIHI6nq/5Npl9ZPusIAPsQHsLbGoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=MOBE2wHupzfEvJUsOQ8fjBUBbozp+URjY0JLReeXgvU=;
	b=ZsBFz4TbvwNLW//kU+TLxsVyd93mS7sLwoMVXrlevDraSS0zZXxm/96LGQvME1TWIbew
	 GXbib4/wliXPvLwRhFmMsR5Sg1+z8f3W9GbkSA5IYy0aI6eM3Hh0vWcouPrSAMNUEWX6Z
	 biIVLs5mBDE4Imy7VsBE1v/XyzKild8mF7yQiLd36iasD9bsei1qLUgOygUY6OqqqNYAy
	 qoxCrg55PrnzoWEK+oMlMccElM9SP0gnXvlKZncDSKq4KvgJCaRvuHM8IA9+5AbjdEnIG
	 AdZ7KAmPG30hWjqXyWyt4ryHTXNVJLbut/tx5OjgH9y5Pn+QK1dblJiFIkMdOQ27alg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xbw61Mei;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048D3606A31A
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 11:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 048D3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xbw61Mei
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5366463571cso12244541cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 04:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793187269; x=1793792069; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MOBE2wHupzfEvJUsOQ8fjBUBbozp+URjY0JLReeXgvU=;
        b=Xbw61MeiO17LINw/DdWCJXBLehXaYctpfSdvsbYC+iglf0SsdicsYvHAl9+bjPtOOg
         UP+WuKnJo3UQCogr4amn1udqPxrO+KJdYuWK4u08KvMiof2MdBf4aqkTvD0oJSlP6Pbx
         6lDRgEO8cQvj8LiLLSO46FPfgJathvWDdlOpmjITX2GacW9y1x193sINVx/OQnGlCTtg
         owG4y9O74OjRB7XvhGuKZWqMZ1fpGxdKjOEpHAI9744KXE8Gpg3OlOitvxzVkbmiTMfe
         tMeXCPcbmFINyfUSLMHTdByN3tTAmK191b/ezKJp968lJYAMsCCQ30hI8xFmnkKLvqZU
         ZK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793187269; x=1793792069;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MOBE2wHupzfEvJUsOQ8fjBUBbozp+URjY0JLReeXgvU=;
        b=DrZRPh397KicySyFPTd/HqDeP+ObduDe+xB9CkvbH60zM9ej/jWxX2fyGnnQiw6KJc
         is2MoX8rFyA2PFIrHoNQADLncjE4ubsalr2D1BbAtEXjZYvDn1X8GHmXFxOtks86ZD2i
         JrH/ovOUW07OXj25Ad9unwDHk26s0ykScnL8pDbAKXBO8KZBKmHoBFqLCBQRymgLY37H
         G/5vSol08SSvS0Hpw3O+aCD42yxl1k9TT2D0ucW7RncPs8V2MxHVW6v+xESyFY751ZAR
         eh7URjNyC6pFm74eR+d/K081fq97JohMG3Wgc2YynpnnFDw/2H9ypjo77bu0SJDNjzAV
         3LRA==
X-Gm-Message-State: AFq9FYK5K3r2tJd+jVWVxtmYOefOHZk4v+feV55ythHhmoFDs/DJNmzO
	peKpjcA5a4AVd6WO3ANrs3OZe3O/5CljzTylZF7aoxgzrFqlE2rU6sZkJqKZDw==
X-Gm-Gg: AYBFou35+Ce+dHC0DWqrg51da5DsMBozw0c1c0/+BrzkkKe5a2OTMzqW1YtW54A6d7n
	M7OYpBgY4JSQTTQISaP6yseNDnUbS2yDNJqyejDOlVQAcLDU32xu8e8ZbDWnjRAEibWlFbG/e2r
	YZEpVCzKOFW8DOkBkS/z1CIPmQ6Luj+P1NHjBbpdy6lrNdlJRx9wDWGyrVl5tYLM6V9aPvhFLwo
	yYnoQV9UuE0kWrMNgriN5I+nlUCkjxwBeg2SgUzHB/v93oaWd/PhaqA4YaKjj0EVMasxWDym/3M
	6eXLPy0QjCPnAu0eUxCgEDnrAZpeqmcxyStOFfMtvoDe7ntMk4z0YBvU5VP67K8HJpZW0DDSy51
	9w0TBw7S9e1icb1YZzHBSq4rUEqjGy8k7pj5WAz6Z1ryFOmciA78T+GZj5wnzAs1mQPDkpZbVLb
	jCl3V1FJLkZqC5TgF+uDSHGoMP3PvWT69tetb6twrY1axmj6lr1O2wAz9tip8jlPmhzPZg0zC9y
	txsZrYPB+xRUPbGf15Y04+cQXUPmF/mA5Z4tV7PQ7Nqxp057SHxprQH4K8+e1AgbaGO5tdqVn4/
	YS3N9grgKw==
X-Received: by 2002:a05:622a:1f10:b0:535:162c:2e87 with SMTP id d75a77b69052e-53fcb509feemr33142151cf.13.1793187268657;
        Wed, 28 Oct 2026 04:34:28 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.93.179])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53838458772sm103447511cf.0.2026.10.28.04.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:34:28 -0700 (PDT)
Message-ID: <6ae1ddc4.e9a23c7b.1bd298.3af0@mx.google.com>
Date: Wed, 28 Oct 2026 04:34:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2628231878187203010=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaojiale02@163.com
Subject: RE: Bluetooth: MGMT: Free unlisted commands on queue failure
In-Reply-To: <20261028050652.134403-1-yaojiale02@163.com>
References: <20261028050652.134403-1-yaojiale02@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2628231878187203010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1195135/

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      33.66 seconds
CheckAllWarning               PASS      38.89 seconds
CheckSparse                   PASS      41.80 seconds
BuildKernel32                 PASS      33.97 seconds
CheckKernelLLVM               PASS      37.75 seconds
TestRunnerSetup               PASS      778.04 seconds
TestRunner_mgmt-tester        PASS      89.18 seconds
TestRunner_mesh-tester        PASS      11.23 seconds
IncrementalBuild              PASS      31.85 seconds



https://github.com/bluez/bluetooth-next/pull/1014

---
Regards,
Linux Bluetooth


--===============2628231878187203010==--
