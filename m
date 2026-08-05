Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841753CDBD3
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785958865; cv=none; b=P40jxMZJ/t8HJai/5W5v87WxrG3HX6tmcDbLo/6OKBYKdUhUrU6V7OSKphNOe0H6P8KhLbMhCznUE+Q9vrwZUfoLBOSMuBGK6W3p1alpBM8fQt85ELc4onGBYDWKO7zhzvWhMO/FeSg3lHjee+EK0oYy0sFKqDlVpJS1ycQwA8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785958865; c=relaxed/simple;
	bh=ImIJYQ+dK21cjoezO4NYJ8/kO7nVUQ5MPInBBoP0rJw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZtB29+OQ5cq4YmJfId4xgdulWnohoh7DbBAIsiGLX00H+bB8hM3yPTcNOfsYJS+oHqF9qzNh5kIIDVHq6LV0LmX2h7GNxusT7zBYaAG/YcuaflQv2cDG2KYOIVpSzlIk+I1BuFQaz7y8XvEU0Jx/UruqigPTfcXn/ww8d+jwfMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmHXD5sC; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmHXD5sC"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92ed19f4d60so16549785a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Aug 2026 12:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785958862; x=1786563662; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qlro30/qVIBohfYr7JjXtpORd9iMgb3uGN0XatSBPOg=;
        b=FmHXD5sCtLM5Hu3zri1Qs6yew/35Q6EBW9xh3/u28up7sgyyl6N3aUjBPmSCh9iaZC
         UvEKzWsnVYAo1XKVJMBmgaLFZ4rGOyk9BGlwdind/YggN3coOxUu0nt4F7394pmB0f2K
         H0MpNWuIVcUEgVbcM26j5q3D8OobKY/odaQRjzJ+qygP7uTmqbUBG5v6n67rDmHX8yO4
         VCN1MlS4VtX/JF4DSAq3RR8b79ONeEH1TtqvZWSOQdyAxTCj9x9LCX/BH05zYocovgDb
         o8NUhJ4Xm3YeBqyPpIdrBJZvWY33wtoFlnvXJtU6hDn/P4SVPA/UiGv13MhtbKr1+W59
         o87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785958862; x=1786563662;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qlro30/qVIBohfYr7JjXtpORd9iMgb3uGN0XatSBPOg=;
        b=aydzjbsr3abYZ+1968yWeb6pR93k3kGGXNLDxWSyT2iOa61wMX/wvyhBL/k8ydqk9e
         o0fZYD7gGYKdZ0m4+va9tDv3uKKRKegnWFHi2MiU93G74NnuhC8nN/68WX03x6SFg2Qw
         FVWsechjOmGwREjFaix+DG3Ln+QsE1BQUzHYIJIKONFDI/NgOjVwiM/6q8teVmWD2Uru
         9N07CzKoZpHylR4AAoUz+wFU9Hb4ReMkh6urGcBUnp+PpW6KVJ6svnlUarQvUQesMk9n
         8KOkyHjhuR3ao3ylhsSLxxb50UXxv9MubLV5gU/B7ScKRJMcjr2Nihs/lElZNwKBKKhy
         HIIg==
X-Gm-Message-State: AOJu0YytcsXGvAzHF3kgJInMcMUvRhcti1I3ilAS7f4o/q7KucCnPbzi
	meKj4F0KHWqAbonYjMS0AzJTvRmGezw6Tl/VBmWaVf9EuZ4MUiEDiDrksrBwgg==
X-Gm-Gg: AR+sD11EM8FcWxj6LmInhrFrPgF76uFIHDJKqt7Vi2bvQCry5q2dXuoJI892Agabn5d
	siTsrtb+5BtFIiRz2kAoDhtWQ9Mp5nf2IOVTRJLSS823M9LgQsDHn3JY6YjcW4r3NjXJ/6sbYS4
	ndrfU0qqc5B9xU23NXqRaBSETtMd5LW80pDyCz94nnJQ4tD0cikwMq8CzU06bPjCmfwtXD3AEeP
	uU8FIs4W11Q6gSpeDJDFtcf32UmLq3oGT28zjq++dJvmt9zxWRg18h9CFu5IeqGZCJKAxqbw5i7
	mTQ7kIryh4lli2jBCqfiymBD/+Aqm8scKoZbasc/Wvyt277Sr2Kec37Ee8aNnrzVbbpnMgITBmv
	ejZObHPgMIGu0Pbfr2O2Rjlns/gNV833jGNBdLxHeb9bZHEexqHBOTmVRMpHcpyEEALe+GERscN
	IwUsZFdqVFyhHhmkep5+A0vzGh6OwbiZP9L6Qq2cd1b3vZpszvvZJHUkSR4+YqKDSvFcEP1g==
X-Received: by 2002:a05:620a:2846:b0:92e:57ea:8c8b with SMTP id af79cd13be357-93659240108mr173489585a.0.1785958862226;
        Wed, 05 Aug 2026 12:41:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.171.254.156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9364a42a461sm220633985a.12.2026.08.05.12.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 12:41:01 -0700 (PDT)
Message-ID: <6a7391cd.5cacff2a.2ca7ce.1146@mx.google.com>
Date: Wed, 05 Aug 2026 12:41:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4094089241317567220=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, acharyalaxman8848@gmail.com
Subject: RE: Bluetooth: hci_event: fix out-of-bounds read in LE PA report reassembly
In-Reply-To: <20260805173701.6649-1-acharyalaxman8848@gmail.com>
References: <20260805173701.6649-1-acharyalaxman8848@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4094089241317567220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1140947

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       FAIL      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.41 seconds
CheckAllWarning               PASS      30.00 seconds
CheckSparse                   PASS      28.64 seconds
BuildKernel32                 PASS      26.48 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      500.72 seconds
TestRunner_l2cap-tester       PASS      63.12 seconds
TestRunner_iso-tester         PASS      82.78 seconds
TestRunner_bnep-tester        PASS      19.41 seconds
TestRunner_mgmt-tester        FAIL      226.06 seconds
TestRunner_rfcomm-tester      PASS      25.61 seconds
TestRunner_sco-tester         PASS      32.32 seconds
TestRunner_ioctl-tester       PASS      26.98 seconds
TestRunner_mesh-tester        FAIL      26.08 seconds
TestRunner_smp-tester         PASS      24.08 seconds
TestRunner_userchan-tester    PASS      20.45 seconds
TestRunner_6lowpan-tester     PASS      23.48 seconds
IncrementalBuild              PASS      25.91 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_event: fix out-of-bounds read in LE PA report reassembly

7: B3 Line contains hard tab characters (\t): "	struct hci_ev_le_per_adv_report {"
8: B3 Line contains hard tab characters (\t): "		__le16   sync_handle;"
9: B3 Line contains hard tab characters (\t): "		__u8     tx_power;"
10: B3 Line contains hard tab characters (\t): "		__u8     rssi;"
11: B3 Line contains hard tab characters (\t): "		__u8     cte_type;"
12: B3 Line contains hard tab characters (\t): "		__u8     data_status;"
13: B3 Line contains hard tab characters (\t): "		__u8     length;"
14: B3 Line contains hard tab characters (\t): "		__u8     data[];"
15: B3 Line contains hard tab characters (\t): "	} __packed;"
22: B3 Line contains hard tab characters (\t): "	memcpy(hcon->le_per_adv_data + hcon->le_per_adv_data_offset,"
23: B3 Line contains hard tab characters (\t): "	       ev->data, ev->length);"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 495 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.258 seconds
LL Privacy - Unpair 1                                Timed out    1.875 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.927 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/537

---
Regards,
Linux Bluetooth


--===============4094089241317567220==--
