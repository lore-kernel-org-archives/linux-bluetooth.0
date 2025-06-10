Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784E2233D8E
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567823; cv=none; b=ou1Cb4E8ssoBlVc7Vfm/Kc9nD2d3Kkm8sTX/kkW/bShVhqYoFF0rGKwiaOA9PsYKLs+UYJL13lhQDreFmiWkmt1rcQbbQKqGlzIHI9bHdjSupb6L2N1gKVoOVQIlikya0ixDr/8A0bIC7HVjEXkVbhOE6yMHozesTIF/u7xwVJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567823; c=relaxed/simple;
	bh=ajqNTu4OOfvBz/j08LkCfRPEM88PQNOvF2+TC8zNi+g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tc10fpXe0I2SaQb4hcFfF2bBDSLHN+3yxWVg/JR/ekKZu/EXYd32LXtgvI20WRMSYW5nywj36eOop5w1UvP22t4hqVbUZhoBZbXdyDpGFevcSLm7EzFeSj0KkeUzMqCLWHOOOy0h6ZL3xAvkH2wCoxpUYsE9Itb1njSIusFpRbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGrDEON7; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGrDEON7"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fada2dd785so64651686d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749567820; x=1750172620; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OCqVGbQO9JsZYd72F8NuMKV/1GSAcKPeka+RK7p1ehg=;
        b=PGrDEON7tvRH5p+bGwxtl8UjWYLwUtrHoJQ8CH72pu8QKfSFNoJH/PsdRq80/OolxJ
         RtiVPtOBq2vF+cUG8g/4kJ9ZGp45HtjCn3lpQoCVjyVfV6xzglO47AxqWndHYrLXp7Lm
         2ebfdH3O2ZiJUvqNZuhVMRtcxbjphEffc9z2Hc9UwjL7HIX38DycC9Ykl8ihAjP0AFBJ
         7Dwf005muDX3jXAjJge28ebshNo1RlHfUq4IatiD9XdNzx4zhuykkKLo5pUtmIWGMCTJ
         ftCf1HmysSSayYy5NCB/e5+kZGfkglBCoPf3QTWaAkqRy8xPTi0IqN/QIe3w8EnEDUPH
         8T4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749567820; x=1750172620;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCqVGbQO9JsZYd72F8NuMKV/1GSAcKPeka+RK7p1ehg=;
        b=wLEDdKS24jMQ9kqD4hvavKTK+Bv35LdLZs2UIt5g+bOEjjuAY6BzQ3i5SMbP+Tx1/M
         Q9IT3qiVkdwVdNJiAYi09oFJVDtDk6XgFGmzMY7tYvFw1MPoayqx8UiXzo3kpplcL4hB
         mE2SGU59c3t6/A/XxgPez86tSktVAk41nAPfHzXfLMDL5KGTHEfEg8EL0R5dfSzqU1fc
         ZMp2zgoNSDkp93Rokfapc72mNE2oJfVloYc/zq/JHyREJYn7FawCWD7ooxjJlVF1/zq7
         iJj+M23MORANogbI9iAO/nAL3nm3UqupDTfkOTj1mWb95X6aNx6FSPVDuBMDcF81O59W
         2teA==
X-Gm-Message-State: AOJu0YwrNpUXM4c9DFpafqBX5wglwYRlyxIYle7fnVJfZUxXHMgH+Ec8
	Cyc+zd2zHjYTHrEaa7kWzOPjYGKLMhos91Q2O0ze/VQBvp8lSI7uNyCtMf2plg==
X-Gm-Gg: ASbGncs7xdetRZ5ztkAi4gRVJ+cXqV+DYFf6L2EVIiuI6U0LQGEhVufrA8JIGdBhf54
	e0pUINHrgAmwzKRVCccdqbyIZmSLrdo7gVXCTsnU7o4ig6pcwrNKa5gDthDbDJC7XIXzE15a0Dx
	Q9HdFGF1c7YGnFc5EiQm7Lhlq++V5PVoLfzUXNIbYxuDC49F3psdCevHGuZGCl8uEmbfrzcWTCR
	5r0ojR0JkLudUmHb2ojnt3ddl6LRSatMS4wdB8a3aOBne6MvOcRToMCScyV1NqtRABa7PNJ+xyD
	NVgTN4RxvDnk7EIkXJdWYSg4bNM+ceUXINzrKwCoKELdRZpx2S2k8UZpzLLfn2IFS7St3bw=
X-Google-Smtp-Source: AGHT+IHXR5khr8GItxGofw4M2RKsR0puviRmnD8ZKDMHGaaUlEhy6DuDbZbWeMtv2/rZkaKzV7XZUQ==
X-Received: by 2002:a05:6214:21af:b0:6f8:ae32:39ad with SMTP id 6a1803df08f44-6fb08f78cb4mr301242036d6.15.1749567819773;
        Tue, 10 Jun 2025 08:03:39 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.109.149])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09ac94afsm67119356d6.44.2025.06.10.08.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 08:03:39 -0700 (PDT)
Message-ID: <6848494b.050a0220.3b04b0.e685@mx.google.com>
Date: Tue, 10 Jun 2025 08:03:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8527700344425279181=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: eir: Fix possible crashes on eir_create_adv_data
In-Reply-To: <20250610142833.1048451-1-luiz.dentz@gmail.com>
References: <20250610142833.1048451-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8527700344425279181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=970393

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.59 seconds
CheckAllWarning               PASS      26.71 seconds
CheckSparse                   PASS      30.09 seconds
BuildKernel32                 PASS      24.06 seconds
TestRunnerSetup               PASS      456.45 seconds
TestRunner_l2cap-tester       PASS      25.36 seconds
TestRunner_iso-tester         PASS      40.17 seconds
TestRunner_bnep-tester        PASS      6.05 seconds
TestRunner_mgmt-tester        FAIL      133.50 seconds
TestRunner_rfcomm-tester      PASS      9.68 seconds
TestRunner_sco-tester         PASS      14.92 seconds
TestRunner_ioctl-tester       PASS      10.02 seconds
TestRunner_mesh-tester        PASS      7.38 seconds
TestRunner_smp-tester         PASS      8.65 seconds
TestRunner_userchan-tester    PASS      6.24 seconds
IncrementalBuild              PENDING   0.76 seconds

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
LL Privacy - Add Device 3 (AL is full)               Failed       0.211 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8527700344425279181==--
