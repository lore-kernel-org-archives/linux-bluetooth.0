Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148030;
	b=5tU5bAjKO6s2Pj73ouDvOQW6a9OFaDQV+q//QxKv9UESWFCsKlHFWHIUv/a4PDC2mdc3
	 qF+nROrv4NlCWyhT2SrBmfRWWfM992FinX/k7QPuQ821XPDYQ29C45z+SOvFNglQRywTe
	 oRBiREXebzYvCe4IjeCi/Vdm+Boh4MZgd6F87JZpiE9IX7HovHZoibOvaUm/nZEKHA3PX
	 DiiTPIx196v9PwLHH1CEX0K29QAUcdgwwco9Cu8o3nmqKZIAKqroFrdybce93a8pJULi4
	 q5vGqhfAgqXjYMm+Ysp8ntFT1gzYNMnjM6NIbJMjjUIT3A+OoKCXVLo5uCNssln0N2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=7wH2BdB9U9PaPhfrQ55I9JOio6TnQStUOzLzwky1Stk=;
	b=Be8R6I26YqELhBvsABPwefSukA0+aPZEDIlMqTeLDDfkbexfy83T5aKejlmV1ua7GWQh
	 dTOYB9BIWvSySC7kPB3o9njK+cfzbDLYtYj2BvfDTU+gFfwbBMliCYncfFDiyQ0bGKRJL
	 1q0RcXi86suHgb5mLLt437FbDQMogaCI8hhEk1K1zIYUqaQ7H0H7nkRfKWr8jvXTazBZR
	 GKkfdPLisfKCgeX8ItFOY7MNZjj1iCj4HPKMbiSPZ9hmPBtSJXyb2AQtA0C7WSIBqOYdK
	 GKeO08xNGe9n0f8Opva3ZCjn3Oyeoe0QA7k8dvasfdanzDieD28P+TFoaHFSbPYGE0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tKXPyYu4;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05CD606A31A
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 00:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A05CD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tKXPyYu4
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-847ac7ccd85so281643a34.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 17:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793148028; x=1793752828; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7wH2BdB9U9PaPhfrQ55I9JOio6TnQStUOzLzwky1Stk=;
        b=tKXPyYu4AZb0VHWM+peQKuc1ztmLBizy4RjuQtZbd2bKBtZf5HMLcsd9FfD69UIhCz
         zgy8uSHBlRg7oh0tRZS7KV+QmxYgYHdNQJIKUTLqH6wMfBac185yD6IhceBAMiEL4xsZ
         NK9ti1AcojPooyTWDQzmNlSiNSUuMwEGs7BSAPTzTD4oppnBk+5s57CKDWPahEg2UTeN
         rBsk1q2BR1kRF0nYXwwJ5Q/zx6lJkhfLnlzLIzRXs9kCIytg8j+dR0EKfdm278lHQ2tC
         UVyTB9NfLLm3eaTI1MvA3aw4vsUx+8HON8MaB5qt6LkMkU02h5QwI1yE5YdiZdvuZR0+
         PrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793148028; x=1793752828;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7wH2BdB9U9PaPhfrQ55I9JOio6TnQStUOzLzwky1Stk=;
        b=XE12y4aGij2hY/ECQn+GvwFw5InTuZaLiX2iTpEyfpcV+wy0YHo4XSSsDv2tgCWs4A
         iL6UM4PSMFpZanA68p6aJvAxaQ5KBlqM28rYXJ4ImjPYjd+ktxXa9z6hl+geE1KV72S+
         Am02cdXIFMsf5G3UVO4qj4bGei0pwyORWvRMvw2+QZ7iZS9/YxbqJG6vFGG5t9Fm2uP4
         Zu2mJy3MwmOaK8G3xnjbbD01P7D3Gxc8ac6xQcurclp4tYvambI5D2n2hyEtM907WvlS
         PICGj1zd+Lt5fqLnfZXt4kmU4HX4OTh/JTA9OzddYZ0bolyGHlLMnnSgF5I+JJZaBCDG
         yDDQ==
X-Gm-Message-State: AFq9FYLeZOihXnVR5yWme/FSnAg5SiMzIeTl4YjxET33FD8AfCX5z4fI
	OHuHWIDLvVBjKlccOVCbwRUXfLc/AsqyMdOez8pLy7k7xSuufjSsdjR+c5KGSfiS
X-Gm-Gg: AYBFou1sX7Rp9JoibDuYCELe2IpzN6iOez0S9hnhF+glSZ7lTxPvJgAcqZDubkk4pvS
	EHjvU/8eT8nLOvWmwyQ9YGoa62uRfxM3MhxTVwzR1a5vqlw5Icrpm3yOKdhzqBDjQUIqKBeupyJ
	dPE4QPmTlcDSYAQPdDeiCMy8CY2K1DRUVFIPPb4LWb+ioK4H6soeaMRcTDVcFCXkiafAW7y9bXW
	edCBnNx9KHd2WJVtMcOYcA4yBOUqxSRTE/RB1z8P02+ZMNpQsvkHaN9CkUoJTHfJ5siR5ySNwCa
	5T6r16o+uDn8i4Lwu8BWiC8MTgigl+Ke9R8f7JIkGgQEinJIoAIBzHa7P4CyUbVxOwivAOJ2cDf
	+KsGG8Q7dCWlnlS0ON+nBX0kRpl9uaCBbZ2c6a5qcGywXoAd3BMo1R7HqUedUXEtS8bHy0LiJx3
	g8JgokoYQ/zvNGc1JGwf7kjkOHHoMf5cfPq1SiO8SbWDqGhmFW/V3xDS3DadydI81hmWcfL24LC
	yK3Xzcm3wje69NmAjZpw17fmGXLxL1II0LsAIhsW/ThK53WGn+XIFgve94wAQ==
X-Received: by 2002:a05:6808:118b:b0:55c:836:5955 with SMTP id 5614622812f47-563a2b520e9mr325059b6e.44.1793148028604;
        Tue, 27 Oct 2026 17:40:28 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.11.75])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-563c363902esm159611b6e.2.2026.10.27.17.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:40:28 -0700 (PDT)
Message-ID: <6ae1447c.31957b85.6547a.458e@mx.google.com>
Date: Tue, 27 Oct 2026 17:40:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2260753257080136292=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: [v3] Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery
In-Reply-To: <20261027210057.44347-1-kevin@simpleble.org>
References: <20261027210057.44347-1-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2260753257080136292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1194926/

---Test result---

Test Summary:
CheckPatch                    PASS      0.86 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      19.69 seconds
CheckAllWarning               PASS      23.75 seconds
CheckSparse                   WARNING   24.59 seconds
BuildKernel32                 PASS      25.35 seconds
CheckKernelLLVM               PASS      23.24 seconds
TestRunnerSetup               PASS      425.00 seconds
TestRunner_l2cap-tester       PASS      12.94 seconds
TestRunner_iso-tester         PASS      8.87 seconds
TestRunner_bnep-tester        PASS      2.77 seconds
TestRunner_mgmt-tester        FAIL      81.10 seconds
TestRunner_rfcomm-tester      PASS      3.98 seconds
TestRunner_sco-tester         PASS      4.98 seconds
TestRunner_ioctl-tester       PASS      4.03 seconds
TestRunner_mesh-tester        PASS      5.01 seconds
TestRunner_smp-tester         PASS      3.88 seconds
TestRunner_userchan-tester    PASS      2.80 seconds
TestRunner_6lowpan-tester     PASS      10.21 seconds
IncrementalBuild              PASS      18.48 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 515, Passed: 514 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.022 seconds


https://github.com/bluez/bluetooth-next/pull/1012

---
Regards,
Linux Bluetooth


--===============2260753257080136292==--
