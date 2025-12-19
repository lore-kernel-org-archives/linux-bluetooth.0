Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8B7339879
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766164316; cv=none; b=PpT+HoAUfgbfcjOdQfoFoG9Swlh3imReBkaqrsK4xU8MpBuwjC/JXBTpnwPM7auMaaud+vMthRXZEFPTU1lyO9XQ3WJPtSi8R7CedMzuFcQL2eyvJnwFVuNCc8NrUzyY2ZpLS5yc2F2vn1A992q6Yq5qMOnf1ZJ2INVgOTqkxdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766164316; c=relaxed/simple;
	bh=7Az+Zi0F/YovGcqII8PKRsH0KmAS5VtBRnuLvewd9zo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tUrDU6MqthryS+9DW2eoUbdYL18NdXm1Yh0HKDKROP3kPQb4y087o7ExbZkBfGRla+LKrLedgp624zoFlFMQHaKIyUbRG3EPz8kRqsg3+c/NPohr3hHDUG9QwF4t8/ksSgOwmLlCmZUhb/24hcuVbMFOuZBzp/rSSFvGulPKnmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lB/rED6H; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lB/rED6H"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-29f2676bb21so24640175ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 09:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766164314; x=1766769114; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kgMQhqgNGMB10RSnRH0iwlZEQdzPNtH6mAo1d7cT16c=;
        b=lB/rED6Hma+oxgd6Iw8MsjJeyccfKRW2KjKHzBrdHxSVBjxjB28NYZ/JSkaxLd8/d8
         bc/jUIKYM3Yl4xq8FnUGmfc0NLEK3dfHujubhTUxsdHTURH/+w3Ej6jtyIm1dEnESKai
         qzrRrQk2vz5wMXZOEc8yt1mnk5/XE5WTe5zqy/vsXboadBTWBNkMxxR0Xs12XZIYATDH
         NEVIiPcwuMhXUg0GqflaTzxGwNjymmDmUn5DWJ19sLesR/hS/BPZbY5JCFET1et3aLTx
         BgzQ6hjYzg7kdkVY7NUZvfcvNhPUEUKj36InHo8rBEgR3g9IhERh8Ia6ESWNN/lFVgwO
         KQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766164314; x=1766769114;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgMQhqgNGMB10RSnRH0iwlZEQdzPNtH6mAo1d7cT16c=;
        b=W3ytyzsPaVfortfKiwK9bEu5qaAN2SipCcZCiOvdS4qFSU6CiuI+3sUypuF08O63I6
         2TgIOjbiNagnaL9Z7J4EtWp1jlUdvg6IRj3hxXoPbxxEVl9sXMqoUP4l8OsD+/g4AwuF
         5zs6Zp0ochdoIECKy8g0wE7FGai1SLV7LAWSsA/8LqyciGVfxhj9bwbrjtp9lcL0Djms
         FNRdT6mDyR8dYXIljSuKAVQagOv000ssy5Hf+9LDSkxKXz8wtVzPZukipmZwornkPJ/o
         1MntY9NseqjU6xb2ge2mPewD/6nJ/JfPhTqzkXsWD1Fd/6x3VRQri8dwNT2hoej+nA16
         o5DA==
X-Gm-Message-State: AOJu0Yx02B8vlxzAnbg11CTCVf20eBvkwqfuv9NYRCwit+ikWHm1M2oE
	gPKMUvl7jrdMWRoQ2+jHRAwG0JNVispDs/q0Pum6rRjsOn0KyibesQBIAIEuDCJ6
X-Gm-Gg: AY/fxX7t+u11sb2I5IlSBThVr+lC7T0+arv4NCYy8UerTKHXzsAo+055rEH+L/3aDPC
	gk9lDj+y+jV4gnHmW6I1coeibWin3omhF2rAaw90SEvtvs5E1RJ1g56sXC+IhFH6TOkf/62BJfy
	mOmaYHRtdo3AcJrPzROmAPPQ/Zh1DtNyulJL1Hu24zoWVS5bvgeafAbBIW2gH5UsD9gMVD4liut
	9GAwr4h1JNutjItVO8+zpUd2KvAJ80jJhdX1o1GUG6oU8/WnEumTXoGZAJinTFusm78DS2YvdIr
	0bQ5TfxIiNJJtLswZRzf8vhR+wgccx34noXyD9tkHx5xoiAvwwuXvVTBFB5xIAF3v1de9qdWh6A
	8kAuggMIy2jLQduWkPTw/2A1jmE1hz/pCp+yJb2L4zSA3lsGYrBFzeIKW+h3R12ccKWmQ6J7pT1
	mbl1YsjFuNClRqMFwMcqYEdQpLFP3s
X-Google-Smtp-Source: AGHT+IEty+ZmChpDB8dbHbZn2sxKogEtUrDyWURvRshbkyLn1thzu2M1ASdlUm/SB8VuFH7TJMTUKA==
X-Received: by 2002:a05:7022:6291:b0:119:e569:f61e with SMTP id a92af1059eb24-121722e12e7mr3689309c88.23.1766164313704;
        Fri, 19 Dec 2025 09:11:53 -0800 (PST)
Received: from [172.17.0.2] ([104.209.11.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfa2csm8386663c88.3.2025.12.19.09.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 09:11:53 -0800 (PST)
Message-ID: <69458759.050a0220.804d4.549c@mx.google.com>
Date: Fri, 19 Dec 2025 09:11:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7711148144245084463=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] fixup! Bluetooth: hci_sync: Add LE Channel Sounding HCI Command/event structures
In-Reply-To: <20251219162820.320823-1-luiz.dentz@gmail.com>
References: <20251219162820.320823-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7711148144245084463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1035126

---Test result---

Test Summary:
CheckPatch                    PENDING   0.56 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.38 seconds
CheckAllWarning               PASS      28.06 seconds
CheckSparse                   PASS      31.86 seconds
BuildKernel32                 PASS      25.04 seconds
TestRunnerSetup               PASS      555.28 seconds
TestRunner_l2cap-tester       PASS      28.19 seconds
TestRunner_iso-tester         PASS      73.38 seconds
TestRunner_bnep-tester        PASS      6.35 seconds
TestRunner_mgmt-tester        FAIL      116.62 seconds
TestRunner_rfcomm-tester      PASS      9.54 seconds
TestRunner_sco-tester         FAIL      14.83 seconds
TestRunner_ioctl-tester       PASS      10.42 seconds
TestRunner_mesh-tester        FAIL      12.68 seconds
TestRunner_smp-tester         PASS      8.77 seconds
TestRunner_userchan-tester    PASS      6.79 seconds
IncrementalBuild              PENDING   0.92 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
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
Mesh - Send cancel - 1                               Timed out    2.764 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7711148144245084463==--
