Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FFE346777
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772833705; cv=none; b=GwjLUpgIIc0c98Lfb3sbCW4V8iaZ5o1B8q0Di0suJcEgbwpaGi+ePsQKbuxrADvQD90X5AehxMrzmcnLUIVeoRKyhKYIFqz6KLIEtJ3+Tjh/OG8yLiqUD30zonLCYFCmqk1p25lYOAiGDpa85r1rcw6pZVPpp99KJb74RqqFd1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772833705; c=relaxed/simple;
	bh=VXTfuq2rB5SUYhYyoE0Ox5M+SkpMHGL1uIXMbqDK+B4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZBL+JaWxh1do/FdPcGNC3As3wWjnRzf+ama+H74MLWJrvvSudMxrkbTq24/fnDigj1TEXwPB4lsPYxCxDxGxqeDSD1CmNgR7Nl7d5xy1Bv6Rwbaqahay2+gDU+mmGul5Oq19fxR39KB92gD/qDGDM+sCX1Uzc6x4JvMKJeDZ22M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ch9NqTzG; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ch9NqTzG"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-124a635476fso11524453c88.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Mar 2026 13:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772833703; x=1773438503; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f3NSvdH/y6nD3GWlo9Fa5A7xtD6Ae2Dt03kdGT2mVD4=;
        b=Ch9NqTzGycemj6y4atqmHb/VXl0iRF1NW+rK3N/ZNZJTHSgVQOpAjLgjnXTH83tYJC
         pV7v868S7Cm+k3zniNad4d+y4vkbCB2g/Am1EwUevsw0ux7z5FBRFVbBG/Rg6oRajOiU
         xUUkcqOnHq3Elk7znGyB9kzmRzW3H7nG38YCjuCtvfXP1dxN/RVkAzlmuPEQ+sYMw06U
         +jIgovPWs0/ZZJoDBs/dIqYFeHFCDild6tDDVaGBbvaW/SGZ7MDLBgCcWGtaqgMdD7/2
         YND/2BUnsJcfyA6ecELXsQIp7G7u0ey81pDsoPtHmThtPSgeO9EyoQHjkyoVs5CGPRO4
         o7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772833703; x=1773438503;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3NSvdH/y6nD3GWlo9Fa5A7xtD6Ae2Dt03kdGT2mVD4=;
        b=G+NBe0YqtkLYw9/qlf4zL518pWwLGaffOOMj1pLDm622086SX3PyojiBLWVB8JuQTE
         hlEKpc1qGlMneKyNrzPXZpTz6RYq3gsnfrdiGyG0pzXA/jLj3JA/flMVyGrGdUqZfru4
         i1bBR9jFA2UzBlhtoZZ/OGd+7F8ZoNBk79qOW+mhACOZOeOF0i6NmTvMUtNYL3FqVRrd
         FgUj8nClkqKBh7LlNHRoe08l/SRTlyaT13gCrvPpxbdh1SQZa7WFOOCIT/ZoL/cDwgHd
         W0J9RvLmyNsAzMayCRnr1fKNCZy9Sg2rUtUV7SxZZKipMhXhgchar7HqYH7BBr2459kB
         PXmA==
X-Gm-Message-State: AOJu0YzDeiO38tkxt/B30zlGc6zbqRiuOQ9AwHEAvQkmnD7sw5yuanaM
	edsGBF+uE4E62RbOwGthRp5W4/2NeHpYyU04+cosHO1UkBHAJRRYC7YddaNJpA==
X-Gm-Gg: ATEYQzy+RVRUwWeotyPqTvPQcdlTYGa+rZ2M3+OqrO7mA1PbojpqkzYB+XL6Up41BZo
	RZHeVSMZ5/hY8ttcqyGMo8ZNgm1vl7n+6vBzcyvgO0tIGe2GRpmJbh1Wv6R9T185tUDnFuO4la8
	tp4tAzx4Ij8+l1b3jq5umiVUVq+aBV8KWnG8jtYcHKu7C9EKdZ5Mkcv/CoWbGXSjw2am38UeDrx
	DKOvphGrQ05jPq3o8JgohSnZkJwCg0C4P3OljM9yfw5zoqvC9/c5dZFW6osA/ENl+Bc6BI/BU0A
	8QpZ1h1NSZXDhq7HO9eiGelclb4l1WXgubhlPcQVARGq61zKCvRwksavPPcqNGd/jSaBjIIEkWS
	X6ZX5IY04ZiHRaH1AMiAyuoeSfqvM2TcExJodx4i/ZvXktWbaDba88IHJfnpBurh308+SAo+usw
	oVR9dL8INKqvTIwaujGrcmRUbq+BFq5w==
X-Received: by 2002:a05:7022:511:b0:127:392f:281 with SMTP id a92af1059eb24-128c2d9b20emr1361672c88.4.1772833703243;
        Fri, 06 Mar 2026 13:48:23 -0800 (PST)
Received: from [172.17.0.2] ([172.215.210.55])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128c4065933sm1870019c88.16.2026.03.06.13.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 13:48:22 -0800 (PST)
Message-ID: <69ab4ba6.050a0220.3022be.16b7@mx.google.com>
Date: Fri, 06 Mar 2026 13:48:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5330976239972323710=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RESEND] Bluetooth: L2CAP: Fix use-after-free in l2cap_unregister_user
In-Reply-To: <20260306210427.703454-1-luiz.dentz@gmail.com>
References: <20260306210427.703454-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5330976239972323710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1062836

---Test result---

Test Summary:
CheckPatch                    PENDING   0.51 seconds
GitLint                       PENDING   0.44 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      26.18 seconds
CheckAllWarning               PASS      29.05 seconds
CheckSparse                   WARNING   32.13 seconds
BuildKernel32                 PASS      25.48 seconds
TestRunnerSetup               PASS      565.63 seconds
TestRunner_l2cap-tester       PASS      28.95 seconds
TestRunner_iso-tester         PASS      92.74 seconds
TestRunner_bnep-tester        PASS      6.44 seconds
TestRunner_mgmt-tester        FAIL      126.51 seconds
TestRunner_rfcomm-tester      PASS      9.78 seconds
TestRunner_sco-tester         FAIL      17.73 seconds
TestRunner_ioctl-tester       PASS      10.34 seconds
TestRunner_mesh-tester        FAIL      11.69 seconds
TestRunner_smp-tester         PASS      8.63 seconds
TestRunner_userchan-tester    PASS      6.67 seconds
IncrementalBuild              PENDING   0.53 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/l2cap_core.c:7788:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7789:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7791:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7792:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.110 seconds
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
Mesh - Send cancel - 1                               Timed out    1.852 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5330976239972323710==--
