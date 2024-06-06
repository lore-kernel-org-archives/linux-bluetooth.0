Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBED81BC3C
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jun 2024 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717700361; cv=none; b=O20C7KFDFLs28iOzYnci/2eNdr9BBOBnVO4ynZIt/DrUeKbtmLYll6I7qTtUUb8j93AN15vbd+uvnpV9OeCKluisjjVbzGi3/h6cN5EmUp2A0dFeimb8ATfG1AQGm6EESI42HEpwspnha2t36Elu0kjn2ZT1QdD+DrFIrNTxUDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717700361; c=relaxed/simple;
	bh=cmaMKKcWQjMGaiXztfofzHOoY6rWnlyRbSh1jiQUIdM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DslsvjXcZjstam0Ms+5KidU6iAqE+ja11RzLQ6ObiXvJlTpZuj+cVVoTVxInnMJ3EyMFp4Nv//oQPpbOUi2XKyD7gWf3Fpo1E4+50pRgNn68OWfS0TpfhHwac+ArutY6WlQVqfY0cxh2a9Yx/duZNn+giha+vPurelhSo5jEVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XT+pu/wd; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT+pu/wd"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ba69e446f4so537687eaf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jun 2024 11:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717700359; x=1718305159; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ogeuq0Xr9ikxHxHvtgCh/UPfCVB4Y8wAOkEeZwZOatw=;
        b=XT+pu/wdrH0OJ5WkICIZh69sO4fqmwpmrjwfK2oY5V9F1xQsRb48/+YuxRwZgAAX4F
         KKgkjCMVjPg6L+rVDN6M5NNkkynuGoEFz+SfJijQS6X91oX74gHh80l6QciN7++Hpnvs
         v0sLyg7keY1tU/gnd/2k/d/yNqLiGoXhQrfAqDVR41qUB4swjCxKTCOKg4NsVeuwp+He
         NIEiOhdYo+29m9h5jLxl71suKFnF9WKlKJ54YspIHCJ73c36hnhv54rGq44d7dZfT4K2
         5DV/4qgIkxkKnXJ2BmY+fhTxk/P1FUaEyqZfBfyzah18kD9dlVJ3lGgbLtqvhQpQhWNI
         T9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717700359; x=1718305159;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogeuq0Xr9ikxHxHvtgCh/UPfCVB4Y8wAOkEeZwZOatw=;
        b=Rcx/T1ggpH2q4F12aJ9MqEjKpCAuiYW5B1kqKCut37lqgXI1wal3Yfnz42Z/YOUY5m
         ZFVmSogzJwh6awm9CHNOtmNVQjGrVnnh/USGiK4/y3EpHVO3nFTkmGKj21g/FyZLKEWv
         aq3ACtE5JsS/prs7//Ooag+fHNHgq1EYBqOKEoKwyzwIuKLrzHjWrnYnHnFAR0Qlkp87
         IDwrZ55T/y7kfqyRt/4Fyv8KVKtXhz/6O6h9YVxA1fl3pzGsoYonzJDFFsH9ysR0Cd4d
         sAN1c3WwMpJHMebGlYn8t+U3n+Ctwuskm7i5d8bz1/l+kLtjmfzouzvDdD4HkHZI9Xqg
         8bWw==
X-Gm-Message-State: AOJu0YxlWGCeKSH4kttfzSbierbKWwxIpChXT6s+ctuRCIU/IaxzIW7t
	cjHHoNRGKY3fvjVGCNETeRpOLpPZdMA7o8Rn99hyDKVJ+gtsllQf3CpKJw==
X-Google-Smtp-Source: AGHT+IG3G8gSHvHETIkO1tLIeerKOjIcM+zvslp3/nGK/92fyIO913I5c7Eh/gqkNHaDiBr4JM1YZA==
X-Received: by 2002:a05:6359:4c8d:b0:19f:1c23:e809 with SMTP id e5c5f4694b2df-19f1fd005d2mr75858955d.6.1717700358278;
        Thu, 06 Jun 2024 11:59:18 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.111.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f9891b8sm8656356d6.101.2024.06.06.11.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 11:59:18 -0700 (PDT)
Message-ID: <66620706.050a0220.30331c.3aac@mx.google.com>
Date: Thu, 06 Jun 2024 11:59:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8775745180764138738=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andreas@kemnade.info
Subject: RE: Bluetooth/gnss: GNSS support for TiWi chips
In-Reply-To: <20240606183032.684481-2-andreas@kemnade.info>
References: <20240606183032.684481-2-andreas@kemnade.info>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8775745180764138738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=859667

---Test result---

Test Summary:
CheckPatch                    FAIL      3.96 seconds
GitLint                       PASS      1.28 seconds
SubjectPrefix                 FAIL      4.71 seconds
BuildKernel                   PASS      28.53 seconds
CheckAllWarning               PASS      31.36 seconds
CheckSparse                   PASS      37.23 seconds
CheckSmatch                   FAIL      33.96 seconds
BuildKernel32                 PASS      27.60 seconds
TestRunnerSetup               PASS      510.26 seconds
TestRunner_l2cap-tester       PASS      18.14 seconds
TestRunner_iso-tester         PASS      30.23 seconds
TestRunner_bnep-tester        PASS      4.79 seconds
TestRunner_mgmt-tester        PASS      110.24 seconds
TestRunner_rfcomm-tester      PASS      7.33 seconds
TestRunner_sco-tester         PASS      14.99 seconds
TestRunner_ioctl-tester       PASS      7.80 seconds
TestRunner_mesh-tester        PASS      5.89 seconds
TestRunner_smp-tester         PASS      6.82 seconds
TestRunner_userchan-tester    PASS      4.97 seconds
IncrementalBuild              PASS      40.97 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4,3/4] gnss: Add driver for AI2 protocol
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#139: 
new file mode 100644

total: 0 errors, 1 warnings, 551 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13688879.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
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


--===============8775745180764138738==--
