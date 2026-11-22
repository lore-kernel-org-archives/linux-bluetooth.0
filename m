Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795368760;
	b=Ga9mVniM89d9d90g4IcJrKHhBLnQIffb94r9CGqDpX/n/OhwIrX80/w/JpJZGp0sWGpW
	 MRvKZoL1Lo3WOSCAuL6p7bhKRP9biE9ilP1DtQeDu4HlxjEFmYomxF1Wffz0BYc2+vTC6
	 qCxf8EgBOzYF7nvyvZKcSolluRKYCci705n1aMqdnl9zao3/7lUkwSrIB3SdxsfKaj6nb
	 UEwRHj2gTGnd2zZpj1J2j73Si3VxKHLz4NU6o4+JcYJHLE2netNbrNZu4PKVVbQrcF0qy
	 2hLIZzlg5MN6HJUqe4eZXK+LnpVLB5XD1XTPblY9Tq9YA0BHVOO9cac0ArcOv0CWTSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795368760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=6l18cxyPCXG2pt512aX1NEihRwIS139vt00HIZOMPbg=;
	b=HAviY9v3IK8kc5JH/g+/2Z+e4u/8h0D/Qgd2KELJ/r1LLk6U8P4FJCH6YgK212/dPw7q
	 GSN0sJneGPgKCNYfJ5m9I0OlRqsQA/0rz+kiDpaStXoHlv+lNoLVCKLNJZ0xpqt+O7peu
	 21jutUyRQ8EjAcYRtMWACs19YgKmuluMCJoEqnX7tB1r8W7N9yx6i8eJdLrVR09d8M+WP
	 jmGy2/QgXvY2t46y1DXfd5AhJFjoS2+xYEyUUvel8QaQc3jNyzLAxEOpZKoz6OInXF9VB
	 ZFYt9JjghZrLWDy/13Mtkr3+3tJS10ojDwQhNYJ/6PAqlWw6R+UhUlY+GDPXe9OHgxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=poObQ3Ho;
	arc=none smtp.remote-ip=209.85.167.180
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B787606A32A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 17:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B787606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=poObQ3Ho
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4b28d7c729fso2134998b6e.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 09:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795368759; x=1795973559; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6l18cxyPCXG2pt512aX1NEihRwIS139vt00HIZOMPbg=;
        b=poObQ3HoCBp/booBvczNKu+NuWRsPX/HFogpccoK6oc7mIKo3+InzGhSzAZOxSt5Cs
         30fmRTR4HA+AD9BHH7bgI913LKI+MS1MzKu+UDXsUDqPxlhMjCXA99lsKHdTsYBJf6E8
         RLnpESxCNFYSgel+O4p7m7HNr/ayZsowR3LWtV7LErZaUSSFRSlh8BBECJ9agMoRXil+
         jAmsVjYpD174Dizmu/rIoU/ui41qHgPxoYl0W06sUhD5l5n8Pw2RPCL5O/XjvCDZTN/I
         nKuKTE3YHpshKpDZzjd5DBmQQOZaBIejLo5GdINXMYfPP/dPNxpXanizYpsVNXdeaH9l
         C2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795368759; x=1795973559;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6l18cxyPCXG2pt512aX1NEihRwIS139vt00HIZOMPbg=;
        b=Q1+A0mXbjgsS5x3UnnJydzdHcAj/CJKYRclZqRdzI8TLUFM4adnl9iTu3F6IU+vFQd
         n9GEUk/fr9uQcWJ+jKJHmPwlpIl22sSkUjBCs1t2QU1v+GuNfcxAG1QU/7dYylwJ7UG6
         GbOQQ/RUZhoe+dOqFNB4u6WsHJNldzVTB00n3XI3tRLRRu52M4yOT1MbXpskEaO8AwWx
         J1d0iql1eRfD6NCn/REzHmD2m0zslvzyiG1MSCwnpVbXXiaatXPgiADE5V0ZK/OOdGBK
         JsZu6imVHM3Yu63BWVsMFdrRke/BuEGy4guCMyCpFy94+iMcKiu2Ojh7BRoFajGRHCcf
         I+Tg==
X-Gm-Message-State: APuU4Z9jNtX6VAdqYw3c/FwkEKefOm0Yo+d4xv4B9sYamzDlHrxQEn6n
	lbj5plTEz4TJdyLUvJ19sQU2r+FnMzdiIGeIFupD3YkrORP35BV+Ynv6BJwkgHDi
X-Gm-Gg: AZFdTZdgmw8wJbNM9nPPA8oZWNg61BAuvYsMOhiywrqaBQU+g6XgiFutNHUXqvKoNAt
	sS2SnWaD7myRp11sUPPk8R6QwkToYkF5xF1z4wCD+wBFuy0b9x11rXeMwArWpTiD39+7w2Vjajr
	UZMy+RpumXt9zK9HQBEbp3NiyqgAfMR2DAkYAalcgu8RCkbgkGY4hEpfYDvbFQjYRVHuOuOssND
	wwJpE61bi/fwjYOZpcilV6u3FhO4Wl3pVGNgcJnB2TKc1oippC+CLL842shX5RHgVJuT7JkTm+4
	DlJU38x2O08ggeBnFbtDPkQfbWYzucA9iwz//tdxd8Iily0agiHJtRWhxU/JpdtO8jUcjJ3XC6o
	ng10jc9z4p+XdtPiNLFI0eoXMo7xV06qobTiO6ACjjW6Qu7uYOc5ve8bMNziSGaTgzSRBiVdoDx
	3F758gV8VV4bN9dx8Buq3PVoI3J8ReRBRhyZsq1ZJFf4lQUDICVfIPMcZUSd650cWdL8xJPFLSH
	K/N6SMFtXvGM6m4bnEUZzL58MKmsOnhhRjONeP20LVmPVkEhAlArXDcz30t1qHY1A==
X-Received: by 2002:a05:6808:244e:b0:574:6f37:671d with SMTP id 5614622812f47-57a056c81c5mr10256112b6e.5.1795368759445;
        Sun, 22 Nov 2026 09:32:39 -0800 (PST)
Received: from [172.17.0.2] ([64.236.134.212])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a35e5ab03sm7164640b6e.16.2026.11.22.09.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:32:39 -0800 (PST)
Message-ID: <6b032737.132edfac.36c088.7edb@mx.google.com>
Date: Sun, 22 Nov 2026 09:32:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6790920273515255886=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: Bluetooth: hci_sync: Write the default page timeout to the controller
In-Reply-To: <20261122153450.1532145-1-simon.mikuda@streamunlimited.com>
References: <20261122153450.1532145-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6790920273515255886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218700/

---Test result---

Test Summary:
CheckPatch                    PASS      1.21 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      30.89 seconds
CheckAllWarning               PASS      35.02 seconds
CheckSparse                   PASS      37.70 seconds
BuildKernel32                 PASS      30.82 seconds
CheckKernelLLVM               PASS      33.34 seconds
TestRunnerSetup               PASS      746.78 seconds
TestRunner_l2cap-tester       PASS      14.95 seconds
TestRunner_iso-tester         PASS      13.34 seconds
TestRunner_bnep-tester        PASS      3.18 seconds
TestRunner_mgmt-tester        PASS      89.30 seconds
TestRunner_rfcomm-tester      PASS      4.50 seconds
TestRunner_sco-tester         PASS      5.58 seconds
TestRunner_ioctl-tester       PASS      4.71 seconds
TestRunner_mesh-tester        PASS      4.54 seconds
TestRunner_smp-tester         PASS      4.37 seconds
TestRunner_userchan-tester    PASS      3.25 seconds
TestRunner_6lowpan-tester     PASS      4.45 seconds
IncrementalBuild              PASS      28.92 seconds



https://github.com/bluez/bluetooth-next/pull/1184

---
Regards,
Linux Bluetooth


--===============6790920273515255886==--
