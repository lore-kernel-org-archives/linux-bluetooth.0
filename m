Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFBB757FC
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357524; cv=none; b=oFZj/0R9y2YnUuqQEqLBgca8+Gu1jUsANWOdJmJI7mm9A6/e+MDUa4yhuGnAZscsbT+bYHFJAMY9FqEng0TgxObElnVmyZZQQ45+CR4cBCpXRAIQ0QZUwXboY+dUZWuza+gmQOWyaD28DwZljXPIeSt5qqVJP2JekSxkeLP/x1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357524; c=relaxed/simple;
	bh=OfE/JyvaxHoxsw2nO8bxT2mM0dZFZ9lHTAU1xF+0OKQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SgbXpGwQb5hkJizuUpnLz5gw5ElGewG2Zitv9988sExmG7dyp0922Q5w/nf2NR6bN9CGOKB5amMC4xZBQxFl754H8bY6gqMkOy2oE/zn1cpE7UvO/demccZU2bL1gQ2MyGeBQhUFgI5+hgqMnh8ULuNf//5F6fveRfBtN2TE1Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZ4VpXar; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ4VpXar"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db35ec5688so1498627b6e.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 09:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722357522; x=1722962322; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4NxY5fFlfhG+NO64yvh0KZqg61tSuRQDbpdPkOV8wz0=;
        b=bZ4VpXar0G1JvWdmgYt0+6i8n7G8roUWZibyzbYEQDo0xohBwDfzwOjuMWkPudOFGE
         yGpSnllyqIkku0n9F1Y4RFzJIbDCXagWO3xUx+rO2QAcKXsw26i3/9p0miClmSGB1i2M
         X6LI3Y/FML+QTzRUTV0xeNAiWf1F3L9ssI0rSw6zRugssmyPj28Axt7yLnTdIsmY/hSE
         RJAvFxIDg+L6/Bafji4pBYuQmxd48J1LM7CV6ajaKNF6RY0XCMgM/bHhDnudEgHDY/MC
         FFmt7ZigGF+CQm3ueoDEh9+h+aIKwmOpoEZnJTOGztgPiV7JUflYlhf14KZn4XdjqMoR
         4Z9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722357522; x=1722962322;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NxY5fFlfhG+NO64yvh0KZqg61tSuRQDbpdPkOV8wz0=;
        b=bXkpLfbVMZW6FS5noLDlQ4iK49oisiDrnZnNlN/v+NfouXdOywgEkHD649dgzEOPn0
         20sP9NUEW2B326eVm3qFR3SRAZWfIKGwloE1+WZmi0NwB4IAqDpq5+kVcxXZUbxKPUtn
         oWSU51PtsgcJ5J53Mpxh+iUFxMlOZtZ6OfHwLp/W9o4yd449a6u8LvXzSp+0n+yAvzH/
         VoTl1KRuX5gCeo+PsSv2Y2Rb/0morJZjZAz8VkNhEGemh409Zzgv6zSVpCtPWwU/7myV
         FDWntzNIsSNx8O2rLH50UOA3dgs28Pg7CH6Sks/wFrDd1DqrwTigOpb0bVZyileja6TJ
         3yLQ==
X-Gm-Message-State: AOJu0YyjLbnKDOlziSTGE8+zlbm22Eg735kCrdvfBValNcfrJ9jYnIGZ
	oJWLJIsnoHQc7/SavW0H3Ktm21ay1/cFjfzGLTOe8R2WDLswfshVQaMocg==
X-Google-Smtp-Source: AGHT+IFWYIKPT0OYx/TFMNYZPlhIOBFwfqIt1+bGJgKXLqRspYNOEObfP8Zsc7k6t703MVP/3Hszow==
X-Received: by 2002:a05:6808:1692:b0:3d9:324a:3c9 with SMTP id 5614622812f47-3db23a862ccmr12670442b6e.11.1722357521988;
        Tue, 30 Jul 2024 09:38:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.76.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8126979sm51155211cf.7.2024.07.30.09.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 09:38:41 -0700 (PDT)
Message-ID: <66a91711.050a0220.8474d.fbb5@mx.google.com>
Date: Tue, 30 Jul 2024 09:38:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5008782058040737423=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bearodark@gmail.com
Subject: RE: [v3] Bluetooth: btusb: Add MediaTek MT7925-B22M support ID 0x13d3:0x3604
In-Reply-To: <20240730154116.25336-4-bearodark@gmail.com>
References: <20240730154116.25336-4-bearodark@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5008782058040737423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=875134

---Test result---

Test Summary:
CheckPatch                    FAIL      0.89 seconds
GitLint                       FAIL      0.53 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.96 seconds
CheckAllWarning               PASS      32.32 seconds
CheckSparse                   PASS      37.78 seconds
CheckSmatch                   PASS      102.37 seconds
BuildKernel32                 PASS      31.77 seconds
TestRunnerSetup               PASS      531.76 seconds
TestRunner_l2cap-tester       PASS      24.14 seconds
TestRunner_iso-tester         PASS      37.51 seconds
TestRunner_bnep-tester        PASS      5.01 seconds
TestRunner_mgmt-tester        PASS      111.28 seconds
TestRunner_rfcomm-tester      PASS      7.68 seconds
TestRunner_sco-tester         PASS      15.23 seconds
TestRunner_ioctl-tester       PASS      8.05 seconds
TestRunner_mesh-tester        PASS      6.13 seconds
TestRunner_smp-tester         PASS      7.13 seconds
TestRunner_userchan-tester    PASS      5.30 seconds
IncrementalBuild              PASS      28.21 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3] Bluetooth: btusb: Add MediaTek MT7925-B22M support ID 0x13d3:0x3604
WARNING: From:/Signed-off-by: email name mismatch: 'From: ultrabear <bearodark@gmail.com>' != 'Signed-off-by: Alexander Hall <bearodark@gmail.com>'

total: 0 errors, 1 warnings, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13747554.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: btusb: Add MediaTek MT7925-B22M support ID 0x13d3:0x3604

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B2 Line has trailing whitespace: "BT 5.3 M.2 chipset that I purchased from aliexpress (and which "
61: B3 Line contains hard tab characters (\t): "	 archive.org, however aliexpress is incompatible with waybacks"
62: B3 Line contains hard tab characters (\t): "	 scraping tool, and as an alternative I have taken high resolution"
63: B3 Line contains hard tab characters (\t): "	 images of the actual chip I received and put them on archive.org."
66: B3 Line contains hard tab characters (\t): "	 get_maintainers.pl"
69: B3 Line contains hard tab characters (\t): "	clearer"
70: B3 Line contains hard tab characters (\t): "	web archive eventually came through so I have readded the link to that"
71: B3 Line contains hard tab characters (\t): "	aswell"


---
Regards,
Linux Bluetooth


--===============5008782058040737423==--
