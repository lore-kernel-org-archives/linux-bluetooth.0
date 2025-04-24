Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A00521884A
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745526910; cv=none; b=N0RCMboXaoqFw9kU5iwFhSQVoaRRCGhr+GgLH9Wk0Y4uJ04Wlk1NDvZY6p7OsHmxRM7v+qjy36l+/64HzKDeLR3mJLy7SQn9NjinKLWTPi+Utzln7FYacPIR10X7JwvWopUf/4F0xxgV99hP9eaHIGLEodaO4gdq2ha6Rg8bGUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745526910; c=relaxed/simple;
	bh=YPNIqdNmTkqynf38nVpFcHQ4BM4j5Ub4jO5qpSR/UPM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lVWexT0LOzBWSLFSJrTmDzuF0XzU0wg2LZD29urtTeLzf/pUeRObByLhQyBrZ9+af5TkMVxfNmP9advNSrD1PTC4kwTFeSTkAFzj9sW7UbxI9ZjSOwWUtbgF6PjJvqmtMH2RgKEBHJQzs1H2bBfFJn6bc9nG10ig7+hY+aUBtGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDriEWEN; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDriEWEN"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5e1b40f68so157053285a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 13:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745526908; x=1746131708; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ewbVOZcHB0hRqeGMP4zfkX/nK+3gVShheEvdJwf5cpE=;
        b=bDriEWEN6GXXWc6ZXNBxt7wgEUjINXP+ZeNcZuBrdhkHqLR/tLZkpnVL67W8mNmHfk
         Xc4KwiDSnld15XLPh6UNL6hoFg8cCtyjMblkBIXUaqY7iUFhk7d0SIoHRmVyevTFbdjC
         S9pD80Lcu8v8QJ9dA9BvoSc+TnsPQiSO1zEeFxv/zkVduT5pWSDQeXXf7TmIHfyEDPbu
         q9egzpbwAFDLBGuOyjJ3+xlwtuWyRZsxBkt6S30UB7RgJHHRgmMuohGHOBYMC7PERWFf
         /lMd2Ot4okH5vJTj4UZDpVV2v97eYQtskZREqF0LWVDK6MoCtReKpejzaGH0lYhpqk42
         jfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745526908; x=1746131708;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewbVOZcHB0hRqeGMP4zfkX/nK+3gVShheEvdJwf5cpE=;
        b=Zdw4DGA6ejXU9eRqU/Ew8coM6UX8QuXSxOq1YakBmFrMb5Z0SGq528s2F1A37XqnkX
         zjyRr89xR7pLOZtxXdZWZia+x8x5jigQJEu6GCT5bSOqFQzfjUs/8CSjwM87R7Q8/fiM
         6uDW0GY/gmLU0j5kxRitQJ3+d9TIa5egeqNIch7C+mzXMT/1EeRyU4sHzNdFvC39PoeH
         yCSbYVlq4rGDIctRhyic/sNeir4B+aAjZHr5jj/ap/JB4K6DvINZuVVQGZSmo5Iuba2z
         i7Au0hNssRo0CXWYRKsuoxW5MC4un/Lzl98+d3dy5TsROYP0mL2UJ4S96dlB/IUzUp7N
         XJGQ==
X-Gm-Message-State: AOJu0YyqAveR44Z0KjA0TWY479OP9Kz8Z9AKfPqXDzPkBM8lEpgy1C4W
	wKXyo/qjvEkWR1oQMvFFNCrDF/STHlPV3fHRKmIdThuFQL4jjSTZgBybxQ==
X-Gm-Gg: ASbGncs7t/0q4kFyPyMAm6Q1jI7s9GsN1fj0ZOlVXJRcue4cCKOEeQSqEyvvRA5q/X2
	DYK83mMFy5lNT4rO7PAy+MUYK9mBuOVQCJnCjAxoURRkdhSIMLVrhLIs8qsHtNEBaBWtQ1ZPmZD
	t3T5ALpmj6fMK0i6Qmqcqxla4TKNafjjT8WJHU+99DUslJvtzbolouReqZ75M/t60wb2ggDTpwB
	riJjCsi1gaEVSf2ML+LcHHq3uoc9/gpXayqMAyLNv6wxr0Cf6GT0+XQ6mp35jshN5avbTY5voSa
	9wrSkndK5Rng5iC15i2MU5qPBN7hbc+M2fqVfzSyFX0n
X-Google-Smtp-Source: AGHT+IGn8RwBukJ13NtLXBiTIjwcMQVzEGJO38ETR2PDgoG4G5DvQQXxIpXf3mbW+Glg5jQtYXZR6g==
X-Received: by 2002:a05:620a:d87:b0:7c5:4711:dc51 with SMTP id af79cd13be357-7c95eed474dmr118781085a.2.1745526908012;
        Thu, 24 Apr 2025 13:35:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.14.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958ce4e97sm131470885a.65.2025.04.24.13.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 13:35:07 -0700 (PDT)
Message-ID: <680aa07b.050a0220.333847.6e37@mx.google.com>
Date: Thu, 24 Apr 2025 13:35:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7990527437531695204=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: L2CAP: copy RX timestamp to new fragments
In-Reply-To: <01117138d56019a8598f24f0df2dd289713cfab4.1745524193.git.pav@iki.fi>
References: <01117138d56019a8598f24f0df2dd289713cfab4.1745524193.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7990527437531695204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=956750

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.69 seconds
CheckAllWarning               PASS      27.05 seconds
CheckSparse                   PASS      30.42 seconds
BuildKernel32                 PASS      24.25 seconds
TestRunnerSetup               PASS      458.00 seconds
TestRunner_l2cap-tester       PASS      21.12 seconds
TestRunner_iso-tester         PASS      33.21 seconds
TestRunner_bnep-tester        PASS      4.72 seconds
TestRunner_mgmt-tester        FAIL      117.13 seconds
TestRunner_rfcomm-tester      PASS      7.83 seconds
TestRunner_sco-tester         PASS      12.48 seconds
TestRunner_ioctl-tester       PASS      8.28 seconds
TestRunner_mesh-tester        PASS      6.04 seconds
TestRunner_smp-tester         PASS      7.16 seconds
TestRunner_userchan-tester    PASS      4.98 seconds
IncrementalBuild              PENDING   0.78 seconds

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
LL Privacy - Set Flags 4 (RL is full)                Failed       0.244 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7990527437531695204==--
