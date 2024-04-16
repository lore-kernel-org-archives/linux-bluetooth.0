Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1C784E0A
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282247; cv=none; b=VubBNfnFEByeRbtRsabe2gaqjQYdiE1GbGqRcfqmPdSFWVg95XQ3ZV+3lajNpKl+YF0E2/LwFb5BvEo7hXK69YLsdtcAtENwJiAh5u2PsEAiaIOILDIf4SWtyuDZ7de1LGkrI6U7dQ92DO4crSYKSgCPYAvHQtmUEzZblLEL+C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282247; c=relaxed/simple;
	bh=9kYH2S9rU5UNWnDQb5uEydaAMoR45qS8cks5ajp020o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g2akLs5/VJYvPieCP+1SjOzEi1tLOBVGVKVsoouNHXY4XPCnXUf8H8UWFmRuiIxtIn5004W0IqcE7i4W8LJ7Tbo3eaIZvamFYCgiBIwxjFqrQVRsdLW+NlSm1tCvf37ixLVx8N+2CcERcudIW44l12HLrXLg9A0jg4urvGQL7gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5/+biJ3; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5/+biJ3"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-434d12e9662so20569381cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 08:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713282244; x=1713887044; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zs885k2tsxajvO1aTFXJEwmIfPeYdTulZXqlwjjynqg=;
        b=N5/+biJ3AKJGqZz5jczufciNBQS74Q2r5fRTqqGhR9v5hGMngCbNWeYHD94TcXRVlK
         x/pBWCLq4nZ+0FYhH5/DCbGwIG5Azfc539GgeA2/4r3j6TGOoSny+Vname5TuNHFBn9t
         BtMCkKtElIuEvdzejtChVLfANjO5YZ5itPVcTs5Hu6lIa8rmr1jImvKIlJd+tfNPmJ13
         Qc2UcIq57k11kM+6yLWCCFpZR0UrHc68JPAEFApWb/zHJXMRIHYH6gPkaHgAZJFkdZkj
         5QxfOmlZ3z7g73PQP2xZp3BpFYcuGoKjjciIjihN3N/2X8blrFinOsvugETTS7esLNFE
         t/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282244; x=1713887044;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zs885k2tsxajvO1aTFXJEwmIfPeYdTulZXqlwjjynqg=;
        b=QybPsfD/gdofyVfAOUcQjwLoDqwbYNjKrH7toIKu9MjL29KeG1q4UC2Kgo1zYp8/8U
         Yswx+Vr0XfxIFcJWqV5TGyswAyaig4kcuMeW2UVuOUmjojmrZtOt32fgSxkaNDx5PpAJ
         XpXZ8/PVWWKuh+/jU95+q9/uyQX6qGoBWKuyMBfLIT2n4dioF7Ns3Sup7HKwLjFBBfL+
         ARSQvvPL3/rSvVpf+zxrkRPh4iCc5VZaQLkDIHLMFmzp9edNvAc+briNqMgjuptxKDJQ
         OKnOt9uJFh8feN1is6zV1dZgUZjYHRn5xKeNnom5TXGunGEFR4eSA+OSWph8WNndp1sO
         Fc8A==
X-Gm-Message-State: AOJu0YwOvr4g72MbP5E3uIDN/kbIMoFrLK/i+yPRXVaAy+NiEfMqGEXt
	lp/FxjAlxD/S9Kvg4b1cv8wQKBKb10/O53wnkXkBYVOfxSiRMcSwyhHz9A==
X-Google-Smtp-Source: AGHT+IFpsMyLllkHbobuXD/8u+CCouC7n1z8edkwnpxCEc5rcDSXlnkmP0ZuMOnbMu9UIJqv8JvcNw==
X-Received: by 2002:a05:622a:410:b0:434:9dae:dafc with SMTP id n16-20020a05622a041000b004349daedafcmr17113655qtx.41.1713282244527;
        Tue, 16 Apr 2024 08:44:04 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.106.67])
        by smtp.gmail.com with ESMTPSA id y18-20020a05622a165200b0043722cf9813sm1799148qtj.27.2024.04.16.08.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:44:04 -0700 (PDT)
Message-ID: <661e9cc4.050a0220.6534.6c78@mx.google.com>
Date: Tue, 16 Apr 2024 08:44:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5771197724206711010=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: Bluetooth: hci_event: Fix setting of broadcast qos interval and latency
In-Reply-To: <20240416150732.101088-2-vlad.pruteanu@nxp.com>
References: <20240416150732.101088-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5771197724206711010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=845090

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      31.09 seconds
CheckAllWarning               PASS      33.45 seconds
CheckSparse                   WARNING   39.75 seconds
CheckSmatch                   FAIL      37.59 seconds
BuildKernel32                 PASS      30.11 seconds
TestRunnerSetup               PASS      538.19 seconds
TestRunner_l2cap-tester       PASS      18.54 seconds
TestRunner_iso-tester         PASS      33.52 seconds
TestRunner_bnep-tester        PASS      4.79 seconds
TestRunner_mgmt-tester        FAIL      114.34 seconds
TestRunner_rfcomm-tester      PASS      7.35 seconds
TestRunner_sco-tester         PASS      18.63 seconds
TestRunner_ioctl-tester       PASS      7.74 seconds
TestRunner_mesh-tester        PASS      5.83 seconds
TestRunner_smp-tester         PASS      6.80 seconds
TestRunner_userchan-tester    PASS      4.89 seconds
IncrementalBuild              PASS      28.41 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
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
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.750 seconds


---
Regards,
Linux Bluetooth


--===============5771197724206711010==--
