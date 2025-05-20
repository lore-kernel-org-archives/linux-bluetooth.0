Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72F125E46A
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732018; cv=none; b=sbnoG2lHLx0grz+olRFuq14Uh2wD6cXx97AKVQDtctBs4RYzhJt8U4C8rnDXJvTKLt2kQHuJoYl6JAgkfBPMJUtLi76tMIhV2KdwDkaN+HhzsdCznyXWpShNP7qRg31lKtc0N5zevt69hbzdk+wEgDUfQtEgy/oenL/BRd42JYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732018; c=relaxed/simple;
	bh=8tQP0o1RI6YuxO7SlLkziJc3Qvy7s2cL8Q0Ad9G6VgE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=H1L9YNnd0o+lbzdZbmn7pecKkxG4xJDEMkbg0GylmdBU5gwpQh4B3IBEUrik1JhKRtSjkxYeFhdD6Eob/qOJRR0gThPQ3A9niGea4SQZx8Vb6SEc/OK4vEeHYQI1UFqej3L/1aplF0YyHtPnWoUsWg5vKjFYXrr4FxfLVmWxRyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjgbf91m; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjgbf91m"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c53b9d66fdso761653885a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 02:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747732015; x=1748336815; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DG1lVOR8AxBIpKjSuIhLm+FUA6TdOrydQGZ6rFraKLY=;
        b=cjgbf91m7UFMTeGYysT3THqp+JWCWvAUvhzKbUEEVJ043YVmFXDKXySieyN7lnFA27
         54oX8WI0U07CSWo909wPWr98hTO8m8MAK2kPyS8R3yWtW6HVPYqf1RaQIIOIfAO9geuH
         gzJeK6B98JQBJRIgAHb3gTB7nDK3bg5CRlAlXEXHAb1qQEQtSEI5200wBQ/073MLNah4
         DCmb+Z8POPWNUGzggKF20xkmtjfWZ9nb+ORF1NErZmrp28aGiC52pv+kvMAObLQHrwQt
         M4ORxjziKaIsXLM0Vt7c+Xxdt5mGo+ztQ6aYPn1FWmRmAAPc5kxgZKsqcXlzrX+MCftI
         lrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747732015; x=1748336815;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DG1lVOR8AxBIpKjSuIhLm+FUA6TdOrydQGZ6rFraKLY=;
        b=eHm6ivZeNnPIAa8v/F2niHzzoMrx8r129/3HF+j1+3+WerD+Qr1YEouLx1t2+U7ZER
         NI6lJJDKmmMWFlofVtT74X8MNQvaYZFrHGbHInWHDexuHZH+nFWb39eERvC3QkhqujfK
         mzJtniZvQ4kKAXAt4K0ZdvMpcyErXY75MG4LVnY0iHRfJYUdm7blO5gdZ36uZWSzn7kl
         PNSYoeZol7qeSY7EBpf8uw0SHGopVm+VEkBLPgwjn9jlxAoy+5bc0fZeY38ze5MkBjGg
         AwhuvXd74zkNeKCeLZdepw2TKuCcBJHR9quheP3k969UVgIzCG1hJh4LLcLq2gHYMMEl
         lGDA==
X-Gm-Message-State: AOJu0YzTKZ8TuYC32ueE4C96nv+E/fYXWkXW7ZTUivuCjGwIGYmFm4uk
	yLTZCosYNQG/VD8epBqhzEYPfB2R6oMs3xBqLGnV265YtyKcsZCbsjG0TFGqRw==
X-Gm-Gg: ASbGncsVKtA3RCJOGuqOD2SSo7UyGzwcUcO9R6qBXccCvhKzELibP++Tl3j5Qjd8/9N
	FS8EjZ14BKp8GagQf4siV1+Bd1StnoabpnA0OjMk1x94z603yIfkum9eSSJRh9rap2zRTGon5uq
	6vwzT245Uom09zidhpZANX5XRk0RFE2i27vJcmHW0mERLoseRvn1B5Kmuu3nlrlj3jlDnxioz+H
	vJbE1aXIu9j1yk+RsqaOu94P5FJKI+IU/D+CbdO6c2CysdqdJ/2Gqfw5OaAuJNV4I8buSQHk+o3
	qeFoUk0u6NgMdgYaNTusF6KSrTzTcEDUHLULq4x8R24CbOZ2qvD0J0iOMdM=
X-Google-Smtp-Source: AGHT+IGbw4og10nnv8RPfBxMV29x1vWu9P3EogvpBuHuOfvw2HAEyZoK3LBbAA8/QhO4NmSptiK7bg==
X-Received: by 2002:a05:620a:3945:b0:7c5:3c0a:ab77 with SMTP id af79cd13be357-7cd47ef13b3mr2676803885a.4.1747732015348;
        Tue, 20 May 2025 02:06:55 -0700 (PDT)
Received: from [172.17.0.2] ([135.237.129.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd47c2d217sm688460085a.92.2025.05.20.02.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 02:06:54 -0700 (PDT)
Message-ID: <682c462e.050a0220.3c295f.9fba@mx.google.com>
Date: Tue, 20 May 2025 02:06:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0905720361001881077=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmantipov@yandex.ru
Subject: RE: Bluetooth: MGMT: iterate over mesh commands in mgmt_mesh_foreach()
In-Reply-To: <20250520084230.502667-1-dmantipov@yandex.ru>
References: <20250520084230.502667-1-dmantipov@yandex.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0905720361001881077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=964481

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.58 seconds
CheckAllWarning               PASS      27.41 seconds
CheckSparse                   PASS      31.05 seconds
BuildKernel32                 PASS      25.19 seconds
TestRunnerSetup               PASS      461.99 seconds
TestRunner_l2cap-tester       PASS      22.44 seconds
TestRunner_iso-tester         PASS      28.91 seconds
TestRunner_bnep-tester        PASS      4.89 seconds
TestRunner_mgmt-tester        FAIL      118.96 seconds
TestRunner_rfcomm-tester      PASS      7.88 seconds
TestRunner_sco-tester         PASS      13.06 seconds
TestRunner_ioctl-tester       PASS      8.39 seconds
TestRunner_mesh-tester        FAIL      6.27 seconds
TestRunner_smp-tester         PASS      7.23 seconds
TestRunner_userchan-tester    PASS      5.04 seconds
IncrementalBuild              PENDING   0.85 seconds

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
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.135 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.119 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0905720361001881077==--
