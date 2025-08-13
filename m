Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70422D641A
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755122373; cv=none; b=o61RbWITAoiFEdpBarvSS8edHj5NmXX0TE0RjUmvrbPF7OaJ0y0zVXzaHvMArcGz+4W94T4hEUxxVRLS4akJksRZCfURGMPKi4YFNGSiw+hflDVKoen6REzOXBcSJweLHpiIRU8iQo50eBbJDzZ9VMlXBUvz0ZQLNINL4gN4vWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755122373; c=relaxed/simple;
	bh=5XgFAs+Z42w4gzeahLlpsnI1mSyJaHNWv4YGo28SlcQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XArYoUx3b4i02HvtLkjlP3hTklVl0TPti0LQTJ0ZzUaF17cUM06xcuuNONkjMdlGsc5ON06B2sIxavnXFZ/QIfoqpGaenD0dPP1rn/GHYrkdJPFQ/YTygut7hhwp6uqddQwTkG0D44FLJz4gB1JEAnvAhUT/yhNOp5qn9tY9FK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnQt9cvz; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnQt9cvz"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70a88ddc0aeso3809496d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 14:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755122370; x=1755727170; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WWOUCy/t2V4YV9fN+MaPiCP6M867Lra2QJtts9Ek04o=;
        b=WnQt9cvzDypMD63H3/tEOdN4dFbm0WmV+mHZPhHHI5hLCdhHNeWkp5VbKIQboWi2s+
         +TCP2Mgv9KBNnmsVHqNO0tSlwNh7uS+C0D+3Iuwc+GflynTu2pnMIlJg7GLtx6Ws4ZaB
         9SrhZUhng8oLBe11g3m3z5fcQaP3UxkraNBzWfYyyvUZinHoImkpLxbl2hJYvNTJLm03
         m3np/rBKinxLOUjCVcaV4v1J8Zwg611TbhsNtkVHrJupYmZ5zXAMLISLZLH2k3jFxZqe
         1Y/GBy7S7t1qZV8J7jcdICosQMu/85r7pvna8MTFK9tscLQDUktiF6OufMn4EY38Llx0
         Y7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755122370; x=1755727170;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWOUCy/t2V4YV9fN+MaPiCP6M867Lra2QJtts9Ek04o=;
        b=Jl083zTZFBN9sL6QkebITNRnMQZDCwyRbSv/zmrS3vAyElvHE10eGEfe1n8pkRSXkD
         A13g4++r6i9SQgP3dqznQXUaaAGmszLjRnmTjQzCrB6pYshgDfKCwdx5+q5wXF/tANvL
         wxeMci28IFGBv1BkU7uP3lX00LbnEk7wuDfdsUEgq3kc+54HpsVm8ssxnYd2N/FhGiNt
         HKrlXHXA0EuNM4s1BdQq+eZZEYhJ/uhrf2XKgkm2AAt6BI71ognTwUierffmStYOmirG
         B44YM7wbedIscX5m4jzFkDaDa8lIZTkRLLOjAAonayBPHAAKtvpmUwFok8bV7p7MM1Qd
         w7pg==
X-Gm-Message-State: AOJu0YwkWGuGUm+xZPJsx+/SLH1UBUJq5IQlceswU3R1Ep/NC5fc36Qs
	oMj/OR0zXnsXj/ldq/Ik2CAw4vLvns1550TrkwDNJ9tLYfIzVa/07RNIuzl2Uw==
X-Gm-Gg: ASbGncsSwgVFBFofve+N/Jgh1uXuGZyEv1VEkYnh9a1KfrS+R/OXm2UCwOogsUqUpf/
	XIKGjCyGQCGv/YorZGee/m5ZDA9a16HdvdQ9elXbkaS8nk4yEboUKJHfh0oIKPUmC3aJN+jtPnL
	cdahjw+JtVv00VswNBge8mMXlnNhSzJEKi0BiSEIwswWP/YQi3bCadpVmzjM6/of0XTXpZMJfPs
	Rtdqr0SfS5Ch0vqmYoFgPNYGJF2nSA2tWWowsiUM44NOH9OjaZRVq5H/L6UIr0akZBPX9/IZ5Dj
	tlXsie7E0JJWFVua+GVwtioKLwDNf+EGJAdkFEbNxH0/tofcsJtn75LnYjtGde4LHcGC25ZFl31
	kWDWF6YQZkOyNY6mHs9+Vc58mS5KhtPieUTJ3jJg=
X-Google-Smtp-Source: AGHT+IFctuNYAY3i1s4igBH9LlSxsqvLGxazdC8s8HL4ebiQDbTF4LljXgxU+Z0wCeoVXfKQSKG8Hg==
X-Received: by 2002:a05:6214:250a:b0:709:9b8e:da0c with SMTP id 6a1803df08f44-70af5f67545mr10811226d6.44.1755122370071;
        Wed, 13 Aug 2025 14:59:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.158.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70af5c1df31sm3908996d6.81.2025.08.13.14.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 14:59:29 -0700 (PDT)
Message-ID: <689d0ac1.050a0220.3af432.1e66@mx.google.com>
Date: Wed, 13 Aug 2025 14:59:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1471372352040129707=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,1/5] Bluetooth: ISO: Don't initiate CIS connections if there are no buffers
In-Reply-To: <20250813211511.90866-1-luiz.dentz@gmail.com>
References: <20250813211511.90866-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1471372352040129707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=991214

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.57 seconds
BuildKernel                   PASS      24.86 seconds
CheckAllWarning               PASS      27.83 seconds
CheckSparse                   WARNING   31.55 seconds
BuildKernel32                 PASS      25.08 seconds
TestRunnerSetup               PASS      490.00 seconds
TestRunner_l2cap-tester       PASS      25.31 seconds
TestRunner_iso-tester         PASS      39.58 seconds
TestRunner_bnep-tester        PASS      6.19 seconds
TestRunner_mgmt-tester        FAIL      127.73 seconds
TestRunner_rfcomm-tester      PASS      9.44 seconds
TestRunner_sco-tester         PASS      15.11 seconds
TestRunner_ioctl-tester       PASS      10.26 seconds
TestRunner_mesh-tester        FAIL      9.61 seconds
TestRunner_smp-tester         PASS      8.59 seconds
TestRunner_userchan-tester    PASS      6.28 seconds
IncrementalBuild              PENDING   0.67 seconds

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
net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
Add Ext Advertising - Success 22 (LE -> off, Remove) Failed       0.130 seconds
Set Device ID - Power off and Power on               Failed       0.113 seconds
Set Device ID - SSP off and Power on                 Failed       0.120 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.220 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.926 seconds
Mesh - Send cancel - 2                               Failed       0.136 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1471372352040129707==--
