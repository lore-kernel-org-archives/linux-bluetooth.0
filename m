Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713111E531
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 03:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755141975; cv=none; b=dMctnOcDtAhUujEqJBgg+nGB+QZvLukbCVTdrK0Qsc9/ehoqzbazYeAedoHEAHv7Qvz1w13uYCwGpfLmlkvEIJEG9iSrYhMbYL162y+1+COgo50deARFLOA+fBrMO6XCzrHEwKqBs7cWrKEDvKzCYLQGyLuF6lvr//5LLjJnWa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755141975; c=relaxed/simple;
	bh=OfN3v6M3qENQADCGFj6Ox2t8xhQvBvhb5/3OMearQds=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RGjj1VjKeOhwEgBwoh1povk+Z4EETJLq+NoZCmu5Pv09Q1hz/nzudbxTQ40hInvPE3ZbfCl4ICWdmlEk/1jYBmX5YCoFg+zvHMAa8JRAmSx7Uop5SiI2BVHAdHcJdQbvelvMlCIrQNNa+QCpMdLViHCnoRrO02/F9TMai+XyoPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0omQoJd; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0omQoJd"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3e571d400daso2236825ab.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 20:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755141973; x=1755746773; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XFkEW63pfLYHPC/IR9byoWumpL3fbpo5dfA/W/pPnXg=;
        b=f0omQoJda9e2jMwTOVmYxoqdaccE/79S7CtYWUAvnm5lxexIDiKBVX7F4Sm4dFNGs+
         /4HVJqLoOoyjW18Q/SxqvHK0jJF8fX2UJEfXsKEnZlcWRuzQuXTndlwa1vM0pZvRPFLR
         h224rqj6f8I2uJArHltJCR1tkrTRa3EhsntlyyI8px7JlP1VQ7UC+pxMLnnzXueb0wGH
         0tHJe7v0H8yN8q5Fyiwz42+Qe6QIDA+ToTVhKNj1qe5sHEvtQsRCOISz9KfHKHvA9IGf
         t3taxWWqR8lpY3fQhQ+dAylVvUaPaKASftbcK1h6TsGZ348xhn6HdCKRsx9V+faeA0BH
         QokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755141973; x=1755746773;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XFkEW63pfLYHPC/IR9byoWumpL3fbpo5dfA/W/pPnXg=;
        b=lUn182SIASTsWQQGw44oGLI4tu+iEwZ4N7+m3MIn6FL0mhCVYvyFPwuTNLdbIf6TwL
         vGGW5y/MmkS8z/rrKMG3QJ/aCcxO+rDcuPpM7Rjnkksq728CxrJ1QMhHCXDh7A2Fpyrj
         VDVrvJuQ978P8+PQ0TOJ0BDLlkzXMXnitcufpAeyluTxlUBW0udTamcbXM9BnjN7w2Pp
         IEZ4AG+G05RNtWm5Eee3IB7vh0eIR6lqQ0c6kHOUkkZ3hcWqhEZgQojrwHVRk/CDvhcx
         NRMJberITH+QRXf7cD7nDFVEtGYd2/BkGugTGLjLovZiS6ULNlSWfDmRy/poAJIPuLLi
         DMUQ==
X-Gm-Message-State: AOJu0YxkGbBwDkO97//P1VXy2PakYsQk/jVAk0kfgE82EDh3kbaD7Ohx
	vOOHccyCPh8qI15TAGYMxq8TN1z0kruy8svJY+g96Uy39qOrjiDRHjcfklLG6g==
X-Gm-Gg: ASbGnctiM/qL9VwFjhiQ4Q3NT3/QptGGn+f8eYVDJP0TNTWN0jS7cDf+N4Ne6C6/ySX
	XCE9dSC4umH7CBi7+qjOhPUx0WfdVowRwi2HQyG+nB3pxaF9kX51QnfmLhYUCRAagDKrsqERtTX
	Fewlcwx7w2Ln1OvqHDkZHYks9rAHhU4GlAUpcw40vVPUMlV6HzM2JvgBKIf4Dx5BWsYVRz8du8J
	HWIqOYdW4OaPnOGRJ8cmZZmOH9N8yxYALtcIysJPQJbN+EyRMWA1HJq7zltTfsrdC+Lud61Dbnt
	5bkEXMELxWMbl8m0E5y0o+r6szH17jIF08VPrqouFsQ+KwhAHE1DR6dRVpXKoWweTUt2Vg+7xYV
	3IQmJw86g74EQ+tOTQvRE4JwDlAXDMPREaBSSV4o=
X-Google-Smtp-Source: AGHT+IHB9jxbaiUoszEhQBM4lMrfvZNqzhTwVEeypRDkm3mncJyBCx2IbWDqq/Ec0jLy52WrrhoVQA==
X-Received: by 2002:a05:6e02:1749:b0:3e5:4eb2:73db with SMTP id e9e14a558f8ab-3e57075d074mr31456455ab.5.1755141973180;
        Wed, 13 Aug 2025 20:26:13 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.201.32])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae997ea94sm3994629173.1.2025.08.13.20.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 20:26:12 -0700 (PDT)
Message-ID: <689d5754.050a0220.163d14.6932@mx.google.com>
Date: Wed, 13 Aug 2025 20:26:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6986690677628852677=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, liujiajia@kylinos.cn
Subject: RE: Bluetooth: btrtl: fix rtl_dump.fw_version for firmware v2
In-Reply-To: <20250814025552.10627-1-liujiajia@kylinos.cn>
References: <20250814025552.10627-1-liujiajia@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6986690677628852677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=991280

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      23.71 seconds
CheckAllWarning               PASS      26.02 seconds
CheckSparse                   PASS      29.35 seconds
BuildKernel32                 PASS      23.70 seconds
TestRunnerSetup               PASS      468.21 seconds
TestRunner_l2cap-tester       PASS      24.54 seconds
TestRunner_iso-tester         PASS      36.30 seconds
TestRunner_bnep-tester        PASS      5.85 seconds
TestRunner_mgmt-tester        FAIL      127.16 seconds
TestRunner_rfcomm-tester      PASS      9.21 seconds
TestRunner_sco-tester         PASS      14.66 seconds
TestRunner_ioctl-tester       PASS      9.76 seconds
TestRunner_mesh-tester        FAIL      11.40 seconds
TestRunner_smp-tester         PASS      8.44 seconds
TestRunner_userchan-tester    PASS      6.12 seconds
IncrementalBuild              PENDING   0.45 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Add Ext Advertising - Success 22 (LE -> off, Remove) Failed       0.134 seconds
Set Device ID - Power off and Power on               Failed       0.124 seconds
Set Device ID - SSP off and Power on                 Failed       0.122 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.227 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6986690677628852677==--
