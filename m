Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304C51D68F
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 22:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711666543; cv=none; b=feEGnxGKNtGcKeRgk+aH+F14eoBnN56OjrCtA36fCvhqSgOkVnHboVf87kJE19UJnbbsPaTIIQ2WhL7EIsRmx6feAuBK27eFfsIaCZxpWhE2DJLvE8DSmU0aQDpN0bK+W/FGiuK8qt3g80/Xp9LWWodFErw6aXXqQPgiDvdmPgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711666543; c=relaxed/simple;
	bh=akVbDsk8UXZk0KCeONyfDKtDvU0VVyIQi7S+O06crOY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=J+GdBfwaHK6WgcC/fDpMPhzCZSFcKVD5GE1HY+qCed3CpDtFll+ejHJiKYV1/DhWaissCE18EqQAr9RgmcR+8Mgmym2UjJXdhBjI1g+MVe8RCblHT9jl5oscUEXkUQ2B3W8+ipImfbFAiB3gOlnA9/VlnA2NQtKASpOwn4PVLak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ntgqp5pF; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ntgqp5pF"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60a5a11b59dso17297087b3.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 15:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711666541; x=1712271341; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HXtY3V5hJe7eOhGOCFs2quwxb8tThGFRfFGaoJBoPyg=;
        b=Ntgqp5pFTJtsmV9FbeKwzAlll6LGQis8PTaTrotYloOfbvshijTBxtEb3wFmebI1AL
         CLBjQCAOZ3Igf7TF2jcIF6lJxlthFn+RcDYmqqIDy+S0/qHoxn8m5MWzO6lJiYiuUqJO
         lxkCjiwXNDtAkyCuEOlBaPvTzs/ywEXn8FV4/mLbKU+yXn6N+ZaAw/HraLsjqidWe5IS
         /1BNmy9ylESqIIGuw2R1W+tWcbR0DYcJkoPRfnnr38oeqwvEFKsOh6kh6PfSPzuiTuTw
         YPHGxPWpywbpyF4DPlTbGz3Psv45XV2vakRYVh+S0hgcyd8E4Q6XaE5eSRmC6cbEHS0H
         IWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711666541; x=1712271341;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXtY3V5hJe7eOhGOCFs2quwxb8tThGFRfFGaoJBoPyg=;
        b=M08lcWFCKbtW6Uuxpa4kXikKlDql/3RLOV/SP5xgEGAQz5ti22Ix8aRSdZecglW09A
         fJazUuxvqFer/OwKKKcKX/0KEb/apySQnpZtaosWCNYIZB7DjV83CS+ptXff91iARZPr
         l+9UfP/f9WlrP8gPHPtFye7Wm/eJ6hUL5PqsOjA+hqSVcjSzzOVYDqzrY/kfIQihtcji
         dnQLTq9xL3JaX6EvHR2IvVXz2dsL6H++zraGHCDaeTpOPafn/HdTf3VNuQXwBlGlbHkf
         h5napn2knqLXBAtcrrRJjIIyKGvJxSB/m7kAtoAeq/LHFzzfq0THrCwgRJmmayjmSY8i
         O1FA==
X-Gm-Message-State: AOJu0YzrnIHETndNwlPlJezFLi5okApm2rojFTcgdA6OGqAwEQpIhJ1B
	XohKbCjrPrHkU/xFR/vUpfMhSVXppxvgJuk3hFeR/q+6umJTOmcbrusaJewI
X-Google-Smtp-Source: AGHT+IFZ6IfD9YdqsEXND5mh+gD6H/Cwmhg78nGozdanCZRnBbPOGlsgCHmSwBH/UMbyiQhzOcCK3g==
X-Received: by 2002:a0d:e5c4:0:b0:60c:beac:a69e with SMTP id o187-20020a0de5c4000000b0060cbeaca69emr892766ywe.23.1711666541099;
        Thu, 28 Mar 2024 15:55:41 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.138.169])
        by smtp.gmail.com with ESMTPSA id n14-20020a81eb0e000000b00610e2f00407sm526238ywm.114.2024.03.28.15.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 15:55:40 -0700 (PDT)
Message-ID: <6605f56c.810a0220.90c0c.2ca4@mx.google.com>
Date: Thu, 28 Mar 2024 15:55:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1443971617898342639=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_event: Set DISCOVERY_FINDING on SCAN_ENABLED
In-Reply-To: <20240328221558.1904865-1-luiz.dentz@gmail.com>
References: <20240328221558.1904865-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1443971617898342639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=839568

---Test result---

Test Summary:
CheckPatch                    PASS      0.98 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      30.46 seconds
CheckAllWarning               PASS      33.18 seconds
CheckSparse                   WARNING   38.75 seconds
CheckSmatch                   FAIL      36.07 seconds
BuildKernel32                 PASS      29.64 seconds
TestRunnerSetup               PASS      525.28 seconds
TestRunner_l2cap-tester       PASS      18.25 seconds
TestRunner_iso-tester         PASS      30.55 seconds
TestRunner_bnep-tester        PASS      6.92 seconds
TestRunner_mgmt-tester        PASS      113.67 seconds
TestRunner_rfcomm-tester      PASS      9.32 seconds
TestRunner_sco-tester         PASS      19.03 seconds
TestRunner_ioctl-tester       PASS      7.94 seconds
TestRunner_mesh-tester        PASS      5.86 seconds
TestRunner_smp-tester         PASS      6.91 seconds
TestRunner_userchan-tester    PASS      4.93 seconds
IncrementalBuild              PASS      28.27 seconds

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
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============1443971617898342639==--
