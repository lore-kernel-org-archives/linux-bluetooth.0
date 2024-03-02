Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5D7134A1
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Mar 2024 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709369785; cv=none; b=UIhr7WrOJkHV1vupoAVOjQ4pjuvN66pf7dhm4EU9YV9wCiWcAZ3ul8NDi+6philu6u8cWKQhsgkye3z8p0oyT1zfDiBj2CG0q6FgrIQOVInXA4Sbl6RFbksJi2Y3dmTA3htR/KPCi1F5ZRqpDINuuoXNqpQwKpkARTvpocNGt4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709369785; c=relaxed/simple;
	bh=awmx5WT+IMqCpNOAdckqm6x9cpKnnHAd/VHCcYeiVlU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ei1474JBhU32wPn+lCNW9aw7HYdcEHxPtsIzcCq/cB6TiZFes7OsKAk7y3zAduMADKbkgUqjdQhMf2/4JCOhJE07NwwRyVt4/DviRVeOerS/l2ayrAfrgJLftXaMdV/I3jvmY++O9vhZbGtjd4sd38EPOeYhk50xljyv7yq34MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lm/lU5CF; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm/lU5CF"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-21ea1aae402so1507339fac.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 02 Mar 2024 00:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709369783; x=1709974583; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XWHWEa3G6sE0xakIHSAHStpHSrqsmzZ0hv0LbVtqGYg=;
        b=Lm/lU5CFatSOIL4ST4KExv2fXF//Ejha16RQqge1Vy0WqxJxPICIs58DlMdtTVIYRk
         czd3ofaNpHuGMfeYB5GvbNeSp3SXT2T4JyBk5S6K6Yw7REl5558l9LFEYJooF0AZ64K5
         KrdtB93Xyf///tpZ/VfH3crfWD8Np8sjajlBnSn03mfQtgCs/Y09nGbNVle6B0BJBlmT
         RnyEd2DIs2d+OZ2vAjtq/iSgg+9VDVsAQoqwjIzYZ9SM7Ok6MOXqFMkPktgaoyx6XkA1
         rRFu36NcgqJW9L7+X4q3eI537HOWB1kpG5zzJfSq4UMU+Jup06AoVljle2mHuAq+LRZE
         puWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709369783; x=1709974583;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWHWEa3G6sE0xakIHSAHStpHSrqsmzZ0hv0LbVtqGYg=;
        b=MZK+gkCrZmz6VEZWFVRAJxJj/uO8p2K0MZJeHs7Sw7WLWuxwYDHcz6+ruEtbILhQFC
         RgKXlIWJXE0mZ4CyJGSv2vJQICpi2664QfNDh4YnaihlbdRjHjtBq3rNbFM8n+UAuPd4
         B6dWTgKtjfLgwICPk8s+JG1rDpCN72CMg3FbaIdctDbOgjQFE/g4cFa2GA5iZLXQYiuC
         oDR/9+jhiyGYJHirJvqaE3Tjp8Co/IeTvE9z0ZuF51JfoxFSqCTTjD+oHMg/q5VyUHsX
         YblMnUudREZ+9BOpSYlGeofP6NwjIJU1v3L93YRUtb2wK/M+AwZ9MLVWJkC9P2PDUuOs
         KGBg==
X-Gm-Message-State: AOJu0Yx9lgEP3uueSxpEmNcZAUNAu7ZiLTzSs5szmzDhQX0M/Ys2Y4Lx
	88QV2+zbzCbfBNJArWV16f8Z6LFIPvfWw+zn++3iyDH8SEk89SqWD8sk4hgr
X-Google-Smtp-Source: AGHT+IFkJcZK/gveVfgVW5xBVeG5zFikT5MJwVqqU19iC0CLYjjpBCfEIWf4IcOdFPxhGN7flh6nJQ==
X-Received: by 2002:a05:6870:dc4b:b0:21f:f485:6b71 with SMTP id nr11-20020a056870dc4b00b0021ff4856b71mr5027495oab.8.1709369783307;
        Sat, 02 Mar 2024 00:56:23 -0800 (PST)
Received: from [172.17.0.2] ([4.227.114.178])
        by smtp.gmail.com with ESMTPSA id b123-20020a62cf81000000b006e594b068c8sm4209807pfg.116.2024.03.02.00.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 00:56:23 -0800 (PST)
Message-ID: <65e2e9b7.620a0220.5fb7d.3820@mx.google.com>
Date: Sat, 02 Mar 2024 00:56:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4800162063082071467=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dan.carpenter@linaro.org
Subject: RE: Bluetooth: ISO: Clean up returns values in iso_connect_ind()
In-Reply-To: <5f73d9d7-61d7-49ab-a5e3-adda72685122@moroto.mountain>
References: <5f73d9d7-61d7-49ab-a5e3-adda72685122@moroto.mountain>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4800162063082071467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=831774

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.72 seconds
CheckAllWarning               PASS      30.40 seconds
CheckSparse                   PASS      36.05 seconds
CheckSmatch                   PASS      97.93 seconds
BuildKernel32                 PASS      27.08 seconds
TestRunnerSetup               PASS      496.58 seconds
TestRunner_l2cap-tester       PASS      18.06 seconds
TestRunner_iso-tester         PASS      30.38 seconds
TestRunner_bnep-tester        PASS      4.71 seconds
TestRunner_mgmt-tester        PASS      108.85 seconds
TestRunner_rfcomm-tester      PASS      7.37 seconds
TestRunner_sco-tester         PASS      14.92 seconds
TestRunner_ioctl-tester       PASS      7.77 seconds
TestRunner_mesh-tester        PASS      5.86 seconds
TestRunner_smp-tester         PASS      6.78 seconds
TestRunner_userchan-tester    PASS      4.88 seconds
IncrementalBuild              PASS      25.83 seconds



---
Regards,
Linux Bluetooth


--===============4800162063082071467==--
