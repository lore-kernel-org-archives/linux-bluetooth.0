Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A911B204F68
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 21:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707704; cv=none; b=nmkj0+XUsoXRQnJubyn5Fh08ETmYqHgcMnGphFaUoAK9DUyDLDf0D+adhwkzxHm5LAgIaFxDPF8NT8M4f9fnYjTBBchnLAMFbalM1pv3ok8BKBGFa+iQgV/wI0H1gJw+2l2lWtkLt6tcIJi+mZ+/LNSKnuamUj1/xFY7GK672TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707704; c=relaxed/simple;
	bh=95mhyehturg/SafntE2lz+KXjZqatxtzcuZYQx1K32s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=e7Agmelqhjh/qHAJJQ5gd6vyGrDKwcFnC4e75YPQX6T/sDBjB8Bw/Mk18VZpmCp0qHKBK+9qhAEJ9fmC/LH/GUFHAV+yh0Bbd41w1FTqdKQgcwl1Zk9lWJy3/qfFcPhAVcc9Goqx5hqpz2fx1ZKoxevBw0gp4+HS8mSlK3R2HmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEnZTWHL; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEnZTWHL"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d3f5fd139cso11354806d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 13:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731707701; x=1732312501; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uRhbhJXhmk1qQ4uYKcbWtfCyAaYpVy80TtXSNWMcwmo=;
        b=CEnZTWHL9ji7cugxy26YECnbN1UlQzhyTc/x6xNi81CPeqeOwp3BaPxzT4A2j2h24A
         9sr/i5Z/7gugiiWXyJIy4tczLDjF/Ix58qD2dEWuNCqbozPN4pK13SoG/qunKdFdGxsE
         p7X5SD9IOiswJg4jNVOxib0CUEoV4iSrYqbDsQdPDAyfiFHCluIljiUEoQ6Q4x0RNPl9
         HUSkvzCxSWJEuonJGyOuyTkFTIdFeVPsdfuJXjsaLAikNY6sD/gYngHQ2PzpefvTObZx
         TxHYfhTjD08YMx4fjm57mB06UsLftZTe1ovrFZ721DBSBztBZpX9fIzG34whT9R3c05E
         T2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731707701; x=1732312501;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRhbhJXhmk1qQ4uYKcbWtfCyAaYpVy80TtXSNWMcwmo=;
        b=UUuq2AB+Cm3hjgJwXu/GXjkhqpu9EaQ30CMU/Vrt6OTGDOhRA0NhCyfnw0pkB9utJ4
         4erAUZQ1yzYnUXPgJAB2pGomfxsA1yxNMZtDpuQU+oQYjDY00He7QrzqDwqG1sO8TODN
         NReFjOJXccNKsXHsZbY83S1gTae7IfDNDinKdVcDISqwWNsNdmUOoiU/Q02mTGX8eW1l
         Oro7fx0vboQqnCX0VBxy4nJMTFL3aGKdet5jRV3BUA5XY0Xr2GnWI7lNf+AKdhXgBHSN
         5LDKbKVn7zTHrbx5i/1gEP4MPoFqbN2aRcdma1wVg7MjW24tlzwDG/6pxpb7rh90exd/
         kiBw==
X-Gm-Message-State: AOJu0YxGdp2wVGj56/LmlF4hdAaHvX8FBsNKRMv3oW78CSgsLiPrTxpZ
	6h+11JDi71wX5+qpRNq1JBW7jG0u+7fJuD2X4N0Ihc2i9HaE/xrKaDA2SQ==
X-Google-Smtp-Source: AGHT+IHqfMwvfYFqwa31iVPqBY3YgTMoXNXlGkvTpWFKm+dceXNqKvsSfBIgaPwqAF0t6A8wyL80wQ==
X-Received: by 2002:a05:6214:54c3:b0:6cc:567:d595 with SMTP id 6a1803df08f44-6d3fb78ede8mr55032196d6.7.1731707701125;
        Fri, 15 Nov 2024 13:55:01 -0800 (PST)
Received: from [172.17.0.2] ([20.55.223.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dd380cdsm1374566d6.85.2024.11.15.13.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 13:55:00 -0800 (PST)
Message-ID: <6737c334.0c0a0220.2862ba.08d5@mx.google.com>
Date: Fri, 15 Nov 2024 13:55:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7672147778086807484=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, eahariha@linux.microsoft.com
Subject: RE: Converge on using secs_to_jiffies()
In-Reply-To: <20241115-converge-secs-to-jiffies-v1-1-19aadc34941b@linux.microsoft.com>
References: <20241115-converge-secs-to-jiffies-v1-1-19aadc34941b@linux.microsoft.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7672147778086807484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=910166

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 FAIL      2.72 seconds
BuildKernel                   PASS      25.17 seconds
CheckAllWarning               PASS      27.86 seconds
CheckSparse                   WARNING   34.15 seconds
BuildKernel32                 PASS      24.83 seconds
TestRunnerSetup               PASS      442.19 seconds
TestRunner_l2cap-tester       PASS      22.72 seconds
TestRunner_iso-tester         FAIL      28.83 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        PASS      122.87 seconds
TestRunner_rfcomm-tester      PASS      7.71 seconds
TestRunner_sco-tester         PASS      11.54 seconds
TestRunner_ioctl-tester       PASS      8.34 seconds
TestRunner_mesh-tester        PASS      6.05 seconds
TestRunner_smp-tester         PASS      7.33 seconds
TestRunner_userchan-tester    PASS      5.06 seconds
IncrementalBuild              PENDING   0.56 seconds

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
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7672147778086807484==--
