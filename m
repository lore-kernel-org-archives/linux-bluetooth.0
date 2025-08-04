Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A8824DCEC
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Aug 2025 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754305832; cv=none; b=lhynX+smX0QhKKxXbaONUIOXsEeOVsRI4uGYaPDcFIMxXVHTFwladv8ZWP6HQoDUGQ1jRSSdp88S0HoP1OhOCirpRv5r2ZUa/bp/+eY0EPx+f+W1lz17l4s3T1WhaD3Ygrv7CP+uYiv+YMfVv8m9SBtL+Bqt63fUVTG9pjhv8l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754305832; c=relaxed/simple;
	bh=CQ8/3BqhQLfK4jpYvdwnLIujKaqkhsHNqT8MxSt2xJo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CnUCbcM3JRKOyeF1jWOx1K0FU+NmButWKcFU09LUdalmsjag5KsLvPwC6nWKgP96DOqYQwh5ipgYP05QlhpJKFtJtluSzqn1YGz0DvGNx8mQpiSe6DDWwwf1hr+oqm5UiUyaBK+N0aJ0ioEJK1HwVcl/ZaGE/+wCuq+DaOt0FsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaV4I7ta; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaV4I7ta"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e6696eb47bso450684385a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Aug 2025 04:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754305829; x=1754910629; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WU7S7X6j04Ktz4VIiaMUMsWNWsV+cTcDkiE0DgOn3p8=;
        b=gaV4I7ta/Pa9Z2IIPF8KNqut8vzMCubYePtdptnCSlUrXeoDqcRwOhUbwtFin1zkpi
         1CBx67/ES6oT0PTRKzW18KX5x63gcRCVZ8rifmq6c4lK4aqCuFY6l0GrMwZPJcJeY8lv
         rMohh1y4ZBNSSyFYy5RfzUKWYVSZ1JiSYpdxkMiDmt++cZzbxkaus7xqMM95G0jmVtVk
         eRR5Mh10VLtJL++YmR4i4BmxH0dvaQh7l/FYim8EmE6tHmzfQMublhkA9ZlAiV5m4wDy
         nVl+BT66OYHOWtStuFMbDZkEbVnuGPPPzkGi6i+rcCkUBpfIwgM99YP94drJ85Q/EoQE
         Kidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754305829; x=1754910629;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WU7S7X6j04Ktz4VIiaMUMsWNWsV+cTcDkiE0DgOn3p8=;
        b=PAitLgG3gagPFeiL/HxVUfWhhEM3hkOJ0YLdg7JzhgQKszG7PxFyp+Mk3KH5GdL9WP
         tEv49OnxKJZd/jqSP6JYO2OLEfE07Z29tJtHVtGk/hsnWkZE23mmWAizGYonv/4+vslh
         vSfO+2Yz+wW1PT0pGQFOCB9FBo+UmQp6faL+3xwtH53+zaU8RGohUuvUgtrWbdD5gFY9
         PcDicbjWTSKGw2BDXoFjLT25xlncJaDbtuhCUX2gzjhYyMGu4g6hWYumv5pBWie0AznH
         ZnTEp1OyNA5hvnZSvdCBK7/Q2ugCaKjP+FqcKMxNFcdNSiiF+FzXXQ/XtLqRzSTpjASu
         QR0Q==
X-Gm-Message-State: AOJu0YzrZwju9ZT951H5pg1YMSid6ZwB8ezmi7jd7vwVHg1Wl+TXTy+S
	LVxLa6OREoWsq/NbJumOGStiWDluYwi1fwaqBTzSGRvzCH+W3XDBzLEzbLrwDt2Q
X-Gm-Gg: ASbGnct2u+bpdlQuZETfPXGC47ZRsrUKZo9nBt2OWFJY0HhSw/TeyhB2zhPCWUk5Nyg
	aKq7P9Mtj9oQiAj4NPt67FyoLiGuKBhJgiSn5jdpZEmcLVk7upDZ/EuGEGIBYjGGSM7Ecub/uIw
	vLX37Eo4ILWQxPerMd347xAT9C1cwqNYIw0hgcV5qjyyYhAJOxPObqKM4PPfudQpBAtxZndm03X
	9xblKx4B0iWzttD77XbNbwLkp0zL6EhK0+tYHW8HPaDwIvok38h+kivRjLUCQVt+CllCUoZLL3Q
	3Gko34FPABFkfoU6JNJ42Qjge2ZWFt16712AoTKTr5LlGkduaLBuEqi255CJka6TrsK5Lm+FK3A
	NVob1XhHxeVSEBpn4FE+S9EVCqfo=
X-Google-Smtp-Source: AGHT+IEJeK9denzLpkEW4VbH7h8nEWiF2GG15tAWxOZqbd89OwUkEZZEHIKquD4ur6w4webZbMiiSQ==
X-Received: by 2002:a05:620a:208e:b0:7e6:5613:9b92 with SMTP id af79cd13be357-7e696268676mr1259671885a.5.1754305828898;
        Mon, 04 Aug 2025 04:10:28 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.7.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f70397dsm533779985a.43.2025.08.04.04.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 04:10:28 -0700 (PDT)
Message-ID: <68909524.050a0220.21ea25.42c5@mx.google.com>
Date: Mon, 04 Aug 2025 04:10:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2267956878507485857=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v2] Bluetooth: btnxpuart: Uses threaded IRQ for host wakeup handling
In-Reply-To: <20250804103015.1104289-1-neeraj.sanjaykale@nxp.com>
References: <20250804103015.1104289-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2267956878507485857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=988084

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      23.92 seconds
CheckAllWarning               PASS      26.78 seconds
CheckSparse                   PASS      30.25 seconds
BuildKernel32                 PASS      24.39 seconds
TestRunnerSetup               PASS      477.80 seconds
TestRunner_l2cap-tester       PASS      26.75 seconds
TestRunner_iso-tester         PASS      38.03 seconds
TestRunner_bnep-tester        PASS      6.05 seconds
TestRunner_mgmt-tester        PASS      129.49 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         PASS      14.63 seconds
TestRunner_ioctl-tester       PASS      10.01 seconds
TestRunner_mesh-tester        FAIL      11.40 seconds
TestRunner_smp-tester         PASS      8.71 seconds
TestRunner_userchan-tester    PASS      6.21 seconds
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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.197 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2267956878507485857==--
