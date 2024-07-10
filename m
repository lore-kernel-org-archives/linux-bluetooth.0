Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25CB4F1E2
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 20:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720642137; cv=none; b=YNcwMIomzRsUh1WOJeHU1C/ebAOAA/E3Kk4zhbu+wIr3beV52kXOR7riz7KYUmbd6jbb3Al5/hFZgYtS71/78Hh9fFfqaiTUViqiNRJFtaL2lCLK/ISuD3+hD6D/pwVaJkBytNSxrHg6uW3WP6jA4AunnLAhtAETaq6xAnMF5ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720642137; c=relaxed/simple;
	bh=aVCp91vHVaKSr4j3Vl106sLAuhucrrWRTshxXZIE1QQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=X3ALOeek3iZAoGXI2e1IkuzY8ucYAtypB9cNvsW6qPzj0mUn5T0dLtBxU27qitIdoKEuvx0U9x575BxRJ3bEnIgr3j/oS68G3v0Ron3F3+VR9CJtx0TyCJiwdlloYcRYnSJutMSSyv9xqskBMKMvCP1VObSAdHIi/kE+6GfOUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlaDWaUR; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlaDWaUR"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b5e0d881a1so9831676d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 13:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720642135; x=1721246935; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z1XxS7h9MI35X3fF9TAHNhWkf8JM4N55d0dd8oNSvS4=;
        b=OlaDWaURtwEa4P0KidFiLI87oFux2yJnCO9ands86RroTWoIgssn86CN+kf88mAf/w
         U3Ha6KKRgMXhjUSFtGkgaSJWSrVZ/aXndWygXSwTSP/AMZVjZxA9nbe7sYVy6CHmcOKJ
         8L94+D6IaznOE8b8TcGQYt4BvnmPDfxX7iLpIzDnJ9wL45M2VT0mYw8hSVNYPFGcPMw8
         mKWMkMbZGVr0XcVz0hNhFXNObXJLaY8HOkrQQ5DmG6EYSbnLggavjkYbDiWkeuPXiM6y
         gjG2qe6ubeglfZqy639qqO/15JDBYae0NB3wQ2skqBotXNnitMxMmQCg0m2rxq8Cf0Wt
         o50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720642135; x=1721246935;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1XxS7h9MI35X3fF9TAHNhWkf8JM4N55d0dd8oNSvS4=;
        b=DggdQJlLlB0eF3lgsmcjhocD/7ouNcH4coB/axGnkinBQ7gX+CWzkyf7WelFvt0smC
         6KiH2Ps5a1UL7tCfIEKaTuae+X8kq6/qYJCSc1u41bLIVTI74UJgBjyns1vegw8P60Pi
         ZCVp9bT3cPI4GMEqb9YdQT+yjFSfNF0q7maRYfBVZFJlQ5f1H9tx927FVYFVpRNSTtSQ
         TioBr/gj2F+STjcRTUMYxIRaTpaNpbk+MY+wpFJocB0P+l2dNZGrIYC9tASgmn4oBzCs
         rI0SEKN/uDw81hIf6P3juHWJfi1rpelwp3fZh7CHYVD6LFkrNFLyzdm4jo/UwZnMsycX
         yACg==
X-Gm-Message-State: AOJu0YwisSdqFGHk51gpInI+8EUl/O6HWtdpFYQYttwPlRrxenP6qIcL
	0+Vtl+2tqcSJwF8EoQsym2K4cgda7bbwT5krz1KlvovpJckuY94FmQSZwQ==
X-Google-Smtp-Source: AGHT+IHwG/t9taSfsVhK4mFiinJkn0AHTQ+ucYzxxqdyjDGXggBjy8hxov8kEUCsotESFr2zRKogWQ==
X-Received: by 2002:a0c:cc13:0:b0:6af:c2ec:3313 with SMTP id 6a1803df08f44-6b74afdc203mr12157556d6.26.1720642134667;
        Wed, 10 Jul 2024 13:08:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.78.11])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba8f11csm19415286d6.104.2024.07.10.13.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 13:08:54 -0700 (PDT)
Message-ID: <668eea56.050a0220.4aad7.8c87@mx.google.com>
Date: Wed, 10 Jul 2024 13:08:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7049120593871633810=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rahul@sandhuservices.dev
Subject: RE: [BlueZ,v3] tools/hex2hcd: fix musl compatibility
In-Reply-To: <20240710183006.26549-1-rahul@sandhuservices.dev>
References: <20240710183006.26549-1-rahul@sandhuservices.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7049120593871633810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=870206

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      25.03 seconds
BluezMake                     PASS      1762.86 seconds
MakeCheck                     PASS      13.34 seconds
MakeDistcheck                 PASS      179.83 seconds
CheckValgrind                 PASS      254.74 seconds
CheckSmatch                   WARNING   360.47 seconds
bluezmakeextell               PASS      120.97 seconds
IncrementalBuild              PASS      1489.59 seconds
ScanBuild                     PASS      1014.26 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/hex2hcd.c:135:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============7049120593871633810==--
