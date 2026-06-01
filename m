Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5D05733E
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 02:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780280022; cv=none; b=tLxeU+Bhrtbx/mL1u+OioAL35xFvREU+giPSdQTDz7mqgxaCOmGS0TPo0V4MOjPDA8sPD61h6rX/ppdSmpjEpYrC4QwdKZgsIRD9ottfsnZBaYP5fneMPnv7MyA7nOslqtafRtDA6UyNNTz/MQpzsnhv+4jpgfiNabgZwj+xBGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780280022; c=relaxed/simple;
	bh=fcXDLMdGRNmm6nj7ZoQglO8nSilbOf4gblBVtTQoSHM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iudSsVZtf3JClmiIcfop/+C3iXL5SCQum6P+kVNRlJEaMFMMqzwV5lWphTwKhDhBHDv8NJCAFDKlj+liUk/V8o9JNmq3EnPv9uCt3hcR92t+l24flwLk4r4Z4hIAk7EQOIgGZS74e3yLhTt1BRWfTH6zZiiK79e3lMtwh6wXh4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=js6if2e6; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="js6if2e6"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8cce22e029cso38525716d6.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 19:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780280020; x=1780884820; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oI2MYxNG5IlFpPRx+u5ridjwsCQBosR6pMrXCyQCo08=;
        b=js6if2e6ljp5UOgClkI2uIT6IvDJfRyGpZGxxxwh9RP75VnTaoZ2A58NOPgOC2yUWL
         kRODpYycyoy4+IA//Ioc0/DBao69C/hvr46G59B+8KTDrgB7kz2x3CV5hlK9CxvzuN3I
         1j4tTney3EwF2yvOj5Te9VuVDDSt0Hc9s+OfxE5P1vF8BklOuQE7sDf/LgCzAbokgbe3
         eukZulNxvFmy9Ct/7O5k84z0uzJ82IdK1Z1f9AjXkZIftsEyp5o6F2SbcX0mwNnnZpjH
         eFFZffMOWgnh+/BRery5pbcupsSJ2XJl3Rsgx7VWKgGCcsEli7l31K/v86v4via85hMG
         OhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780280020; x=1780884820;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oI2MYxNG5IlFpPRx+u5ridjwsCQBosR6pMrXCyQCo08=;
        b=jtBAxy0wScwfXcrJfnlJOCdr8xJji+7C/dFw4oQEeSZJhDMfEVx3W/JHGoHjlvdNKm
         NTWd2ARDHpAOaNoMy9nU9qHdS78a2RpL6RuxAbIoAcqnyzHajUnzo0hs0kkWZBOo/IQj
         C4Uknun+lV/p6qo6xVKvA2FrkIeK1/gt1bMvsJPUJ377g03+u+87IS4wlCadrrhZ5bZ9
         SGhVKdTeCSMQFbYzuuosT0i8zJOg1kH+QVuxS0oAVnMzVHaYg8dKV6Da0EvWy6x9AaK1
         eBTIREYywpmy284IOz9BBZoF0L5REE2Tr/OEe+4yobUVzLF/OlFw9/RYdRewIpFPXcvI
         dKFQ==
X-Gm-Message-State: AOJu0Yyt8XIMbhqJ5gPEq2h57JFCGSFYxNLpm5k2H5DxO5Z1m3xF9C/a
	VRLo2gG5ZvYRaiSp8nppUTm/quTA8unUf9N7uEg/o6LFK+Noxs4DWS0J5BzreQ==
X-Gm-Gg: Acq92OG6FkYwBKoRJy6poseHAWVCnu4JASGJ7Ia6tdFK2vsX56X+1P64FCRJrvGVjEA
	kG9jhSmU2VXczRk1t1t4zx8GE6Ib/pZX0QjTPKLi2sTFMeMM7CVS/FNEUqPpOwMXUhWJu8z8UQO
	1wNy5BkdcbSdupWIgIkrrEagKUAKZbt8gN5hQTkyHI9JKgm9T6kIUEQH8HLBm0hv/yY/QvtwYn+
	pLOMPMUf5CrUIqUcocU9E2mGQJA4d6pFw5DBqbwcmM62n6Y6/lF3H4Q8Viq5vsa9mla90pHanLS
	gEVF8I6IwurQdJIOPD7CCSs0P96XEUBREvPSAAohFmyKsLg8vJumq4AjhkdSGi5gEmof86IVPvu
	DSBiBOwMIfPSpOBIlVG9f15esLbiS+rxmM/YPsurpO6Gmao9ghU3QYLeDTSRhyT75o70fhJHkHW
	21ChYKEtTgSy4ibsqtGcq3LKgfGrPB65Effn/NiAlq
X-Received: by 2002:a05:6214:3387:b0:8cd:e7ec:dbd7 with SMTP id 6a1803df08f44-8cde7ecdeeemr78130816d6.2.1780280020128;
        Sun, 31 May 2026 19:13:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.30.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea1c2ca3sm80337556d6.29.2026.05.31.19.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 19:13:39 -0700 (PDT)
Message-ID: <6a1cead3.997e10d9.1fb74f.90aa@mx.google.com>
Date: Sun, 31 May 2026 19:13:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6882532195161863980=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, liujiajia@kylinos.cn
Subject: RE: Bluetooth: hci_sync: fix simultaneous discovery stuck in FINDING
In-Reply-To: <20260601012620.11764-1-liujiajia@kylinos.cn>
References: <20260601012620.11764-1-liujiajia@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6882532195161863980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1103706

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.47 seconds
CheckAllWarning               PASS      28.43 seconds
CheckSparse                   PASS      28.92 seconds
BuildKernel32                 PASS      24.87 seconds
TestRunnerSetup               PASS      535.30 seconds
TestRunner_l2cap-tester       PASS      59.65 seconds
TestRunner_iso-tester         PASS      77.77 seconds
TestRunner_bnep-tester        PASS      19.01 seconds
TestRunner_mgmt-tester        FAIL      210.17 seconds
TestRunner_rfcomm-tester      PASS      25.71 seconds
TestRunner_sco-tester         PASS      32.80 seconds
TestRunner_ioctl-tester       PASS      26.19 seconds
TestRunner_mesh-tester        FAIL      25.96 seconds
TestRunner_smp-tester         PASS      23.25 seconds
TestRunner_userchan-tester    PASS      20.24 seconds
TestRunner_6lowpan-tester     PASS      22.78 seconds
IncrementalBuild              PASS      24.64 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.247 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.344 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds


https://github.com/bluez/bluetooth-next/pull/262

---
Regards,
Linux Bluetooth


--===============6882532195161863980==--
