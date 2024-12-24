Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3C51494D9
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Dec 2024 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735023714; cv=none; b=HtP/xgobC6sljnqNthLE8IgMwW+AajNPu5XM9lw7nXIFVg3zP9VBEEpGB1AYes5UszqaTt++Ns/iim31HiqaXB6aL4ZuyoXJZ0Lgej/sLB/5ZmYGdQWmC6IzH4T8Iqcv7ZCYnFDtt+Zyjwg/UnU2wPj0YXcDfISUX36/He5yKxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735023714; c=relaxed/simple;
	bh=nCQos81m/fRX4g0sntrl6PzmiszZGcKI1SUshwZdtak=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TyiASOLvdiceQwSV7mMUuL8gPg1P8GWMbwpFb7pHvzpCtZK2bgSSYnaHSIHn37ZtSty4ReRgSc/UGlx3oYD6XCjM/hBBBoE9b1ZnSTFcWR18nJCV03K33yOlWpSk4UQxpPZYN2w7CdnO8bRpNsbSOVbbbOepAZ9hoXequQhC06s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfyF8ovN; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfyF8ovN"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b9bc648736so324481685a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 23:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735023712; x=1735628512; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hb3edpB86F36K+Fvo5vIPL8KnH2djcclE3siWx+oPPg=;
        b=hfyF8ovNsazsfhZ50+dzt6Lw/FunMZWsOMegZpuzpcOoZoCluxchRq8mjzsYzbPJ1S
         fnpM6/OKNeNWQnWpNb1TO8W7/4Xo+90Jk7Re99zbIDIUfRQkpHsXP5cduRox7BqYmRDn
         yOskTQkQVl/JrKYr+28zI4Nxlk+vDwNeQhgC7He+Aimf33mViSVrlEPp8lx/7vq0xU3p
         0ry2Cu67CqsXRn1pgty8BF8Kur+N5Fr0wGojvlWIH7IPnk0xi7MrQ6mJc4jattAzYO6L
         BJTM/KXAcrw3y0qGgrvq1fpZBn2trMeTAiGMq0Ai+QML+ROVryGEJSf0Pu64qjnMV0q5
         IMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735023712; x=1735628512;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hb3edpB86F36K+Fvo5vIPL8KnH2djcclE3siWx+oPPg=;
        b=EfWMm6C2FzHMNNgEJbU7DLhXe2OIJu5VTOTBWQA4TtQTrf62fK4eYtbY3JdZiXNCqe
         E4veDrIIEiUGH+8+J0ic3Yv3CnafJoQZl3nTqEWkUsakpX3f0uPJ4CLMju+f+O8X4EFV
         agKveQccjd3117jkVbmMJWpXvopKSMMEliqz/lcyptr1OkF/MyBayG+Sp4j0+24dhTHx
         fiB2nPIvAID283k9gHT4i/kq8G65qXpSQqcfXEWc/MeEcGMF2FaEIA2rvuL1sQnHPLIE
         1jDpGHXy8wag8NGIPE/dvYVWJjALYyUlBAjIhRicb02f0Sx3VgOJLStd/83KSiztAgQp
         3kEA==
X-Gm-Message-State: AOJu0YwkihyQLTeqGIVLxbYGTo5LH7H1EkWRbx7gKx0YmdV2GWaIde1m
	ij+5UnJRsL9B/CIAXw4ILDVnnkxaYcqK1aJXzN0OqciXfnugb9QYdYZvohz/
X-Gm-Gg: ASbGnctdmeAslEW0ylvEZHkfUPpGhgQN57LMAW3vywRBjj4FSISAzeuMYMySb1XcugH
	ucE6wtdyU0aoy1TKTJf5EF/D2fxTfQrFQbbLA6q385SPi4v3JbVSbjhDaL4JEPLp/LYjEnpBg4V
	LRVEfmEYNCdaj6ioy+Pw5lUXwWonP8fKNSQz6Jctx598gRs00QJKzxC+nfZH2yM4lt3ddB3afTg
	eCLG+ERFLVTwWKFSy4TsZVeF8+E0jUvPqMXQKL0InRZcln/Ig/UwyVUcKky
X-Google-Smtp-Source: AGHT+IFJhbuFvQ1tkvf5898IAXUmSJ1tYvKExM3dsgiRVOAbIhf3zNb8Gb/FspV3O7OH4CsSSDUMnQ==
X-Received: by 2002:a05:6214:c64:b0:6d8:aa14:f5b8 with SMTP id 6a1803df08f44-6dd233b6e4emr249495596d6.40.1735023711627;
        Mon, 23 Dec 2024 23:01:51 -0800 (PST)
Received: from [172.17.0.2] ([20.51.199.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd18208102sm50541016d6.128.2024.12.23.23.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 23:01:51 -0800 (PST)
Message-ID: <676a5c5f.d40a0220.2e9a31.12e0@mx.google.com>
Date: Mon, 23 Dec 2024 23:01:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5468088061635256574=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, en-wei.wu@canonical.com
Subject: RE: Bluetooth: btusb: Add new VID/PID 13d3/3628 for MT7925
In-Reply-To: <20241224063522.82004-1-en-wei.wu@canonical.com>
References: <20241224063522.82004-1-en-wei.wu@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5468088061635256574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=920632

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.17 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.05 seconds
CheckAllWarning               PASS      28.24 seconds
CheckSparse                   PASS      30.74 seconds
BuildKernel32                 PASS      24.92 seconds
TestRunnerSetup               PASS      438.38 seconds
TestRunner_l2cap-tester       PASS      22.49 seconds
TestRunner_iso-tester         PASS      27.84 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        FAIL      121.77 seconds
TestRunner_rfcomm-tester      PASS      7.60 seconds
TestRunner_sco-tester         PASS      9.52 seconds
TestRunner_ioctl-tester       PASS      8.10 seconds
TestRunner_mesh-tester        PASS      6.15 seconds
TestRunner_smp-tester         PASS      7.01 seconds
TestRunner_userchan-tester    PASS      5.11 seconds
IncrementalBuild              PENDING   0.77 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.162 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.174 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5468088061635256574==--
