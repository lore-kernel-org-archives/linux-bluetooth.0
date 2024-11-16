Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05195F9CB
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 Nov 2024 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731774867; cv=none; b=IpGNdjDPlOdn1S6ZZRSPMTP6O5lH1zgJfpCOq7L4MHiAtMOagE3Dc4DTEMeF7FL9e+bWc/GfqIRVm8YC77ZAPQj3wNB/vHvXF7aOABTp+wTIqBmqSK9RhsX1Wxb32nvWIvK5dgffy3RPMsOqBw8OEpUEA+CI69+66BeZ2XuOOaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731774867; c=relaxed/simple;
	bh=Ie5BXUvg35m/LC3zl1cvlgRBjpoanM94gsA8GldzJSk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VIvYnAuV+lcn45gcjch+q6DE+VV4JYYoPBG1iiwt7bZpTnMQxa/KRedJC/t2ij1OoasChzcXuEhRETT+gjCVkd5ebTs9nN5/UAF+yJ1Q1ErFz+ext7d2yb2Hwi6whd1tuOjHw6wEOhcR8SN0ZIJNnXiG5qo4k+TtNuNnzfvq/Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3/A+FA7; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3/A+FA7"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b175e059bdso43822685a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 16 Nov 2024 08:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731774864; x=1732379664; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gfN18Z+p9SuS7PF9X/oY/bYsYMqF+ftlCilOL0nYftg=;
        b=l3/A+FA73G250LZWoU/Zf3j8hcw8PK8iKlGLbTiVINFzL0ocXwFt8V7hfI5ombviWb
         LMjDHtC4sNEam7J10BHI5I3EPvoF5vl2a4HU4VOyi+6y4zFSFVXQ4tbNbB9fgUgtpwpA
         Kz4M47TbZzny8OgKvGRolM92RD4ZYnxhxfKgVy6tA12lCzmxZDzFIi0Wapiwd6LtG4Lj
         qef10aJHbzw5S3Wz1Q8j4w6cc7qDwk7meHVP8uRpkTJ2tIPPiASxs/id1xdN/ie8VCJ7
         IkAgcJk0s60DOQdaDnSRi2WfLWAu0Is12XFgSFvX1Sgy0MU8ggSw5ZtxPqT3ogq/7qAA
         sDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731774864; x=1732379664;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfN18Z+p9SuS7PF9X/oY/bYsYMqF+ftlCilOL0nYftg=;
        b=ENF1MdPBECwo8nFuxZg5tNNfB6WZeZNHxBU1mlG7Sm2VBKtSVpVDI3AxXajGEb2gWo
         BhczgiHcnyFpf26JY76jZoEOMj3QMbQV1lRjcAAdynQjQB9Ip5W39JnbqztcvTq9heGQ
         JTOCl8MM3A7fWW/UTSStIVEKbsIO7pr6KmYrdkqsh69vd7RB80W5Y0nfItyHwWsC0owZ
         Jt2RNC3wELKex7ma7VBMtnv0hSer73NaywoEsnsH3iro8YqUJ36Y5OKBVYYHLVlCEZgv
         0qT+yX0Bj+0ZKmoOOaYOxxTJkBTNIRDIs4Z5lkQFDoXMsQsPElY5/T6DF+cACZUAQofw
         u2Ug==
X-Gm-Message-State: AOJu0Yy1R79Fs/rmSDPwPhwSXIgId1RfdxB7x3jGKHmqEyo+CLiu7glN
	LibCmzMG6iuv1KZo8pqDosYYZfBOiM5+2/FPX0CLD66Rt5wFeXMwWbNdKA==
X-Google-Smtp-Source: AGHT+IHSBSn2V+7/X/An8hOJLyIvYupWZSgzNAuSUoXRjUVyIobUcbeUxNcTJZsy6KRk8ddIsEwl/Q==
X-Received: by 2002:a05:620a:1910:b0:7a9:b268:3655 with SMTP id af79cd13be357-7b362330b31mr909932085a.43.1731774863781;
        Sat, 16 Nov 2024 08:34:23 -0800 (PST)
Received: from [172.17.0.2] ([20.97.191.49])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c98453esm274844285a.16.2024.11.16.08.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 08:34:23 -0800 (PST)
Message-ID: <6738c98f.050a0220.3000e4.9393@mx.google.com>
Date: Sat, 16 Nov 2024 08:34:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1448233585826378994=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v2] Bluetooth: qca: Support downloading board ID specific NVM for WCN6855
In-Reply-To: <20241116-x13s_wcn6855_fix-v2-1-c08c298d5fbf@quicinc.com>
References: <20241116-x13s_wcn6855_fix-v2-1-c08c298d5fbf@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1448233585826378994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=910294

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      26.04 seconds
CheckAllWarning               PASS      28.50 seconds
CheckSparse                   PASS      32.35 seconds
BuildKernel32                 PASS      28.73 seconds
TestRunnerSetup               PASS      455.88 seconds
TestRunner_l2cap-tester       PASS      22.26 seconds
TestRunner_iso-tester         FAIL      33.51 seconds
TestRunner_bnep-tester        PASS      5.00 seconds
TestRunner_mgmt-tester        FAIL      120.78 seconds
TestRunner_rfcomm-tester      PASS      7.87 seconds
TestRunner_sco-tester         PASS      11.71 seconds
TestRunner_ioctl-tester       PASS      8.45 seconds
TestRunner_mesh-tester        PASS      6.24 seconds
TestRunner_smp-tester         PASS      7.48 seconds
TestRunner_userchan-tester    PASS      7.67 seconds
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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 7 (AL is full)               Failed       0.208 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1448233585826378994==--
