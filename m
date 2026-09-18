Received: from mail-oa2-f32.google.com (mail-oa2-f32.google.com [74.125.231.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39787385D7B
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742469; cv=none; b=FOoP4Mmx4V/bFFbCr6vodyh/hsU3TxrDWxBaJuWUTZzsjke90sQYrDlGYgKvb/cXMWCajMVx8xIojX34nFLy7Y97sMWByJfM0QXeehHgCZs7wTUkoQfLTEGtjj5wHZk6f4OFznnfRZ8aFyHPIYMC7ddU8cdc/nOclqm+qSlDPGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742469; c=relaxed/simple;
	bh=XT9VKL+PfzSjroHZuYAAM5K6uwerDeCvhZb7dN/jams=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nL9+4SepPGdTIf401bNvI39WqqDov5PwtKDCMbLSCDn87KeM1XSvRKCbmE/KLFTyVIeceQ7tOUfrrjHuz1c2Bx6+kx4YglraNc2fwJ4uXvWnKcF2pnOjwpDGGy29RAXcVKAdcmk0H47GvQ4JINRfjtP0hH6sAXkZao00CKyX/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbZLP/7b; arc=none smtp.client-ip=74.125.231.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbZLP/7b"
Received: by mail-oa2-f32.google.com with SMTP id 586e51a60fabf-46a63c34533so903877fac.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 07:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789742467; x=1790347267; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VPBexYOJPfRBQR+/4axQDV0WuBrnXwbSkycX0qPu5Zg=;
        b=WbZLP/7b9K/X5ypqkRaiIYH21WdywllLv/g8a4NijfqTClWo1bE+pmkZk/m+7izJX9
         pi4u5p59d9HNb45YN1BGrXmud2s/b1sNgxIo1c4NHfh+/0JKIJOJ8qTPmO/ObM2IRdoD
         jRla2qM7ZqkI5+lAsn+5L8QVFByDhOyNhguz589LFS8p55iwwSu4pBGnfFbxV29x+FIj
         vsKHAd4Boeir11jeSjKCLbAbYRHWPW3mOwAQ8anIpa/Ub0c6BJTQzv8/jKhb/JWGzeKk
         aW289EwwNutxRqhYshyo0ep9TQM91RaBuBEFwRvQDywanSAxeK08Ek+XnKQ78cUhEc+G
         epVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789742467; x=1790347267;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VPBexYOJPfRBQR+/4axQDV0WuBrnXwbSkycX0qPu5Zg=;
        b=2Z9LS9/DIELk1NvUYsw0n+q7IBUcikVyOgFhNpR+75CynpjFYfGM7c3pkpH+Y7iOby
         QOoeZKd18HqALrmPqI5bsCaaccJdGR5Qo+rowKMXdgAi2ZErtplhuSSFgdK5xTPr15kj
         Qwwc4nRlkDLZQcmkiRpf1KhlPI7vZE+7JeWsEVZ4Dx8gmSisyCaNNsShamLmGajoBlHo
         5R8LtciIOvcLyUmjSX2iy5scBxoRxEGeHh//uZvvPt9KEtNoSkYbdFT1nv9p2MTio7qO
         JTXhLBT8nH71vprrYL1/vWqdabwrXyejLXmf4nPUXKjvP/rb8viw2TVDLJ4xcfl0dt7w
         mUTA==
X-Gm-Message-State: AFuF++klvqqSS7x2iy4UjrVhmWCaYHJ2oRDRslXT23WRkU83XkoZy86a
	VaaFW2+pCnhbr5Ma1YjQR8PaZkp7wkehPqHlRi9+U1cuIwLGFPEZfEkz+6pqdQ==
X-Gm-Gg: AYBFou3ztHINjPCdJNamQzYtrpKCLuqmdwS8i87HXN4bNlvYVvTPlpfzT4c/LEqlEyq
	QCW/6MjrDvL3yAg4m1g8UzSgXmBBoWIBRkXbcQpBbsXuDHgt559yKHNJtUvmkvQmGWioQcmDG25
	8psuag/4Wv1qjGAtbqJlAVuEXQZyHH5sYCE99VorJXpfQgp4G3tbtQo8+MDIMFNq9w3tjDLux4d
	693UArH3AcrvQFtKakTZEhI0m2a4XEOUQpVjv0lqd52NKTMztmFaL9GsMklLs7sXKPdf5t+WK9u
	2Cyh/NDuBUmQQzSIlZ9n5670zFHRBbkZtkgqi/fkwHu2/WlvhmGT46tKGK834coeVuK+qhDCS8b
	Y7z4MomCo2/qPxNUmJTT+lm5OLXtN/FWQ2WFhgJElxc8Etpm1JqeW2a2vjRx7DS5tl34wAN1O4k
	SM/75UJYBIrpxK9f7oU3l9PB3gLFMrhUnwrJU5+4dWltQtuLABPW9XAJWdHuGQiKjOgKZeirv84
	f1r
X-Received: by 2002:a05:6871:5319:b0:475:a1ec:961c with SMTP id 586e51a60fabf-486e7513013mr2771551fac.30.1789742466874;
        Fri, 18 Sep 2026 07:41:06 -0700 (PDT)
Received: from [172.17.0.2] ([172.202.78.9])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4873780b1c0sm1144067fac.1.2026.09.18.07.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:41:06 -0700 (PDT)
Message-ID: <6aad4d82.f7f62383.8f14d.3ae1@mx.google.com>
Date: Fri, 18 Sep 2026 07:41:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3826900841671812406=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bigeasy@linutronix.de
Subject: RE: Bluetooth: Remove %pK formatting
In-Reply-To: <20260918105318.PdvCbvuJ@linutronix.de>
References: <20260918105318.PdvCbvuJ@linutronix.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3826900841671812406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1168562/

---Test result---

Test Summary:
CheckPatch                    PASS      1.41 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      21.02 seconds
CheckAllWarning               PASS      24.27 seconds
CheckSparse                   PASS      28.12 seconds
BuildKernel32                 PASS      21.46 seconds
CheckKernelLLVM               PASS      23.47 seconds
TestRunnerSetup               PASS      502.85 seconds
TestRunner_l2cap-tester       PASS      17.81 seconds
TestRunner_iso-tester         PASS      29.96 seconds
TestRunner_bnep-tester        PASS      3.01 seconds
TestRunner_mgmt-tester        FAIL      55.95 seconds
TestRunner_rfcomm-tester      PASS      4.10 seconds
TestRunner_sco-tester         PASS      7.00 seconds
TestRunner_ioctl-tester       PASS      4.15 seconds
TestRunner_mesh-tester        FAIL      8.29 seconds
TestRunner_smp-tester         PASS      4.27 seconds
TestRunner_userchan-tester    PASS      3.25 seconds
TestRunner_6lowpan-tester     PASS      4.14 seconds
IncrementalBuild              PASS      22.31 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.018 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.669 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds


https://github.com/bluez/bluetooth-next/pull/791

---
Regards,
Linux Bluetooth


--===============3826900841671812406==--
