Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8A5273816
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288519; cv=none; b=cz4P4xSmNPVl2B21cyN/FOIOjWrxVzjxYu4ve2ijF+xHqbN7H+SG/q0ELc9Spl6Lf+4LRvfja9AUgZ3kkqmhSuPhS1bvPxkQR5iaecVVpiTuo8fIU9fF0JpI1PupO73g6RG622PIKsYZVytcEUfxlA32mxnF2ymu2XeZX1SPwAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288519; c=relaxed/simple;
	bh=Lxr1wH2YLLoxKGnAZ7eOLkGgW+Y2EqcfQKg5ziNgZvw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Wi5x8fe3YuZwuUog5OBjwMBqzXYcs91RVGPj1Jh0wz5RbRr/rpq3i1w/W+RLsyZSVRpGPEY5VREKSguboRZUhigYwS8jMT0j2ilk2NuKnqIzPXNeqeojBa6/9aUFnzl5d+uE/ZNptXNRuHTd0dMwpns7YP10P634188EHmNGqJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQGUEbib; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQGUEbib"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso85061646d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779288517; x=1779893317; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T8SyUjdzpbGliGyfDudHMYkYkWv9pycIdSN3RTl6ZLo=;
        b=GQGUEbibwzg2cNWOOBynqH5BtjW0U3MyaXtw4MvX2rhCN6Xc+MbgAFiSkR+cB2ipz+
         zzO8OutrSCdjS7UQOZQ2xYSNiV/q3f7Z7aHPPUZZ+KMxukel5UtYbiF2cfHbRXD8s5QV
         0Ew+RDLsa5hPOxW3udj2RXhLJQpPFMA6hECvsv5TuFtXC6u8uVV2Yykx0kJ9bfXzvxKU
         hmyfI4luwN9r8MeRddaHFQeUQ/teM+aTB8OdvToAzn479mRij/hoWa6rgm9cbk0eAywi
         dx4ePGd+R5UeAp1z9yQLgDROi9LlKa7MDAzlWJuh2rrNHlTTsjvpfvs0nqkKySGmMnG0
         nN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779288517; x=1779893317;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8SyUjdzpbGliGyfDudHMYkYkWv9pycIdSN3RTl6ZLo=;
        b=DDzOsAqM5LEDzEhsREe5oFf0WxJ4x+wkgvzjujiq88Ui4kAjRHkIt5ck8/85VRITYH
         a853m1nwuQt+7m6+7RuuVGZHCKJXCYmXWv2X83g3y5wQ8996DVydwgrhCUrDOFDaXyx3
         hvXoCozcrM3n7wljncwDPphd21TmrFbVPVwJZOkdATyao+K2Mp1oG3V5HkuFsyJNZUC4
         EehCSNfTtrhY3d4eZ6YGOBOBQNKs/mZys6L24beMOHMGKn4eXythOSTjX0uzOnq/u6DV
         kKGlpI0SmrdzC7RNZZA5/HAzEO6zmfF3CrZLtp0RPgigp1zniVAhotI6cJrto6ivXCom
         xnkQ==
X-Gm-Message-State: AOJu0Yz83b/EXsHJYJDf60l1LaIY7y3RdxG7KtRCLxnbqyiDx86e3Lcq
	vxHzTmhS/DRj9lytRJF4htkpoKlHDFcRX/COFucJXSb/Z5cNomtBzkbmiaTkqA==
X-Gm-Gg: Acq92OG/n9TT9iSZY78DYcM3XeR36ZiisErFFaGWDWB19qbcUGVsCp6dFNDqNewvUsA
	6RUHjt7K1tIV+N1lZ/b2NwT4md2W0WkVBybfZAXNFBMXMSpwIP2kItsGL64iSLPQTkOgWh0ZJap
	QYeMdBCMhsawna8HFC9zRQ9Ubq5/N6mJw4JQwDrEXNwv3qdycepKBiOzfFTe2H5KcspaMFs5S1f
	6JoMO4Ne+Apn8twrh/0pEZFovKL226M931AQu1ZBizRiZ4ey1YJVuK11k+Pb285pDpoEvXiLHlq
	K3rBoTddnKwDewbc7DMTp/uIJhZtTkexL5NngHweaCALAvyCxHYzsacKmS+w6kjdJi7OjAuL8Zq
	WxMJ6EqGGZACRh4Q7Ir3/HxF4XMXRME1vgXYOgMvLkBhJLJGnM610P/7Kaj042cKgbe6uZyyK6b
	kxydzVQRAss8D3gAW3hL+htSa/Uj1/
X-Received: by 2002:a05:6214:4306:b0:8ac:a689:34ce with SMTP id 6a1803df08f44-8ca0f6e91e4mr405655396d6.45.1779288516561;
        Wed, 20 May 2026 07:48:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.222.82])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36095326sm124400276d6.14.2026.05.20.07.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:48:36 -0700 (PDT)
Message-ID: <6a0dc9c4.44cf08e6.2d8bd7.b56e@mx.google.com>
Date: Wed, 20 May 2026 07:48:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2733949952064051460=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michael.bommarito@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
In-Reply-To: <20260520135034.1060859-1-michael.bommarito@gmail.com>
References: <20260520135034.1060859-1-michael.bommarito@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2733949952064051460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1098049

---Test result---

Test Summary:
CheckPatch                    FAIL      0.96 seconds
GitLint                       FAIL      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.08 seconds
CheckAllWarning               PASS      30.16 seconds
CheckSparse                   PASS      28.23 seconds
BuildKernel32                 PASS      25.90 seconds
TestRunnerSetup               PASS      577.67 seconds
TestRunner_l2cap-tester       PASS      378.48 seconds
IncrementalBuild              PASS      25.39 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 0 checks, 79 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14584036.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
23: B1 Line exceeds max length (84>80): "Link: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarito@gmail.com"
47: B1 Line exceeds max length (82>80): "v1: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarito@gmail.com"


https://github.com/bluez/bluetooth-next/pull/220

---
Regards,
Linux Bluetooth


--===============2733949952064051460==--
