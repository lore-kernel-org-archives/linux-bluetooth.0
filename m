Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F58C57268E
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067084; cv=none; b=UsYCwpZzrB7wrNCleafxy/dBkTFislBrtd7ZlQ/GingQsBGvLs0AzaLjhIaAnqLWtjfPskzldUG0syVhYbmS+rZSBkxalbdDKBuPyIQCG68nAi250HM8oNg9/c1o2jdEi7MLncaZOhzIqTaN/ZzkzvIxpFbQe60cPJ/ibVgvYZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067084; c=relaxed/simple;
	bh=J5KsKZxcpY4lTrbdyZG3cVZriI4Cn/k7aDHVuoURr6w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oTN5uJ4fbgtIYV7h9tYXroOGDJNV2AJ5zR/PT3+ulzxjU3jhhOU/fVbr8pvJdwdqsxqpuLRXDVZvGgHYFQGYf9oxMB7jtk6dmg9ePMDKKPTRYqbRzDa8muuED6udXFNprOfu90vL0SLKfFqv8eg95VZftQpES2X7msrMe4tMpE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPChIRQZ; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPChIRQZ"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7f4f824de5dso51167a34.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 12:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789067082; x=1789671882; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YQOhjGRU+olNIQoCxlcVZoCuB95A87VK5i6TFkeuVfY=;
        b=RPChIRQZqhe9UEFMoImjg6nehr0D3veGNDykQnBol6XBnpE9dV85UbNvyPB9cR5tp2
         2fSK8jPyx2dKo4jL1iS1EIPyHJlQMt3YzWkK8Khyu6symour5csD4cCbsdaDbs7T5vio
         pEGrEvp5J2lA4Sv4gVBjYt7H+J1W+5lLAd/cpzA3EBwv4UgBWF0ZN3mR9gVHhQHbqAdi
         SmtBtr8iJtlkPEPCJDBSeG3gl+Mjiix4f+/DkJoUGKSNBVSpHXVV+OlIj5pxmqawqmNU
         9Vf4GpaYs/ru3rH65zu89X/YACFWW10pEZFn452RXkJpGrQHVe3HDTHDwHiIZA0bbprk
         g/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789067082; x=1789671882;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YQOhjGRU+olNIQoCxlcVZoCuB95A87VK5i6TFkeuVfY=;
        b=CgNNDOupRtc+iltKxzxq+udUpvn2Mx7JVLyU4kd2xDV4WW5/veKO09Hl9nLR+UqIbE
         UfXiLXFxXEaa0DdOfqjjRLhwb9BcPphaGL28LZsVb1zA4Z6fm8idwwdsd4BO7/e6818O
         aHgArOEqJmJug4hujotlCs0FlTGLQIwTVu83DsCeNdFxwTOxYlO7gNOitR3EKC4QSHge
         45qu202WrYgFw9nb9L2SIqK6IeX1O4gNDi2rLGfk8iXS+Nt1mVgq7njvy574DzoHlgTj
         FR3ivzcNCnrGmSkZmg8ufOlpe5nzf8JMYnnsnUnwcsegwTFqAgbFejdz89qROzbpOgrn
         PguQ==
X-Gm-Message-State: AFuF++nOdAdZbSFpY1cBR/0tWPLik8irtf2zxihRaneXKhjy5hrlfkh/
	JWZIr2WyZUiGxdcd87s/8FUQDR+qhMr396emOvXZlo9m3RD/H17Xomk0mTucag==
X-Gm-Gg: AYBFou2u+A/CuXWuZ7eUV+Tw2xynYNLfM7LMUVKv+VTrYRZifo8XzCqrQcC7R/ZYPPM
	5rngLkdv4IrDkhb2zzboY1NB4x3LPayRgfGU2/VBHy+I0ey3LjZ+DrxMPotL4FyU8SZzI+dS4on
	ov54eRmozIWbeGC1L2jT8KKaTFpWKeaNRqeJyfY6aDhkgKwSUKtOXbpzKKG2qXgPVI1kCoqKlsT
	AVt0mmc7v1l5ty/E2UA5H3FsgeLeKCopOuLf1lRLUL9/Xn30HLVIgifZif+5I8yCsutSV8KsC/J
	nwLpAm9Wj8KMzxALZ72K0IvXNJuoyu3ZisvfanQSdFJVIpWNf4L5sPdNv6mT5scozSXQywECP73
	KgyqEUXmhikB8ozMXXGgZKKP1z869OtKgnVNczQo8lK5HKSFhS4/rRbosjx5CTVoT5G0o0Y9Hva
	9zW0aQ8l4h7xOniXaVDCO7Lla7jMhxdOEufVWWErbhXkdxSS8yhzAVF8rOLZxqaighruD2oDvVR
	z+PwpuO
X-Received: by 2002:a05:6830:348b:b0:7e6:50dc:6512 with SMTP id 46e09a7af769-803fd44f229mr211697a34.6.1789067081813;
        Thu, 10 Sep 2026 12:04:41 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.232.53])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f6d2c072sm308931a34.26.2026.09.10.12.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 12:04:40 -0700 (PDT)
Message-ID: <6aa2ff48.6b931ad5.2c2e50.656e@mx.google.com>
Date: Thu, 10 Sep 2026 12:04:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4799271064076545255=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: hci_sync: Serialize local codec list cleanup
In-Reply-To: <20260821174350.3034506-1-nicoyip.dev@gmail.com>
References: <20260821174350.3034506-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4799271064076545255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1149960/

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      27.24 seconds
CheckAllWarning               PASS      31.28 seconds
CheckSparse                   PASS      33.71 seconds
BuildKernel32                 PASS      27.91 seconds
CheckKernelLLVM               PASS      30.83 seconds
TestRunnerSetup               PASS      728.94 seconds
TestRunner_l2cap-tester       PASS      44.51 seconds
TestRunner_iso-tester         PASS      91.19 seconds
TestRunner_bnep-tester        PASS      12.16 seconds
TestRunner_mgmt-tester        FAIL      143.15 seconds
TestRunner_rfcomm-tester      PASS      16.12 seconds
TestRunner_sco-tester         PASS      21.19 seconds
TestRunner_ioctl-tester       PASS      17.26 seconds
TestRunner_mesh-tester        FAIL      18.16 seconds
TestRunner_smp-tester         PASS      14.84 seconds
TestRunner_userchan-tester    PASS      12.95 seconds
TestRunner_6lowpan-tester     PASS      15.19 seconds
IncrementalBuild              PASS      25.59 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.140 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.356 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds


https://github.com/bluez/bluetooth-next/pull/741

---
Regards,
Linux Bluetooth


--===============4799271064076545255==--
