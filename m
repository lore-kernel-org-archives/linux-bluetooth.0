Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A8017BB6
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 May 2025 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748707003; cv=none; b=Od8KRXOU0jG/qwi8JT+cmIf6oerRhMdQmKOZ/+AuTDy5VFHPGmwdpqWYmReXjuBaVgLmZFEb78nNXRs+8dacglkawFwCmGjnoOyDL9HymJlZVQbF81WoMP4QlqUrnkcq/WJvOeYhpdsKTw7AIqZGFfyks6X0UBCV8U0XI0wPTmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748707003; c=relaxed/simple;
	bh=TnRoqr/5fAaFNAkGTiRwH/e4NUZxcYZGPcPvmkwI6T0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=h3Atq3bBXLVPfHOuDYD9b1vRiRT8ircxBm5b/d1Kv6kgFixWs5LgIQCuzkQWDts5X7fKpsVgcba6U8LCXqqE7ck7c8joJ0tnL5JXHJPjPtlkJj3YFecyul+u4JXMjFSaHSWjTIgOacabcSl08bKicFgULFyKPogfEHFjDPwR8hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkHpzGCH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkHpzGCH"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22e16234307so25831705ad.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 31 May 2025 08:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748707001; x=1749311801; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5BmnYURfYeGdk/uq2EKlrxgKUEfLmdifEfRiWqvJ1qU=;
        b=JkHpzGCHbT01gNZjQOEngndaevD6aqBHpuaFLG9/HPyCUJFrmU2VcND4EXWCJCSw7N
         XxR60cFY9lxHyJmBlhJjHotft5h2s3l2KkCf8UQEE0JH7dpvThSkPpeXiu/T5pWAF4h0
         CpC+fSSW0bjsTo1onaMdRpSKVkHneyAhIRmANN/kTsaD3yXlML95RkyvMT0EfRuuZ4BA
         68jpfSCpCThfHZv74c2d9s/K+eJjYcS0+ojcxTVnoI9zw/Y9DuicKkBnl3FTaV4VULk1
         nJMpHts2hhYwJnWvxg+9DMczTiRSeoBZMGgfjfKm4YlYiOxEO6z2nHbIaJW3tYucj1/S
         dMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748707001; x=1749311801;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BmnYURfYeGdk/uq2EKlrxgKUEfLmdifEfRiWqvJ1qU=;
        b=mL4T17FeJ4HOqWt1GCfi0Q5d+FC+mXNQwKc4PCBi4oZqrpvEPrrpo4NjMvRpzfyPBg
         tOcWmmCj7ZtgN16fVWH2D3rcV4aBxf4S3madMenhxmYhvncUDZygHcBkYjMQVADiw4rk
         w8Eu3Ji7zmGYLe20Zoi1O4jlNbd3rSxM/SsmWCCUE/zGbazmmCZijmNm17bVhmp3rlKs
         uHWu5yWdLEPXZIlHuD5c3F4qvPxYjwVotSAd275D0hcXAsRVS1JprQABs5rQh4UPmbyw
         3wQQXHiKn2Bxr7CN+oeSjI7cyfN9P6ZAD9OJTvNGzVz2dCWHvo98L+wDqWFn+pp6cm8r
         m1NA==
X-Gm-Message-State: AOJu0YxlfQJTDB1kD1emrKPGPZaQmVWuBzvwx9w5CR6x+EKMsEhFLV5i
	P9Kzcr6JjK6UtXwv2xw/FqTRVnJkVrk6QvkRfR2iVnDepqlfROsP/773ObWYeg==
X-Gm-Gg: ASbGncsnOwZtDNHG/dCNyh1/yA98WSLerxW/1q2bjj7F9aeEfDjZJcotfI6rgbG77ct
	bvMkqJDSguMpJ3376QHjRMoHaumuhLg5HU5mGxPuCrVPRpU5WNmWV77BqLgXlrUKajZtowWcnfP
	fI3FhWp9r0x+JHLEUpR5Rp6rBFJcDR3MIwL0ltiMkbfwlN8hH+ReI+bYMopwE4OxzBgKA/aIEj7
	LjlT6iC9zrnSbBHjwi0vTJ9Kj8HWM0EUERTDjGTF5rH5sgTOngmr1iB2TfL/+tWQrPHxcVDCW+u
	5LOQNkr3BmHh/e/5mfOJVVpZRvRyl17tG6mH9ljJnql7Q7eTQtD8RIpbHA==
X-Google-Smtp-Source: AGHT+IGI0iHGqbQlpYBx3VVtswkYXYHxf6HfMaRoSb1KnGRQhufkgAbbh916cd+ZaxxpbWT72q5stg==
X-Received: by 2002:a17:902:f607:b0:231:ad5a:fe9c with SMTP id d9443c01a7336-2352b06d3e7mr97625095ad.15.1748707000794;
        Sat, 31 May 2025 08:56:40 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.77.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf9543sm44155265ad.209.2025.05.31.08.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 08:56:40 -0700 (PDT)
Message-ID: <683b26b8.170a0220.24050a.b786@mx.google.com>
Date: Sat, 31 May 2025 08:56:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1717934838012590845=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: hci_core: fix list_for_each_entry_rcu usage
In-Reply-To: <4bfedc6d6edfdbdc7f2bde88da75a8329e78abb4.1748704997.git.pav@iki.fi>
References: <4bfedc6d6edfdbdc7f2bde88da75a8329e78abb4.1748704997.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1717934838012590845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=967792

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      23.89 seconds
CheckAllWarning               PASS      25.97 seconds
CheckSparse                   PASS      29.37 seconds
BuildKernel32                 PASS      23.39 seconds
TestRunnerSetup               PASS      447.61 seconds
TestRunner_l2cap-tester       PASS      26.72 seconds
TestRunner_iso-tester         PASS      41.31 seconds
TestRunner_bnep-tester        PASS      5.78 seconds
TestRunner_mgmt-tester        FAIL      128.21 seconds
TestRunner_rfcomm-tester      PASS      9.13 seconds
TestRunner_sco-tester         PASS      14.49 seconds
TestRunner_ioctl-tester       PASS      9.73 seconds
TestRunner_mesh-tester        PASS      7.14 seconds
TestRunner_smp-tester         PASS      8.34 seconds
TestRunner_userchan-tester    PASS      6.04 seconds
IncrementalBuild              PENDING   0.48 seconds

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
LL Privacy - Add Device 3 (AL is full)               Failed       0.216 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.156 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1717934838012590845==--
