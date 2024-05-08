Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82078AD51
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 01:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715133153; cv=none; b=CJlRPKZfGHKCnRgkXVmzQ+h8hw80fYMrmlukU+85rJtx4uFB5TIfY7/BZjwHHX6CKamidhE68aWImXvAxWFCLl100/Hk8WHeNTiIbuQgXUoHHPxrdcPV+yT99dRTXpxxvbD3AFo9bkv/UnAOhI1mp1EbjgLnRabfhZhujRynegk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715133153; c=relaxed/simple;
	bh=/QI+CRGVuuUHHe9LhQjI6YLiqWImygvb/AKmCmhLUvk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fq0NSWKKjJpgZ61C3V48H1Y1tvvmEpBISg/X9PKxksOegJt78BUUqsU1BKQNpOO5edT4ZwpPBSdk9kixSW+R8VcmGQPNa4Bj3gEzVXBVrBe4jSj/uIlfHA9URinUsavb7e3Fte7rnTQUKXJ+oXMR1UEf0F+roiunfYInlPH65EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5KcTOPn; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5KcTOPn"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c96fef64b3so1394432b6e.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 May 2024 18:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715133151; x=1715737951; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xVynRX2avb9b37GdFTnnJWI7M+w+3z8t7dwSG7RTw0o=;
        b=D5KcTOPnGWhwB/qIoO/NXY9wea0SUHyPXkeTURmVLOAiZh/U4wiQI15Q384o0BBISR
         KLGlfx/6fiVbfV+Vyh8QDn1h+SQwfv0X5p4rtV1dGLWIRI0o+ZOmc5YkeK8kMH7vIpJQ
         jMJY5tEZMn6PXYuJbQEzrZoDc1FayNa1sNG9oQR+zLMAnn7l3cWW0/WJa3qSuyU/baCx
         q8i8XKBVGuEfXyop5XOXMVKckr7l4mor3wJxuVvJNwF96FZ1r+P1MpTQs49wScvharFQ
         374Phu7pwnc6U6q0XY8+aRSpv0ptHYPcIwySKgBci1TIeHQ4AUgo0GtcMiGehdSm+Qpm
         8Jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715133151; x=1715737951;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVynRX2avb9b37GdFTnnJWI7M+w+3z8t7dwSG7RTw0o=;
        b=pEfaPnkbMeFG0GJlLNyD9i6PTZLtDuHC2qiIgaVqf3D5f+LuFLQRaCFApYf8YIBhYI
         +f388KNXcrlAJ0Zr/ZQZhmf/cjgFKneswLVRNrE6F7Liw/X6BZmnTquoCdWhh66pDAbp
         HE3E10dcRH73nS8hrX5JPaTnbn1aClkeaPIvkPLsKdnpVBQzGBJCcWt0ZbEu3gSjLP+E
         EPdP/hIXbyV6n8Txc8t93N9qHy1/S4rHq1ovcyXq9XLV07AL/s8Z3ZQZ2MhYoLo2QGoz
         4DV7JUfjI8uCu7nO5UE3cIoAZf2dYPoNgANc6LNJcmQrRqgLzcQ3cwW0rAb8C327BwH8
         8n2Q==
X-Gm-Message-State: AOJu0YzgGU+/f+9AqSA8dr1Z8NyVM7wlabZ6NfDlSrMz4DDnzhQ99Yrz
	GgtHF+I2/py4TLAimf1aZm3UrKbVrdKoz3121cJCiRNcmF/HB5USWVudHw==
X-Google-Smtp-Source: AGHT+IETJQoIc1qK48/AvzAKtmCVoI3lGobeDqEIvEXNKITrCxlT7ZjazzH7vqn+ITOH1NNkoDXlGw==
X-Received: by 2002:a05:6808:181d:b0:3c9:6cfb:bf42 with SMTP id 5614622812f47-3c9852977d8mr1654485b6e.11.1715133151425;
        Tue, 07 May 2024 18:52:31 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.68.212])
        by smtp.gmail.com with ESMTPSA id fn19-20020a056a002fd300b006f447e27459sm8831383pfb.168.2024.05.07.18.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 18:52:31 -0700 (PDT)
Message-ID: <663adadf.050a0220.e3864.ddbd@mx.google.com>
Date: Tue, 07 May 2024 18:52:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8500705750808063572=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Fix compiler warnings
In-Reply-To: <20240508010431.25687-1-kiran.k@intel.com>
References: <20240508010431.25687-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8500705750808063572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=851385

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       FAIL      0.46 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      29.23 seconds
CheckAllWarning               PASS      32.08 seconds
CheckSparse                   PASS      37.50 seconds
CheckSmatch                   FAIL      34.54 seconds
BuildKernel32                 PASS      28.21 seconds
TestRunnerSetup               PASS      511.57 seconds
TestRunner_l2cap-tester       PASS      20.26 seconds
TestRunner_iso-tester         PASS      30.57 seconds
TestRunner_bnep-tester        PASS      4.63 seconds
TestRunner_mgmt-tester        PASS      110.22 seconds
TestRunner_rfcomm-tester      PASS      7.14 seconds
TestRunner_sco-tester         PASS      14.88 seconds
TestRunner_ioctl-tester       PASS      7.65 seconds
TestRunner_mesh-tester        PASS      5.68 seconds
TestRunner_smp-tester         PASS      6.66 seconds
TestRunner_userchan-tester    PASS      4.79 seconds
IncrementalBuild              PASS      27.32 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1] Bluetooth: btintel_pcie: Fix compiler warnings

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
6: B1 Line exceeds max length (82>80): "Closes: https://lore.kernel.org/oe-kbuild-all/202405080647.VRBej6fA-lkp@intel.com/"
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


--===============8500705750808063572==--
