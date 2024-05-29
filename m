Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEA316936B
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 May 2024 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971759; cv=none; b=tF7V7gSh53XhM4TYZg9CGpqWPDnSS4CGm+d6+A7jTHhVfivBmuD73r+afdWPn8OTFMu5Q1CSo3jQb+oah3lkUMBFgCrKvm8jNsFKbhN9bWzU54tdMCVaC1pcWL09rlE5ANb3RuB9i0UKhIJK4lCndNfw3yE3NjHPwTJteI9Kb+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971759; c=relaxed/simple;
	bh=iUoWZiuDcvQ50BggoRaQp0p2C2W4tuZt9NGkSr9Agas=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dvr0cJMgdHjofqI0SrB7aLtumqLxVGe/WhXFjkwlNvUb9I2rztxbYaemmIYT01pHlErf5n10qE3RdVY0bAsH4AaPY8dIbQ0MfMySje8atWKqxT+E4rRfY6F1Z1EOlUwuKr9PglfMYze4hynJDmV2ovHLMyMby/M9nE26+gTmbuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUdsUmsA; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUdsUmsA"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f8ea01ff05so933148a34.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 May 2024 01:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716971757; x=1717576557; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6LOQ2fOd1U5+sSr2aw0L+9x8tqNfxyFXPr4Td8AD5Lw=;
        b=FUdsUmsAK2SPjxM/3vbjiweNWM7iNpa/2YMHYLJfhDj5JdYY5TtY/jB971HOomYN1o
         55v4lwLVAZBeu29jskFPRbl/CZ0BR0wS5ue9A5ey8SDkTikhbgnwNnuf0x9rS2SSXtPo
         inR5+/gRAG3pld809r/SEUJR3Vm9JdjXfIV7oe4KHojrOGPNUPzz822vUPq/rnCKYdhi
         6QQ3j6fRe4iS+ovJ65EoIsOnRTYTGjB4g6/k6xIIj+f6n2I+oTul/rsA+Lg/EP56IkH5
         2pnZC2s2j5l3RdY3J0z/GusF20IEV+9XJLx3Ir2yxSmjTuYWta0/MP2l3rP51x392tKk
         0M7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716971757; x=1717576557;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6LOQ2fOd1U5+sSr2aw0L+9x8tqNfxyFXPr4Td8AD5Lw=;
        b=xS9Iq2tZRn8u3+N+77LPN45FS5tCcQY7gabqFAZeY+V4eSXSrEFkTeQA0LlZYSOmpi
         tYruUhX+XxAeMwjzlhrxMMiwsrbtdJohUz9cFXZ+iOK4ZfgV8ixYmyRw8Ga5fuN3eLD6
         Yo3brRZzzmbDwhuXYla0egLqY2CYlSDN9MVtJ4EIEjB5Urmlj1nrDIuUun80sm54l7rg
         DKJ5GkdNYgYs+HtJkSgL1/WbXbVoH4vF9Rp2ChlOIwQc9tCAzjcGi0YHGjBvFP7KgJBP
         npSE/ozQMQTGK3dSvQRRofEzGnyFHgfMnq2Yjfk4Evv7wmMgOvz/DJiDOakKPCJhDiHU
         C3MQ==
X-Gm-Message-State: AOJu0Yw0RZvhg1LjTiPCO+lteJhW7/0tTw8JQ8/TByjEuIqYqChFPhrv
	LCAx8sTZA1ZJ1ESC9TGJKfj8MZ9mvcZmmiI58alEokH1r8H5YCVT8VjBog==
X-Google-Smtp-Source: AGHT+IEmJFl01uFrol0+mKuM07NwIzxhDwJKNcQug+vEnsSx6j6bgkBfBLRIXTC0VjTYzodWryUa8g==
X-Received: by 2002:a05:6870:c1d1:b0:24f:cd48:53fb with SMTP id 586e51a60fabf-24fcd485758mr11867368fac.16.1716971757212;
        Wed, 29 May 2024 01:35:57 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.115.105])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc059a27sm8049151b3a.61.2024.05.29.01.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:35:56 -0700 (PDT)
Message-ID: <6656e8ec.620a0220.f7be9.5e5e@mx.google.com>
Date: Wed, 29 May 2024 01:35:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5630323847437003514=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: [v4] Bluetooth: Add vendor-specific packet classification for ISO data
In-Reply-To: <20240529080123.2146946-1-yinghsu@chromium.org>
References: <20240529080123.2146946-1-yinghsu@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5630323847437003514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=856864

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      29.47 seconds
CheckAllWarning               PASS      31.86 seconds
CheckSparse                   PASS      38.24 seconds
CheckSmatch                   FAIL      34.47 seconds
BuildKernel32                 PASS      28.20 seconds
TestRunnerSetup               PASS      514.22 seconds
TestRunner_l2cap-tester       PASS      20.13 seconds
TestRunner_iso-tester         PASS      27.86 seconds
TestRunner_bnep-tester        PASS      4.71 seconds
TestRunner_mgmt-tester        PASS      110.26 seconds
TestRunner_rfcomm-tester      PASS      7.26 seconds
TestRunner_sco-tester         PASS      14.85 seconds
TestRunner_ioctl-tester       PASS      7.61 seconds
TestRunner_mesh-tester        PASS      5.74 seconds
TestRunner_smp-tester         PASS      6.74 seconds
TestRunner_userchan-tester    PASS      4.90 seconds
IncrementalBuild              PASS      27.31 seconds

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


---
Regards,
Linux Bluetooth


--===============5630323847437003514==--
