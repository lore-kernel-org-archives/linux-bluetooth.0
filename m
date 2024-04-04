Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B015F17BA0
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248471; cv=none; b=iGyFi3Gd7ceIq8jTcuc9ytnFvLjqpEpasJTfXGH5ZsXL7BXEWhHRr3PM5yJd5578J1Q31ZsHmVvQpdCuVBFzpCYTZdbubSq2RRjDPX9zjDtblt9VnEjqj2csbnAdue1D+3lihbH0elHejR7xh+1sL4+VDFHK1oJnEDJql0HdSSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248471; c=relaxed/simple;
	bh=8lGN9U6KRhHFn36TImm9qD+t8mnvdgJixU5KyXIVT9M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=f+2VPRv0jquy0qU1kY3s/79EriCaMQrp0Fv1SL/xtg9V4lVyEy3E5d1EXfNPl8dp5BcyNRDKkU/5sa70Ny7TO0P8iTfu92GP8VNSxXJjHUxTJ6DCKibaY5UTkoyMU2Y+AynLfCZdog7SIlFi5TpTPhCjImmSFChvDTa5Ik58Cpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9I94VIL; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9I94VIL"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-615053a5252so10675917b3.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 09:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712248468; x=1712853268; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nrgk62wvSfWiSypdtb8xG3RwGk+NdsaxAV2+p047mcY=;
        b=Q9I94VILoMglXIJqnXENqxEfaDphGMk9Ul8T7kw2KGqFS6Y6LLN8YWSaUNBEy4PxtF
         +HnwXbB5hLuOIJezTlE3s9RKnyTbl35hVweKIVWDje4hy+D2EZp12vlxNZxqR3LRpEj3
         OiSIvwAcQOLzkApGVkZIspf+URQQPO6lRAvRF8V6TWxMuV+yb7cpIkdnj/nYc3e0C/0f
         jk0nvjt+xlI63cqpMxTVPxlu8fR0jCAYmeyNJXPbS5/DEULWf4pl/XLa69KkIiaCQ1R6
         2JW2LBqtSZwLsNKojy871qYoipoiO3I599NXmeySbmuaPOtlaFmOWfdN8BjgUyAKp2Ms
         VjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712248468; x=1712853268;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nrgk62wvSfWiSypdtb8xG3RwGk+NdsaxAV2+p047mcY=;
        b=ZvmJImhupZkToTk6JcdV0L+tYO9lVL1CF8EGUWKtyOWEG2sIz9721P9oREsXA0wJKE
         LOwXcBlm0hl22fW8vIUyq6uT/9bW3USw0vZOCRQ1E17nbsD/DWxrwD3/5kaYXUXQoxtd
         2zKsW9A2CodAiSbXboVw7vq0/TSRz1wqFP8eluiPcueAG3/xZO+eAFzXfta14RFgi11v
         LlDqWgEIdDpYTrkn8noP4TvC+CZneO6IPLCiW0ZlwZJbvMPvXcNdwhxKSawV4RE+Y4nv
         noaVhb3M6Yn4UFfSJaIOOeTfl/CbNnOqMmApRRD7FZj0j1bVwo25lktO2Wjy3nrToNXL
         cK/w==
X-Gm-Message-State: AOJu0YwtM1L5mQlDJHCOr4B8YDq26EzTDE9ecHpk3vCfw9R1aWEA9anD
	eZHk+AHGS2UFATpY9mE5SJaQeKIxfYthno9Vy46V9XmBpBWlruBsvbsfDRzV
X-Google-Smtp-Source: AGHT+IGicb89lVDXSD3/N0egwYxR7zNvQMBJGnnbL9tu11JVlCaxQwdxbqbvE0w8/gekM9FdLHDgSQ==
X-Received: by 2002:a0d:ccd0:0:b0:615:236b:584f with SMTP id o199-20020a0dccd0000000b00615236b584fmr2274821ywd.19.1712248468319;
        Thu, 04 Apr 2024 09:34:28 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.132.29])
        by smtp.gmail.com with ESMTPSA id u68-20020a818447000000b006150c4478a5sm1730683ywf.102.2024.04.04.09.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 09:34:28 -0700 (PDT)
Message-ID: <660ed694.810a0220.6c01e.9b9d@mx.google.com>
Date: Thu, 04 Apr 2024 09:34:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6355064767262348650=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_sync: Use advertised PHYs on hci_le_ext_create_conn_sync
In-Reply-To: <20240404160144.3193698-1-luiz.dentz@gmail.com>
References: <20240404160144.3193698-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6355064767262348650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841493

---Test result---

Test Summary:
CheckPatch                    PASS      1.38 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      31.00 seconds
CheckAllWarning               PASS      33.76 seconds
CheckSparse                   WARNING   39.32 seconds
CheckSmatch                   FAIL      36.01 seconds
BuildKernel32                 PASS      30.56 seconds
TestRunnerSetup               PASS      539.48 seconds
TestRunner_l2cap-tester       PASS      22.18 seconds
TestRunner_iso-tester         PASS      30.90 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        PASS      112.43 seconds
TestRunner_rfcomm-tester      PASS      7.28 seconds
TestRunner_sco-tester         PASS      10.85 seconds
TestRunner_ioctl-tester       PASS      7.73 seconds
TestRunner_mesh-tester        PASS      5.84 seconds
TestRunner_smp-tester         PASS      6.82 seconds
TestRunner_userchan-tester    PASS      4.89 seconds
IncrementalBuild              PASS      28.89 seconds

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


--===============6355064767262348650==--
