Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8B12AF07
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981443; cv=none; b=dOTKJpBAil/VSi6Yr4MaljhGtDA4ajd+lb8ynqURrk3+POsz4yvJetWsPTNAYt/K2ht3ppA8bLtqDZND4NeitAdr8wyYfEfMY3hqbagqcvrEJqdJTbct4e/xY9G1CW9Day8mk+RZptY59bn3wGVB+SPa0ETKhv5IR6DYDxE4do4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981443; c=relaxed/simple;
	bh=36K33FkPjNtBJ0BolWBCa+ZprLZk1wIrY2f+7FK2MbQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FKqdo/cpB+WYyy/HwaxGJWIPgqwQaS7iG8TZRiP/TBALXNv4ffddAh+78AZNwP5d2YNLELoqiOSQB5WNoJBnhLE1Z9A6PmwcCSFefGpYQbI19t7393V6SAPkTjktrrvUTFz/NhL5Aku/HCIBQLqRh5z4JPZla1yZVfgetFEtaqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELBlIYBr; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELBlIYBr"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d21cecc11fso851775685a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 06:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751981440; x=1752586240; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cqvfr9UJZuLgWkPkYhV//XczDAPTVYDz8DTSNIiPskw=;
        b=ELBlIYBrkPu1SXakS5aDnnhpKmc8rRD2YeEoM82dJxpbatfwTSmIDJDBuo1FPsjIWf
         VMvOnagZlLACdDMHFNL6kje5rLgnah0SYuwCVrDUgoNo4Nmxx+e+Th81vzuxQeJGWxEu
         NUYzxD6KhG44W9mtvazQ6cTCfKOgArBIJLYjy0kLRtXVb+X6vWR+upb6llEPM4jYbW10
         1ZgqOSrCrSR/9+3G2Hc5fe0mV6ldxc26bqrTuGDw4nIK5J5qBn3GTKZKYcO0a/oY/mhs
         qbL8qcal5FTmn1VW9pk4CzsKkR+8LKqGHJkzwQ92CVkBmMmFxHzf+nKRZow5jUw1JgwB
         y76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751981440; x=1752586240;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqvfr9UJZuLgWkPkYhV//XczDAPTVYDz8DTSNIiPskw=;
        b=aVttApdiAmBFFAaI8a8UgIDmvjUJilXa8sdGleo7g9e992U/HRBLkRSzqxByCVMrtq
         bzip4d+bfo+nRY4gwCaLn90oqvT/+F1Rllh4WhU6e+hmc9HNhP1PaXeH2uySd5meSQCL
         QYEAmfuxtFCWYOWAGGOYhl/5ZZgEN2Io3p2EMwSg6kGnxtH4FeUU1U5S5AZlQD3QUqvp
         /2jIT+8Le3pLVQT6ChyURE2LhCBbUCrv9m0M+onw+aaMpG3rnzEHvnnF/HgH6CYSo5c1
         7kWFXAwWEZGqKToeQV/WtMPvBHqPlY54OwW62U2WelfLvO/dwpbGJxAFF2p2QZ9/m9xF
         bbTA==
X-Gm-Message-State: AOJu0YzsxYyNvn8f3q25ZQsDQwcuIYalq0W6LEtijsQV1gjcCRJNiV00
	lLbtroj1GWNiaQP5nZxprFmXES3Kqh5Mc12u699dwaHrf9BTxdOqBTSAZwTYtQ==
X-Gm-Gg: ASbGncs0WM0j/rUfGd+RguPpl80P5sF+qLCC56IJ5x1l2JYM6ByE4Ma/9buMytMW7zw
	OVBRPmZz2fHGG881mKJwbRWatf0uRCbzvBoAP9WonXn8YWBiOIZbs9CjrsVf7Cm88kUxsF9HmIX
	2xKOvfypeDIbS6TI3HZGHXo7RIUT/DwAfQxqI+HrSZUDoAt4cpfvPKusMow0tMSx50Ec2xEhncc
	BXsNL9hUfz1CuPy4k/1+oUkU4droLsUiAuHW6mVUFjryTluXUGb/qgjSmjTVq6k7ZoqLsPJJktG
	eIrP0wDQaSDHvZzAW2hruJHzEqbUW0CDHyWC3grBna2sdIHNiGhcXl71iM4BpnbBoQ==
X-Google-Smtp-Source: AGHT+IGiW2qTJBFi1e1+0uKzyy1ymdm6R9FfN1xzR8Wer3kq4BOO6Gn9xOCO+JzOru+6clKQgtqtUw==
X-Received: by 2002:a05:620a:10ba:b0:7d4:3ac2:4c4 with SMTP id af79cd13be357-7d9ecc0b7b0mr406864085a.50.1751981439790;
        Tue, 08 Jul 2025 06:30:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.134.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbd93dcdsm786419385a.2.2025.07.08.06.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 06:30:39 -0700 (PDT)
Message-ID: <686d1d7f.050a0220.2f2483.d04c@mx.google.com>
Date: Tue, 08 Jul 2025 06:30:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2447362569324758144=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v3,1/2] Bluetooth: btrtl: Firmware format v3 support
In-Reply-To: <20250708124516.2836881-1-hildawu@realtek.com>
References: <20250708124516.2836881-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2447362569324758144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=980045

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      24.07 seconds
CheckAllWarning               PASS      26.45 seconds
CheckSparse                   PASS      31.10 seconds
BuildKernel32                 PASS      24.17 seconds
TestRunnerSetup               PASS      479.60 seconds
TestRunner_l2cap-tester       PASS      25.91 seconds
TestRunner_iso-tester         PASS      37.12 seconds
TestRunner_bnep-tester        PASS      6.23 seconds
TestRunner_mgmt-tester        FAIL      136.41 seconds
TestRunner_rfcomm-tester      PASS      9.46 seconds
TestRunner_sco-tester         PASS      15.13 seconds
TestRunner_ioctl-tester       PASS      10.40 seconds
TestRunner_mesh-tester        FAIL      11.54 seconds
TestRunner_smp-tester         PASS      8.79 seconds
TestRunner_userchan-tester    PASS      6.36 seconds
IncrementalBuild              PENDING   0.69 seconds

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
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.233 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.939 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2447362569324758144==--
