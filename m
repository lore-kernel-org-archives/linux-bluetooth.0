Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B244C260A3A
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 23:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007889; cv=none; b=umRI8Dpu6gWBUds7Tt29bSvliX/qhhax0rBP7+uLN44WOBpU6v0Hu9y+BdfzXXOatMiVU5T9unK8wvCZpByfWkGFVUnZtWHumzIeAdQoLEllXMyFA0A8ZeZtXx1GES9cx9VggtmSyXiSv7N9ihuGfV7SL9v4JO3uPHuDF+QPEYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007889; c=relaxed/simple;
	bh=xebNdWYCBlcN1OxLvycFBt+/1EecgA8W3hCyqeFRyPM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oy38oRxc8/vjS1K7CJY+r/NOvbyORzNAwrgbE1PAiNQQC00insE93qwL1dmU1I2YmohCt/pJirCKDmjk2xkQQp6wgKbi1bkprtTfaZcy4AX5nmnZJ2NTj2ik4oe9XBl1WRu06s3D1CqmyzD/lNPFQMZxZBO7/AW0AIkUbub6COI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCa83Cyj; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCa83Cyj"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e41e18137bso2372066d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 15:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740007886; x=1740612686; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3HjMr8nwzw06pUEduxwnN8P0cBNT98BAzA21zMPWNrY=;
        b=RCa83CyjTuBDtZ5zUFI3qKnRuiuDUfT7IqE6Eg97JsaavVjcjSewWzA3VbffrGYg3v
         EWbjmXJe5EFoZIsv1m0MDDxLzp0ElOxeY4y5jdTO4fg0GKcxWklKrt4+CAxTqUqWkV7j
         zXNG/iwnrL159QXz6Tz9sR3MRxO7q3Bc4ewlNGh9EL/ijM49l2x/e9L1xHvC4gkxTXlQ
         b1oSQTvJEufWo6NHkOCQtZVbVtuUvyl2lFAC3RYeu9oo6RbcdJKI6cY69NxYgUJztgxZ
         CD8QTCV3iAqHu8QzVjC2C/+ldwOhEW/A7vuPr50Z9otoZ4Mu+BO4RNEIFpZu6W9qvVGC
         NwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740007886; x=1740612686;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HjMr8nwzw06pUEduxwnN8P0cBNT98BAzA21zMPWNrY=;
        b=dSdldCsu8l80N5VLydeovU97hpXm4QoWHNbF6iZ4ovYPR2clg0rhfNNKZfAJq4RjTr
         dDCQVnjBqntdn8CwuWnNlsX8/I5cmN40Ag9d3sbDZge0claYxxBUW2cH+nX/AWlpbFKI
         ewh4kuGDd9LdFS2SSEy4MDb5NDsJaSZx6lSC53PRfUET4EP04vn4ldxiN8Jk/GSjrKxI
         yeoqvicZgzJBJNUdLE1Cu4yKQ0F6Nqu6SBcGGyoEwig0R6jqr4wqPa4w50YzL9/rzliJ
         k3zYk0y8yb1bPhhI0S75imBevUKDgjKJjerTyDVO56VZWsauf5aOyGtToEVkX8BqYCH7
         GE3Q==
X-Gm-Message-State: AOJu0Yxpgvw+jqtmrfB0FxNfZgREQdTLQ4LTvsZxBJOJJ204KpE8BlGJ
	srEj0neGjeDMS5QQNHrENaHWbvnZ7lSh8hKC0rNxmzDglSZTVMGlHRpmLA==
X-Gm-Gg: ASbGncuR7w0pf9h2y/bvLRoCzj3QOXyIY5MyL0rLURa2yGL5LhnUVPxLhBZ7aWd0YnE
	oyLDs1fNR7aASSLIz10EMjhs6GarLsG1jfrJdFuAbxTnWhkTchSTsintgViM1BSCo5ef2iC0UjV
	0ZxG80mJER0tZhjp+AMEP17M2vkasDUNA/7eHkLli5LploUNQQbSvEOd3EoNihL/Hls48JQy5eY
	XIqePDsWUOdFf+voOsnOJQ284jZuFOKKE8sqzJ3/F7TJaVh9YMYwnVWl/sluY+wgdqzj36uwKTU
	I+K1M3COwdxsMybeZgQ=
X-Google-Smtp-Source: AGHT+IFrJmO2wsjOdt4L6bIvUSJ/cxl6odJkNcC55dRf8lM28t+6l1d5JfwLkgFs1U7XRbNe5+7pUA==
X-Received: by 2002:a05:6214:dc6:b0:6e4:4484:f35b with SMTP id 6a1803df08f44-6e66cceb6a0mr287786786d6.30.1740007886253;
        Wed, 19 Feb 2025 15:31:26 -0800 (PST)
Received: from [172.17.0.2] ([20.42.17.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e664c6be4csm68278726d6.80.2025.02.19.15.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 15:31:25 -0800 (PST)
Message-ID: <67b669cd.0c0a0220.18e13b.e489@mx.google.com>
Date: Wed, 19 Feb 2025 15:31:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5607159368501334025=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, eahariha@linux.microsoft.com
Subject: RE: Bluetooth: Converge on using secs_to_jiffies()
In-Reply-To: <20250219-bluetooth-converge-secs-to-jiffies-v1-1-6ab896f5fdd4@linux.microsoft.com>
References: <20250219-bluetooth-converge-secs-to-jiffies-v1-1-6ab896f5fdd4@linux.microsoft.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5607159368501334025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=935772

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.48 seconds
SubjectPrefix                 PASS      0.51 seconds
BuildKernel                   PASS      24.76 seconds
CheckAllWarning               PASS      27.89 seconds
CheckSparse                   PASS      30.85 seconds
BuildKernel32                 PASS      24.45 seconds
TestRunnerSetup               PASS      433.52 seconds
TestRunner_l2cap-tester       PASS      20.94 seconds
TestRunner_iso-tester         PASS      32.02 seconds
TestRunner_bnep-tester        PASS      4.83 seconds
TestRunner_mgmt-tester        FAIL      120.59 seconds
TestRunner_rfcomm-tester      PASS      8.00 seconds
TestRunner_sco-tester         PASS      9.65 seconds
TestRunner_ioctl-tester       PASS      11.85 seconds
TestRunner_mesh-tester        PASS      7.79 seconds
TestRunner_smp-tester         PASS      8.92 seconds
TestRunner_userchan-tester    PASS      5.22 seconds
IncrementalBuild              PENDING   0.65 seconds

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
LL Privacy - Add Device 3 (AL is full)               Failed       0.201 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5607159368501334025==--
