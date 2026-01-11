Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9420B239E9D
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768120969; cv=none; b=XWWZjn92x2vLnXoh2QgECo51Prma7MCikFuZ5TzdgCVVU2NIbM2zqvtm+cmAJfK9H3eJpSujODOzePj4iICKge0Lmmk0kjCmNtZl24v9xbqyJ56Y2XXHBXFWFPs8YallcDaCVt0+9b5yuMPZ8ziB4ztJjCK8LUTLRLJDJBorIlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768120969; c=relaxed/simple;
	bh=5PTZrtLuW5uI2PQWmXKU8pEg5Nf0y4CF3+fVTrJNlX4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JxU9nJ5aQ0IR7q05S7y1etDjjgABLb6pPeg5g2N6A0yUp/y/J73Jpqmn+K5BF2c8MsHlP1JyB2AznDqKJHLQvBeZP6iMjTg/eEGDZSbG/z5NkmNi5hHRI8mJzJg1/+DVJf23+Ij7i6lKOckyVHM/dfFPcWMhg0NEli0SDtSPicE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilYu1CN4; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilYu1CN4"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8c2f74ffd81so569478885a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 00:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768120967; x=1768725767; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wqCzWvErZzF/8t+TU4SNZFlPsUjPVMWQaK3OHROIgJg=;
        b=ilYu1CN4WI8xYR3hgr8g63eK8IkmPuzLo6f7hXVBQl89Kg/j/ceREDQanHCmA9LD9P
         n1Ep2ADD8pch1sqfcGnUBnl2EtyopXNaOyzo54ioJ/hKA1lyeuFyhMBBav/Q0dGTZ8ta
         vGmwsfnpJcLUtDECLR2YOZMtX1WDirZI6lVUEG4IAOCaM1PNQURPglUSP++vXBdb+hJE
         DbLA+qX4/48t/HeAg3bdq520fyUb0zd0UwJuscPnHSWLo5K0dmlCq/KZuR4qR2/0ZE1I
         cocE6AsHhIx10diwMV4r+0cHKxv8Qyrz1oDxihi+ZrgcohFo+9yAm9h4CzXINfF0T55J
         y9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768120967; x=1768725767;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqCzWvErZzF/8t+TU4SNZFlPsUjPVMWQaK3OHROIgJg=;
        b=HIgGO5d1rXSQJ0q7KQ/4eKm271eb1xMUUAqLXzDwn54wooEGSGnFsTO4Gd6MYgncVz
         CSx/mVBVOvma4wXlBy3597jvCaUHPdcUHbTrJamuQ58FHp38hpoJjBg1REv1Pt4Pb/CS
         rw+7lD/1R3qlwJdfhq5Bh0/7vGgW5VhQL+1mu+UjvJ7VrecsW5GzbOVAUA4W7A6MTw35
         QUfUqNjhVJHp/tg6Mj/1if/WjWU75yCOg1zCcdbnyDwEGZRj8baUj6MSsDtp3aUzfj/E
         RGz1QLx8l0Om8MuJ8gkNRO54LrMlwDHlZkwfDlMPfrbKqSUWlo2PEF462xag2HMq6t+P
         I6wA==
X-Gm-Message-State: AOJu0YzH2ToaHI3TMvoe6JJXAuqq6/vLgezsXL6VpYz4W7+bpZk/V6+0
	68G9/obyPkbXMeTIGZG3cUrxIq9M/UZIuHo0aYHjs8g+Ycy0UbkFItmQCaVMPaEC
X-Gm-Gg: AY/fxX4qmoCmoPlNdr5fZCxVINWDshtlCEabI7bfKWpBE84/ryP6zOhOHW4EsaQJR+f
	y3aQwvb708BzY5IrRkZa5RSIGFfNydOPlA+dOuvB6lqlbS4bzA9whWeBiKJ2GrYfHG5c8RtnRHD
	e3+7B40TLVtG8J+02R8YuHdhKS9OwPif3X8lT8Landa4A1jsx6LviJiV8APK2g/wEoOui4IU3GC
	hdDSW9gPUHRBoXQ2jdaKJky8zazis0M5hYvpE8J67v5d2GKcLUgSbTQbdd99oWW1IoeU+270fA7
	kwLcaf/acRGZxkG1zEY4Sfppm85qXyO4kJvhCSCnIjp/a5YQcfMC2y5fsyLB82tf3fTDL6PeNi1
	gLk+ksShzch51xxuFXEbQTDBGZhvHVUb/wxnYXGBtmJ4zqaK2fn/Qr9MX86WwRelUiWqkIuLRsT
	WSHreGd89nrh9H4A==
X-Google-Smtp-Source: AGHT+IEDu4L/V/0x75egrQNGd5Z0hKnKMexkTa0DvWUiI9foiUjLLbBGvhNxK7D60ZFnlplY2MS2gw==
X-Received: by 2002:a05:620a:40c9:b0:8c3:6603:cf63 with SMTP id af79cd13be357-8c3893f6de8mr2227992085a.68.1768120967300;
        Sun, 11 Jan 2026 00:42:47 -0800 (PST)
Received: from [172.17.0.2] ([20.49.61.49])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51d06fsm1228104085a.32.2026.01.11.00.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 00:42:46 -0800 (PST)
Message-ID: <69636286.050a0220.196b6f.46e9@mx.google.com>
Date: Sun, 11 Jan 2026 00:42:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2130329058239795315=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, santiagocr@gmail.com
Subject: RE: Bluetooth: btusb: Add support for Mercusys MA530 Bluetooth adapter
In-Reply-To: <20260111073748.105957-1-santiagocr@gmail.com>
References: <20260111073748.105957-1-santiagocr@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2130329058239795315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1040804

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.74 seconds
CheckAllWarning               PASS      27.77 seconds
CheckSparse                   PASS      31.28 seconds
BuildKernel32                 PASS      25.32 seconds
TestRunnerSetup               PASS      552.96 seconds
TestRunner_l2cap-tester       FAIL      51.73 seconds
TestRunner_iso-tester         PASS      77.27 seconds
TestRunner_bnep-tester        PASS      6.46 seconds
TestRunner_mgmt-tester        FAIL      130.05 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         FAIL      14.59 seconds
TestRunner_ioctl-tester       PASS      10.32 seconds
TestRunner_mesh-tester        FAIL      10.63 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      6.59 seconds
IncrementalBuild              PENDING   1.06 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP LE Client - Close socket 2                     Timed out   22.710 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 486 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.118 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.193 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.170 seconds
LL Privacy - Set Flags 4 (RL is full)                Failed       0.233 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.136 seconds
Mesh - Send cancel - 2                               Timed out    2.584 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2130329058239795315==--
