Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E772EB0E
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Mar 2024 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282156; cv=none; b=A0eP6IF8Hy+mk/DkHGAZs/90+QH709jYpA1VY9KNBdHIq4FeRzbyUiCpFrzUVca1g7uYkXOKW46S0UPqSxQitwbIBfvjFloSJ0Q28ACpDlJ9+oNRB25gNMCacltsE/R80QXghHRCn9KC42KjN/N2Og4xXDMFMxUFME8z0fErUq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282156; c=relaxed/simple;
	bh=naJNXbxKUSB0j83QuGyEfqKmIgf9baQHa/aFc+wPBHQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WDKFhmJT6hCtjfmzo0nhMJaj30OG9i0NtkzNwsA4BzvKEXAK3OCBww5Dja2g8zDahuV9MMgM4xq0OWwFFAVxzWpppdRXkadKBa/cj97i4LgCewKHR7xWgjt8NExRpJLF3To3ucDzLfS5jgD16QkxQyRiCjHWf5QWhvyE9llUJLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYxMleiz; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYxMleiz"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68facd7ea4bso8031706d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Mar 2024 00:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709282154; x=1709886954; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T8FDYcGOtuoukjLOs9T+IW1GhxRt9F0LodPLvPEqySI=;
        b=ZYxMleizKaUIFrWNKtGOIbmgrLG65p1MFodHI6lr0pCcV3Rt6PAxfG9fziS7ksmaUT
         6MD2dp9oHjeeu1rTrvG+XlAld+Xud+UoaqU1CVrAknBFxGnTVaF/QB4f79yXG7jFzV8c
         D7PfkcTUEGnuj6buaLWnen+YClvM4Lyqk8TZ00h3W2KQUPL9IjBvpEB4bUwW+umZPYCM
         hGSHwA1OEle8D66TFE6kv9NrzSyLKp7ufIQh8O9RzQY7xt2KFJ6tVNbAoea20q+ikYEj
         JQfXlxubU6xjgWhoA/uAIbysHZPmjAxTChLOSpA7lZy9E7KKSPYAO26QsF0gI8vpMtYT
         oyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709282154; x=1709886954;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8FDYcGOtuoukjLOs9T+IW1GhxRt9F0LodPLvPEqySI=;
        b=L17RShtoYRz41qnQQe9leM2F+lgBmkdtnxMUDp5baMre/yoMCqGFoxfuALCJmkR7KU
         IWZOVYI+xBeY0asfqUF/KZdgLbSWR1aUNPC1MvWR0+w27BJSym3jSGanvirJXTi4DWv3
         n3rAEu41OKOc4fcSzwuOQprmhb8iHagEIqk7M3Hsd9cz3+Kh0DPiBc/ZeAgNR1SqSB7s
         CsGoicXKc8f2vaGewcT72jOdzNNopn28zyFh1b+gHu01Dx4KDY771ev4eF8PNgLjBBQo
         OOxf6pQhjvK4cc23VZNG0ST67l3INSDyUcUA/XORMQlc2ybzZs6Hk/9H7uW6wg5glBeL
         U7Dw==
X-Gm-Message-State: AOJu0YwvgzIqowwwbpt2lQuTPxi28lobFL9JEWe4g2RTI2hEGCyNNKvM
	rkrTfnMqoj95jGnGRdVQb4ucXPiltUkRpWi6NCLi/ez3N9QaxanxfOm4U/DH6ew=
X-Google-Smtp-Source: AGHT+IHAUnz+QyCi6Fds/l9CH9SR3hkcWRnIY46tjLCUqq322YIDL5rOuDTOki+L9HZpe6YHGEtfdw==
X-Received: by 2002:ad4:4491:0:b0:68f:d6a9:7065 with SMTP id m17-20020ad44491000000b0068fd6a97065mr981289qvt.44.1709282154100;
        Fri, 01 Mar 2024 00:35:54 -0800 (PST)
Received: from [172.17.0.2] ([74.249.23.132])
        by smtp.gmail.com with ESMTPSA id pd7-20020a056214490700b0068fe3170b0esm1644762qvb.11.2024.03.01.00.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 00:35:53 -0800 (PST)
Message-ID: <65e19369.050a0220.6504a.7538@mx.google.com>
Date: Fri, 01 Mar 2024 00:35:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2782977855399465607=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: Bluetooth: mgmt: remove useless NULL checks
In-Reply-To: <20240301074824.1259409-2-r.smirnov@omp.ru>
References: <20240301074824.1259409-2-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2782977855399465607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=831404

---Test result---

Test Summary:
CheckPatch                    PASS      1.24 seconds
GitLint                       FAIL      0.89 seconds
SubjectPrefix                 PASS      0.22 seconds
BuildKernel                   PASS      30.45 seconds
CheckAllWarning               PASS      33.01 seconds
CheckSparse                   PASS      38.01 seconds
CheckSmatch                   PASS      104.03 seconds
BuildKernel32                 PASS      29.19 seconds
TestRunnerSetup               PASS      517.85 seconds
TestRunner_l2cap-tester       PASS      20.35 seconds
TestRunner_iso-tester         PASS      33.56 seconds
TestRunner_bnep-tester        PASS      4.89 seconds
TestRunner_mgmt-tester        PASS      110.78 seconds
TestRunner_rfcomm-tester      PASS      7.66 seconds
TestRunner_sco-tester         PASS      15.25 seconds
TestRunner_ioctl-tester       PASS      7.98 seconds
TestRunner_mesh-tester        PASS      6.11 seconds
TestRunner_smp-tester         PASS      7.11 seconds
TestRunner_userchan-tester    PASS      5.10 seconds
IncrementalBuild              PASS      34.47 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/2] Bluetooth: mgmt: remove useless NULL check in mgmt_set_connectable_complete()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (83>80): "[1/2] Bluetooth: mgmt: remove useless NULL check in mgmt_set_connectable_complete()"
[2/2] Bluetooth: mgmt: remove useless NULL check in add_ext_adv_params_complete()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[2/2] Bluetooth: mgmt: remove useless NULL check in add_ext_adv_params_complete()"


---
Regards,
Linux Bluetooth


--===============2782977855399465607==--
