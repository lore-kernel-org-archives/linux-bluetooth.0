Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9741A3431E6
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484804; cv=none; b=HdCVgmTownw7wpNAOsaJ3yDQFPXmpmvKR99/tPrfkp40T5WikLMdqlUzUw259sdFcIc3xfJUtNzy6uARIjI7uo++iVdAKXKryy7EpTk90NnRI/22sXjOTssdp8NODuHdT0Y4/Xmz8cShzTIBevimcmdBoLzyR7JekknTTGlTY0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484804; c=relaxed/simple;
	bh=e6GaDMITCJlo064tGC52D6bzYdNAj5HNPN4u7e2XSYE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BxvL4k5HpDCc5rK+MMhucMRoo0X1CsC55uidVdgH+A9WlG1ugkKW6ItOdddBG2iCqshHfpm+BfdFcNuxpZZ3yBJcp7OorzrETVbHpxwSP74/BAhNTMDZEiFvzaij/tlr/qqkFwlvBygOxC4PYWT9v3jGVyWPZQ/ielC/U/XzMMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTp85f7n; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTp85f7n"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so533666a91.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 01:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785484803; x=1786089603; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8RE14cDAqeN7ZY1MAAK0p0+t6GF0wjasEDc/9Ftqlxg=;
        b=JTp85f7nyVMXnhL71xvOJejRQrTZK5k2XH+86tlYzDSew2nE4O+z6EXR6Edwl942gl
         CVE6r08KxZrIWCA+fEgNhVq0rAo4i26L94SDOW0Wni5lHImkpVjCBFsTiPfz8Xz04gp8
         okJEA7pXxnhwoesXSCeBW/QAadkvOFVByupyec3x3i9Uib5uq1MBg8m2Vbf7je3xs5lP
         s1dN5CNxmB7NHXOQLpeYPzoiUByyoIBCJXYZp4XkvsZaS2S/Gh6XYG6SrUgboim+Seyn
         eOC6elCG0sd/sc5oYFnLZIjHhipERGTR/oV7e7Cc3jjznwyL2QKVSFBvDcwmulDRlhq3
         L1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785484803; x=1786089603;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8RE14cDAqeN7ZY1MAAK0p0+t6GF0wjasEDc/9Ftqlxg=;
        b=swBIARe5e/dR8iMJFXSeMx4/UBMwrBhKgro9Jz3XkmjGLNYBWLRBGJgyMKj4Hh1rdA
         zyAQsmZ4D/iB5HZuZfpYeNQj0EVL03S62NneMGSbl9szMLlY6FcI7gt50SamMTBlZZMt
         haQOTBdaI4+gEQxJhlIoDtmqffQWFRFhY3MqvvqdeWHuXA60UVCmwXdndvB3zIcFswXm
         dbfYDXYParysC4IR82cgnaEmC3ln7wlolIf50dwiFBomJy0NguW4mCBX476BQ/wB24Im
         17aInXKpA7DcBbaWIg/yfIOpT+kd717zuqpBNWP5cYTWp1XDsR6oAlvCLKJqvGApdcg8
         O2QA==
X-Gm-Message-State: AOJu0Yz9lCjlkHqtXq4tn9i6QFEtl2OZ0YceaHCU7FkQGdVB9OlgUp07
	R2lyfRhxAW5yReKmYai4+cnj9fqBemjFPaWGo1QL2TpyDnOM/BwDaFIvdPcIgA==
X-Gm-Gg: AR+sD12IpBBb+jSqPkL/epa55z7ZGWT7XxDUVm6LCKtbblzTl9QjQLzGbQGUfqoJGra
	AqV0sbJlPx4OAyexqJ1Fmh5O61I0BXLkOs+/Ah4dHwNSUZ12b32HMn4igjOQgUzr1eJDqk5iGDQ
	RlmJqCWWCz8NU1eJ0rAJuazri/W7mdbuwdMyOfrUBwpVhblNAq9hYiha/Rr3cD0Hh0TP8+zHSTO
	Q4PboxRvhilOauyrSOx+HTHTjTXr6EidCWpZa//tyo3b6qAbW5lewFfnIDwZXOHp3zrYbPWn8Vy
	g5Eixm+ToMYDA+QVqvxJsxEIaAAAF252Si84FXOXaWFb9KfNIWT3GDlbe7tPDUB3HUDD1O3Nn6g
	2zxLqOHzu0vSd6cufc7mlkt2M2p2CPijPDOMkHrvQMkT0c7Y/xGRRagf5hay72+nvXBVse9l2JU
	EuDCi/Uc53vacSD63eDfJ8bFg6Ghps+TIJeI4IjCbJlgnDyQbhlRVc1PcZAX9XzXWRVI9xyQ==
X-Received: by 2002:a17:90b:1d8d:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-38fb121ee39mr1073085a91.14.1785484802835;
        Fri, 31 Jul 2026 01:00:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.242.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153ddda5d9sm3919911eec.13.2026.07.31.01.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 01:00:02 -0700 (PDT)
Message-ID: <6a6c5602.6c5720b3.159f43.a64c@mx.google.com>
Date: Fri, 31 Jul 2026 01:00:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6456729299541637904=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: doc: Add CS distance provider documentation
In-Reply-To: <20260731070159.2769120-2-naga.akella@oss.qualcomm.com>
References: <20260731070159.2769120-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6456729299541637904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1137931

---Test result---

Test Summary:
CheckPatch                    PASS      0.87 seconds
GitLint                       PASS      0.64 seconds
BuildEll                      PASS      15.40 seconds
BluezMake                     PASS      398.30 seconds
MakeCheck                     PASS      17.66 seconds
MakeDistcheck                 PASS      127.87 seconds
CheckValgrind                 PASS      181.44 seconds
CheckSmatch                   PASS      211.07 seconds
bluezmakeextell               PASS      76.64 seconds
IncrementalBuild              PASS      428.77 seconds
ScanBuild                     PASS      680.83 seconds



https://github.com/bluez/bluez/pull/2365

---
Regards,
Linux Bluetooth


--===============6456729299541637904==--
