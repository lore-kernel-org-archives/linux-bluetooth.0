Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7463C53A7
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Dec 2024 02:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735007721; cv=none; b=jUeVzRe98nH4ZsLgK2d01zmd8Sbg4OKqsV6GwUc0BaOzKbcSgeR1HGLfsD0eD4lb547/accawl50vR7yU12SH7qVrghWQBVUED0z0fJ78mzKL9Dde4GR+VHCSiSRu4wLmBUAVGX0UrcW9CRgc+hrRIns+kLNofHjARkV6NNX+CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735007721; c=relaxed/simple;
	bh=ynMM+UA85r+ok18ao7dhyaetot5WwAyL+BauaVkLN1E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Nvo2j19eKmssOw5oCOf9dS8PfehTqxkYhh/CwChM81RjJ4SEEBaambd1TVkx53sw885Jnryxj/Tx4z9YEb6ScsEn/JDY1fyyhYmdmzMbtnzi6c1UpdIAnpjUScQHYbDzLMu01swPDWS+QfCtmrrGlrtt60YKM5E5414fNGt01vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgnZB7qk; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgnZB7qk"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2167141dfa1so44421455ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 18:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735007718; x=1735612518; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zmnfXYDOe9gAFJuhEffMaYmIBBoZRoh4117xv9tbOvQ=;
        b=MgnZB7qkXki9j8sliumE4lg4+LjUHbeQ2sGDS7ag9OgEtXbiRmoFTKTfSZNtDObR9f
         shfutBndk8nx2mxYt5krXpxmn2VNca7yF9IzTgXwbMr/dISI08EH5MjvudkOVDc8jBYd
         ffdTvJa9UCAvQf7RsHPVf+IXoFDLYRdA10ZwwqtDPISC5LlIBBr2+tYp3scjoGbiYnOD
         zQ0VlI3YensK7o92Xd3F8njZeh2awkR32Gpw1at6y7mH33lirbilpuheyu4uXl3z8Es2
         2kPa/CMfyyUeCUdNcS34MIcuqCnXCoH1NEZrF7gkgRviXECeN/t1SQPzoY25k9w/413m
         4A3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735007718; x=1735612518;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmnfXYDOe9gAFJuhEffMaYmIBBoZRoh4117xv9tbOvQ=;
        b=vG9J2AIFI2hYEmhGpqkA4l3dzSWHU6OHbEbPgG13zQCObP9awfD6tUdlevgtXe0uwp
         yl+TBKUaxRtsdzKwQwjigc6/BCzMoajQKysE0on7yg+g7+LId4YdKjh1jqJiLxhdw8Sa
         e/kj9B+vu+fHZjfwhlSCNIRRQdj9f1PhIe/FMk3vSwoYA59b9CaSj+PuNp2wcd1aXW2X
         V8zRXYhpWFnWykoAsFEozOhT81zf3fWzi1hvaSAQVz1VEaNoA0M84I0aLqIoZt4Bs2dY
         jSxC+DDxoOtWH+vG1TCmXmisWj/akXh7+uTrdCVE/3qpng86fyvZCU8hoq4mfI0WXxsV
         N6zg==
X-Gm-Message-State: AOJu0Yx+q4ePmF8MyupQ5MJ98o7Y2fKSe9mFo7LAjKHiNPiyWrhbM4AR
	yW6pZ2/YhFk3gN+vG0sdVPovBvlrn5geisXqAzb32bberlvE5ONlS6PjAw==
X-Gm-Gg: ASbGnctRppEZU/R7K4A/zoXLiSB1Apedsok7crsIqmC0if4tqCfAv6icviLD1cBhH3f
	Wrh9+QDb5ZQGSFbuBBXjriBtEHkpUaaubeyN4srL8XFi47AQsS48e3Tb/3MXllqBMRvjYVNqGsP
	RZU9AwqVaO2s6Q8c+PFI+R1Hnxru6jIn6RmTFuNs2wBNWnFZulo7Ex3TIktPxvb3WGmizvCkLa8
	MMCK/t1qfcNaugdO7AoLqpD3/mffuOeViQ6VGscCho+oTD3XtxnjDEQ8RtbM0c=
X-Google-Smtp-Source: AGHT+IFWVNZpP6mbcKYbJN67+vb/4EOI6en757tbjNRkJ7oLvNmWvvvgZ+V5kDP4S+XIHwD16ZsPYA==
X-Received: by 2002:a17:902:f64d:b0:216:6db1:1a6e with SMTP id d9443c01a7336-219da5cdf93mr306613995ad.10.1735007718245;
        Mon, 23 Dec 2024 18:35:18 -0800 (PST)
Received: from [172.17.0.2] ([52.234.33.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f842esm79822035ad.218.2024.12.23.18.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 18:35:17 -0800 (PST)
Message-ID: <676a1de5.170a0220.14f72e.93df@mx.google.com>
Date: Mon, 23 Dec 2024 18:35:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0851499925787095825=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mazin@getstate.dev
Subject: RE: Bluetooth: MGMT: Fix slab-use-after-free Read in mgmt_remove_adv_monitor_sync
In-Reply-To: <20241224020616.10885-1-mazin@getstate.dev>
References: <20241224020616.10885-1-mazin@getstate.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0851499925787095825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=920604

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.18 seconds
CheckAllWarning               PASS      28.38 seconds
CheckSparse                   PASS      31.68 seconds
BuildKernel32                 PASS      25.27 seconds
TestRunnerSetup               PASS      448.46 seconds
TestRunner_l2cap-tester       PASS      20.71 seconds
TestRunner_iso-tester         PASS      34.40 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        FAIL      123.56 seconds
TestRunner_rfcomm-tester      PASS      7.73 seconds
TestRunner_sco-tester         PASS      9.46 seconds
TestRunner_ioctl-tester       PASS      8.26 seconds
TestRunner_mesh-tester        PASS      6.10 seconds
TestRunner_smp-tester         PASS      7.07 seconds
TestRunner_userchan-tester    PASS      5.06 seconds
IncrementalBuild              PENDING   0.82 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.206 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.181 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0851499925787095825==--
