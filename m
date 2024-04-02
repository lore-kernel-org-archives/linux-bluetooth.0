Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9002286253
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061716; cv=none; b=oN6JtYGmMR06nhsEahaUqCQI5hVdECmOrBtdU6Rs51/vcjqrihU3hBnJ2AE/lq3+HY5QNof6kE17XTYc/y+LMg32A/DGClgahYva/8zFUZkIpr3F2/VvkPvVzjudtfT3JHV+WikRvK2BkEY/4uXDJqGEs1eb0agfywUpWjRnpcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061716; c=relaxed/simple;
	bh=IlHTdQmbjRyNm1U095hAkSXvbxyef7qjr8ums2r6M10=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Lnf8oS6GdQFwRwCTkAFPQ7msDb202B24cIpbEzd1DNr7p+x7o4rfMJFMBMLoQTeSDXtci1jTwQkTpOiflb9yd/iptpZcI4YTHk9EAL9Mmcu+tf4F/frvBeQtR8WfvlZtqGh+1P0N5g2q2WEDKg7WYHM+4MOb08MjChwpt8HzB/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLU+LPCP; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLU+LPCP"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e695470280so2933417a34.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Apr 2024 05:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712061713; x=1712666513; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/fssEqhoSFvxX/GGwiskdmN4s2vbspsVTDCw/yzXH2I=;
        b=dLU+LPCPU5WZ9qhqwLFAWAmyNYWOV51+4GxHACgRqWjyVztllBDr+io8YbxwTzKD2w
         gi95BWxbeRZzQnQHsFFFI/9RkSzIg7n6d1A3b2nk9YiVBgchpBJRr0syZN6GjHi7SaRj
         T0xsDQTVo0dQ3gO4Aqa8OkZVV56otURQnmi/bSATdyhON3lJFMlScpEa1iEYyH464A5W
         Evmb1CXaVprolPLO/RLlRdCyf32pjg01YQ6MF8WO1dacf9tnkS74+jcy5IF6UMm0NQc0
         7zESdl2JWcS3nzILmxZjz7fs4Dxrx1J4sT6mS5bIBGyhaNRHsPFX/hd2pvgTzDpTc2X+
         IoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712061713; x=1712666513;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fssEqhoSFvxX/GGwiskdmN4s2vbspsVTDCw/yzXH2I=;
        b=P0pzZSaESVaZf29RTz9V2r1Y3FmfnJI/Sgkepw/yrvelwZYHvbIrZRHZxOxJYUq+Br
         KKuy3K/31Z/DUTEjc6bf17u12AzR6mLEglUnQo/4fEgxA7c1JnW8KYnPc21oKh3kqoE4
         upmzdytajeb7vr9LEYjP0MPdGC6Mo7gnLUGFgR8iPYjHJxQpDNl2V9m+5cAEGvzbx4oY
         efLkFbfHht+VeXRS1p9H691bhu++Mjtbmt7Hzwxy6zW9WP2Kro40DXSqYw7/adcHxblo
         i/dpq/SH2VDmJnqH0nVg7NkEqoubMCZcoJcGcimG26EcV0KY1C9J0gOvLeVA0pYU6llf
         Qd6Q==
X-Gm-Message-State: AOJu0YwXP0CGS+8eHwf25004RcU0NdLKSRhCKMTfBRjPu71nE7TSysTa
	aekDxKrstd1kUgAyYx8Cvtie8AJ+7jaEOSQT6cFqvNuO+dhNm5HoeBYR05qH
X-Google-Smtp-Source: AGHT+IFMWDr/436pPebPn7Eeg930IolmFalnLpdDcNaD4qXZ6dBjjclwDhvpYjGbyqdfXhruuEQz5A==
X-Received: by 2002:a05:6830:1d6c:b0:6e5:3134:1108 with SMTP id l12-20020a0568301d6c00b006e531341108mr13546227oti.38.1712061713274;
        Tue, 02 Apr 2024 05:41:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.159.101])
        by smtp.gmail.com with ESMTPSA id ob12-20020a0562142f8c00b0069046d929a3sm5432737qvb.145.2024.04.02.05.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:41:53 -0700 (PDT)
Message-ID: <660bfd11.050a0220.bd106.9e51@mx.google.com>
Date: Tue, 02 Apr 2024 05:41:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8594188251832607721=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmantipov@yandex.ru
Subject: RE: Bluetooth: fix memory leak in hci_req_sync_complete()
In-Reply-To: <20240402113205.7260-1-dmantipov@yandex.ru>
References: <20240402113205.7260-1-dmantipov@yandex.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8594188251832607721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=840589

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.16 seconds
CheckAllWarning               PASS      33.20 seconds
CheckSparse                   PASS      38.58 seconds
CheckSmatch                   FAIL      35.20 seconds
BuildKernel32                 PASS      29.20 seconds
TestRunnerSetup               PASS      530.37 seconds
TestRunner_l2cap-tester       PASS      18.32 seconds
TestRunner_iso-tester         PASS      39.85 seconds
TestRunner_bnep-tester        PASS      6.09 seconds
TestRunner_mgmt-tester        PASS      111.56 seconds
TestRunner_rfcomm-tester      PASS      7.41 seconds
TestRunner_sco-tester         PASS      15.06 seconds
TestRunner_ioctl-tester       PASS      8.04 seconds
TestRunner_mesh-tester        PASS      5.91 seconds
TestRunner_smp-tester         PASS      6.99 seconds
TestRunner_userchan-tester    PASS      5.71 seconds
IncrementalBuild              PASS      28.59 seconds

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


--===============8594188251832607721==--
