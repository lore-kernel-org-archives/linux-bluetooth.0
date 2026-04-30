Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3F139FCD9
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777580385; cv=none; b=Of0iC8H1WsthV9sWOcEw86O7kKA1WyROMTB3gwY95vZDZK84APcXCahm9Db8I8Z4vjdXY7BD/WVmt/84ZVBQgM7wz+6QmhsAHNyuAvIxDIUbxEinWsRS4uLD0jRC5gt8ffl9I3dQU0gfhk78bWEvh56tXanEuyb4RPfCV1xnzVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777580385; c=relaxed/simple;
	bh=4Tdxdt6Glqz5VwQ53zJq0XwKBBK+L+3wyj+TMICMTeg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=R9TPyOjUM9uTXT0e1Lt5o8qLJsRPV7nFFb8au8Uqc67uUnUdSpK9Vf4kB1CpFwt+tVxJrMwx2uz31Kiw0oMiQvq2tBjzBhYNgN2Whby0mjbI/iheoaL4RMRbtDRdJjM8jGdGSy7zeVJ6LxS5t5ERA3VFDM2IhD4lhVZV96mZU7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0wBJPH3; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0wBJPH3"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12de530cbf1so360422c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 13:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777580376; x=1778185176; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ig/j46md4Y5IU4vT8AFXLBJGv+V7kOSOwc6MGOVqnwE=;
        b=m0wBJPH3Brw3DStfxM5wLUVvbu3Y9YoJKTOJvUOwy+sxdi3GgfP4KD+g/feXt5Acgu
         BTw+vEB8aAUlv8c63StupMCzkojCfO8lwWD9Fm9hxBRkH+SW1+aD3hcKZMuI6y+a5zYI
         DPrCmieQ/veO+cRB8KJk3vGUStUM0Cv3tQMEz6p4vUSU1EiOi9DdHQ/18/DHOv6s7k1C
         AfotZQW8iPn3ScWvTJ/NE794uCIXcBWuHOTjZD5vT/q6H9Jrb3R2FGcp/r6e3QNANyZD
         VWuDcNfeBOLKXnwxblJwDNq+G96V1YxrGCv+Vh665W4YDgAJuL2ZvInDwWzVMKXQ9t2l
         s65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777580376; x=1778185176;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig/j46md4Y5IU4vT8AFXLBJGv+V7kOSOwc6MGOVqnwE=;
        b=go/Kj5EA7Xk1GSCC2hJdfmMQ1gY6Q+ddgAJdJ6oOcgsyba1nY8xGfEd/6i53Ez4Yul
         eitYvn5oKlY6R0pspsyFF4z144fIuOe1+XVi0GjQ1/iNCkcNLrJkBMdV4h3/tGRQvEJq
         O2HTaFbVQuAk+3CAYoS4oZRxPyuRUpLJFErsNfaqW3R0gSUObVmw8xO7v/xjX5/w4wEj
         fPiUQlf/l0K0NdBgojkiyL/P20DB2NoVlYOOUTe8wHrlcnrkQrsvO1O7XVuiXZjt3zAw
         RtpH+1V6XuGtJGQ4T/Go24GIe4iQE9i/hRwa//5Krx5oE0DTgIC6IA8eHfFd9Zcyr8eE
         84vw==
X-Gm-Message-State: AOJu0Yw0MCFu9YyUkLAL9xpYLCm3gR1d3ygOEskJ8OBG4+aNwKut9zke
	EHrCJhhqbOQwf5eyBJVCcJulSFBdIJgg7wD6F5r2Mwnfds5CCNJ+GpLjKvmAAg==
X-Gm-Gg: AeBDieulDAVVtIwM1YiKJgRtRiP8AR42vNc6/WORi9DODUhhYBiPC0nAqCLL3hwVRxl
	Cod9YSNcut2wfSfS6anxcaom+cVcITrselBB8sFdL/iW0YKOhg+Bx0tMtrMg3hrXXDUF3lUaSKa
	Sa8YLqN1DDjNzJPfSKZDytuXea6C/iyT5ojYUfDnRYDgHAWXKcGDGJC0fiq078wOTGYIZebN/ju
	1Gl2Y5GY/S9krVldmJQJ+8z2NvMtdB/D5PQm62UkFrLLoNMSQU8K3kmLJv5ueslWlHy+kRLQXS0
	MozMlwAdi7H3a/HUp6d42JFuqAaF5IiP6plxUbjBlUE5Q84i6CO7gVasawkYrGEI9dKpBrjslUL
	pC3AMp9+eLec8UxhA7ZT6FuT6W5XTYIoB8UJJo3GFv0fAvVxDZK3C/feM0sCTNmEIFbV0vl5xSg
	lPKTY31J4fp/S/eQhNuS3uTMCXTJkW4NnZpK81Ib8=
X-Received: by 2002:a05:7300:80d2:b0:2d8:1efe:51dc with SMTP id 5a478bee46e88-2ed3d2bf85fmr2373401eec.6.1777580376133;
        Thu, 30 Apr 2026 13:19:36 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.59.51])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b783a95sm1386428eec.22.2026.04.30.13.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 13:19:35 -0700 (PDT)
Message-ID: <69f3b957.050a0220.37bec4.7633@mx.google.com>
Date: Thu, 30 Apr 2026 13:19:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1685217348221661338=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v2] arm64: dts: monaco-arduino-monza: Add Bluetooth UART node
In-Reply-To: <20260429103537.1282497-1-shuai.zhang@oss.qualcomm.com>
References: <20260429103537.1282497-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1685217348221661338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1087406

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       FAIL      0.20 seconds
SubjectPrefix                 FAIL      0.07 seconds
BuildKernel                   PASS      26.26 seconds
CheckAllWarning               PASS      28.76 seconds
CheckSparse                   PASS      27.28 seconds
BuildKernel32                 PASS      25.34 seconds
TestRunnerSetup               PASS      568.74 seconds
TestRunner_l2cap-tester       FAIL      6.77 seconds
TestRunner_iso-tester         PASS      295.76 seconds
TestRunner_bnep-tester        FAIL      6.74 seconds
TestRunner_mgmt-tester        FAIL      9.03 seconds
TestRunner_rfcomm-tester      PASS      28.98 seconds
TestRunner_sco-tester         PASS      68.04 seconds
TestRunner_ioctl-tester       FAIL      37.50 seconds
TestRunner_mesh-tester        PASS      27.03 seconds
TestRunner_smp-tester         PASS      6.63 seconds
TestRunner_userchan-tester    FAIL      6.70 seconds
TestRunner_6lowpan-tester     PASS      22.95 seconds
IncrementalBuild              PASS      24.54 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] arm64: dts: monaco-arduino-monza: Add Bluetooth UART node

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
41: B1 Line exceeds max length (164>80): "- Document that the QCA2066 Bluetooth chip is powered by a board-level, hardware-provided 3.3 V supply, and that the GPIO is used only to enable the Bluetooth chip."
42: B1 Line exceeds max length (92>80): "- Add the required sleep clock to satisfy the qcom,qca2066-bt DT binding and run dtbs_check."
46: B1 Line exceeds max length (83>80): "  https://lore.kernel.org/all/20260428025652.662502-1-shuai.zhang@oss.qualcomm.com/"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_bnep-tester - FAIL
Desc: Run bnep-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
Total: 28, Passed: 0 (0.0%), Failed: 11, Not Run: 17

Failed Test Cases
Device List                                          Timed out  -30.821 seconds
Device Info                                          Timed out   -6.175 seconds
Reset Stat                                           Timed out   -6.179 seconds
Set Link Mode - ACCEPT                               Timed out   -6.182 seconds
Set Pkt Type - DM                                    Timed out  -14.368 seconds
Set Pkt Type - DH                                    Timed out  -14.371 seconds
Set Pkt Type - HV                                    Timed out  -14.374 seconds
Set Pkt Type - 2-DH                                  Timed out  -14.378 seconds
Set Pkt Type - 2-DH                                  Timed out  -14.381 seconds
Set Pkt Type - ALL                                   Timed out  -14.384 seconds
Set ACL MTU - 1                                      Timed out  -14.387 seconds
##############################
Test: TestRunner_userchan-tester - FAIL
Desc: Run userchan-tester with test-runner
Output:
No test result found


https://github.com/bluez/bluetooth-next/pull/139

---
Regards,
Linux Bluetooth


--===============1685217348221661338==--
