Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD7113281B
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344158; cv=none; b=P9krvYfcrTue6ZKAd8gyml7s1tzkwNTT7ZUYYA7melvdbucpPwczhFEUn7gDeG56hROTho3/qpVtxhRdPg01TYBd+ttm2g15iAyNCpQuykvxzkYJyEgfG6jCuFrF1VBH/KY21MBsOXUqItkKX/7UkF4/BOucN5YQZlN9HzGDQd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344158; c=relaxed/simple;
	bh=zrUNdmOEHxXLx2JNeO9b+39wNA3Ppcr4IRB6+j+W0GI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=H73vYRSWLNtPP2uVg7h5VSgDNrNB4Pz5WW+DAytM2pMViYkd5L7pdLuAfnnKLbfsznVvqsRoWqXjAy25xoS8FLqTPpXZlJyNUZZYbxSiK7J0UQnQ+aEobWcjYsCmGKt+FACMCOvK52/Ixn8Bh/xql9eeody4LA5+gVAb1H4C4HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKSIuPeR; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKSIuPeR"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-436ee76c3b8so24974471cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 01:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713344156; x=1713948956; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qZiG7MKJOs1vuuNFRGq8kq6n34/KDDN4KymGTDTScDQ=;
        b=FKSIuPeRjbwO5R/2K3mUnEd2UQR1oPhiPCUwaT7XwPdZc+hvQ/kUksg0n9YiEgnXJE
         qmvnWFEqsFyFWNRS5/GYxzW8kMQOG+XFONsm6yOa/hxmKpg+Po/JZQgdy+a35OIoyPeG
         +qWXZb0CKFw9bWoOCdKtOiUPUT0dy1VP3jM8ITJkr6lpCrfodcQY0cdeCv7OAABy9k0c
         FqmUImOJXGQ97/EGWwCGq8u/M8mww7KyBNd6baayOnBQ+xN7zTIu7zIuxGWPnezwaP1N
         5ZUnMiFQO7dN0qjoCxspM/5Ma8yt9AzhpCdXe9424qTPnmXnNg+6D5CCOtJ/fRsngYJK
         +xPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713344156; x=1713948956;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZiG7MKJOs1vuuNFRGq8kq6n34/KDDN4KymGTDTScDQ=;
        b=DLfo4zLMZkqnorTy6PDGxZ5OA56XxTG4F06XPiKcEcYB4ZIh2d/jElpBs5AMSZuqru
         8XNutqQIQGfflu759ZL4hAbi7NEaYpZP1vraTxRVT2U7XCyee3F4SWxumlf4YTu6JY+s
         y6pPs/bdAmHe0IaXVLRb6wfS/Vb+53p7O28gyzXYc7JX3j+OkpUmNEeY5L2fhQhPqc/Q
         dJPJZk9oyeI2OEYiZv2wRTYSPRwj8RANH3O3pKZRYA+EtlJ0ZBpSanlt2Ta4xK864ehb
         8h7oN3vuNVbyrEk5PEV/XEkoTIxiQ3PUVHKnxfFZNcu6N/T9pf19E3037BKHLLh8XLCF
         FhyQ==
X-Gm-Message-State: AOJu0Yy7fUhQ9PfmvXy9sEjL8rzSfPV0HDr8Lzo2hUx8vSEqY6wgaurA
	KvqrLjXv5+TcfNnbfyey1LT215yusQp2v/dR2FuuQgrphgci6ebBWZKyJA==
X-Google-Smtp-Source: AGHT+IHmKcAkAVdfr/z3CqAuNKzieyITHErxsb+nDaIg1LvpPhGIg5pv3JbZK2VcEMPM8VOg03wEJQ==
X-Received: by 2002:ac8:5e0f:0:b0:436:e104:1745 with SMTP id h15-20020ac85e0f000000b00436e1041745mr11714002qtx.2.1713344156018;
        Wed, 17 Apr 2024 01:55:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.159.80])
        by smtp.gmail.com with ESMTPSA id z8-20020ac84548000000b004349bb95e01sm7882605qtn.26.2024.04.17.01.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 01:55:55 -0700 (PDT)
Message-ID: <661f8e9b.c80a0220.663b8.5561@mx.google.com>
Date: Wed, 17 Apr 2024 01:55:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5801087490576629295=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v3] Bluetooth: btnxpuart: Enable status prints for firmware download
In-Reply-To: <20240417081517.920454-1-neeraj.sanjaykale@nxp.com>
References: <20240417081517.920454-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5801087490576629295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=845335

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.72 seconds
CheckAllWarning               PASS      33.65 seconds
CheckSparse                   PASS      39.11 seconds
CheckSmatch                   FAIL      36.54 seconds
BuildKernel32                 PASS      29.43 seconds
TestRunnerSetup               PASS      519.51 seconds
TestRunner_l2cap-tester       PASS      18.63 seconds
TestRunner_iso-tester         PASS      31.85 seconds
TestRunner_bnep-tester        PASS      4.66 seconds
TestRunner_mgmt-tester        PASS      112.25 seconds
TestRunner_rfcomm-tester      PASS      7.18 seconds
TestRunner_sco-tester         PASS      14.89 seconds
TestRunner_ioctl-tester       PASS      7.62 seconds
TestRunner_mesh-tester        PASS      5.72 seconds
TestRunner_smp-tester         PASS      6.72 seconds
TestRunner_userchan-tester    PASS      4.85 seconds
IncrementalBuild              PASS      27.86 seconds

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


---
Regards,
Linux Bluetooth


--===============5801087490576629295==--
