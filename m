Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500CA2B2CF
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 May 2024 03:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716955012; cv=none; b=D2L7xFxG+10sfcwYX0lnJfnMYJnQ+yavNaUkn1fTfNf24JD7sLALDEFAa6/XtoAI6Gb8IcVWb6+Zsvd9q4qJyeLsSfxwEy3sCxAaGoN2tFy4P+JXI4SPhtyS39T52qVk2tiTZ243cTvQoE/oNO+KG3LWniis5wVBV+xjX5lbx1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716955012; c=relaxed/simple;
	bh=NXND7S+R4kmGVT6YDlxcvehm8h9Kx8IEOC4p1qiJx0U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uekJcsvxG27jp8cQh/mGEvnEph3bgM6eKSOlNqnx8U4VQe2LltuLrFtuvA6IkQKErNcbHeIzKJ+rV+/p5gUiBMn4KFg1wXigmCtKt++UED0QKrprVzokFPyzpJozwEntslioADccDS3+Xd9tCUIJkxymw76tGmDs+UkrO33nydM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+2f+W6S; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+2f+W6S"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ab9d01c479so6868166d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 May 2024 20:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716955010; x=1717559810; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NAkFzI2lQtP5ka0miuKXhP2/io0qKgOggOMjYzQ/9Lg=;
        b=Y+2f+W6S03hj56iL9xoEBa99uM4KZsd5D0ScJ2J1XpQmKdRqjTseWdJ4vJhyfjdwR1
         rZYOMrfFXA2dfOHVqYMNsQpqXUmePC+ClopwYwaEaA4tyag6GAIWkM01JEvlQpcgtUgY
         XVrtZbzccKttUyUKJC1ytVF0wmXVG0wPNrucl7CBrC9VHQWG5hl6UL3NxhJz3FcUr7Yn
         xCeg3/RMEEu2JRd0b8Ljh4e3FRNHHKEbC4dlqcBeaQnIn43VBosK7u5aKwvPR7zIxGUu
         1V81fEtryMcnpbH+1dFldWuDvmVGuu1n5xVfGim3iZNbtgABaEtmwVRxw2b3y5s4RmDF
         OEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716955010; x=1717559810;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAkFzI2lQtP5ka0miuKXhP2/io0qKgOggOMjYzQ/9Lg=;
        b=d5yrqWFSFURLh4Dtmat4AkwvFeUL03E1qdlO3+/m64iKALtLkO7tdwLuBt58vXVnGN
         YexM/f20A6hRjC4x+dQAh5PPVLZLfBaROr17TTLpxxUxrImqNF3LeBHEBE3LnK78jY6l
         dNAScZyBG/36D3ZaDWFwRI8TQQ0cCl/UtfP6kGyjK+3oTF6a2ZSGUKMVWO3TxYrXaBc6
         0I3GdhTPAiKu4ptjyTsLh4qpVF4IItIHZlByw+VffWNA2LZC/YdAUz8R65myNFkIvS5E
         jM6pgVV3WjVY83/3RbWzD8lEKtTE52r2wak4smJA15CsYWH1+/1HbibmUbDNH+uwCvCO
         2C5w==
X-Gm-Message-State: AOJu0YxBpu2tlmv1iu+tAkyR9ETTtJbyfv7ASGWMr7y3iIyUy2eJ8vZa
	jMK/kXRlRFH0dVntxXMgBki5Mcz9uG3N5ekwPg7e4Fg+qgefChJBx5O1zA==
X-Google-Smtp-Source: AGHT+IFLMgGoIvEfowpTxgjAiweD2LNn+EATCHEFOawZNL1TpzixAi0kLA+wX49MqGYcA9nKbqgvAA==
X-Received: by 2002:a05:6214:3901:b0:6ad:835f:9417 with SMTP id 6a1803df08f44-6ad835f95ccmr92871446d6.14.1716955009792;
        Tue, 28 May 2024 20:56:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.14.229])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad74d51fb2sm35246086d6.45.2024.05.28.20.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 20:56:49 -0700 (PDT)
Message-ID: <6656a781.050a0220.44b7e.be4a@mx.google.com>
Date: Tue, 28 May 2024 20:56:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3778875743713609137=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btusb: MediaTek ISO data transmission support
In-Reply-To: <20240529033038.28458-2-chris.lu@mediatek.com>
References: <20240529033038.28458-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3778875743713609137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=856796

---Test result---

Test Summary:
CheckPatch                    PASS      2.70 seconds
GitLint                       PASS      1.01 seconds
SubjectPrefix                 PASS      0.40 seconds
BuildKernel                   PASS      29.71 seconds
CheckAllWarning               PASS      32.21 seconds
CheckSparse                   WARNING   38.80 seconds
CheckSmatch                   FAIL      34.50 seconds
BuildKernel32                 PASS      28.54 seconds
TestRunnerSetup               PASS      514.87 seconds
TestRunner_l2cap-tester       PASS      18.13 seconds
TestRunner_iso-tester         PASS      28.01 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        PASS      106.75 seconds
TestRunner_rfcomm-tester      PASS      7.34 seconds
TestRunner_sco-tester         PASS      14.91 seconds
TestRunner_ioctl-tester       PASS      7.62 seconds
TestRunner_mesh-tester        PASS      9.42 seconds
TestRunner_smp-tester         PASS      6.86 seconds
TestRunner_userchan-tester    PASS      4.92 seconds
IncrementalBuild              PASS      39.11 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btusb.c:1368:45: warning: incorrect type in assignment (different base types)drivers/bluetooth/btusb.c:1368:45:    expected unsigned short [usertype] expectdrivers/bluetooth/btusb.c:1368:45:    got restricted __le16 [usertype] dlen
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


--===============3778875743713609137==--
