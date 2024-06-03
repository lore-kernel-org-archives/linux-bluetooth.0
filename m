Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9E9374FF
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717399973; cv=none; b=VtSDKZOCErQecAYu/UQ0Brmwfhi9PVVdvtfP1tEepcEs8+EUr7TLy48EL3QceeSJjrqg1Pn+Shv72oU8b02KwikOSrg9i9B5Sla8WQssLdHImlyIkchxI7hyfS+G0itfZt0PBRCkTFtmo2HHcIUUYmVcixnGy9HFxkuhf73zRr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717399973; c=relaxed/simple;
	bh=ydWAB4HxT3RaZFKjAXFxynNACGaEmuRYSuP1KUA3fbM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=c9fIbxHbxgteEOjuzaKNcdujpddC+j0y5gfOIDf6Ehf+xsUrxqWgIhiVE6zx7YI7RHe27D1MWK/gIJIQbTNZZyq0LmwXqsNJNpA+NWVfnxDosohwEAbgl/jT3kH9WOw51lwCZZNEjtp00bgZz/ESXqNptYw67duI/Cwg7KOuUq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8BXcc5i; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8BXcc5i"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-43fb058873bso16227421cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Jun 2024 00:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717399970; x=1718004770; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MZagUn0Xabn4MNZmUozjFcezu6tX3HWjYVjyzT3EEpY=;
        b=M8BXcc5iDmCANyUOpbRe3KDcqVri54cB58NE9DbpRuv+hGICqEyFqLXn/l4bOtAFb3
         8d0HapW511pDZ7j3qtmg43QOMtuPKbN8fxqPhVF76g+HoSsLDEXtEN9u0Y8yvP+0VKho
         UC7Z1MF/Auk5Dj7frFPJFVYNFYN4XJODa0hArWKzvC85m8TeZWRjbRzaKxN8of2yWXHi
         RyGqhfbL8NHDbiPKQyO427RCJ+Oul8EPpTGPzrp8OmI1lw6MBF0c972mMKtMJ5KVNgMd
         TCudTj/qraBayiywbeI2JSC+0EaeXAPIGhmNRk/AWLYvVFBfQmN6i0A9WEDihDjzbj1R
         lhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717399970; x=1718004770;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZagUn0Xabn4MNZmUozjFcezu6tX3HWjYVjyzT3EEpY=;
        b=INHoU4rogj9zYv9DQrzkA5XZISOiMYy2r43yIHHlvQ1m1F6+ntpAMx4EwZTz6DCL86
         BF1tzmctHWeoCTB3bKFMTQnH+586kn/5FonGmZIhHulNHhasxtUVVE1FAPOy/u1WMJLF
         B9pkQN475ORncKbIbsRe4ZkEH9RupPcoiXUP5EVwVIj+bq9bDZnS9iNOy4oCHqBzsNrg
         RQ29DxYmMavdygaknJ4mPmyt14bJWHcBuPb0mEo6kTbIAwBKGMRmJtvdFGLn81uy25Ja
         iP5twFkW2ZoJAHEAosvzxACr7arwnke5l6EXaM2BanN/1cLigG80qFsprFmz6VzYQ//1
         zrVg==
X-Gm-Message-State: AOJu0YzFszPDKGArOt4f6Fm07+qIsdlvP5ERweQ9Aj8oLMdYk+E7Eg4Q
	mOB61gV8EnJQrve9OF4/WKTg09zbV+caE3W0MoKL7ArL/RcYiHlOQSC0yA==
X-Google-Smtp-Source: AGHT+IHmAZiUCYFTbDOD/CDGVcTfXFX0XRgin8IH0oGlcDznHMV+5K6AGCo9S3l38qiqUIRyUd/5aw==
X-Received: by 2002:ac8:5f46:0:b0:43a:74d8:8971 with SMTP id d75a77b69052e-43ff52487dfmr96799791cf.23.1717399970574;
        Mon, 03 Jun 2024 00:32:50 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.119.129])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff258039fsm36947341cf.79.2024.06.03.00.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 00:32:50 -0700 (PDT)
Message-ID: <665d71a2.050a0220.44da0.f22a@mx.google.com>
Date: Mon, 03 Jun 2024 00:32:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9186306105606444101=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1,1/1] Bluetooth: btnxpuart: Add handling for boot-signature timeout errors
In-Reply-To: <20240603063753.134272-1-neeraj.sanjaykale@nxp.com>
References: <20240603063753.134272-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9186306105606444101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=858161

---Test result---

Test Summary:
CheckPatch                    PASS      3.18 seconds
GitLint                       PASS      1.59 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      29.90 seconds
CheckAllWarning               PASS      32.62 seconds
CheckSparse                   PASS      38.59 seconds
CheckSmatch                   FAIL      34.86 seconds
BuildKernel32                 PASS      28.91 seconds
TestRunnerSetup               PASS      524.43 seconds
TestRunner_l2cap-tester       PASS      20.40 seconds
TestRunner_iso-tester         PASS      28.57 seconds
TestRunner_bnep-tester        PASS      4.83 seconds
TestRunner_mgmt-tester        PASS      116.55 seconds
TestRunner_rfcomm-tester      PASS      8.72 seconds
TestRunner_sco-tester         PASS      15.00 seconds
TestRunner_ioctl-tester       PASS      7.90 seconds
TestRunner_mesh-tester        FAIL      6.14 seconds
TestRunner_smp-tester         PASS      6.89 seconds
TestRunner_userchan-tester    PASS      5.09 seconds
IncrementalBuild              PASS      28.05 seconds

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
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.094 seconds


---
Regards,
Linux Bluetooth


--===============9186306105606444101==--
