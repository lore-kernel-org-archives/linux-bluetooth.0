Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41516163
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Dec 2024 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734802170; cv=none; b=gwzHNdaT5X23TYQ/gxYB28R0D0WZp+4gh8sFmTDCn0mhNEtCFOfXFRyvrUb1FySzDFJsm7Vnc/7Zpiv+6Fly8/7kRRYTtbHCLxANIhXEpdx4i7jKV5CKiC7hMzMX2OsM/zFrC1xbOWIR5DxsQOyf+EOF+u+HDdVt0m6yOtRY7qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734802170; c=relaxed/simple;
	bh=thQtzPq0/4eg/k0JRt3YZRld2yGtLtqc6HZIJNJ3/Mc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jnQI5akzGvKvqXFXGPN42GAKKjFxX315FfyehTyMeabLyroJgzEkqESsa5JjpV7ERx15VTWsEXNGr/npiH36n2iCIoFprKCsd+6ecvvG/+3KCXGiIUV54szeqirCqwwTeunrvLx0CIqb4FIDoNAjWoMToMBOLRD1xYcuHEUx0W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRNoiSjj; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRNoiSjj"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467b086e0easo15541011cf.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Dec 2024 09:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734802168; x=1735406968; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Et+ZQZa7c5ogqVnlEDRX3v0ljY2qBsudkbI0BubfKYQ=;
        b=JRNoiSjj8p0yAduK6zOi8Kt2vrhpfNLEAr/m2gSDaSiofeXHBwFBVi2Z1t8jIu5G0L
         tKoPDA36eXnW/tVX5snP3nOCj1OdKB2J3Vygd0dP/mNmGGyrKkzwtoI45as4PDSUkXsc
         N4x0Gz0N5jwxIpntepyqC/nbtIrAIlfUNOrtFEwuS93UQ5W066l90kKhUyIVkoCwp+s9
         11TD7nXIxdN0PLHohy7c+d9km6ZDrF1rSfNfzFMrQcxIaDjZ71eaaelxJV9QvjXthBlR
         KxKyN2ZbejdZgrWA7FMbiBEtVTBw01g/FVGA5hObY//1P8SR/XlgTAjW+nPWWZ4A0NQo
         3gGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734802168; x=1735406968;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Et+ZQZa7c5ogqVnlEDRX3v0ljY2qBsudkbI0BubfKYQ=;
        b=g9UOOIBxWlgjxEhyueHBeRZi9O3N4pBhQs4n7pAo4bdwnuIikgOSqiBqWzrGFBgr4f
         IgZU7k7n3wevXwFrxi/2XMUWj/qcOepKfvPYOsu7eWFiM5PlXnr1FMzYScB4FP97l5CI
         c8n2/vkQMOchtQsKQa6NI5bJjvv+FLMpeiIsT8phf5Z4dZsBfFDuUAlUXBLok9UOpFIL
         FjHtJAgWwcHX5Wu2CXttPMb90tJoiioNNknvKIK03QM5tetdmlRkHNtqfYoS4Pna7/tI
         QHlaD80f7SIv0hZqxe0MulV0K2UqdCxTmsZOMyLyT9FxUoWGZ4UUf8gcISg3SOkJilSs
         XTXQ==
X-Gm-Message-State: AOJu0YyOzJlIu2gzbIvPdcc1JD5ifLxZnHdXWwP8ObwHeixveh6dmoHk
	9JaoDzQKmB8GkU7iLWNFFlqwbDWntNWwCtUBH/+unDMW8G8ZDJmk2CLZYA==
X-Gm-Gg: ASbGncuDnaY7wbXcqEWk+RWd0SWStqdYZLEO1cLmQYlWRs6mQzmjvsrJ9LCJYEd8jYo
	tByARIYpgxmjhtv81cV4lGPtJkqH9eauHJifmbIskzdLphB6YTHnUQnNrwspl69FI654Diy291Y
	SBwfFgcRjl8qZNiPYiDjHL0X4oNPMmkVOL71FtkKXzzGeno651IJcEksCkhqTlIEqB+HCVkEoGj
	5BXTXoypKB1wLwLOlFxrX9zDu66sk9ISia/5zi43cE2M4nvOKGWjhmyWJ7w+50=
X-Google-Smtp-Source: AGHT+IHn696+TwHAkHlGE8PztzviWshSAY89JOaqEwlLFFdJvnciVB/98RcTMehyOMQyAiTar4LV2Q==
X-Received: by 2002:a05:622a:13d0:b0:467:6c18:9855 with SMTP id d75a77b69052e-46a4a8ebb04mr141976391cf.27.1734802167847;
        Sat, 21 Dec 2024 09:29:27 -0800 (PST)
Received: from [172.17.0.2] ([172.183.36.24])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bd0a5sm238467685a.20.2024.12.21.09.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2024 09:29:27 -0800 (PST)
Message-ID: <6766faf7.050a0220.325143.90ab@mx.google.com>
Date: Sat, 21 Dec 2024 09:29:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4267122497144142073=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mazin@getstate.dev
Subject: RE: [v2] bluetooth: hci: Fix UAF from MGMT_OP_REMOVE_ADV_MONITOR during closure
In-Reply-To: <20241221170459.23095-1-mazin@getstate.dev>
References: <20241221170459.23095-1-mazin@getstate.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4267122497144142073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=920165

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 FAIL      0.30 seconds
BuildKernel                   PASS      23.83 seconds
CheckAllWarning               PASS      26.31 seconds
CheckSparse                   PASS      29.67 seconds
BuildKernel32                 PASS      23.85 seconds
TestRunnerSetup               PASS      422.40 seconds
TestRunner_l2cap-tester       PASS      19.94 seconds
TestRunner_iso-tester         PASS      29.05 seconds
TestRunner_bnep-tester        PASS      4.66 seconds
TestRunner_mgmt-tester        FAIL      115.93 seconds
TestRunner_rfcomm-tester      PASS      7.45 seconds
TestRunner_sco-tester         PASS      9.16 seconds
TestRunner_ioctl-tester       PASS      7.87 seconds
TestRunner_mesh-tester        PASS      5.91 seconds
TestRunner_smp-tester         PASS      6.77 seconds
TestRunner_userchan-tester    PASS      6.13 seconds
IncrementalBuild              PENDING   0.62 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.214 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.158 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4267122497144142073==--
