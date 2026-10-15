Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D930855C30A
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095777; cv=none; b=ksz2iBz0Mqm4TUhErVeX2/y2VUH55FVnJG9gAMgeAgVbNYTSQwfiWbHIEv5Xb0sguONvLjVFhSemu8wPybJmXeK/4oD5LPqAld5G/aoCeb9VIWG1ANLECX9Fen6C349V7QCi7MQ5dAx26d118g5t8IwXYx+60X4uBEILtsOwk0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095777; c=relaxed/simple;
	bh=5Lghbt/Sm6WzeInjLBe/2Uh/YT8TFL0VHCDlsvGMPoU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HwXU8wT0AFzZ6w6fQwSBc0DOgSVKyCdr6uBEESthXG80n8uvvGDff8WgRZIB9P5i+43vz0q0Qafo3+LyZDuXdzaG5eHfCu5R1XYOvBBZp0o2axdu42wXcgVqLy6sCHhaCRERklCv/0t660l58Nj0bNAF4mp/rSVDNPoJv5g0+Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k87v1QdA; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k87v1QdA"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3550c917fd3so3405640eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 13:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792095775; x=1792700575; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cNynY7by6CLb6p1/af80eI7nfjvMmtpo/lgVVHzRa+0=;
        b=k87v1QdAs6M3/lcyXDZqTwgFF0Nc3ZGcpbyuJCJ8a/GBjLqIFMxwwUI9R5ZoQ/+F6C
         Jd9FcOTVsSglJPSxSCOO9hxKlQPzX9d01CdatE6mFjuu18sYhnDcXQqKioJzqI695+e8
         /hSjT5oV+iWkCMjT5ZU4ynbwSyiL6gBn6j0uK37Xpc10j6/sXXKRhCFA/a79zyW8t2tA
         JG/0BtyZSNxzViWJ3VOesjBpz5nLw4D+uRjMdpUL9lic82xFL+CVon+ihMxtGv/A5hAZ
         zjoMX9mqBLaP97BRCfWguoXfYnAneuVLTET3FQPHErGIffCeR7PXoTz26YLOONGgc6ng
         58xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792095775; x=1792700575;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cNynY7by6CLb6p1/af80eI7nfjvMmtpo/lgVVHzRa+0=;
        b=Ro/olIGYB1WFXhTEOrn56GWAqNitcSRXjC7lIo4s0ifu8D17g5r9zAHV85UqQDXg0e
         AZe0+kojDf/IksRW8t7JVMfGoOrw6fhBrpIH7+9LPOh/boeS/qwcXNNtW6Tp7veb/5Xh
         ZCVd0byj/mNz0BsmRKZT1xz8zGdkFLI+DO2Aodd9fUASezjBoN1bB3knKJpcip0e047H
         Yj66QcPMgSrKotdfEiVZBaUr10d02j3AcOTi7KlCVMXLRnD6gjfeaSq8uksJm+LL0yMa
         3tA+WvmsinNWEjIusrkM1HOHZkkwRPTpdT6+t+XoZiXjrU+TYiQqUA6UVAbmRjX4wWLc
         7SKQ==
X-Gm-Message-State: AFq9FYKT5AzkhBFgKv2rCLNXiSY3dhKcXYlZYUy6kDrakqrtxRmoMFUV
	8bAwyLHecIq+rGPC0gJbn+TTZe4fads8sb8gDmQV9p/9u/YVXQdjxjoDTRMeFA==
X-Gm-Gg: AYBFou0RWLw82mHLPw/6ITq7lQMn8EfRvZOiNvGPPhEEQwAVY6pFlAVqxHJ5yiVzLSU
	X7/puv1zWpuZZsIclMTePcnhSVTkKMBtwDZI1EFrlLhrNp5VdnVY6XW+Z4MvpBhM8DdL9wf08g0
	DW1z4rmA6Rf//O2VPz5LjJKLXwu8tvE61ItMOkixE+/06dZQfmKJbqY0FFGGA64/tlCL8InzPXe
	Lj2YC4F7inSKwVdQZiQuUVRA2zfuippnI5nYjIjZY+hypURj6/sG34Az3Ro3XREHrBqADvrmQxu
	V0PXjze+931JOttmHXV9WryLnYdwuDZ1oXGqIGdst5dxktnTyAPfCc91eW1/lU378i9870hk15E
	J3r0iaDbuOe0B9+o1RiaJh4R8A2FSLZQo1J1PReMfMuHGKaH7EaeNbwAAgvf75/jgMft5MsGHr+
	Aot2XtejmCDImTRyLe74om27te0ZInB0/6ejK0iHSZH18rlp47uP7LGzTSY/ErLDZLBDm+gFMis
	THZ
X-Received: by 2002:a05:693c:65d0:b0:35f:71bf:131a with SMTP id 5a478bee46e88-35f71bf19camr3740346eec.28.1792095774640;
        Thu, 15 Oct 2026 13:22:54 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.229.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608258aa66sm399399eec.20.2026.10.15.13.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:22:54 -0700 (PDT)
Message-ID: <6ad1361e.dec19f78.2d5a2d.8229@mx.google.com>
Date: Thu, 15 Oct 2026 13:22:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3832957835425148844=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shimon@gobeyond.pa
Subject: RE: [RFC] wifi: mt76: mt7921: add manual MT7961 Bluetooth reset through PCIe
In-Reply-To: <179209131379.1251175.8756794738527947285.mt7921-bt-pcie-rfc@gobeyond.pa>
References: <179209131379.1251175.8756794738527947285.mt7921-bt-pcie-rfc@gobeyond.pa>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3832957835425148844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1186730/

---Test result---

Test Summary:
CheckPatch                    PASS      0.83 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       FAIL      0.22 seconds
SubjectPrefix                 FAIL      0.06 seconds
BuildKernel                   PASS      29.43 seconds
CheckAllWarning               PASS      33.86 seconds
CheckSparse                   PASS      36.23 seconds
BuildKernel32                 PASS      29.40 seconds
CheckKernelLLVM               PASS      35.18 seconds
TestRunnerSetup               PASS      704.27 seconds
TestRunner_l2cap-tester       PASS      12.50 seconds
TestRunner_iso-tester         PASS      10.63 seconds
TestRunner_bnep-tester        PASS      3.07 seconds
TestRunner_mgmt-tester        PASS      87.13 seconds
TestRunner_rfcomm-tester      PASS      4.41 seconds
TestRunner_sco-tester         PASS      5.52 seconds
TestRunner_ioctl-tester       PASS      5.27 seconds
TestRunner_mesh-tester        PASS      5.44 seconds
TestRunner_smp-tester         PASS      4.24 seconds
TestRunner_userchan-tester    PASS      10.17 seconds
TestRunner_6lowpan-tester     PASS      4.34 seconds
IncrementalBuild              PASS      27.19 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RFC] wifi: mt76: mt7921: add manual MT7961 Bluetooth reset through PCIe

22: B1 Line exceeds max length (81>80): "2e6968e9286f3573016b9f804d4945373a21c489. Patch applicability was checked against"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/954

---
Regards,
Linux Bluetooth


--===============3832957835425148844==--
