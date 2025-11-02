Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9B134D396
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Nov 2025 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762111917; cv=none; b=YkjT/hO5pMR9LU8/WE+6+OTZciFIMTdOv9PXtALlsJzbLV9JkI+CN7rxnLt3n294rMT6RLkYonu4e38tKpgzOcax/+PTWn94ANlBhOLYE5KGh3U9VW35Pb8UT4WVDobyhdy6R21bc0jjHQVBcINQ855GQwFp+Sa0XRSkZbRWPHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762111917; c=relaxed/simple;
	bh=o/ESXznMUE7vYXIyZt87qeSmgKCAfMRc8HcA7yECnz4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=U2lB0mysZEkNa1Vlz3PahtuslAu+axNCp/EPCcWv4LdxCDFvzEEmrRgxGmpaTWXIYr+UPfej5SWyvzDuN8GpTdi1b++YK5f9hESr4GkJ0hXMPljJF5r7nBHRO62BGhChULFogs9nEL+aNjdAeIdDj4l7p5o6ZpjzBaozKI504g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehVRWS0F; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehVRWS0F"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-93e2c9821fcso387906039f.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Nov 2025 11:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762111914; x=1762716714; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x/FL7rQhorIwrn2C+o6XqK97cZp9L3uI4MdXhv12aZM=;
        b=ehVRWS0F4a3OTDbzp/x+EeuWZZwYcNs/XKacmE3whDomJ0JBbOWvKqTvSXhXu3gt6N
         egNJEyM1y4fUz/Jix7UUil6GZFWfctEC++/dhO8EIXAflQQ3LrrsNK38HD4gD4GGxQLW
         +GLCM8aAzHvvj4vgRdx1EPvBT8p5KsoDvXNbOeoC0ft0sdPAa31SoN3JwCisnidbHmkD
         aczAnzz5eNCbBSxgf2fAsGDI08x2mU5+suCshvEHJlHewdyKyqb+fkunwM3K6lSWLnRk
         7Jc6X6YxnJyg/9UoitxcEqMLYz+fCVyBJ//7x/94fHHbrqKAybuW7qeVA+mrUICGZ6FK
         rRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762111914; x=1762716714;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/FL7rQhorIwrn2C+o6XqK97cZp9L3uI4MdXhv12aZM=;
        b=t/dy3TDG7WXMw9ebQpuh+XER8tG1jrlGgKxr2OD6+GtVaK/8DNoo2WMfczxzbU6mWL
         5JSuZEPo4r6rznUhufBn9DtgNPDU80wf+TouAWWem+jZMEvZMyq6iojtkZ0lfvbuHi1I
         1uAP/8o7GBSeZq6tsFJBCWvav9KboiCYqc8xVjuyKODSogn2iLD910gRZ9YCMGlaOa3Z
         +mTavBLtchrK9/mv9+Fp1j0yNZNKBLmox3RSWE3304KnGRNugMg6Jj712OQqqjooVY9A
         JzfPwkudPzJaZQNYJsFHp83P84ts21D/bVGcRStcrKaOGdkD5rYwRWDhrRDs5Uj3ZyUz
         tgmw==
X-Gm-Message-State: AOJu0YxEYUoGKE8ctyMYbvGzMYSFQVw1piYSS5MNktnBnhe+6g7acR3B
	x3eaXHOK6wWSEcyXD0dAPd8ZWBK37vJboNdc9Y4tmgCg9GP3aCbc4KzjN5PygA==
X-Gm-Gg: ASbGncvJG2V5ZotMXn6ttT0jipboRfZ5vawrwldrPv1jMYP6j7zkgY7pSB41JugPEWW
	SziIQL3MJ29dYxamVpmfLvY2BCGqNXYVxVTEJta7P6EuR3GuN//X05ISHZt4vsukOWw3UyuKpls
	ztlIitv6tGVH4rfPd5Hs4l/t2qx2SNdCyNlXYdm4LfYoCuw9urhJay5Kq0p6Bu8BO7IdzxdzAze
	upR4I3HQG230WY+Jq5CNW6IvRpBLFpfV3WbWH8H5nEdnXBjk8xO/7ERWZi33YmSKKDeCP6DyN9A
	dox+SYw7yETa5u+8CCw5qIhPRAy93fhtQVnyh+LsPAsE5AGzol8QTiQZZkMFqKawoUxETWPqYad
	kiDEe2I/uARs3PVNluNBDXrt/VeP+NLRCMsre/rjeQM7x8gpGSxavczIdnpmUtV/tmLjBzvk/Rl
	0ed5ygeYg=
X-Google-Smtp-Source: AGHT+IHWu84sXQXxL5r6k8HO6QLXOb9banLNuTc16qRAi9y28z95nlpcjja8fW/+4vURydVWhkyCOQ==
X-Received: by 2002:a05:6602:13ce:b0:945:a8a0:b2e1 with SMTP id ca18e2360f4ac-948228ab671mr1799767539f.7.1762111914148;
        Sun, 02 Nov 2025 11:31:54 -0800 (PST)
Received: from [172.17.0.2] ([64.236.142.145])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94827db991bsm268523239f.20.2025.11.02.11.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 11:31:53 -0800 (PST)
Message-ID: <6907b1a9.5e0a0220.1d4ef2.3dbf@mx.google.com>
Date: Sun, 02 Nov 2025 11:31:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0412426624768625346=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: ALSA: usb-audio: add min_mute quirk for SteelSeries Arctis
In-Reply-To: <a83f2694b1f8c37e4667a3cf057ffdc408b0f70d.1762108507.git.pav@iki.fi>
References: <a83f2694b1f8c37e4667a3cf057ffdc408b0f70d.1762108507.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0412426624768625346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1018659

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 FAIL      0.34 seconds
BuildKernel                   PASS      25.05 seconds
CheckAllWarning               PASS      28.12 seconds
CheckSparse                   PASS      31.87 seconds
BuildKernel32                 PASS      25.16 seconds
TestRunnerSetup               PASS      507.28 seconds
TestRunner_l2cap-tester       PASS      25.93 seconds
TestRunner_iso-tester         PASS      81.32 seconds
TestRunner_bnep-tester        PASS      6.20 seconds
TestRunner_mgmt-tester        FAIL      114.39 seconds
TestRunner_rfcomm-tester      PASS      9.29 seconds
TestRunner_sco-tester         PASS      14.53 seconds
TestRunner_ioctl-tester       PASS      9.97 seconds
TestRunner_mesh-tester        FAIL      11.39 seconds
TestRunner_smp-tester         PASS      8.56 seconds
TestRunner_userchan-tester    PASS      6.62 seconds
IncrementalBuild              PENDING   0.44 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.107 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.184 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.931 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0412426624768625346==--
