Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845AD14EC61
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800063; cv=none; b=Im/qtIx5EI2jlCTZc3Wmzf/DMcm2SVUFo2fFMC2kHQlkMhdLeAJZRU1kCZ0sHQGFB4wkduSXIbD9TLgYPgCH6wk9qPKjXU0bsXRBj1F4oE/gfX+UQIkn/tYWn5OZplQ0nzRq9rLNa205vXIHVFbmUU1Rpea2t/lEM3skSETDESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800063; c=relaxed/simple;
	bh=/5enReizSIx7wIpURka/8PY2KMLeQ9Ogo2NCUaa9sFg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AlSNPCd4H4atED5Tv2ipKHlpnsRbnaZa90722/kg0oVlp9tw+mQbseh/fOCnsZWJRh3aOAN+8Ngvb3yXNC7ACpc4SZSYoYUgulTQ+thdaYxvMqL0+JfP+LsWZfOHZ9qubl5jXq7eDMbnii35U6AJHkF9M3DOhqUBl/HtG9YDPkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioyoWGiX; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioyoWGiX"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69b10c9cdf4so17150606d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 08:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713800061; x=1714404861; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LglUuL3z1jvA3c7EH2rG6WKN2v7Gm8aUW6NfkhBZWKk=;
        b=ioyoWGiXaNEJ+ljomfBMCo1qush3GNRe1vo3j+3yF1cNR2x/rL4ts76fUmMrUFtDUA
         IS1Zx4fXvON3oi5zWIN6K1m0fX1/XnIs7Z9BXcfQDl0kIgAX4m0iff+cho/p8ZxMJMh3
         o67WhLWPFMLIsnI11wHFczmvbN5dMdCIT6AopdCv5quyYG8wf9bFjsEyU+DATtJ8KZvc
         nzjq7IzBcDnvP3RN4t66wUcKpfDvizykc2hP6F+yrfvIPAJ60G4M4VigewZV/ZcDw6vg
         w1S4LF0fqHmqxIbgqOXJSiigB8QWkBorPTKd3zDhEHmacNdBAoraqfreewFNIePqzjqF
         +zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713800061; x=1714404861;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LglUuL3z1jvA3c7EH2rG6WKN2v7Gm8aUW6NfkhBZWKk=;
        b=Nm/MGiMIKbNfpzIV+d7oueNQLKCrCfYYAMLInXKzVcnwF/t68Vlz/qJga2b38r78QQ
         ulA2bseIQYQH7EjPArg9Qys3k/j7D6n71W05FIVJAF6Rzxs4haM3K7v6qnkaBvHIExH5
         N+yZc9kOS8yuQXNHnTUriq6Do1WndkKNY9jj792X4qjYtaL23rbwVCmo5vXJLH1mQCc6
         BLpaNent5BWkODQWhec3vYTmrftTZK3YhZ2CvO4GdEI56wzZadpbzVAvNb5r/IRLTOMM
         /+NeFNGYIycTM596PsiPP4H+NvZrKCLKoMa1YK8dxOY7JvM12GRk1FMxnOWkwdKkz37I
         Q68g==
X-Gm-Message-State: AOJu0YwPCDZM9Wv57fKOJMydw15eRt+xBlZr+5PHFsgfM/umFWdHRTZf
	nFCzQ9891Vbbiy6uPSOVDO6ZF9UfbZfrWS52gq14eGvVBRs4YIryWPwEug==
X-Google-Smtp-Source: AGHT+IH+h5kqmghdk0moOamWqqDc55y2iaNwxkCuhv+FDvhrDU2NyxSqpmk5H4i1YxgQS0FV1VH+qg==
X-Received: by 2002:a0c:f88c:0:b0:6a0:7324:600a with SMTP id u12-20020a0cf88c000000b006a07324600amr7062249qvn.52.1713800061284;
        Mon, 22 Apr 2024 08:34:21 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.161.210])
        by smtp.gmail.com with ESMTPSA id c10-20020a0cf2ca000000b0069f54baabe1sm4316749qvm.127.2024.04.22.08.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:34:21 -0700 (PDT)
Message-ID: <6626837d.0c0a0220.97c2d.2275@mx.google.com>
Date: Mon, 22 Apr 2024 08:34:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8817054690801684371=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v2,RESEND] Bluetooth: qca: Fix crash when btattach BT controller QCA_ROME
In-Reply-To: <1713796702-22861-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713796702-22861-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8817054690801684371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=846699

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      31.88 seconds
CheckAllWarning               PASS      35.51 seconds
CheckSparse                   PASS      40.67 seconds
CheckSmatch                   FAIL      38.18 seconds
BuildKernel32                 PASS      31.05 seconds
TestRunnerSetup               PASS      551.98 seconds
TestRunner_l2cap-tester       PASS      21.08 seconds
TestRunner_iso-tester         PASS      34.75 seconds
TestRunner_bnep-tester        PASS      4.90 seconds
TestRunner_mgmt-tester        FAIL      117.39 seconds
TestRunner_rfcomm-tester      PASS      7.68 seconds
TestRunner_sco-tester         PASS      15.28 seconds
TestRunner_ioctl-tester       PASS      8.34 seconds
TestRunner_mesh-tester        PASS      6.12 seconds
TestRunner_smp-tester         PASS      7.12 seconds
TestRunner_userchan-tester    PASS      5.02 seconds
IncrementalBuild              PASS      30.33 seconds

Details
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bpa10x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bpa10x.o'
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 486 (98.8%), Failed: 4, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.162 seconds
LL Privacy - Add Device 6 (RL is full)               Failed       0.194 seconds
LL Privacy - Add Device 7 (AL is full)               Failed       0.198 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.210 seconds


---
Regards,
Linux Bluetooth


--===============8817054690801684371==--
