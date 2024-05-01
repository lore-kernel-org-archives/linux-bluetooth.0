Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1314683
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 May 2024 01:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714525821; cv=none; b=QG6BGzbxJIZ+WZ5qGclCnpkcSXvMt2jYKiCvuI5F29oIaBARovuEGsqFchuUa7SJ9gyaQToGFZW8QNMNoKqLGwMtcHU9UiSLUZHVDwGP+SRtTBEeamipxQNWJXdGNzRmecQsH7qdzTFUAIZVIYD07SCoOWH4dF9+x5MWpEK2nkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714525821; c=relaxed/simple;
	bh=dQRiEI+hB5Cde5VhVJqnKOpr31irWMcCQkIoN6TF7vk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cEeYZ+7sbEN9+OwmpLBMSJEtX3nuwMso8rC1TtTHpjy3znKe5yNNrQCQVQWolOf/buk1QtBJI+2EGXiMUM8LhVkx3414ImJ4vQ8GJXLeJMAamCq7x8DQr4iuc3onwbO1Zg8czdZYKhJh63u4+U8mIEMiKe6b+odjHvR+M64WO2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9Jx/aw2; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9Jx/aw2"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78ef9ce897bso446222585a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2024 18:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714525818; x=1715130618; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=At+8l0mMT9pRrXsPecM24XIoEdM0CKIg9k3VcYXpt4c=;
        b=a9Jx/aw2Nk1etovKjELGi8Mn3d59Hhsf29ENdfPos0G3mtUdalehqlya9JbaCBszdJ
         sxsyq6VTE52DbsX7emsSUS9sRSK2RMbfWNN7D18x7lGMdvND7JFQaUxnPXEMvB2UJREE
         K3oosXAd1YI1X3NkQWIHeD9PipnLyWXOyYnFOPdP/RdOjPpADFWEVpL5ohxRiG36pXFp
         n5IEDP5fLIm4u1uvWSsY6/qMbTOiXXx5DFL+aZ5/l+PdK5YeGugF7bGv01yaYYsW3gqB
         BmWmiwGyxBfc30UGPbU1XKp18v9FeT9tzMF41hf3c0BxCDULtukeMevzzfT50d6QEdDu
         ycdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714525818; x=1715130618;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=At+8l0mMT9pRrXsPecM24XIoEdM0CKIg9k3VcYXpt4c=;
        b=f0OewMMUFVrWehEAYA9v4OIdUSd8CYnsowTO/3Fqosso/GAA8sv4FSP+3wmWZFx79U
         sqcEyEGhGu5MFxwAImdmgL9ABrKhChJOq7NBY8zRQRt6Tbb3wB/ygkP65yeAzlXKFMF2
         P5vogdoo1fDXo4BpE7nIqS8i2srpQQ9Lse6+x4LZ307YGI9hcdFl3FNd1GzQBLnZreIM
         w3sAr5/spi4d2LfE83DAgL7ZZ530q/fGToDLaOUN/tmxv3sxxWuY5c1FVdstg3+Kl2qe
         vgLAuBtm2tXcI+fDTyDHRWG3UyUJzreQofGaBl0g9qIB2tPJgq2ozc4cPUAJuAs69Opx
         5XNA==
X-Gm-Message-State: AOJu0Yw+rDXE/sX4GOY824vy8ZhviCIvtTaRIm+3GZCiFFuPDO5sLtvx
	zUG9ThZhZ1IOtn0nG08Ajsmv0iCNNfSx0UVfqlhkwssxri70zHoUE6iKHQ==
X-Google-Smtp-Source: AGHT+IHuHtIJeyDBiKIg3XJl8Q+Q58xFxs4ATSH27oNsG6HNO7H7sLq1ULw9ryq6C7pFzsZhrxKomw==
X-Received: by 2002:ae9:f00c:0:b0:78d:68b6:5c99 with SMTP id l12-20020ae9f00c000000b0078d68b65c99mr967221qkg.69.1714525818305;
        Tue, 30 Apr 2024 18:10:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.46.206])
        by smtp.gmail.com with ESMTPSA id d3-20020a05620a166300b0078ecc54b1b9sm11851558qko.71.2024.04.30.18.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 18:10:18 -0700 (PDT)
Message-ID: <6631967a.050a0220.efded.70ca@mx.google.com>
Date: Tue, 30 Apr 2024 18:10:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3391523106470242660=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, surban@surban.net
Subject: RE: [v6] Bluetooth: compute LE flow credits based on recvbuf space
In-Reply-To: <20240430235122.37716-1-surban@surban.net>
References: <20240430235122.37716-1-surban@surban.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3391523106470242660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=849510

---Test result---

Test Summary:
CheckPatch                    PASS      1.24 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.47 seconds
CheckAllWarning               PASS      32.52 seconds
CheckSparse                   PASS      38.18 seconds
CheckSmatch                   FAIL      34.85 seconds
BuildKernel32                 PASS      28.88 seconds
TestRunnerSetup               PASS      521.79 seconds
TestRunner_l2cap-tester       FAIL      20.92 seconds
TestRunner_iso-tester         PASS      31.54 seconds
TestRunner_bnep-tester        PASS      4.74 seconds
TestRunner_mgmt-tester        PASS      110.77 seconds
TestRunner_rfcomm-tester      PASS      7.22 seconds
TestRunner_sco-tester         PASS      14.98 seconds
TestRunner_ioctl-tester       PASS      7.71 seconds
TestRunner_mesh-tester        PASS      5.83 seconds
TestRunner_smp-tester         PASS      6.80 seconds
TestRunner_userchan-tester    PASS      4.90 seconds
IncrementalBuild              PASS      27.45 seconds

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
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 55, Passed: 51 (92.7%), Failed: 4, Not Run: 0

Failed Test Cases
L2CAP LE Server - Success                            Failed       0.098 seconds
L2CAP Ext-Flowctl Server - Success                   Failed       0.099 seconds
L2CAP LE EATT Server - Success                       Failed       0.114 seconds
L2CAP LE EATT Server - Reject                        Failed       0.095 seconds


---
Regards,
Linux Bluetooth


--===============3391523106470242660==--
