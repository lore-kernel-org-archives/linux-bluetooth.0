Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7A25DB0D
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067278; cv=none; b=CEMJi3jAA+rA8WMsaulRoFb8enSCaZt2gjqViSk7c7OuEGnPSZWluQTCt5lnsOLZGkiR5io2QZwz2OJs+CByI7gHnRVKa5G0JV8aCi0dWZCljMMSGC48xPPozNDOKH7AQJIAvitwYBXAMns0unvO4vJnUQPTLhs4TmGL0Eshsac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067278; c=relaxed/simple;
	bh=EAdegw+bCkJJL4D3NzYCFz2AB+yN8/32uAlCq+EWl/g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mafZBkYrOfupP3cctAxxt12tC9JIs4ms++4QWTFo8L4J2QL1DKAJ8aeMA5kgXym+ufeB8l5ZFRtQQ9IclmPSTCXeSt+QSa+X1RhHeAVdPjknWiHI5+gZgER3zQBg6xgCL3EYV335bPpO6Hdobbw4g9rYMOVqViQ1yKWkegv3Ey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s2beCwWI; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2beCwWI"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc9ab650so109285fac.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 12:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789067275; x=1789672075; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bSG3xhCMMiwUxUTFzAFTqmNbAUkm0ro1i1AkzVly+u4=;
        b=s2beCwWI9IFichALkx/3t3PLJf/4saZwxQyeYes4biMWU2Nslct384FXlYqsizxgUH
         3hXM32JX79uSnZkrUrtJ6gMqfDpIwRUYgUPb+eO1yk1JPqKcCMxxpuUMTk4BoaDKiIoU
         0xOrrm328DGKYPFezV2D7Gfdex0f+YYBLZBEhC5uZYuyE5RFOKR2eZsZcUjFBO8nOIv/
         aCgIqyW/K2dUxexyv9Cu2PvqWGm8TDGEEKK8OvW5JrNBPzmcqkdmIeL5BhZ0qFJa683n
         OyqjkBOgrI4UcqamSHYoPsJpqX+QF3Dkast7pxPqeNqZUjASK+R51TWA9EMXiJ1f9u95
         6hRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789067275; x=1789672075;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bSG3xhCMMiwUxUTFzAFTqmNbAUkm0ro1i1AkzVly+u4=;
        b=M+DF6StpFCL8XMP2HLjiba7P019AvgaC4DKYK5kLAHEMupEV/lYu8g82czPEN148aJ
         no6Thy7A68qROU68A6r2oX2JGUaR7wlvlwkI0Jz9OLA9Y7E9m8NY6AZef6yaXYJ2ro3y
         6YmLusdcQPjCk8odpJjz2Bz/eKz1/NDCuEi8pXeFT3g+b9cd8Fl3krL7uOTXNe2z3qkN
         evY2vvqi50pn8TAQWpL//oKp/2P1KMnYGTeQvpa7XNwqeKulGOzXsyLdK1t6ECzjb1bp
         BKCJCM8theLZdPQS5YYtEtsz+Xp9O23VmW3HA0uJyXeGtZ0NclRyAZBAR5ceCcDnC2bP
         6HsQ==
X-Gm-Message-State: AFuF++kZ+K/gPlKAV10QNUz5ymc7WVSdBGNXBJnx+J5t5kNgE0U5n/dr
	ZQswKPj2tjs9Mt6iuxTXkozNCTGN4VrU5Xt5R2mdUTVROJjVq4AVWmuqmGI1VA==
X-Gm-Gg: AYBFou3aLIAbAphIJJHyToIlbuuEjoLlJLBg0zh7UOoVRLpbqqAmXSFawUBpf/imnVQ
	PQ7s1HSWcQjWH5hYupfhm5lK/WWtJUqJJnSmH+gtbv8x312JUH1oKOxA7BlI5lDc58wbLT5vKgE
	tlX7QPCrDkFWi9kBqv/KzlPqopTVETjGZjCPgvan7e6XUq9pBtn299B/1WfzLn4XPjfN7KxiL2r
	zltDXKc0jC7qgeuEzTgnLAfodmpwPd0HvKKuzb0bMCoLXRwGGKTcFIV2UBg279ih2SkRXtnm27Z
	yMOPxg4Nixv6ACwQuri3JlXUqwTNySBUQ02LwzSfsgI+T7hGj97w+cKU/2fEiLVaolxCw4fAR99
	v1cHmn8HEtlJPl/N4E+doZp51gbEQXarJtaTzGn8vp+IprYCls6oO6+0uspRMb1onP2FSkZS2Ly
	m/UBPvoKfnSDAFDri/9axEzrqr0uuiLNfwf8xpqCxOL8Es+062HBi0XHDLZphvFJNPOAapLirXV
	7hNZA==
X-Received: by 2002:a05:6870:21c9:b0:45e:edc5:f469 with SMTP id 586e51a60fabf-47de85c97c0mr335387fac.2.1789067275053;
        Thu, 10 Sep 2026 12:07:55 -0700 (PDT)
Received: from [172.17.0.2] ([40.116.72.209])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df90fb975sm59199fac.13.2026.09.10.12.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 12:07:53 -0700 (PDT)
Message-ID: <6aa30009.0db9a8d2.b7c7e.d4b9@mx.google.com>
Date: Thu, 10 Sep 2026 12:07:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3727601201392852322=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, daniel@makrotopia.org
Subject: RE: device_schedule_reprobe(): core helper and conversions
In-Reply-To: <1b051bb8145febf69cb33d9e8a83444db079e8f2.1787281239.git.daniel@makrotopia.org>
References: <1b051bb8145febf69cb33d9e8a83444db079e8f2.1787281239.git.daniel@makrotopia.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3727601201392852322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1149424/

---Test result---

Test Summary:
CheckPatch                    PASS      3.48 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      1.24 seconds
SubjectPrefix                 FAIL      0.39 seconds
BuildKernel                   PASS      29.55 seconds
CheckAllWarning               PASS      33.66 seconds
CheckSparse                   PASS      36.63 seconds
BuildKernel32                 PASS      30.00 seconds
CheckKernelLLVM               PASS      43.82 seconds
TestRunnerSetup               PASS      775.59 seconds
TestRunner_l2cap-tester       PASS      44.07 seconds
TestRunner_iso-tester         PASS      93.05 seconds
TestRunner_bnep-tester        PASS      12.56 seconds
TestRunner_mgmt-tester        FAIL      145.83 seconds
TestRunner_rfcomm-tester      PASS      16.05 seconds
TestRunner_sco-tester         PASS      23.41 seconds
TestRunner_ioctl-tester       PASS      17.22 seconds
TestRunner_mesh-tester        FAIL      18.17 seconds
TestRunner_smp-tester         PASS      14.88 seconds
TestRunner_userchan-tester    PASS      12.96 seconds
TestRunner_6lowpan-tester     PASS      16.38 seconds
IncrementalBuild              PASS      39.00 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.156 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.116 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds


https://github.com/bluez/bluetooth-next/pull/740

---
Regards,
Linux Bluetooth


--===============3727601201392852322==--
