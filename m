Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA841DBB13
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757716386; cv=none; b=V2iHS3SJuu2VgihsiskFhzVmBxfVmcpFN7YMHovhr7SNDcsrMeGLvgJBXDWfQa6NuBV4biBKQRRagTAo8so+qZb5QM/4T66xBQ1DVQ0tdcNp3DhW1y8wXG9hdDDDvR6MFXHjLmH+nGIZwlHWXJppAWkM3dsru63sdWTXXkSJQG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757716386; c=relaxed/simple;
	bh=EojWmaJOdC4UxxeSrjk7GlL8dY5dZYeUj4bXJyW4Oqk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kZA1tsA7T6TYqe6vHEFJRNJRM3OwLvZGYE6/6uVskoGSMFRIUEGLVefuKm51286JQCLD6MtAnnIE8mk4PilqwHwY5k7IvgZiNezNMXhw4cDQBMbSjfDC5ka4EZVL1U1m8xELD9rR9KcOhWAjSUW9zcnEatGKY8FR5tb5N59WUJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meIErkbr; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meIErkbr"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-72816012c5cso19341566d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 15:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757716384; x=1758321184; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o6f411Q4TO5kcHVruJh4GvlUHhNRWa0AgypsoZnHlFA=;
        b=meIErkbrfpjNexyWGRWffXovWG/FjfsMY5WAH7aVDfaVrNpxS5KVe5ESCLUaIpeXp2
         I4yiBSewSEq5TYS8XMZ+tDW41Bw5tLSCYsIy7lYzKNVaxVfAasXKzsn8TkhD9A/JDavT
         nhNs5fDBL5VS7LEYxQ6fvuS5TCClESaEV6icDOnwdhn5B+3Y9qm7qZy7i57KOjTGH36K
         OliX8JskZYdPL6110OGla8tiePx+qB1MkxMLCXZZNxhpVjr/HUmiwvmj+49p5t4tG9J/
         FVZe9100w8otBN9+eVcFSZUBLfuOGFbnVZLzv3OkwdfdFfuy4+US3wK1TEx2CSbTG1uo
         QaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757716384; x=1758321184;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6f411Q4TO5kcHVruJh4GvlUHhNRWa0AgypsoZnHlFA=;
        b=r6mZk/B2pZXDxocGimp6jA2Bboj8QHXE6SrnEDbR0iqKEx2X98NqmxThbMWjEHNpPa
         1O3X3ZwsIXRZsf116Hsr08WDMLewTLNMVt/naHHxDNXVEkyo8YR0TdWlMy7uJcCe+0YN
         uWG1XhWblc0dNHlmYiBeIufrkptdy4XocUzSGnJ9/JfY26YrJ59LA0r4g3DrNoZhXBdP
         2WSyVA85Kuug/ExMDg/RrpkLFNBqs2/Hvoz/cmEIM2oyOKxZuh69NZ8fxjD61AZ0Y48+
         JxKcxHlUmFrdc1kJ5aVYs31bdxo7rUmWBXO0n5MILKccVKojKjKPPeJ5Zz2QdOwKXrok
         RmFQ==
X-Gm-Message-State: AOJu0YwUpOONfS9zkN6dLl0MlQU0hMcGdtTP3PtOdAJxvbw5dNzpkxRy
	09MYnZmh36FSjM2178bbD4+6kZUsDttwkpHSnp6pdBTj6Og8KLhf3tacxRieltJN
X-Gm-Gg: ASbGncuOrYjnmbpwQcXvQFg+isXp6656USb00IUGgNkSJGKm/hKDYJeYGJsCGwdJRR7
	N+hqqopa+smRZ6bPPhFsDhLRUMxyDLEvRRWEtgyt7Bc0AFjW4detfLAa3qcJjKNLwIHSM+QroeI
	X/FZtGIrzJczUk4ZuphC52ADhkpktqURRTOwvLwIsoQf8wXmCgKZEWF1NQPFcuvx4qQm/Ahha6x
	fXwBsQNVi7TnXbVNyWcuqKvOUqsO1Z+r9mQ+hDdNgW0zwjGAGB3Qnt0BwsTIayHJSVLDsPMv5hV
	EKUTesYXIck2O19hY6NmEr+Xh12PiFtMTgDCP3dg7pskG02nb3XKJ7nSgXCFyEyF1fUhxVpdAWy
	6VihIKGA2Px2Yf6OFwMChq9NHLS0=
X-Google-Smtp-Source: AGHT+IHXSHP7l68nHRBOg9Y1E5ePutWsv9VmLSLdm08qnBq+ufLT/5r6b1me3gfjx3m1vOaLlsC7HA==
X-Received: by 2002:a05:6214:20ea:b0:721:812a:e6f0 with SMTP id 6a1803df08f44-767c3772476mr63586586d6.38.1757716384013;
        Fri, 12 Sep 2025 15:33:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.87.145])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763b450b4a2sm34347736d6.6.2025.09.12.15.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 15:33:03 -0700 (PDT)
Message-ID: <68c49f9f.050a0220.225601.db74@mx.google.com>
Date: Fri, 12 Sep 2025 15:33:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7162649935078830334=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [RFC,1/2] Bluetooth: hci_core: add lockdep check to hci_conn_hash lookups
In-Reply-To: <7fed0c48a73265242c440611825888c096c4c93a.1757712988.git.pav@iki.fi>
References: <7fed0c48a73265242c440611825888c096c4c93a.1757712988.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7162649935078830334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1001955

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.22 seconds
BuildKernel                   PASS      24.45 seconds
CheckAllWarning               PASS      27.25 seconds
CheckSparse                   PASS      30.74 seconds
BuildKernel32                 PASS      24.44 seconds
TestRunnerSetup               PASS      486.11 seconds
TestRunner_l2cap-tester       FAIL      25.68 seconds
TestRunner_iso-tester         FAIL      38.99 seconds
TestRunner_bnep-tester        PASS      6.18 seconds
TestRunner_mgmt-tester        FAIL      129.91 seconds
TestRunner_rfcomm-tester      FAIL      9.69 seconds
TestRunner_sco-tester         FAIL      15.34 seconds
TestRunner_ioctl-tester       FAIL      10.41 seconds
TestRunner_mesh-tester        FAIL      11.39 seconds
TestRunner_smp-tester         FAIL      8.84 seconds
TestRunner_userchan-tester    PASS      6.20 seconds
IncrementalBuild              PENDING   0.57 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
Total: 68, Passed: 68 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
Total: 135, Passed: 135 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.224 seconds
LL Privacy - Set Flags 4 (RL is full)                Failed       0.270 seconds
##############################
Test: TestRunner_rfcomm-tester - FAIL
Desc: Run rfcomm-tester with test-runner
Output:
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
Total: 11, Passed: 11 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
Total: 24, Passed: 24 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
Total: 28, Passed: 28 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
WARNING: suspicious RCU usage
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.012 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: TestRunner_smp-tester - FAIL
Desc: Run smp-tester with test-runner
Output:
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
WARNING: suspicious RCU usage
Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7162649935078830334==--
