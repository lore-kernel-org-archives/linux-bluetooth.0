Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C6B63B9
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380217; cv=none; b=YjwHCL/PBCFjX7u/ZENaubN4E5G14vHHPAB48dXKAdHw9misBHIxCdGlROEUACq6opl35oWbGEOYexbBLLnQ5Y0w/MjnPnPnzkGGVbjatgwHrCD9itoUrfZT2m6lnJ+BIJLh5r4Z+I+Q/OVmYqZv87U9ZYOh9EjcDbnfTT15LFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380217; c=relaxed/simple;
	bh=pXGHudOfBxLDPf1JPcql0SmKd6XOUXDJ2Qd7gq1xVtU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fXtX6ZdbL/9M5Usavo0uTrKz4oTn4Xl555QnJJvsZbf7u03B/sN3AaI1VyTMXz+BM8BH2AHPCQIEEYlYA/5pTaZBnNjo4olpBIokGrGBhyivyJKFWaUgEpPkqpdzEG2yh2I0/zmkkWDBI9JV90XTcEblAmkeMwBQkm3R8WfcVDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6HhEA3G; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6HhEA3G"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8f8657f29so16642476d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 07:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744380214; x=1744985014; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vG9I1FBeaBa8loIFKFTqnz14XEwl00ieHLOmqeugw/w=;
        b=V6HhEA3GXA/hUY/HJjygnEvac78ZUkYPaOlIQ9VBtKm+m4svV1eI4eGqw/ZB+PMlqc
         mrgb4NN6NNMQSdInZYmAKt97NMwlGr0yEgIgcmGRJcGhf4eRS7G3SzqBu3pqPyVzGhqU
         OV4O76uQ8YKLz/2PiMJTKqouscQhEJW45GXLc7us87c2nwaitlKGHOozKyySbccHzhIj
         qV2aW2mju4JG4FZLwbyyj9EVFFXtjMTupU4/tgxWkQUDyFBsZKhuo9/YKRZBuqc1oOFT
         RRpAYruO/4ExlMy/yfqI+MowL0PIvSlaRv0a5YeQQGgJWdB9pxlNDoVSxAev7S5YgJwX
         a3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744380214; x=1744985014;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vG9I1FBeaBa8loIFKFTqnz14XEwl00ieHLOmqeugw/w=;
        b=ry4j7MTXhkbBQfl/XwORBZm9b3kC0LIcm2GDXwB5FcBGGx1DrWdJ6tFhk1aUTTZWvX
         XsRKxUUb/TT8F+WG2U5zMgBy4+Y+km3FZVeU1o/dfDCJ0CpRl16ekIomWPSdvqF3f6Ls
         plxMIxBxHhbCzaHEmJI4+RW1VAL32C5BJk1jFr4oDlp5nZfUQVGmTHNnS7izqOUpHecf
         aKDJXzbVTELz3bObWCfGkLHl25VahT32kITcsm4n0BM2xK3/iTyPjf2kOIMwTRAxwPYd
         2ny6+E1WsbBfX4emsHHX1ME9FjUzM4q/rKv3dE/ixxmOR0ja1WUmLbMc4JprVn1WfF33
         cHkQ==
X-Gm-Message-State: AOJu0Yx5DThZBRf+C88EmOtNpu6enc1RKOLMUgXpgfchFMGlbejAYZJv
	MLvma6jnK0dKVZTTf/zvl4KLXIaxw3zO/F7P3LjhdkqEZG5RbJaYmAH0sg==
X-Gm-Gg: ASbGncvXWvqUGNVLYwY+uPjvfDWWDAxTEu6Dyq0nNAo0VkpslN+jml/b3NA9za7VOE4
	qt4kp7b1ePh0rQb/Mmuc0pf7JiCFRpFmJBEVV4Jp3o+Z9gFqZTywy/u+CrkBy2SmzD7uM4tjbh/
	MEk/zGTy40fyFiXK2DSwJIAKj4XtHjwY7sCtPGQ8opx9RE8jaZHBL9bB40/rSOTRyz053vATKSq
	eS4JlqNV09Sf2xnYlZ36+POWOlL8XAn9xqCF4iZ7fQ5fiWubx5zdJlTptq8Bx8XsH2g5B1Abtry
	7p0R2FehJk+6ROUc1lOL1uK5SQvwNQIJcQbp+W/pSwg+nZoahA==
X-Google-Smtp-Source: AGHT+IGVG1S1iX+npDwocnsCvUxuaiAZCoMQn/+96wtrL86xdOGoAiJBpD3vmilVK5abXVnh3b0I3w==
X-Received: by 2002:a05:6214:248e:b0:6e4:4274:aaf8 with SMTP id 6a1803df08f44-6f230d45827mr41810346d6.17.1744380213376;
        Fri, 11 Apr 2025 07:03:33 -0700 (PDT)
Received: from [172.17.0.2] ([172.206.110.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de9734e4sm36813626d6.39.2025.04.11.07.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 07:03:31 -0700 (PDT)
Message-ID: <67f92133.050a0220.218762.b40a@mx.google.com>
Date: Fri, 11 Apr 2025 07:03:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1244356316533428337=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chharry@google.com
Subject: RE: [1/4] Bluetooth: Introduce HCI Driver protocol
In-Reply-To: <20250411133330.171563-1-chharry@google.com>
References: <20250411133330.171563-1-chharry@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1244356316533428337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=952530

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.46 seconds
BuildKernel                   PASS      24.45 seconds
CheckAllWarning               PASS      26.95 seconds
CheckSparse                   PASS      30.86 seconds
BuildKernel32                 PASS      24.07 seconds
TestRunnerSetup               PASS      460.92 seconds
TestRunner_l2cap-tester       PASS      21.13 seconds
TestRunner_iso-tester         PASS      36.61 seconds
TestRunner_bnep-tester        PASS      7.18 seconds
TestRunner_mgmt-tester        FAIL      119.99 seconds
TestRunner_rfcomm-tester      PASS      7.91 seconds
TestRunner_sco-tester         PASS      12.57 seconds
TestRunner_ioctl-tester       PASS      8.32 seconds
TestRunner_mesh-tester        FAIL      6.40 seconds
TestRunner_smp-tester         PASS      7.24 seconds
TestRunner_userchan-tester    PASS      5.04 seconds
IncrementalBuild              PENDING   0.87 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.193 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.120 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1244356316533428337==--
