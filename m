Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCDB433E81
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786534388; cv=none; b=q4voIZWihKx72AGP+oLPm+5+CN+eMQuKpEj/k/nIUhfAEuPuNxWSWm+sm8kFAH/d9nG65VYrSHoZvdCdsw/PnMy2yFIgijTeILxuYR+zdz+FlvL/w8TiEEeTew7b/Jz3qWnWyy9D7ot85Kyzu/P04V98ZmMPXNvyJkqPaBA8b7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786534388; c=relaxed/simple;
	bh=bb+w3/JUhZvjrWI5a0X8Af2pjIXR0ejj/xdynJj06DI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RUNXfFetiS+ZTKqLwTeHp0g0/JyfweBsSYO/2vTpQmgW+b/lAIUqjGVhkfx8s+8NunOin4PUy1ICSbxwXbAxC6VcuxFTLK+OFpB8Uu50FZyx1z9oAE4p8NYUrDQErkf2QbXcYLjLTn3CpCJIeCdoto4vUyHxGajZXz/plstWKsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6i/17X0; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6i/17X0"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8efcef23d21so4179806d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 04:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786534386; x=1787139186; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I/xqpx5h11BNs+pjQ43fqfBKNOeZbZx0CPFQfwlMhkA=;
        b=F6i/17X0GXHDMvTxRSOGZT16Y6nQApwxWHFD99pOAR6RgMJqwK/JW0XAsqjdJ6f+I/
         nBw+ePFKGXVMQKPgkrQ64eO9p2/RjluIj/qFoHEBqztEp9NaX6QA0xdyOFVjueiaN5Eu
         MqwlPLo6JzSLMT3fMUGMdXCus4nICrfSvNZcxYAKysuihR9r8Ih05W6H11kAgx9lKNee
         DcobT7H91/xmPpWmkIujlqTozacuWATulDpzNRx87Z5fCTJuIl5qlr6yCja+2mRRm3w4
         tfPgyawLOQ7kM+FFnYTI1ES29WgZc0M+nnpxrallCWVJ0wFxp0ZI1KbC9Pu8JuyH0sAC
         wNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786534386; x=1787139186;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I/xqpx5h11BNs+pjQ43fqfBKNOeZbZx0CPFQfwlMhkA=;
        b=YiKzA0jCO3dCmwgyb/JUAK+mKVZg7F1RtNx0ObajHnthwRbii8/HdldEuQijD6e9B6
         MHsAqirUrBXDEshdGYJeDQ+1HmEdahw/S2s0iMEPmRlXQ6HfZHqtx6sJWAOxEYztt10O
         RknExakyHjoMN71PUB1WAvwv7mJiaqFioCUZ/kAweeYPuKkUuC6N931spgSC0Kk1uO8a
         eugdcESnLrNgxeyiKhb+Ae7j+uI/CwRbEM5yfOS6oUij7hobDCM+t3SnIYRvVPsaH6i+
         knpHwDlyMbcvIqT40rQ+09Df8ANq2d762tATtBCDClF4Vv83JVXWrCJu/r0r9LaX0B5Z
         tnBw==
X-Gm-Message-State: AOJu0YwpWbsoija5SZ9GN2U2eDul8Yhnab6NVmEux/VHilfDOf5geP1f
	qsOdXsrIEDutQWYoHi8NTTkX55VYi2XgJNj+bT8g4Dd+TGvhFI6mLj7G6r970g==
X-Gm-Gg: AR+sD104Cv0UYZVZ9u0vKk9HB87qrf5tQ659kXiDP1Vkf3t46A3LdE67dDjq0vvds5T
	tZJvQ+D3/Mj4J9AxIS6CKwSe2vRcz9uBkoEh0yCBbojIorNGjBrElJExn/sYbWj7EdwMxFMZJqq
	fp8gnKJtv5mPmKHPekUGW5VOwxVtYteBNPyh3laXInx7BAJU3CJsCr32LN2BLfdIplCcfrUW+d5
	TgXIAQRuRU1b6MV1TMDtyauku0P+w0Mo40AvfPda4hcV5ExcGPtwFgVlEmwC4qomUZoC44y/Lev
	AqSrHVoouKwdxBZ3Zan+cCCNqMTCxd1CQnKn3Gsjz53NJYL4raID0ynE16plpGSGIiYSjfRbW+1
	JIJIrWA60hy38aK1HGCf9D/BpKaQ3SllbbfoNpcFbrmPzNTrcls0sU3L0HlIbOb9AC97ePItPqJ
	maneEJeULq5Zq8/J8WEAvm7e17HIdPz2vzsnWwprfzNa5Yze/bqP+gdXq09Ivw+LwerUut
X-Received: by 2002:a05:6214:598c:b0:907:dd19:fcb3 with SMTP id 6a1803df08f44-90a700bbab2mr34217176d6.24.1786534385491;
        Wed, 12 Aug 2026 04:33:05 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.121.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c296ae8sm19611276d6.11.2026.08.12.04.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:33:04 -0700 (PDT)
Message-ID: <6a7c59f0.a8f5276e.2357f8.6717@mx.google.com>
Date: Wed, 12 Aug 2026 04:33:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0026812608307463686=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: Add CS distance provider implementation
In-Reply-To: <20260812100345.2956271-2-naga.akella@oss.qualcomm.com>
References: <20260812100345.2956271-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0026812608307463686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1144626

---Test result---

Test Summary:
CheckPatch                    FAIL      3.07 seconds
GitLint                       PASS      1.68 seconds
BuildEll                      PASS      20.03 seconds
BluezMake                     PASS      553.43 seconds
MakeCheck                     PASS      19.28 seconds
MakeDistcheck                 PASS      152.69 seconds
CheckValgrind                 PASS      217.60 seconds
CheckSmatch                   PASS      294.33 seconds
bluezmakeextell               PASS      95.15 seconds
IncrementalBuild              PASS      596.67 seconds
ScanBuild                     PASS      872.59 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,4/5] rap: Add CS Distance provider D-Bus API
ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#812: FILE: src/cs_distance.c:566:
+	btd_cs_distance_provider_manager *manager)
 	                                 ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#853: FILE: src/cs_distance.h:23:
+	btd_cs_distance_provider_manager *manager);
 	                                 ^

/github/workspace/src/patch/14745271.patch total: 2 errors, 0 warnings, 650 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14745271.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2397

---
Regards,
Linux Bluetooth


--===============0026812608307463686==--
