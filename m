Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40ED2C11EE
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769659296; cv=none; b=dq1wzRtNBMNz/1WGEs3wWFZI4quAWq1ceR9rxKIyFQtHTDD5Ig3WQ1TrZihifnnLahBC5Y2NRYluMNQ7ApqTz/KMey3HIwEUvTlW3Dg1NCRf4LsC0Ia5pRYO5DqeqAgibzlrEyN+4X21SB5BSRseSZ/egoZ25LZjNUAkPkV0Rzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769659296; c=relaxed/simple;
	bh=/ttEb9Ag1bsJtzMcBvMd8RzQ8upjjHmMz7WKkaI74CY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=q2HfNQ/Clfu8fHOaRWnSi7D47XDCvO0x78Ikk6MfF33pypRIpn5rjQ+6F1GPg0hP6A7ETb2eVSgs7Q+biAUy8fxwfWk8/sJC0t1WR3PL2JOhPrM6BlOfx+BBx/6yz0KPQsVgVSPI7qdd2FNRzLXIf5KygFebTOvvZtMkXyN76Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rwmc6mmg; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rwmc6mmg"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-124a1b4dd40so1400264c88.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 20:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769659290; x=1770264090; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i4kXtYbCONXwZIqjXfowEFcAltVXxZkmZ1/6RDBbvto=;
        b=Rwmc6mmg/pQTR/8L55xahsEu4dZ0cnJV27RzD7UtzbPo3gDx/2KqlgVZwu6aXTK318
         Wus3jY2ubjLh/oGhK7eaNFppKwX6A3WchPo/aiV7yTCxwu0WkIrF/Ul9Nv3/cPGob3UR
         fpR7PEjO9Ont3PTaFgTM5/4F59x9Znkw76Af1+VNFCkZmOe5VQwcDN6iRYJaxad2YRvx
         5w/Yi+0MdP4splnyiKDn+Uoa0Pvcd+SA5SkGqcSbx7esIiFMcTSAV/Au3kqTPabF5A7k
         q+V2KgdhVxBWaNCH6a50k0ukolNaYZbfVQS77ysExpqZ84J3bmiyKF/XrKEZdorvB5me
         YHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769659290; x=1770264090;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4kXtYbCONXwZIqjXfowEFcAltVXxZkmZ1/6RDBbvto=;
        b=IISyzSoHxBmcaj5HQswEMHUACOQdDyvL5SUcpzUj5vSSgy6gcsLjrO78we6tOra5mw
         JIRWMAG80ngpjr3HAYAD3PiHPWUiHgd0xBZB2JzXegjePkX1IZ0t+PK666xGqKfN7UnN
         9/698rXBh+chqTOTp3c6HU+V7mid/+qyI9SCj0cunBcNOUPjC042juJQpGS+OZoRHqYb
         nQixdWoz2WZtoc/RhKaBK3dbQ47YkjZ/2Cew7jvg/QnQAtrF1r4T1XlWTFvOigPAgXFf
         B26vx/W5vEXna2gKWuYUMNuW5DRQIr0LJYCIi0JSMIFiGxFkR/lbGqBpJnKAMa+LEl2L
         DBHw==
X-Gm-Message-State: AOJu0Yw73dIdotUyftWEj9lAIfGLgndGIWilLuA1U/6w/v2oCCpnM/wr
	bRxIfKGcg0OykyUFgZ66DKWtf4FZuwhdj4HE+xyYkOqvmT9FGUgK7425hhWO7c0Q
X-Gm-Gg: AZuq6aLHonwQZa3Sdyof+MpX8pRa+ZqMaO0H8ns6PHQv24HwWxDKrGFcHKb8e2d5uSf
	xBjnBIxpLkK4i2cEcN9+YRCza5KdqPVKVENECDEdsSqYlQjG5rw4XCHTqMIJQiEi+UanbJDbm6b
	9lNpdH+uc3r5cK6JEC94TARO1YcvCKC0nIAUnKwhrC6XOsqau3MsOCuIdATfxc2xbcc8EcduPkM
	QH0uyjpyhAEyDxJ2H1KKgxu6xMe6uTHa1MOTFWq6lyTkeOtjTbtR8da/LMiTWgaPN+pJRhg3Sks
	UvCSf0T9Qf2AWnShdsF7ngnPabr7mt5wT9zrUV5j/ifSmaYmQdmyTL/g0lu9brqIXZ1VrcapVBn
	IXD37Ux0SvlZMnt9F4WsOrp12HA0kGX6u96jCpQyntOjlHySuageZV/INC8ylwB4bsvAzuAhvtM
	vSnslhB2BRXIJFnwL/rVmhM+ov0S+KTg==
X-Received: by 2002:a05:7022:671f:b0:124:8d7d:2d63 with SMTP id a92af1059eb24-124a00c4dc7mr4909426c88.35.1769659290320;
        Wed, 28 Jan 2026 20:01:30 -0800 (PST)
Received: from [172.17.0.2] ([172.208.153.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1af898asm6021764eec.33.2026.01.28.20.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 20:01:29 -0800 (PST)
Message-ID: <697adb99.050a0220.a0ebc.bb21@mx.google.com>
Date: Wed, 28 Jan 2026 20:01:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4630228187068874317=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zenmchen@gmail.com
Subject: RE: Bluetooth: btusb: Add USB ID 7392:e611 for Edimax EW-7611UXB
In-Reply-To: <20260129022819.61290-1-zenmchen@gmail.com>
References: <20260129022819.61290-1-zenmchen@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4630228187068874317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1048323

---Test result---

Test Summary:
CheckPatch                    PENDING   0.58 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      23.75 seconds
CheckAllWarning               PASS      26.04 seconds
CheckSparse                   PASS      29.02 seconds
BuildKernel32                 PASS      23.35 seconds
TestRunnerSetup               PASS      514.98 seconds
TestRunner_l2cap-tester       PASS      28.46 seconds
TestRunner_iso-tester         PASS      77.58 seconds
TestRunner_bnep-tester        PASS      6.22 seconds
TestRunner_mgmt-tester        FAIL      115.14 seconds
TestRunner_rfcomm-tester      PASS      9.54 seconds
TestRunner_sco-tester         FAIL      16.71 seconds
TestRunner_ioctl-tester       PASS      10.16 seconds
TestRunner_mesh-tester        FAIL      12.51 seconds
TestRunner_smp-tester         PASS      8.59 seconds
TestRunner_userchan-tester    PASS      6.66 seconds
IncrementalBuild              PENDING   0.89 seconds

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
Total: 494, Passed: 486 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.107 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.199 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.159 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.183 seconds
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
Mesh - Send cancel - 1                               Timed out    2.749 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4630228187068874317==--
