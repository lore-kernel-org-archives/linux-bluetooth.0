Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027867602B
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Feb 2024 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708454259; cv=none; b=sAUcQEOunARqKcept8jYpjY4yLXzV8WgLC6a8D+i6LeUusE6Z9E+wlsHXTq1Nx+y63b2GaULQl0p67zeQGBDH0ZALiEBiRZV+u8++yi46VHWZkaD8pQJyWePRn3zLzotm5c2FmcwYz65VcBeaEOs3XsQu3+qHYVrr1qWuBDwB/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708454259; c=relaxed/simple;
	bh=2Ax5jhhEs63vrN0AYv1gI6mz2PsC0P8afix1wntEgmw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FbRvKpfGQbeIdz8egGKIS6XbQjv6sKOw6Q+8U7qfo4RwtcDslaM6fh/lHp/VoJ/BvDNzePliFPDzVUAAG9t/d1p8/H+Tgn/3SENHnLinTvx1nlDKnhVrQHjGPLmY00nJ76bAR3L1TH6KKUKnoQmAYk+BeFp8oFdweWudB87/538=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=St9lhCph; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St9lhCph"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-68f41af71ebso38708536d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Feb 2024 10:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708454256; x=1709059056; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OrGV+HrLzcRYiCjY0iAmnSMxQ0Ri3dMKD+IXiX9MHM0=;
        b=St9lhCphabD/gyoXA0ifnoThVacnIsbgvilWoo2HzkAXghM/F9tqyfraPpvjNnarfI
         9fNGlFmwRxNsqRGzX5Zi5rhtlN5v4LfTFVidD4mP9+2c0QOuS8nTpZn/e4iW+rXQN0tn
         YGZJohMizLZ/mqn/2H3b46rvJKIsHsaShB3JZuLHC3NQGs025mCwWgCo1O7nr9f6E224
         a4RRbFdV86iIVcSTaEXLkaVijbHdU/T58w+jMm6DmhiplicSvH6S8VrOPpShhephtaXI
         +Y/G8uPB5Ze9mFQ776QjLK2wLing7acawbYPDfOltHzA1v7Y4c9dmsLnYTN8Ho8UrWlG
         fMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708454256; x=1709059056;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrGV+HrLzcRYiCjY0iAmnSMxQ0Ri3dMKD+IXiX9MHM0=;
        b=DVsdjeZOMmeSHEs/nTIo/W4fs3U2gaxewaWpLkXIXXJvU4Z4DcluYfHKi9n5jZNgtR
         r/pWNn8K7jKK211PIXzH+5Br+xuAgwG31o+NAlsyuY9EbQhxk07YsmRolrvJeiYKf7CK
         cGKqUVBDOuveCv0HfMZpB6RtlS0zNOyeetuz6/SVLl8Ljka+wDvxo/niZxhhSZYs7TqL
         +gruzD5IpLag54ihSRTSsqKvTnGVhEhL7eYwOsx7NqYtUYAezIN2qN0u4xIHubZ0C1ti
         nFHWyVPmWSWFYkL8QUcTnp90pOrg61epSEPbA7U838/feKns8nWbJknBq7Jn6CX0g1Su
         F71g==
X-Gm-Message-State: AOJu0YzrSrRN1hZ1XqLrWaE24fcsxDTYvMm/QpI8/CanukI/32dBJwHU
	afopQRviIqKxfkdDk9IbkTXQs6/6dl1OOJ9XYbUPHBIO9rdNmE//fPI0dkfk
X-Google-Smtp-Source: AGHT+IFUMMwd4sMNQDxVavpCDv1ohYLIIJ/hhHQtUb/gK8xL06w1Z5nd5P9NclAUkGYWcBaSiAYi+Q==
X-Received: by 2002:a0c:f3d0:0:b0:68f:325f:d88c with SMTP id f16-20020a0cf3d0000000b0068f325fd88cmr13853041qvm.1.1708454256584;
        Tue, 20 Feb 2024 10:37:36 -0800 (PST)
Received: from [172.17.0.2] ([20.109.38.196])
        by smtp.gmail.com with ESMTPSA id lz1-20020a0562145c4100b0068f8f3912c4sm966529qvb.3.2024.02.20.10.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:37:36 -0800 (PST)
Message-ID: <65d4f170.050a0220.4cc31.61a4@mx.google.com>
Date: Tue, 20 Feb 2024 10:37:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7737287415015098788=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_sync: Fix UAF on create_le_conn_complete
In-Reply-To: <20240220181319.368485-1-luiz.dentz@gmail.com>
References: <20240220181319.368485-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7737287415015098788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=827947

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.92 seconds
CheckAllWarning               PASS      30.94 seconds
CheckSparse                   PASS      36.81 seconds
CheckSmatch                   PASS      98.06 seconds
BuildKernel32                 PASS      27.36 seconds
TestRunnerSetup               PASS      499.61 seconds
TestRunner_l2cap-tester       PASS      18.24 seconds
TestRunner_iso-tester         PASS      34.49 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        FAIL      172.03 seconds
TestRunner_rfcomm-tester      PASS      7.49 seconds
TestRunner_sco-tester         PASS      15.01 seconds
TestRunner_ioctl-tester       PASS      7.84 seconds
TestRunner_mesh-tester        PASS      6.03 seconds
TestRunner_smp-tester         PASS      9.00 seconds
TestRunner_userchan-tester    PASS      5.06 seconds
IncrementalBuild              PASS      26.14 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 488 (99.2%), Failed: 3, Not Run: 1

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.117 seconds
LL Privacy - Add Device 6 (RL is full)               Failed       0.143 seconds
LL Privacy - Remove Device 1 (Remove from AL)        Timed out    2.207 seconds


---
Regards,
Linux Bluetooth


--===============7737287415015098788==--
