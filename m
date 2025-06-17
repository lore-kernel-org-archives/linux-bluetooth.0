Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2328BEC
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jun 2025 03:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750130486; cv=none; b=dNvyN9AJv9UrMwyHWX635vulaEBxUZuZbCwn/sRECZrDDCrJOCoQtBbErEFMW+3yfCVjXH231A2OaL9YYuItsIhVQ7XUIgwXvV3IpixGD4W06n46GOTi0hToErDqmA9+nwR82B5oosM0gWvpwF8HJr48AqnJdZIq6vewFH7j//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750130486; c=relaxed/simple;
	bh=Chq9IOxhWhkJdi/jIyLY4EdBGdC0CuDxQJ/1pWN04IU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Rrv9vzmW20dHRMwvyCBAROBJ31Tp6NInzWAUKahYywAodD4/IzxzNZLC+aXR00nsOWA7m5ji1TdC1W1JjbJ+WmTcrxx0fhSOzhIGseKN7kmRICPQqigpiB3CycdaDm7vu781JRL+310MPpMnkAd1zak3B/0qEZa+i5EvkwG833E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIl/+dnU; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIl/+dnU"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d38cfa9773so550154585a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 20:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750130483; x=1750735283; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7lo51mlh7dZ1cMojc/+qfLcNtUFVjc+m+Tj2jv/ux4Q=;
        b=jIl/+dnUAxY72AUBpUdMODCMEGqnWPbklnzEU0tJuTmcQlXFVmz4B35HW4avFsLbiy
         S70PqXVPSLePCwmvmSIpOacGAHx+BTZYP/q/w9FIw6SUG5kxI6105iSzG9YaEQUxvWE8
         VcPlcKADpaqPMi5jRZg0IeZnApVNpvQ2tYDxxK79jHmdabNnA+FvsuRBmKsc3qrwNBNy
         rVD4SCEQw/jj4Zo018/1QAs6UelBdwGpdLUd012xHhZFk0XdAZjHkKkGbUe7+qNOyMpY
         A8kEXKW5fCewlsvPxFy233DPm60fR/N7mZhvWvJNKDoE2f+cnv7H6Wk9Qyvex1aUuKId
         ndGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750130483; x=1750735283;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lo51mlh7dZ1cMojc/+qfLcNtUFVjc+m+Tj2jv/ux4Q=;
        b=G7LgDs+gcJ+vMOWAJP0J7Y3vMJBVPJYYpfYJKwyEfDv1+yEmzmuXuH+Piq90LctqUS
         jBdiY7PMrbsrDnmmdSZroFj6b5daym7yJQHGBHOghgBb+6WohwOJ5nJIeDIaH0FDIQJ3
         uYKdurLhwnt4CjQ07AHR3WwfW7lQYl40KjaqZi0hlavQAlcKWfXRPTSuV7wTEeE4/BHq
         hESaoY2mfhmG66fZc+bdweIz2LexoZm8eG1rjJxGaqV9aot1uYWcKaDMP/gmAXhub+Cd
         12BtFzyMnwsEXl9BfYh6MjF5vxT+PFnrlMaUIZSTHXyqM9HN0H005/LOdOVYoMf3QruS
         rcjA==
X-Gm-Message-State: AOJu0YzYxtp/yCEtq0687Z0234bZORBKOd5zTZ6MN4TPkqvVs3JEIXqw
	txVSE4QF8uINJu0Cqhzld0Z5vgSBmUzK/aBPqmXtDLHmibQR7Dl5CBdF9G06ug==
X-Gm-Gg: ASbGncv49L90FGoEWBbS64I5uqhmQ3Smw0KxuPlDEFuX2vqTgRYmoI8rzlYYEaMLpcK
	LV3iZeM4Wohmg1QBWuBLpYj9I3enj0kHVN1tKVBSTCoGuydtyUxKwNQioNlOszXd74K1ho4eo9y
	/lcdQxtBIT2MyGutKV3Gk1AikUKAwAyLbupNWU4UQX+jI9Q+5DwxcxeUj+FRGBYXgFB1GQaQO2S
	PjuP8j+mTPrJvruEIlkkDug5scqXehhMivEUzFqx6HbrusfJT8pFhz+Wfdq/TmYtBOiY8ufUN1F
	N3Yjs8sAKeaHb6rIAavk520h12LLV7gHw/Bcc9fWXXoOozUnntUmNLWVJAK023HkWwJI
X-Google-Smtp-Source: AGHT+IEgF3EaVmFcsmozPFn2v8s+7KYxv3X6j+SapWVOGwd2F6tyiIdzhwjLDhcM2o+ulO4HRh6Pow==
X-Received: by 2002:a05:620a:718e:b0:7d3:d732:d4bc with SMTP id af79cd13be357-7d3d732db45mr597226585a.32.1750130483360;
        Mon, 16 Jun 2025 20:21:23 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.31.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8eacccfsm601392385a.66.2025.06.16.20.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 20:21:22 -0700 (PDT)
Message-ID: <6850df32.050a0220.1c9752.77d3@mx.google.com>
Date: Mon, 16 Jun 2025 20:21:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0942202981697724952=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yuehaibing@huawei.com
Subject: RE: [-next] Bluetooth: hci_ll: Introduce hci_ll.h
In-Reply-To: <20250617030616.3642576-1-yuehaibing@huawei.com>
References: <20250617030616.3642576-1-yuehaibing@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0942202981697724952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=972761

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.18 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      23.99 seconds
CheckAllWarning               PASS      27.11 seconds
CheckSparse                   PASS      30.38 seconds
BuildKernel32                 PASS      24.39 seconds
TestRunnerSetup               PASS      455.77 seconds
TestRunner_l2cap-tester       PASS      28.28 seconds
TestRunner_iso-tester         PASS      40.31 seconds
TestRunner_bnep-tester        PASS      6.03 seconds
TestRunner_mgmt-tester        FAIL      136.72 seconds
TestRunner_rfcomm-tester      PASS      9.31 seconds
TestRunner_sco-tester         PASS      14.80 seconds
TestRunner_ioctl-tester       PASS      10.12 seconds
TestRunner_mesh-tester        PASS      7.49 seconds
TestRunner_smp-tester         PASS      8.68 seconds
TestRunner_userchan-tester    PASS      6.33 seconds
IncrementalBuild              PENDING   0.49 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.201 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.212 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.206 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0942202981697724952==--
