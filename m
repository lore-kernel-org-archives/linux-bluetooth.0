Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32F9382F13
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821218; cv=none; b=ScROJvEJqUahjZbuFS/wPZTZyLWhVAoxokVkM4IDANdAwTFAtQWLvMn0PTNFZhWq7s7vA4jviTyQtPiXdj+VnbiQCkD4y5LM54Wf4eOFq9job1UY1x7r7XOZjYxrsqVIVXIO4BtEliwJeJVtJfi4XtTCoN6DdSB8KE30BJQcHFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821218; c=relaxed/simple;
	bh=oksVQh2wetVDR5QPylozi7hzW88xSTVQZwsxcTkkE8g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XHbeH7jIARq6UETMUjjl17ukrvj1K7UgLSuuWAHimyzLJ82gVBHR0BOtHogNMN6+Op76vqD5np0KK3Utxzlx3jbdbI+kQPuDpU7N90erfLMQMG+BAAK+5OFUhkcBss65eu8lS9CqI2wpJLD/+k/1C5MeRsZi+bHmwXeol84tTLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaGxo4TE; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaGxo4TE"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6aae11ddd13so151032eaf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 08:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784821215; x=1785426015; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dglgF/zNwta7B51Bjifm2w/kKH4HutuwH65+lKXt72E=;
        b=GaGxo4TE3186VfTNbSwVKqLrOaCzsAGsnfkGoTJvY5S4qkchyth/v2yAviuh1Ml8Kr
         NvKBjrpeDyPXEyn2BVdEqgpsmoeIST1Jc7z+UKPbKIEdTUbC3xjse4tYf7BBjImVREOP
         p+vAv6UxQSBJUEeGXKEvSzD+KS1D3v/f6RfleJxPh6VCZi/xRnMaX0rPkeXcnSta7wgT
         19xylIx29tbsHIwWCx3hm9RSPIb2UWj3qMxe0f2S2kvXQleDi/9GCUiXEBarTb0QatY5
         bRYyl+En39nWvzwb5SDkCzM5u7Ur7WaHMECBE/+DzIebjitP2Uhq5n8/n8GqH2gQScfj
         ibBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784821215; x=1785426015;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dglgF/zNwta7B51Bjifm2w/kKH4HutuwH65+lKXt72E=;
        b=r9IaiSVPlUKHKScyIl6nCUEj0Y6GBKGagxJ1h/IilBqPYe7pM+BqMp7M7B5wi+W3Zs
         UlsNKUud4YrLBkaUrOJymeSAsHq7aXGCp+lP57B0HyNYSedM/dPO0SqBGi/pxHt2ryiX
         aTXwYk0UolIqEBGV1fBdR/A0rG0XdRNOmEFM454Tk1FAdvt8ar+08bKEOLrYPsh+65qg
         QH7XHrTthlfu9EqExBS2PZtb/6SPCrc8uf28gqfkCEP5kvfTFsAcA6VCaWGh6iMTcitk
         RcBLvVstZIZB6i9qvASJ6r2X1B7krJ/GpcVuh+rOOuDBntOcXHbz1TlbjOpzw+qm7a/a
         NIGA==
X-Gm-Message-State: AOJu0Yzyqyzr5YbwLEVI30qZGQQLUhRr09VwZ45UIntX5Qrd7UNf/D0J
	ZJogb7bwCowW6g3sTsLsk13W3gGj1evBo6LzPzISrN4da2yvocyVddyU0gUG+Q==
X-Gm-Gg: AR+sD11f6Fv8MP9HkdGOGgKqaJG4OoAi+4Cf5l2qRlPUtIGvybfr23GDrcYVSADdtcr
	njywowilTd8cT0jueaaQ510AZpUFDPfdFOst2SXid9Fv3eoVaGtzJU2nsTj5826y5NwZXa3idgK
	tiYIfVWTI68a/O5C04YQswEYEFeGRMQsun311AuUbejDx0D01PXf0H+2mAggBGZPuBavchOCIBF
	xhb3rao3uagX/KOX/qx86rYQVtDiiNOHc4DiC5grOKf6hecyf9P8XzulAZgKSghyDaU1RfmKllR
	1fvW7aPFoYzE4CxGzf0bKspUDXZ+RhyMuWALq0LC+AxDhlg3Qt3/KDh9sPDGHm/cHfup0D0cNL+
	piYyNUjL/IXJFw1t8vorcYujTOueVcxV93U/TY3iCLX9qscNmsXFjQ4Hf2kBuZsuVjpEm8o/YDn
	YzOKQEmC1j
X-Received: by 2002:a05:6820:989:b0:6a1:7cae:53c3 with SMTP id 006d021491bc7-6aad407dd81mr1331467eaf.31.1784821215102;
        Thu, 23 Jul 2026 08:40:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.101.53])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aa79301fe8sm3683059eaf.10.2026.07.23.08.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:40:14 -0700 (PDT)
Message-ID: <6a6235de.00a9ba89.b3671.6169@mx.google.com>
Date: Thu, 23 Jul 2026 08:40:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0420610524574159101=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhangchen200426@163.com
Subject: RE: [v1] Bluetooth: hci_event: Add HCI_Write_Link_Supervision_Timeout command/event structures
In-Reply-To: <20260723095616.1543159-1-zhangchen200426@163.com>
References: <20260723095616.1543159-1-zhangchen200426@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0420610524574159101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1133206

---Test result---

Test Summary:
CheckPatch                    PASS      0.84 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      1.20 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      19.80 seconds
CheckAllWarning               PASS      22.19 seconds
CheckSparse                   PASS      21.50 seconds
BuildKernel32                 PASS      19.58 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      326.53 seconds
TestRunner_l2cap-tester       PASS      50.67 seconds
TestRunner_iso-tester         PASS      72.05 seconds
TestRunner_bnep-tester        PASS      14.13 seconds
TestRunner_mgmt-tester        FAIL      191.83 seconds
TestRunner_rfcomm-tester      PASS      19.47 seconds
TestRunner_sco-tester         PASS      25.38 seconds
TestRunner_ioctl-tester       PASS      20.91 seconds
TestRunner_mesh-tester        FAIL      20.66 seconds
TestRunner_smp-tester         PASS      17.85 seconds
TestRunner_userchan-tester    PASS      15.27 seconds
TestRunner_6lowpan-tester     PASS      17.90 seconds
IncrementalBuild              PASS      19.83 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1] Bluetooth: hci_event: Add HCI_Write_Link_Supervision_Timeout command/event structures

1: T1 Title exceeds max length (90>80): "[v1] Bluetooth: hci_event: Add HCI_Write_Link_Supervision_Timeout command/event structures"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.211 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.141 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/481

---
Regards,
Linux Bluetooth


--===============0420610524574159101==--
