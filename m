Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337186;
	b=2Zch7mXC8bJUGY7qlo5E+5lQiuMIqCz3k8ZQGNJM/YVLA8QPLbT/OKKzc5CpJBGxiLR4
	 lADf1tST1LdMgmC+RTrffRXnDDf1Kc12Mp5eZWiNsRW3N4vDUH5pzdFxiMh2ziBVkz6Iw
	 1j40LkJPEr3Lg/LcM3Sjm+5le5i8WwucI4dEYKPXJYSHYlaVM8yA/fVbdT9bFJ6ZIJFLY
	 Okz8Fz8WA1RNFocO20HLq14qYCo5kT9Ae9PrgGXZJBBalq51/jHMZI+kseJnt1XdycZdA
	 F5CRbjpT9EhUWlCyJQtYS3r3OPHd8SSo666f9obv/HAWcXWtPOQgRspzDAq3IaEkrMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=wiWAE2MARW+uYgsXqMn/dvHTkpsUAKHphu83cjphvrY=;
	b=mK2tUGP+BuwyqpcmB4VzS9/tP8J1CmGSRBTVtXxO955Srlpr7bXLN2Co10GLi/ellc+o
	 HhDRpgJpy5Wq1ycTU5fypRcc7ObsWC7nf69jC1HGSCqkpmVoh667MKxo2mbjUcCPB3h87
	 valuqGGS9z7pf3QEfDTu+bXmEyAQ7qtYeKqSnXssv6KE28NzLw0DSxyUbwR8TafK9Fhlj
	 FMHUwONQmLWJAbF0sT86K3v8DyFQEoR308Ur7Yo6LHcP4aNnxeE+QmVzX4ikgHwZc79Bh
	 le9WEAQL2gJiqFSvnmmR+RaSLb4iA+J5zIT6xwJEbrjDMOL6ZobmShfwcehLLyfGOcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yyQI6s24;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694A6606A320
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 18:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 694A6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yyQI6s24
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e9d7791b00so20787855ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 10:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794337186; x=1794941986; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wiWAE2MARW+uYgsXqMn/dvHTkpsUAKHphu83cjphvrY=;
        b=yyQI6s24zAEkmueRhrJdvrZx6VOGanw1tENKdWTG0Sq2uyvLP0AX6RXu6X+vQmtmbE
         jUpoTmO8xZ9bJbWHdmk3AhFyAvTxk6OfD0o9rpvYqE1VO7nMqvyCJ5tMMsFz/JwGRtuE
         4UtQAm1Y7dy4g59iXjWMHWuJgb2mKzdSXu9ilukboitMcHMlw4k/eFotZEVfcuMdDZ5s
         gXAKn0uKz6SBgc/p9guRz1ZR88PUH6pOV2/TxSl3HTpRUz69wlacpgIwVK4xqziYi/bg
         dyRonH6BW2yiU86YHgtxhdCCbFSnqSeEGXYsthWbyp8AMeKms4kM6TujGWIH7mDBgdd6
         fHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794337186; x=1794941986;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wiWAE2MARW+uYgsXqMn/dvHTkpsUAKHphu83cjphvrY=;
        b=wkJKRONffguX+EET/aVacwWjVI6XuJ017HTgVMaq/P3spYVVrNdyNJQPGyQ+wYCZGZ
         GJuhvYmC/+1lc1hCHBwyDqLpytXl2BwjhKji+fIEhTVbYIBPy5LJ7of8zNwKMtSAKLm/
         WU2Sj3HMFR/c0q+8EnUxR/DjKxiDEMocBBxFF3ujHhRxD5dRzhg3Yzxbkg0FvidWQcvV
         jY1z+p2ICaIiqPh34j4f/vaDSactgiA4/bS3Dhg4ilY0PuVzJdnCwqv6FBEieOcQIIPd
         50Si9YDHvzTZgnoKf14OzywVgOzhwUG3khHVBZO56EDIJ+GW0CkmY8CfPg35hmRI6T+i
         U64g==
X-Gm-Message-State: APuU4Z+MQH8TMtMrhDgfYamgrhysCV82tBwfVT12JrubhpnrwqHqaiSr
	cemuFf3vCyAmUWN+6XI/dK4aJrV1iUJHJGud0rsvqRfW0G+J1C5idp+SDsuzJw==
X-Gm-Gg: AYBFou1BLXKVijxX7vdYhHT9L3nP8KAJfBz6UWGc9BspXnSkRhKsUvlbqaFtfEa/tFQ
	4N/AVY7iPdVX0KA9D90o6KIFvO3q7Hbwg9cIBfU2rNJ0l1SmrrcMXkYF9Gc0Ha3iJQSOrsxohGa
	C2CXHyrU5L+EWin0lUP7zebeqUIizwu1XYgh0CGNVh2KMSNWSB2IynyePnFbjvlaPXV8e8rg5Hh
	GtgEKagwOfBnqsvE6uZd9MtwzboUtxMVy+jSB5PeVAex1LHFAx6vMfRYmMMCqDxu0gGaLjyZj+D
	y9X94MHmwNSF0P8CXjNUiBu1TzTLFT5kabdfA/J5aSGzxkf1T2FYlKgte5vmpwGKEW86FGExsZa
	uRtj3yLoJ4MBikMVdVKfTjayzWkK+tjUAB4CJ1M2rMZ/xTMuvn5Y0xbSmgPmF7UHIYf5dhddnQH
	8pKIXFm9QvNbtcnX7d/Q5The8sRJJRsyAVgmUUDQj/ogBZnDkbQLrGUZlIr9vcqgEwhEexd2/Fk
	8kXZqZkJhp+49L+GPL5pNR8xBe8ErO8HKqxk1MlKgzzGSaJkT7TntMlxezFAfEVbcMQ4j2Zc0uu
	JTac/UQA
X-Received: by 2002:a17:902:cec9:b0:2df:90d4:7758 with SMTP id d9443c01a7336-2edd7ab6a43mr171655ad.23.1794337185717;
        Tue, 10 Nov 2026 10:59:45 -0800 (PST)
Received: from [172.17.0.2] ([4.154.174.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6dd4b61sm12592415ad.60.2026.11.10.10.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:59:45 -0800 (PST)
Message-ID: <6af369a1.6655ddc8.1c7c8.4255@mx.google.com>
Date: Tue, 10 Nov 2026 10:59:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1747871646429465981=="
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
To: linux-bluetooth@vger.kernel.org, piyus@iiitd.ac.in
Subject: RE: Bluetooth: fix stack OOB write in the legacy adv data path
In-Reply-To: <20261110175334.676816-2-piyus@iiitd.ac.in>
References: <20261110175334.676816-2-piyus@iiitd.ac.in>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1747871646429465981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1207528/

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.04 seconds
CheckAllWarning               PASS      27.41 seconds
CheckSparse                   PASS      29.59 seconds
BuildKernel32                 PASS      24.15 seconds
CheckKernelLLVM               PASS      26.22 seconds
TestRunnerSetup               PASS      554.53 seconds
TestRunner_l2cap-tester       PASS      13.20 seconds
TestRunner_iso-tester         PASS      9.60 seconds
TestRunner_bnep-tester        PASS      2.86 seconds
TestRunner_mgmt-tester        PASS      84.44 seconds
TestRunner_rfcomm-tester      PASS      4.22 seconds
TestRunner_sco-tester         PASS      5.17 seconds
TestRunner_ioctl-tester       PASS      4.29 seconds
TestRunner_mesh-tester        PASS      5.16 seconds
TestRunner_smp-tester         PASS      4.04 seconds
TestRunner_userchan-tester    PASS      2.93 seconds
TestRunner_6lowpan-tester     PASS      4.15 seconds
IncrementalBuild              PASS      23.04 seconds



https://github.com/bluez/bluetooth-next/pull/1105

---
Regards,
Linux Bluetooth


--===============1747871646429465981==--
