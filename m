Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AA614A82
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714034099; cv=none; b=UftT0N8+wROiSEvo5H3eT3qHq9mNQ8qEn7C/z0+ooOSY93hnN6WO5xodifzNCUK/3JROJaRMjQaRd5QEVdH4rOgsQUFMcexvqkeoXyfKWippyxEyjzrGMkMH4tosdmN57GbEGjMPZHibHnYU8eUj3L9GC3KVA/NpnxQUZxDoX0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714034099; c=relaxed/simple;
	bh=rl4y3vtO+ShNm2TVGWrDLc6jxeieQdj0ihHwkKcmzvk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=p8TfaykOBVUuSnvJ4JMdz6iXoD+jffHxBKcrDqsoor/xV9EgKu39mYV4TJIGTw7EGZXDFV8KjFrRHcjMYlOKNMY7mH0bn7ylWIGTcjNMb5RM3Do3vSuH9gmFU1AhmUiFzFc7pQ1pY99gVhFYYiJSdoV0wDu29HuEDNbcI/g4mgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5lqp//v; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5lqp//v"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78ef9ce897bso46569185a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 01:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714034096; x=1714638896; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FNQzbyU1f1Q0F5sWSs7p+21/x7mc0ixMTkKW1afAqxE=;
        b=l5lqp//veg/jINr5iLw2rmlNn7mau+Mc5v59Qroo62wdbBJrrUWJFpYjacbAMX9TTH
         AybFcJr0eWlrVJ0+I+jy/75MIrwymqPoRPhHialWuFAdGeAprmcD92jtYZyXBvpwB6MC
         AwRagPyzfPVqCEx0ipR51/3J0S7ScpHDxmVcvdHJhbDVsvnG0SEqHsc6ADQPE/YtvJYm
         rz3aHWOc52sLjLMv7G/LcMIXCWXZTWd2EfDnIdXdulQDx/2i50waLQw5IT3TdyhXwDuc
         PwAbxJTKNwv0Ery1TcM4LzrBhVLJOXopSbfBtTBUShRXgjeH4cwmArfomYtKHLu0FF7m
         Osew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714034096; x=1714638896;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNQzbyU1f1Q0F5sWSs7p+21/x7mc0ixMTkKW1afAqxE=;
        b=B69nU5mekzZXXCDfOMAIeJsCO4YpxhipXZijVF6RIVKQpBwuIDzkhE/srwWXCE2Ulu
         9AMoXykyMJbk7E9sLevatLeer1Ijb6DwPNmov2Nu+KLQfptn/NjGyAgDDRekKUDhWhHd
         gv8y4/rvPz4KOQtmuhO2w4xxbnRfJXHbldsMdNZcBiiN8xNEpF3b4X8DO+cCaWu9OXmz
         5CQrLjnKfw2KjtdKd96NtA/7GOInaDGobyngYkKOO8fpKgL0OK2nuLxX+76WH2he+j4m
         bcIaqhQRPOw3UTcZBTZ+CRqDd/Wmgk34P8qfZ3/oSvrusOu19gaIrEt3gXt51onjqq6I
         HmQQ==
X-Gm-Message-State: AOJu0YyHnPkAiY5gKEzxXqKYeJWF48JJl5D2ODqy/yW407wA0dzp+Hq5
	bWZHUvj5msqWR9Sxp0DJlkuNG/JpduXxC0ZsDa60nLpzkOscPZHUx/1kew==
X-Google-Smtp-Source: AGHT+IHn9fYk+SX4CvAsL+Zt0kYlyFRgJpikAF2qWRX2WpOqPxBSyvXNoM+Q77J4BZkdoh5y1Yl1IQ==
X-Received: by 2002:a05:620a:5e4c:b0:78e:e4ea:8acb with SMTP id ya12-20020a05620a5e4c00b0078ee4ea8acbmr5030689qkn.73.1714034096486;
        Thu, 25 Apr 2024 01:34:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.159.78])
        by smtp.gmail.com with ESMTPSA id yf9-20020a05620a3bc900b0078efe9e1f50sm6831425qkn.82.2024.04.25.01.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 01:34:56 -0700 (PDT)
Message-ID: <662a15b0.050a0220.eedd9.0f3f@mx.google.com>
Date: Thu, 25 Apr 2024 01:34:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5676621281307582517=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: RE: Bluetooth: qca: fix wcn3991 device address check
In-Reply-To: <20240425075503.24357-1-johan+linaro@kernel.org>
References: <20240425075503.24357-1-johan+linaro@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5676621281307582517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=847735

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.02 seconds
CheckAllWarning               PASS      32.43 seconds
CheckSparse                   PASS      38.00 seconds
CheckSmatch                   FAIL      36.16 seconds
BuildKernel32                 PASS      28.87 seconds
TestRunnerSetup               PASS      519.69 seconds
TestRunner_l2cap-tester       PASS      18.30 seconds
TestRunner_iso-tester         PASS      30.96 seconds
TestRunner_bnep-tester        PASS      4.69 seconds
TestRunner_mgmt-tester        FAIL      111.19 seconds
TestRunner_rfcomm-tester      PASS      7.19 seconds
TestRunner_sco-tester         PASS      10.92 seconds
TestRunner_ioctl-tester       PASS      7.60 seconds
TestRunner_mesh-tester        PASS      5.72 seconds
TestRunner_smp-tester         PASS      6.72 seconds
TestRunner_userchan-tester    PASS      4.87 seconds
IncrementalBuild              PASS      27.66 seconds

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
LL Privacy - Add Device 7 (AL is full)               Failed       0.198 seconds


---
Regards,
Linux Bluetooth


--===============5676621281307582517==--
