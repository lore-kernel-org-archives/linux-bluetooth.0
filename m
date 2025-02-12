Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C83E20A5C7
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378209; cv=none; b=q0L3ozOhMv6UvTRauG3Gdni5CG4ZeDSnlA1IUw/TX7DPm/NZocHQy3HKRBWmyuvu/6+GgGdb8qTB5bJSZvkx0H3DAa9cZtOWfQaibYr8C7dZ2sMbDiCQWPHuzXvypHx4XUPfZdnNHyrs2m9nsk+4B+CY8tpURBuFeCykIlRQGoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378209; c=relaxed/simple;
	bh=lK/f6cY/FiFpcBAw1ND/QbxM6FBGfZiTNcnMi57PAs8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=O9FOBdfn3C/Q9A8As60RR9j5bVSqb4gnthgdPUKIAnkLjYRNgUd5mnrkFAxRBW6ovErZ3o4bDKVgSqBjyCDdTZYpLLqQI5kUoSSBsz0OV0SFWV28qUk4PdteLNPZaV4PoCvm3thCEf3quL24mxeAU1UDbtKcNn+oaOkyphYP+6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIEMTEpn; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIEMTEpn"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e46269d2c2so42632266d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 08:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739378207; x=1739983007; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vBgSOrouUz1qLWtUjXBCrMQWoQxUMpJ+ELsIKQLNGBE=;
        b=VIEMTEpnjxJ+Ab1GF8sosuSDDulK347YMD3bqoiAQ3KCifK0R6Sexs2+omlF/smiii
         Uale9V3a/4MYOIFH6a+oT5TkkKTsmHh+H8xN06ml98Ia8zSJ/V/vmlh16Eq3evywuIGV
         JPnu0asBGCyzyDh2AV3xwY9X+f/QmhoZYZMVWg+UywK77eVL5SPjp9X/5qLSKLcmCRYD
         s5jMxZMsrMy97FtUaRNYJnjDn9TxC68NfCKF9Pj2lm/53rNLbxHuOMJu84Jozt657GMs
         M7Q2jWeztC0n4Xx0YRkCnBPg4y81lt2LrO9pNQEYY0H3yhSt7zH9IDU5z48UVFrdcyVF
         IM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378207; x=1739983007;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBgSOrouUz1qLWtUjXBCrMQWoQxUMpJ+ELsIKQLNGBE=;
        b=CSqI5PzcwACaun2ll5UeI1z7+lgjFY0IVvzpeltTwGX2yEd9xcD40zRmrkLSkDej6K
         5sbPT2sOIsniDPyzgaRlS2O0Sv53eOn2YTOK7p0lRAmV2SPiZJhsFFmf2hjp4T+cpDYW
         C3SsBU6Rjfd3toWZogVE+/BXWqjLrBcffNx7gv4+L6BX4vfGzTlbB1moEhqRfNP512tD
         YUY9vWH+lUwMgiB8UEbtFV/Y/gWaMAE1B4i0FB5tD3iQVEuNpg4iQSK5CTnB4XE+gkuS
         2jaU9DPqbx0sm0MEv/2y2gTv2/JO+JL4I9wSPdn02klnkf3k65fdZ6buxJOTy6F3mf94
         ffSw==
X-Gm-Message-State: AOJu0Yz3dk3Rso1HpTRH3J56uvPxeqDrVtRSukjTU3YRZ28ZTTwO0OxA
	90yyxzO7uqklxZipsxPQChtGHcrQ5xuM/JI9OVPNoRVzgulsnAwweR2WCKUw
X-Gm-Gg: ASbGncuq52se/xjMIPqXUS/c6z5+9m0d8oEycsQlmXY+PJlJkrw1PfemBkokvVXs29L
	xyPeJHwPx3uAKOp9kRy9bXdXFUuqbKAHXBOlEJ1Ooamg6x/TGVRgn+TY/jjdl9BvDZyWc5FOrrq
	HcW/lf7S+L5Z+VbQmdQ3bKFk/rLKCWQwcIeRWQHq0obvWhckkrp/MHhcS28UQ5lmjitK4GpMV7U
	bKYVJ5sY1YJmfxDiiWq23y5cFtatgmHspCC7N/zWEGfqWquLhZHluZZsE2mhEufnRvBBhDcmQRW
	9iGWF/FefF02HA2dbN7Z/A==
X-Google-Smtp-Source: AGHT+IFyH3icwvWpUyuE/4mzf/UvfvYYU3gMI3ZGjuP5XCL5KjLdGMLoiBwUtH4s21GRRInUTcJl5Q==
X-Received: by 2002:ad4:5ecf:0:b0:6d8:846b:cd8d with SMTP id 6a1803df08f44-6e65c1832aamr1437096d6.30.1739378206820;
        Wed, 12 Feb 2025 08:36:46 -0800 (PST)
Received: from [172.17.0.2] ([20.124.86.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43dd7818esm78496706d6.68.2025.02.12.08.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:36:46 -0800 (PST)
Message-ID: <67acce1e.050a0220.3f628.b64a@mx.google.com>
Date: Wed, 12 Feb 2025 08:36:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0725985972829468268=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, alexis.lothore@bootlin.com
Subject: RE: bluetooth: hci_wilc: add new bluetooth driver
In-Reply-To: <20250212-wilc3000_bt-v1-1-9609b784874e@bootlin.com>
References: <20250212-wilc3000_bt-v1-1-9609b784874e@bootlin.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0725985972829468268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=933239

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 FAIL      1.93 seconds
BuildKernel                   PASS      25.72 seconds
CheckAllWarning               PASS      28.21 seconds
CheckSparse                   PASS      32.61 seconds
BuildKernel32                 PASS      25.49 seconds
TestRunnerSetup               PASS      450.87 seconds
TestRunner_l2cap-tester       PASS      21.43 seconds
TestRunner_iso-tester         FAIL      65.35 seconds
TestRunner_bnep-tester        PASS      5.04 seconds
TestRunner_mgmt-tester        FAIL      123.64 seconds
TestRunner_rfcomm-tester      PASS      7.87 seconds
TestRunner_sco-tester         PASS      9.78 seconds
TestRunner_ioctl-tester       PASS      8.67 seconds
TestRunner_mesh-tester        PASS      6.31 seconds
TestRunner_smp-tester         PASS      10.92 seconds
TestRunner_userchan-tester    PASS      5.35 seconds
IncrementalBuild              PENDING   0.60 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in iso_conn_hold_unless_zero+0x78/0x1c0
Total: 125, Passed: 121 (96.8%), Failed: 0, Not Run: 4
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.186 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.138 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.174 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0725985972829468268==--
