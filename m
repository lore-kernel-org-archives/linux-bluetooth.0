Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B3617753
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 May 2024 02:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714618797; cv=none; b=PaWC9ul9CxXmdaawRNwz2/WuLxKx8V8D85zJvRVSwkhJUix+AeE4U04h2+AvEQe4bSmL5MILtWFCZ53YMl+XKh9WZcOoe89u5jKY31zvGllqV2uQDbEenGxDEGdnqFDmQirUVGs2NYwW6uWmcbUVyDlUrrYHSgTKUKOG7B/eyIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714618797; c=relaxed/simple;
	bh=/tR/p5mLHhlZHkmr9X/mUNbuhMJ6lxfZBGIstPEHF0Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GnyCTjYwKdI0He6o2ciJvAPY8kYPM5gg4UEgleI5lxwLmaoF5uGTsy+B8PV6qc1Ryvzal+6n6cV4+/aLeF2ECH+9MCUy1hYtrSEM1lcQq3LUEXjZdqjFRTZJWpsdKgDnQhaq+48W8a+/HAbA7+P+tyPLJPG0WMndPnXQEZon86s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJi7Jxzy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJi7Jxzy"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so10336455ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 May 2024 19:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714618795; x=1715223595; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p1Gz2ZFNLaFHuJAIaG+aB0FEZQnhMUke9CSQ3dlhS74=;
        b=YJi7JxzyekpO2QPu3DkaFm4EDDjiAAXBeLsRSwGwliIzpB3T1dvrngRrZlS8UXogc7
         uqzn68wfT8vNf1FeJdSrgLQpn+CpGdsob+UVcgWYpaWeapwU2YRnw6EnISUd5qeieFis
         VwkdvWfy56Xz5MCk72BmKtP+3cuHceIK1CZGQHh45tnq6etaR4gAOtBVXKG84S8J5zDg
         c+sWs1v1JSa4jG6OtqOWt0xlxY3+JdGPiIE8ZQHFfulG4sRlv6eqtX4U1dmv04qsh3lx
         mZtCL8GRI/KeYA4Pr/qPlY8nuiL+0iA7s+WXQGiDIfywBHKbApLn8HANKU4Ci4XafgKX
         nkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714618795; x=1715223595;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1Gz2ZFNLaFHuJAIaG+aB0FEZQnhMUke9CSQ3dlhS74=;
        b=Dz98WdkCsfibbBwOVhW5jmIXedeZ2NlkxelEkcy4Tb9Ew0eMgSe8HM41zhKQiCzvft
         yyVNjM+iu+xXtN2xY8Rsy3FX/WTwDQMwEYICxqH5+jagsbMc0PKY9E86kAZnRfPgkvJ4
         eKLOyiNzON79mIbJEeFQppdNTfjhmIMRh0P1YACl6FqEGAUa2yF4jvHAH0Z/CB7HQy8a
         wHMTTR+hAGLOlGQo82spy/DCgl2teBePxj1VHB4YqHeMSNavoCLojmhem4bsivZ7Qg2C
         LP6xy58ckWBsmMthUcm1T8hj7d+l31GDkf5ph5XNx1lgHnWXXSarwsgZ8CaEpFpKh5xl
         e2fg==
X-Gm-Message-State: AOJu0Yz/zQyGEJtWjgbw0PHdgecWTyk26BdRPhcAbTPvMJpnLoPtIzX7
	r7suC9AQ2LH+jEpEz/T3B8QwIbyxuJvusKdmu1T48r0r3fbI/ErrrCvDqQ==
X-Google-Smtp-Source: AGHT+IGX0w0CRUt00q00joDtnYW45Jax2f0PKVM9mK5NfIbsl3eiLQ6rJi9EeOxHZ7Dmotnj9h7mUg==
X-Received: by 2002:a17:902:ecd2:b0:1e2:58f:7ed4 with SMTP id a18-20020a170902ecd200b001e2058f7ed4mr2505422plh.5.1714618794784;
        Wed, 01 May 2024 19:59:54 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.123.180])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001e8a90b8ac7sm76945plk.303.2024.05.01.19.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 19:59:54 -0700 (PDT)
Message-ID: <663301aa.170a0220.cdcf5.0389@mx.google.com>
Date: Wed, 01 May 2024 19:59:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7283469541552713251=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: Bluetooth: HCI: Fix potential null-ptr-deref
In-Reply-To: <20240502021709.141220-1-iam@sung-woo.kim>
References: <20240502021709.141220-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7283469541552713251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=849769

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.46 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      30.20 seconds
CheckAllWarning               PASS      32.72 seconds
CheckSparse                   WARNING   38.10 seconds
CheckSmatch                   FAIL      36.22 seconds
BuildKernel32                 PASS      28.91 seconds
TestRunnerSetup               PASS      519.88 seconds
TestRunner_l2cap-tester       PASS      20.55 seconds
TestRunner_iso-tester         PASS      29.18 seconds
TestRunner_bnep-tester        PASS      4.64 seconds
TestRunner_mgmt-tester        FAIL      115.50 seconds
TestRunner_rfcomm-tester      PASS      7.17 seconds
TestRunner_sco-tester         PASS      14.93 seconds
TestRunner_ioctl-tester       PASS      7.61 seconds
TestRunner_mesh-tester        PASS      8.89 seconds
TestRunner_smp-tester         PASS      6.73 seconds
TestRunner_userchan-tester    PASS      4.88 seconds
IncrementalBuild              PASS      28.05 seconds

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
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.239 seconds


---
Regards,
Linux Bluetooth


--===============7283469541552713251==--
