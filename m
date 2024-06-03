Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F732E414
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 07:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717398058; cv=none; b=srcgINfqKqOCst7LJoqyNgpAZzOjSLU83Xfp8R/1FiIq97ewgEp93oKMnLwHUhO8HZ/7lRVcXcOqoE91JKVbuSkPtOQqtwFquFWA2ZMH23myM9n+1Qb+ZSe1bcuG4hSlE2DTUibJ31+nuEO4cqWBT+A3MZldc6SW6T7sVd+oeg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717398058; c=relaxed/simple;
	bh=1TSD7nBcUgi02lOJibCYisaNdmf/5YibdUsslGJU29w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fI7urwVoMlilIkQj/5cUuNWvYykxoDKDfdHAJtOohvfSDeH9w8x12OE8MiMlPK2q+2r/zmyCoa2guQHxtngUCERfBDwIPDTgko/bvRWF32lz1a6215YrhTO4g+OCJYULt1fL/SvzTeB+buua+Kzw9l/NL4Cn14IcpbDjSrPnxhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbvKWgCX; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbvKWgCX"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-62a2a6a5ccfso40456197b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Jun 2024 00:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717398056; x=1718002856; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2AhRxcr8SPOukTEfi4W2RlmMnLoGI7UYawQPKG/z27g=;
        b=PbvKWgCX0T8L5dczhCCApqIab/K4gAySNywJlpyWKhxwbSjIHRhzQMU0whX678XVdq
         XHlYIEI+DoEO/r2na0wUFnuE03AJSPXoaAe8zubpf4avqbNhqL204AWtVCWAB/5+3dm+
         Iw/2WSxNCXnCKb6YJW784NdL3DJmKfSSMPggJu+5r7JyDlFDoUfiZwM2Lsr+2EDkCVYl
         +jRkU71Ngzp4QF6WNdhvs7IVWsQrBmX5tOH49EHX/s3ApNLlYXeQIto6KRMYAlEhnMJz
         cFbTqaR6lzKyXanTDUXeOAxW7hO2n3CWYMJ4AnmPnUgzrvCx52Uzok865rNFp04NjGnn
         W88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717398056; x=1718002856;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2AhRxcr8SPOukTEfi4W2RlmMnLoGI7UYawQPKG/z27g=;
        b=EEuqDhikhTXh1Q2v2BDZiiFijyi2pGjRUWkagWjSwaCFXDlGzcIy/2+xbW9lgVb/nw
         dQ6q/Msrx4vld8/CdXMmNM4F+gnko5CxbTXkizUYBHKnOamlB5B3PT10R1ay5c7SGrZf
         tev0d74dNIF3DlFA64m5b5KvWSKnkCPZ0aKs68c46P95gWBDtJlLQ0UcbrVnO1N6uS9D
         iSjLqhvey1DcrVfx96JtfneNuiV3rpBM0ud6TtNo8DYb5i+50Ux+5jVC3lRj2f3W0Fzh
         wBujPL6eaf//mdMEdYVDUdq6G8VOHz0SBltIBcGGL2TSNIc7RfQLseuOkhbFugyxS7sT
         oXxw==
X-Gm-Message-State: AOJu0YztvU9GaZjd0Xb/vtIwEpNpN4G84i8LrRDfydT+fiNxNZ+uhibP
	ASyMJIN9Nlz5UDS+6CB0aBZmjGgk2Ikz6uAY9cGNp18ephwPWF4v6IdlLA==
X-Google-Smtp-Source: AGHT+IFIZXZ+3XdTbu9P5G1S7x69Kw3kF571h1G8rK46ymAS6WdRD+ih76YigzeTTul5CdHvynseTA==
X-Received: by 2002:a0d:eb16:0:b0:618:1202:3222 with SMTP id 00721157ae682-62c797e649cmr83172517b3.38.1717398055341;
        Mon, 03 Jun 2024 00:00:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.75.95.210])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f317070fsm259305685a.108.2024.06.03.00.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 00:00:55 -0700 (PDT)
Message-ID: <665d6a27.050a0220.6e66.b0ba@mx.google.com>
Date: Mon, 03 Jun 2024 00:00:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7118063530524705417=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v2] Bluetooth: btnxpuart: Enable Power Save feature on startup
In-Reply-To: <20240603062255.121063-1-neeraj.sanjaykale@nxp.com>
References: <20240603062255.121063-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7118063530524705417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=858158

---Test result---

Test Summary:
CheckPatch                    PASS      1.02 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.80 seconds
CheckAllWarning               PASS      33.19 seconds
CheckSparse                   PASS      38.79 seconds
CheckSmatch                   FAIL      37.14 seconds
BuildKernel32                 PASS      30.76 seconds
TestRunnerSetup               PASS      528.73 seconds
TestRunner_l2cap-tester       PASS      20.63 seconds
TestRunner_iso-tester         FAIL      35.71 seconds
TestRunner_bnep-tester        PASS      4.90 seconds
TestRunner_mgmt-tester        PASS      112.73 seconds
TestRunner_rfcomm-tester      PASS      7.51 seconds
TestRunner_sco-tester         PASS      15.14 seconds
TestRunner_ioctl-tester       PASS      8.35 seconds
TestRunner_mesh-tester        PASS      6.09 seconds
TestRunner_smp-tester         PASS      7.02 seconds
TestRunner_userchan-tester    PASS      5.44 seconds
IncrementalBuild              PASS      28.39 seconds

Details
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bpa10x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bpa10x.o'
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 116 (95.1%), Failed: 2, Not Run: 4

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.178 seconds
ISO Connect2 Suspend - Success                       Failed       4.224 seconds


---
Regards,
Linux Bluetooth


--===============7118063530524705417==--
