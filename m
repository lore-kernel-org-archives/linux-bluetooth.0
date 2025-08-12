Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261357080E
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755031042; cv=none; b=dNeCEr4Bnfd0JWbVuZmOfUrErf3C1ouXblxqv0OH8Gct7dtdBdvFn41c77rjd+qsaKHmgUNaHlwXTAfdFbDvGRAgVgbM4w3Vk4THbNllTdT3z7h2sCQN0EnIFDNI1z1PvyNWJ3HNB1VSPlHTV4b5mqkdtMl1CafE9eKYicOjfk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755031042; c=relaxed/simple;
	bh=MRSCB0eFK+k8Tbg8Cm/wfUQQsSn1VhJ2N2uYgcdtHQQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Pe5R+Nt8Ii0NAunDya6WX6aBvz/cGzgTimmb2kGn568/fejxbrKBvLdDYnW7MnNjotLGYx9/O5FETj0Xqy/GJYefr/dYM8fWKGnxYgi1/5TrUxo2Be37kp89d/Fb3ZBWLq1RkXai6p72lEkH6IP8rQfYgI4NrQBsS5MlvhTAz5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHB5FWiX; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHB5FWiX"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-70875cc3423so2703596d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 13:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755031040; x=1755635840; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QcQft5W/hPDD/BJ7+g9eAJzdSLLyVSbMMFy2ZQhnK5o=;
        b=IHB5FWiXtgnjP/y1O2ETRWcmPVnssYleMQExUvviaYKOTskh6F+A57tTTG3avHQQh5
         q3gPSSmJ60N3ZBmevMrHI6JE5GDHRbUiXs6d5u1dFYOwCaZLkS/acZAcHKC5O84s+PtE
         Nw+J8mNjluvCvhoalTD/tIYj7CNTl31B3ti1+p75SjpNDkxO9/oFKBSz0mNY/I91EnFd
         HlTHoukSY1hFZ2m2a8fDhX1tg1mqlxJnOYcL6hMMmZ1Kt5ThCp5c+oWocVlgTB4KSg+c
         i+rAZLkXryuGgOtfbyPToC30kqT+5jy20lM6RYSZxtmbKcgFZ7CMTY1EqnnLl44C6Rrd
         3ktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755031040; x=1755635840;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcQft5W/hPDD/BJ7+g9eAJzdSLLyVSbMMFy2ZQhnK5o=;
        b=ALr5E+7CL2YEdwrNtSJaVwN05ztYe19UnRMAOe8JQ0apV40okeResSp3nr2PBBqpQt
         CqruangI8LvmeM45ofsBsx3Bu7VQ9GBSzJ7GKvKQVnpVmeV0u8bv9LopbKlnnWukx7Va
         Qm6dyljXM1tSr9Q/DYA/uigP7vJadQSY63cZ54Lk38lwfqXqZMm6xFZjsi41ar1jqel0
         +c1FAwKwcgBEc1DTtf2PBijZu2Encxsja7OPkquKIdMPimi+sBGsR0WQFK6ktm74FLw9
         DnaloZwC1TeWdGA3ClQP9cIR7JvhWwUZ2PQElECt+XkwsyFNA3jVqQSGaheKU1zILRW3
         XOeQ==
X-Gm-Message-State: AOJu0Yz8qsN/fnrbyU0HWPceGmkaZaLef/dwiTfSTIjuNhTkbN/DKyiV
	Zau3dxacj7xoVt/9a9Bbv+PSRbixtRMDHZxwzTGkVWJdQnz9f0dmet5TZ4IBlA==
X-Gm-Gg: ASbGncsXUkZidAoXSdYY76W1LtiATUO7dod6wd96O2hmkhI4Nc3frvf9nvpRXDhXECv
	5CzHyuxwz05IQbNApUqMYmOnR2zr33PkU5DfnVxun7y0N7PQ4m8o8vVRZzD9QEqdTzZWqK3cKCP
	sr/iR4RYxSxq0Le8uT6NpqJlMzCt7wwifmOtEw5zBdTq+xvMMKKwNs6AlH1umDcJdt3oKoZ3gjR
	xx3w6HLChvJR3Mu3SncW5wbx3LVdAghA8WDgA8SnSq9+oFYOlCsZwiQC435iI5jDmtyC361oa6c
	EvwzTihhK0u+RiP21G9EOqqqv4Jyil88lcoogFf9vY1A9ztWzPhdY9S+JBcxdxe2IRM3zG6PXrt
	Xdmh5CE5YthLUWOvo7dS2U7Pw1yMX9qowLRfClkU=
X-Google-Smtp-Source: AGHT+IFE8lkEVmh4gM7XrGyooWtcxy7MC9QIDT2v6Q4+Z/Unb44ca/bI3XUMHehgbVwlsseSjSSk0Q==
X-Received: by 2002:a05:6214:623:b0:707:3b3b:4e9d with SMTP id 6a1803df08f44-709e933dda4mr4946036d6.18.1755031039591;
        Tue, 12 Aug 2025 13:37:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cd558f4sm182384806d6.43.2025.08.12.13.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 13:37:19 -0700 (PDT)
Message-ID: <689ba5ff.0c0a0220.3b3c26.a0d1@mx.google.com>
Date: Tue, 12 Aug 2025 13:37:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9113230955715034417=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/3] Bluetooth: ISO: Don't initiate CIS connections if there are no buffers
In-Reply-To: <20250812195323.1522605-1-luiz.dentz@gmail.com>
References: <20250812195323.1522605-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9113230955715034417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=990709

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.34 seconds
BuildKernel                   PASS      23.92 seconds
CheckAllWarning               PASS      26.53 seconds
CheckSparse                   WARNING   29.98 seconds
BuildKernel32                 PASS      23.96 seconds
TestRunnerSetup               PASS      476.08 seconds
TestRunner_l2cap-tester       PASS      24.64 seconds
TestRunner_iso-tester         PASS      40.47 seconds
TestRunner_bnep-tester        PASS      5.92 seconds
TestRunner_mgmt-tester        FAIL      129.29 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         PASS      14.50 seconds
TestRunner_ioctl-tester       PASS      9.93 seconds
TestRunner_mesh-tester        FAIL      11.50 seconds
TestRunner_smp-tester         PASS      8.60 seconds
TestRunner_userchan-tester    PASS      6.19 seconds
IncrementalBuild              PENDING   0.46 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Add Ext Advertising - Success 22 (LE -> off, Remove) Failed       0.126 seconds
Set Device ID - Power off and Power on               Failed       0.110 seconds
Set Device ID - SSP off and Power on                 Failed       0.112 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.107 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9113230955715034417==--
