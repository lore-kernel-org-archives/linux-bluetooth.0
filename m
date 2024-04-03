Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0AD1494BA
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156195; cv=none; b=Sp0kjf9csn1SVCTm8TIJZX6j8c3LqrEczKgAAFhZ6te90UjdIQ6AshQuJaCsO+/ULqlJei1WV4TVbRT++Xeryrxf6Viz1dzOopk4iqxkwL6O72EfSXp2CktrnySNLR7oBwvCLYzPVC3lDCixpn+5dEiTORjXDfdFi4aJkW3CrdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156195; c=relaxed/simple;
	bh=4ae24oEgbSHmwAdFClSkG00opqajPT5DyeO6or5/0D0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NLLqBE4Jf2YB3QHXo8onykT/pVmj/3GkOmb9ngm81F80ulKeogbWix8Q6GNXlCkgISqdNf4wfy5uPcX25g/KqOyAMpTmcV1JBEJALHvT3UCQ8651lKRQrMROvl/ovUItlyP6CRbcWBkBoIUzgiP5747CbaMyaKqwxwQyXX/m2r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEPDKCtj; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEPDKCtj"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ecd957f949so439899b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 07:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712156193; x=1712760993; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OSYpxx+RI9jVeTH13Rvu3on7qBO4MyZr2m9DXkyul5g=;
        b=jEPDKCtj+owBvTQJape2kJr6nKeqH187hyooCm5B450WuWcuFkFvav1s0+CvTxepi5
         P7ppETVtls6FclJelIQRK/BwnN6pXC2l1ty2kv+B+HKXcesRUvZVr2F7CWycGmPxy63h
         GKfwOky+qN9Yk4rI2P54+2xRIyf8GPm0NCO2QuigYAb8/JCK1TtTScKA/PPMn58kxLe1
         AjxbHAC/lBT+oMggcB3sBP3f606twsEX7+DUJOzHLMxxmZIB0gTu1amoV8FM5BkEO3V6
         z1wsAQEj0RQZpOFs1r0OB8cNXWi/vFSM1DX2IxUhN6+Oc0jDWp2cRXobBnOQj62CQ3HB
         ILrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712156193; x=1712760993;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSYpxx+RI9jVeTH13Rvu3on7qBO4MyZr2m9DXkyul5g=;
        b=dhsAHhK8oEm7u+qBQBpA1q0mGwpWp5FKSt7CLaJNXMQivt6Lb4sBb3+BCZj2Vw7kBb
         WT/WR45JIytyeXJ3fDnzTLhtFfh3C/jht1c+Pqp5UKSQ9E10EtVg0goKIKogwwxPxdzP
         i+55bUaX+xq6BP3BckCXrXVe729UxY1FXAIcFap/6iQzFO/w+Njl9i/mVkppMFpB7n9u
         lPU3UV/BjeHweJ2xd/t6H0DwqHoQ0D18oX+yaS5C+VjQ8JI9AhKPH3oI3stQyNspm5UE
         JJHfaCaNUlJj2m6g0Bxeu+oxBAFJYNU/rKw0n+hwaSSY8QduDTmvQy7iwe4Av4GEib0B
         5r7A==
X-Gm-Message-State: AOJu0YzegvO/VyWlbNRCUF2KWHT8U9xYbwN+jyTpcJiH56V3dNc0XQGr
	33l10t5doMG6pAy1K0zR5Q/aO/S+lkfPbS1BzxrTVIx6EX3yxCC+uUFvgU/N
X-Google-Smtp-Source: AGHT+IHVO7sMjR/Mi7zErUaMsJlwfMcur/4Ec5enDZQ1+ELwwH1v00LZOZtVvTbFYY+uWFzJv1O0+w==
X-Received: by 2002:a05:6a20:3949:b0:1a7:e98:96dd with SMTP id r9-20020a056a20394900b001a70e9896ddmr3421027pzg.8.1712156193399;
        Wed, 03 Apr 2024 07:56:33 -0700 (PDT)
Received: from [172.17.0.2] ([52.157.1.129])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7804c000000b006e6b41511fdsm12146035pfm.94.2024.04.03.07.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:56:33 -0700 (PDT)
Message-ID: <660d6e21.a70a0220.59536.1688@mx.google.com>
Date: Wed, 03 Apr 2024 07:56:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5442878818289683948=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: RE: mmc/wifi/bluetooth: store owner from modules with sdio_register_driver()
In-Reply-To: <20240403-module-owner-sdio-v2-1-ae46d6b955eb@linaro.org>
References: <20240403-module-owner-sdio-v2-1-ae46d6b955eb@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5442878818289683948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841110

---Test result---

Test Summary:
CheckPatch                    PASS      3.07 seconds
GitLint                       PASS      1.40 seconds
SubjectPrefix                 FAIL      0.69 seconds
BuildKernel                   PASS      29.73 seconds
CheckAllWarning               PASS      32.46 seconds
CheckSparse                   PASS      38.12 seconds
CheckSmatch                   FAIL      34.81 seconds
BuildKernel32                 PASS      29.06 seconds
TestRunnerSetup               PASS      518.13 seconds
TestRunner_l2cap-tester       PASS      21.01 seconds
TestRunner_iso-tester         PASS      29.85 seconds
TestRunner_bnep-tester        PASS      4.62 seconds
TestRunner_mgmt-tester        PASS      110.07 seconds
TestRunner_rfcomm-tester      PASS      7.10 seconds
TestRunner_sco-tester         PASS      14.66 seconds
TestRunner_ioctl-tester       PASS      7.49 seconds
TestRunner_mesh-tester        PASS      5.64 seconds
TestRunner_smp-tester         PASS      6.63 seconds
TestRunner_userchan-tester    PASS      4.80 seconds
IncrementalBuild              PASS      57.83 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
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


--===============5442878818289683948==--
