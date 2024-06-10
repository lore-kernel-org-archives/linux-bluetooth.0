Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEAC7D40B
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718019156; cv=none; b=ujoI63BTmc1PAecmhi95YzJ21BBXXwD6JwiQcYAfOw8MtqlNgT0REbh7Dl8yVGSeW0PF2U2n3NADfrEo3Xwy2Fowtzulr8JE0isQcim4aTz4OXVCxFCWugyViAHfCFxVCbPZDqhv1obUrIWnDFROXrgYAJFfOvMtPqmT+RrI0jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718019156; c=relaxed/simple;
	bh=GIdxbDGVwbNu6lF3p/NV7KS1dWJXFyisrXcopvjYzwo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Tn2ZyG6+LAot6bbRrvjOsg15DyQEjwUhN929OvDtGoMVVF3TzSMXzNZ4vuw31YMIFVB329YTO4Rz9Q4KEsJhSxQagPdndcPEovn0D45qlT4MVQUQhvJMd9gi531H2xR95iqzHFeH6eLK0tkkxWNQl46oeu1QG7I8p9J9ohWEb8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USHFZpTa; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USHFZpTa"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b07712207cso5777646d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 04:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718019154; x=1718623954; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uzkE5ezCvPBeKu0FxfHTzNnmXDqtD6B4JZzK3SKNKt8=;
        b=USHFZpTac93Rdb0PoCqZ0feMVkajWA8w3OMgzgPAK4rRFarlVPU9SCZ2Gm1RxqsCS9
         NaED389LXE99E43ukVX2j4R+tM/19pS6G+rGe9D+uBmYe7dqL2WvtW0QYmrFWyjSLyAY
         fkiQ7KPjtSQywYrlxLtJrk8zA07i88sJt2R1vIYVEBZPkO/xE5ublPW+NURcMKHt2lN+
         tqaVo48CXmyQ/UtwnHfZLCvQvWTK31l58ojKVfYln98KCTr9xJkaagROr302RUirhrVw
         ekn/ct7chbkbCD/1uVgbI1mcJ/FeJC5Io6uzdKwjmZ8KPO2FhOVH/uSVA4ncMB3S+ZyP
         0w2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718019154; x=1718623954;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzkE5ezCvPBeKu0FxfHTzNnmXDqtD6B4JZzK3SKNKt8=;
        b=oTpjc3+nQyN4JqQjLNiuL3ofHSlGEBsQyqhFX9bFCbxUKet5R8otVMjAkNhjUt23ii
         JIXqfDQ9Lqvs9riy/HcC3JgxKVesgiSfjSwsq2O/7mdj2/iUIdB+oz2kz1xWUOCNEYV0
         q7ZVtVx4s0kav6THFFRPEcZnlfyzPXBiULnUs/VYbOyQztZzpMTLgce/kyr3NbhDnjdV
         l7yezOTJkCho/tzxYq3imfHEAuppnvzR2XcQ5Pe0FGxM3ztAP9KRZRQJvDe0EFOdhubN
         4nYjP0F2hc0L4kGQBdjt7c0vwS8WS7H9CqEmI4/Na3uAYwBTW9jfS+/Ky4WGSpMwrSF5
         631Q==
X-Gm-Message-State: AOJu0YwVoYOszRTbbAT+bJRxIt8ZUsh2eEMceYyxTbEYDDBB1sQ7grA1
	sV9PGfrUXWknJlNFdR80zQUUBUNXPJtis6XUeiED3CZS6qgwHq77sodvXQ==
X-Google-Smtp-Source: AGHT+IGZtEvmR4Lco4MwJZG+YiSHCIq6P0COqxtp+XYOwYGyEGqY1Xb26zFJbCsROXcEltr7byVTGw==
X-Received: by 2002:a05:6214:498c:b0:6b0:822b:c2a8 with SMTP id 6a1803df08f44-6b0822bc437mr15647706d6.35.1718019153696;
        Mon, 10 Jun 2024 04:32:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.14.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b078212e14sm14106676d6.116.2024.06.10.04.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 04:32:33 -0700 (PDT)
Message-ID: <6666e451.050a0220.94e46.3b8a@mx.google.com>
Date: Mon, 10 Jun 2024 04:32:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2591957752011842209=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
Subject: RE: Bluetooth: hci_core: cancel rx_work,cmd_work,tx_work,power_on,error_reset works upon hci_unregister_dev()
In-Reply-To: <7d6f0ed3-678e-4fd5-bd64-f980e0035b87@I-love.SAKURA.ne.jp>
References: <7d6f0ed3-678e-4fd5-bd64-f980e0035b87@I-love.SAKURA.ne.jp>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2591957752011842209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=860391

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       FAIL      0.50 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.41 seconds
CheckAllWarning               PASS      32.19 seconds
CheckSparse                   PASS      37.62 seconds
CheckSmatch                   FAIL      35.74 seconds
BuildKernel32                 PASS      29.74 seconds
TestRunnerSetup               PASS      514.54 seconds
TestRunner_l2cap-tester       PASS      20.03 seconds
TestRunner_iso-tester         PASS      28.23 seconds
TestRunner_bnep-tester        PASS      4.74 seconds
TestRunner_mgmt-tester        PASS      111.15 seconds
TestRunner_rfcomm-tester      PASS      7.28 seconds
TestRunner_sco-tester         PASS      49.37 seconds
TestRunner_ioctl-tester       PASS      7.67 seconds
TestRunner_mesh-tester        PASS      7.84 seconds
TestRunner_smp-tester         PASS      6.87 seconds
TestRunner_userchan-tester    PASS      4.97 seconds
IncrementalBuild              PASS      27.45 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_core: cancel rx_work,cmd_work,tx_work,power_on,error_reset works upon hci_unregister_dev()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (105>80): "Bluetooth: hci_core: cancel rx_work,cmd_work,tx_work,power_on,error_reset works upon hci_unregister_dev()"
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


---
Regards,
Linux Bluetooth


--===============2591957752011842209==--
