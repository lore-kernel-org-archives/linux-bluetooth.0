Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DA920B35
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277955; cv=none; b=GNdDGPTuCBz+enNgYNzR4RQz/pcie9TRBALq+Fi6gnWm/a3fDoNYUkGyvcX02GXhOw6cTcICtoGqYvbepDnlDxJsLDAJ19CLdZafOnAZ9YmblRSfgCiLCKxMzKO8lF0tPRQe1yS+cJniy8D/9yYYC/cUG1u57lQB0GX1eRvPU9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277955; c=relaxed/simple;
	bh=09u/HNXHjrelhpLLWxaNbgy8yyJva6MmRIK3VMQhvmE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TX69argkYAA6H8wpLWGyIn1ab6nT6+Q+OAE6Yijezu9203aE3Zm2y2c1EFXbLoTq16hRgN+up24QhiLxDNIdUuFq/Wnkjg5Bbg2yywcaXTNYl3KcYtBeeob7+d0K8SGOMb9FgFgsaMsF5pEda0qP/5WfRIg6I07bwR4Nv9ZdLsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCda417f; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCda417f"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so4245224276.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 07:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713277953; x=1713882753; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4Oie7gw9a6FSBWBqe8zRghAcfyCxpgYbIPsh57qGIFY=;
        b=CCda417fXVn8rLhzUM9lYC75YRyfiai7ZrHzvB8eHNMGcvXCzOqSt7obwGBLFalTk+
         Qpk2os9SVLzpvT7IGxbttTcAY2aSoS/54ofkyfVMghZv127iF0uDUu6VA5Hg0viGQR2G
         BkEFmGfLpt1g5bfO/yChFRLS60D6ABUy5S5M5HiDqR4L9cZuIu9osD1/g08q7KYAUxdL
         0cKii4beySkm3lazmszbdiaWA3CFQvNVdwpY+vCKHq8nHVEqKAUe4b6S8aSmXDayfluN
         w41darof3XeS+PEISokuHlU6TJrWoev0KHXG8hQXC4P8zvlgdo2FKjt2URHsL0gqnEjp
         dfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713277953; x=1713882753;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Oie7gw9a6FSBWBqe8zRghAcfyCxpgYbIPsh57qGIFY=;
        b=SsZatxR+wZj60eNk2YYnl4J8/5OyWT6qR4RPZ9a/FgEJvVHnxbltH2VkF2QycW49Ko
         LsTPnrVG525I6SXy3Rw5gis7SedW4m9b37E6blxUwTpWYyKfgqMyx9L9XA4Bdyee8YMd
         ylgIp3jBQODJwjqOA1lLytHJo3gUXBoAMWdHUc9qsQLtaTTN0CZz4slNNGET4oDgfxh5
         nGg0JSbXMUEjBdsx16H3esXkecXdSe2/h6ZZUikamCiWhXAyX3bahwLP2Pgpi7XDXOa2
         jZ4tZ48Bco9kTA9OY96fDO77hSSfZjKP/twosHe2UJKrDFydpnkmN7q+unUpik+fGt42
         PO8g==
X-Gm-Message-State: AOJu0YxepklhRcOG3kjpcP4JntVwtXn+LSnwEZAS6smCj0O3/7n2n8+K
	+1VUdxQS8nHq1jH5/lpAscJ/xJQcN+LOAd78+VygStpx4/U5W7erEMoXkQ==
X-Google-Smtp-Source: AGHT+IGzvG0UKFgkrH4zvAj8Yp+XHXHf8hIbSheVCJWdy0OmmjsJJGqjVoCltFLE9i6CDhuFm4Q19w==
X-Received: by 2002:a05:690c:70b:b0:61a:bfab:8328 with SMTP id bs11-20020a05690c070b00b0061abfab8328mr6047831ywb.11.1713277952612;
        Tue, 16 Apr 2024 07:32:32 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.32.41])
        by smtp.gmail.com with ESMTPSA id i188-20020a8191c5000000b006183cfc614csm2529990ywg.42.2024.04.16.07.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 07:32:32 -0700 (PDT)
Message-ID: <661e8c00.810a0220.ab2ac.cab1@mx.google.com>
Date: Tue, 16 Apr 2024 07:32:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6765805893392541585=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v2] Bluetooth: btnxpuart: Enable status prints for firmware download
In-Reply-To: <20240416135228.902973-1-neeraj.sanjaykale@nxp.com>
References: <20240416135228.902973-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6765805893392541585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=845060

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      30.13 seconds
CheckAllWarning               PASS      33.24 seconds
CheckSparse                   PASS      39.31 seconds
CheckSmatch                   FAIL      35.38 seconds
BuildKernel32                 PASS      29.44 seconds
TestRunnerSetup               PASS      527.41 seconds
TestRunner_l2cap-tester       PASS      20.60 seconds
TestRunner_iso-tester         PASS      33.63 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        PASS      118.04 seconds
TestRunner_rfcomm-tester      PASS      7.47 seconds
TestRunner_sco-tester         PASS      15.17 seconds
TestRunner_ioctl-tester       PASS      7.94 seconds
TestRunner_mesh-tester        PASS      6.22 seconds
TestRunner_smp-tester         PASS      7.15 seconds
TestRunner_userchan-tester    PASS      5.19 seconds
IncrementalBuild              PASS      28.44 seconds

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


--===============6765805893392541585==--
