Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E7D481B6
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2025 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738156440; cv=none; b=OAjqcazumtPJOgfkfytL0rLrHbfR94jesQPoGlox88huK9k/rPfAnTqLl8msvwXv+RRB+RpkdcBg69HnwmAZaePAKm3e5FG3cFo79p+xqfAn58z81FdnP+jcZOY5czwbWvaEKxRzw56VgovVxazQTB8sMb7/4sVSNPwJlhjKjAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738156440; c=relaxed/simple;
	bh=WqUmlQOkDHJzOpNHwj/bqbwYMvwcWB+pA5Zt/UgcHIY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bqoQQsaxYSlpRAvPN/V4YsC7gHcwJclGlZZEg00fGmYa9YIfXLklJH4yH7Zj/BLWf1QBHTLXf2Th1vfWnWc3LfqVsx8WZhwGwN/SiT/rCAHhwluLdGhadEBytRgKFvhHda7UwoVHDzvcdzPBc7/zoGBcJNFqP9JVRSam8njwLuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SahE8LyP; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SahE8LyP"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d92cd1e811so5807296d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2025 05:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738156437; x=1738761237; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jbgF1G5mx1K2mBMy/AMoi6NUuqholcHZv1/5CmwImd0=;
        b=SahE8LyPw/TuLUb3ZPGEvJenDneZCzNRJr+aPsPeE6g01oy1gQ9xV1AfSXP8STXCbH
         yl6F/fMYV5OravHpXTvMe/C2l89WHgjaH5qrAeJttB2yEs3tTpV7IlBrOp9Wfiy5/inq
         X7CXibwN9jaZUx4KpYvSZMqm7kT8qKpmBtia4hzuT0/Zop7XDI8x71EJtxxfwHEICwD1
         iAF/8Pz1UszpQ7sZaEmv/NGQ72Hh5rqSQaXKCUN8IpWhiMn4oco2WGHk6B1nEUkCh8dw
         7ULyYRqFYOMSGAmQJFpSN/Z8BO5LKrkhlepUtetdgb1DhjNCnHwCUp3Q8JuKQeIQXLW6
         8Wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738156437; x=1738761237;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbgF1G5mx1K2mBMy/AMoi6NUuqholcHZv1/5CmwImd0=;
        b=k2kf18gWlYMR+gaO1l7qWjwTrqRVk79U3wI7NWJaCHw/nqD5lzgViqxmclp9esVgWo
         CpfmHUxt2rkR8LeuBWfIPt+Ypdy/o2/WclcHaMcV7FSH7gs/sr6bpFhypFIEELzSSM2n
         wB97b3pKb7sPDe0FjeSfXt/vxhaqlIXj8dCnluIjopm44RGmiCc5DHCZAV9/ABP8wMZx
         VhMXl30cBYH7yFXnLk0OPSD1dj5+6L1nkP1uc/JO3PmTrwdnDJCHmoY8N1Kr4Pxiyais
         wqxfMXcqCPWHv69flCu5mXQuDnVC9i16mpNY3kgaYV+5F9T/Mj/ZOZ5gX1CttL6vTjLc
         /UJA==
X-Gm-Message-State: AOJu0YztU3sLurLsrf85suB1IR4t1Gc4d9S/JGg5ojI8WFAvLJhim+97
	nSxh4pecdhqpNqZVBAAcPve6O4DqG30jc4dxa4ceATv/nobQCblHGwulGg==
X-Gm-Gg: ASbGncs+BzFMc6NbDVL7PrJqCQ/CNaZgxmFwk1AN2GOJd/qqe/fTJNrAP1sIEUureQg
	94PGcR41hYi6IQPPdrFw5Pra2G1MiLhqLSNbZji4+vPCRHVw3ywtYUShEeYScMcNF/QVtC3c32+
	UwAa4XhnRkRSgJFJ5zop56XvlQJ6H4DUBbsUS1OcfTA+IRenF0DqAGvFcTxeHDRRK3wkM0675Ax
	wgCWJQVUL7P6ceCobtKbNEou82yEG+fF8eo5IsSR7Wyzb1qRwMs9jdQxEjslxVYIL0ByzpgMr23
	4Ccoxs8NIismAdGKAk+m
X-Google-Smtp-Source: AGHT+IFVdlZQ1oC3JpLIy1uhRFMVjnoiWrb1dDvjgaAiNGG+o8d8jmPfOwyceB3dwDQnbBOxSCPExA==
X-Received: by 2002:a05:6214:5f03:b0:6e2:383f:4acd with SMTP id 6a1803df08f44-6e243a4486cmr52317866d6.7.1738156437111;
        Wed, 29 Jan 2025 05:13:57 -0800 (PST)
Received: from [172.17.0.2] ([20.57.71.204])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e20514f426sm55172746d6.38.2025.01.29.05.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 05:13:56 -0800 (PST)
Message-ID: <679a2994.050a0220.215e2e.5eb6@mx.google.com>
Date: Wed, 29 Jan 2025 05:13:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2575245141049649148=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, deaner92@yahoo.com
Subject: RE: Bluetooth: Fix code style warning
In-Reply-To: <20250129123330.391567-2-deaner92@yahoo.com>
References: <20250129123330.391567-2-deaner92@yahoo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2575245141049649148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=929064

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      23.83 seconds
CheckAllWarning               PASS      26.66 seconds
CheckSparse                   PASS      29.69 seconds
BuildKernel32                 PASS      23.59 seconds
TestRunnerSetup               PASS      423.37 seconds
TestRunner_l2cap-tester       PASS      20.23 seconds
TestRunner_iso-tester         PASS      27.40 seconds
TestRunner_bnep-tester        PASS      4.82 seconds
TestRunner_mgmt-tester        FAIL      119.55 seconds
TestRunner_rfcomm-tester      PASS      7.49 seconds
TestRunner_sco-tester         PASS      9.28 seconds
TestRunner_ioctl-tester       PASS      8.07 seconds
TestRunner_mesh-tester        PASS      5.93 seconds
TestRunner_smp-tester         PASS      6.91 seconds
TestRunner_userchan-tester    PASS      5.00 seconds
IncrementalBuild              PENDING   0.41 seconds

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
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.161 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2575245141049649148==--
