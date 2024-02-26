Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191AE13473A
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 22:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986868; cv=none; b=W/TyHLlLEUSiI7jtGvGgQuv+k3WziHm3S9me52QEt8g4Z58XmqPTmie+drfiQd+EqP2z4mKDY+OAtp7YSTnOOkp+9iZBNZAg6s0TwlDeQJS1fgHoqyuIIBB56E1fLJ8k9WQBrv0YC0xLdtV9Zp+yU1jFCmlIexx5D9LviPBCUnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986868; c=relaxed/simple;
	bh=bFMCIYqjA3NExLU14dNg+ROwT0kbZ+3bZHJ94iTL9Jg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MC9oXvxE5RgUr7Ocusa6z05lT6y+FxCRQnvgrPWqcoVJXuVAW+0ND9NZj9p5pe1DEQ5jx+eikz5Kgbk9bwO8InMXWR7u19EMBtONKUA1KFbF6Cw2DmY6qNtvzI+ilLnqAFJ+SR2IidMiN5BJnmf1dH+AvAU2rk/ew4WaCjPnddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbXsQTCr; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbXsQTCr"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e49833ccdfso810212a34.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 14:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708986866; x=1709591666; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=itTurH5pVm1vjRA+6+EIbb4wDFoTRLTei7ch0EGJiLw=;
        b=KbXsQTCrYoxuCEz11RgMg1Xkd6DJHOk43UsG6WQuvld8n3STQjF73fCh08VvrKirUb
         /2uLBnmOdAwq9rp1+u2NPBM+fZ4vK9tipbj7/P7mibpeonu6C/wzaiD66iXHxRTdoGwg
         IvMX6sIrG+No4umFLeJPxt22o3AKKFjmVVkNc0JpDDuC9j3463BEGaHYBgEz1XQ3tC7t
         59cA5vZPM7N3FaWi80U9XItZvxZ2Tz5FtcMv9lEKqGEA1d95fd4jbUP5atMReAXMUH7M
         yM7sIKt1PxMZfTdO6SoGiqfh+LOzdSQme1vJoTtPGO0YDDtpE/l5b/dUAQKxhs1PwEvI
         PDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708986866; x=1709591666;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itTurH5pVm1vjRA+6+EIbb4wDFoTRLTei7ch0EGJiLw=;
        b=DNkByndTZ8Ybgg92A86j79uBkqNYObJ6RoGKsnF5dMOATP+7o89kbKsCVmmFHv6nJ3
         5kQXwERv5QASiUHgIraMqSqTRFvulZQHOZUXQNdwardLNXzEXvLVufRodgCd1PDugA1v
         qddDLov54sRThNXf9lPEbQV9flGXx1BwnZiKycfa06zApjjNI2RHEItsVNWcC0wJe3yB
         q33UkrMv/yvjGQ6MyFZRaG6NgGAXw/p2Mx+s1EI+mkEl/G384qTJ6ySpUTXKJKoMnt5a
         etEdtXHTYBEqwrCWSC/HfQVCO2lRmatD/GpIcKcdRgKscYRTRK2Fey6H/firSM+xAqnA
         fuxA==
X-Gm-Message-State: AOJu0YwgBUay2jioxADhn5+rI6seCUEcMZOXk5SIM9oW1JXvQGljfiPU
	hWCg3PkJkaI5jVKe+Ms7odZUblZ3EEOWI3w4qpHiw/+fy2Lpvh7YuLbfRJKy
X-Google-Smtp-Source: AGHT+IHovOvGMllVrcEBcEyh0CLhqGRjagoa2TzkFDUspz2Vuwx0+nniuy+EjRl5K1J9SAsdEIPmaw==
X-Received: by 2002:a05:6830:1557:b0:6e4:640d:797f with SMTP id l23-20020a056830155700b006e4640d797fmr7960175otp.35.1708986865873;
        Mon, 26 Feb 2024 14:34:25 -0800 (PST)
Received: from [172.17.0.2] ([172.183.50.159])
        by smtp.gmail.com with ESMTPSA id p18-20020a05620a057200b007872d50caf5sm2940362qkp.19.2024.02.26.14.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 14:34:25 -0800 (PST)
Message-ID: <65dd11f1.050a0220.791de.a3da@mx.google.com>
Date: Mon, 26 Feb 2024 14:34:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6290401605313836223=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4,1/2] Bluetooth: hci_sync: Use address filtering when HCI_PA_SYNC is set
In-Reply-To: <20240226220031.1686256-1-luiz.dentz@gmail.com>
References: <20240226220031.1686256-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6290401605313836223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=830056

---Test result---

Test Summary:
CheckPatch                    PASS      1.29 seconds
GitLint                       PASS      0.59 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      30.03 seconds
CheckAllWarning               PASS      33.36 seconds
CheckSparse                   PASS      39.30 seconds
CheckSmatch                   PASS      104.56 seconds
BuildKernel32                 PASS      29.22 seconds
TestRunnerSetup               PASS      536.96 seconds
TestRunner_l2cap-tester       FAIL      25.62 seconds
TestRunner_iso-tester         FAIL      52.66 seconds
TestRunner_bnep-tester        PASS      5.13 seconds
TestRunner_mgmt-tester        FAIL      125.49 seconds
TestRunner_rfcomm-tester      PASS      7.79 seconds
TestRunner_sco-tester         PASS      15.40 seconds
TestRunner_ioctl-tester       PASS      8.37 seconds
TestRunner_mesh-tester        FAIL      6.46 seconds
TestRunner_smp-tester         PASS      7.14 seconds
TestRunner_userchan-tester    PASS      5.30 seconds
IncrementalBuild              PASS      35.49 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 51, Passed: 50 (98.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP LE Client - Close socket 2                     Timed out    2.692 seconds
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 115 (98.3%), Failed: 2, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Timed out   10.255 seconds
ISO Connected Suspend - Success                      Timed out    8.251 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 485 (98.6%), Failed: 5, Not Run: 2

Failed Test Cases
Pairing Acceptor - SMP over BR/EDR 2                 Timed out    2.658 seconds
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.158 seconds
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.175 seconds
LL Privacy - Add Device 6 (RL is full)               Failed       0.191 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.052 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.112 seconds


---
Regards,
Linux Bluetooth


--===============6290401605313836223==--
