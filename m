Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018582;
	b=1j1ILd31CcMP+xjNro3vEA6JJ//mrreqJLSy+IJufBR65yM7FpecKg4fPTYDpcGTvtBL
	 EGzkhpcCjUWDETZzjX1r49qgRB7mIkH7flNA08kTM/RnPGkFk5SPiLQ7QgXHVPWZdv2zO
	 Ct/feVly2GeL10zFT81ZmusJUJTbKWAwCwUfY90aDEbt+8+JSQ2VKGeIdgMJx6r0+72jQ
	 yzIqEvtuDfGZXVqUIdntToG3171ZBWsJQ1zbAaS8aTcQHWeHqGupEEJcHcNTMWq7WhzCf
	 BBwH7DZaGnb059dSv78pmGDP4oA62A/K+fKuVlyFz/AQiwQEj/XncH6w9zeBpSkQS3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=IFbD+cIWUyqDmGXizk9r+V35BNnh2eXYMTxLcB3olXg=;
	b=1T/P2pdcuiimsLpLeAP/0iUT4BZkKyZ/N5/M1h0P/2R9Ym8M6GCLokMhH3ANeIqIlp5Z
	 RF54jXPdAuOZUB/itTzxTNBr0PsXMqCAYnbcaDb094yKMCv+K/u/ItkkygYQsWtrAy87a
	 LVYNZqJdONEszSwIXeQLt9AAaTE/mvb1tA2el5Crc4TPMSg4MdW7H6/EkSbkYUXWbN8wA
	 5oZ4UJMaLFuZYJjxQZA+UaO72ggyt4dWf7ZNwnOzLaIquKRxkdczjJMNvdluVReCRr6A/
	 JzuIlFLKPbRFVQnymbOW4k/DDPeIe+/xKVgqADCe0GCFBqTD/OaCImy9DhaZkZtTYuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="c/tnXG21";
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C6D606A333
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 02:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30C6D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c/tnXG21
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f2049ea7aso101320885a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 18:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794018581; x=1794623381; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IFbD+cIWUyqDmGXizk9r+V35BNnh2eXYMTxLcB3olXg=;
        b=c/tnXG21v/icTIDM6IVgdST2C3G6PPdAfi1OPAHUZnHvr1kACF9S4Jqm/6Y1AydEO7
         iYJCeFoUx3+BXNtF6RaSJa2rBaomkE5pP/kUuIriO+xyPZWxfFELeSdrbQ03hoIvhWaB
         /i+7jkyF6woz6bxeUzA5ltXRIzKjA5ps+7ph/bTnUO3/SnNhFHxdaaQGsD527wKtbYY7
         5uCpsdiYiidng6jZw6D8tLU+Df1L8GgyWch7h2GqRUPFgJeCmxrnyuqQ1GpvX7lH/VOK
         oL2B2SsxPjT5/SM55RuvDLOGOBYfhqKmLhXkJBMXpsG9KSrDdMksXfW3KJrfgNEMaHi3
         L0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794018581; x=1794623381;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IFbD+cIWUyqDmGXizk9r+V35BNnh2eXYMTxLcB3olXg=;
        b=G3ZVCGTTkAjLpYv3mqR7QPjxX1SMmwn2BFG1siWgGnXQFPYKzEap55xailtgVsMxlC
         sKW0R7+fNrR465FLiMi1Y0LS23ju75eGSDaMavK0JiwLuHaxxhnBGfh0afARQDq7aiY0
         Wcqucb2bw+7Pak6m8oZvziOHYvbHgUNZbRlobTNSFi1kDYKBSa6CPZIfN6bjeJ9i1AL2
         sGvmy52fFmHFBZKJg6SlpVO2Lop171z7sbKYjGP/+hIFacK6ynFjJ+heLe035fx/5Kls
         +pBpE/FOJqt2GKZ8bYdt+QDcbdmna5UcpKEA4aU0JA7a/8nssxQR5bjZvxeGxNwYkOSL
         haHg==
X-Gm-Message-State: APuU4Z//ZX/SeV8wsD6Lk77iDe1KQLSejWMjewo2WH34nz4NsppKSoEN
	JpZrk91yZ29a5JJiOCAi7PqBsn/6x5CFdmefhtlFAg+5mudE6UlfRtNzTL9CNw==
X-Gm-Gg: AYBFou33nYsZ1lx6vPEAb9zKBjeKN5qa8FfaN9f+jONNlC/gSD4gYCF5P94+OZSv8fS
	hj8+kfbazd8n4uB8WuNK+q1guOkJ7oaf3YT5VyjnCC9NyDmdl6/CeZ60N24lq4V3HfSxW1kdi5o
	Ljon+vt94arGchsPZ3JsBYCn36cZDeqRkC6jD9o87/TlrjwNIu2ZrMOXnfPV7L3dYTyORn8LCoV
	xfDKYyBaHY/TeIZSnpuVfzvvGm5RA2PrFpXUaUa+6Jngw2TLFGPKXgcEDJ4TGAKgjW6AOvjhjqH
	qYJYMd6nGVkZqdGEmqgv9wo6tNOUzSa5wg3NwAMbPiRlTkYafJuajcCTUmuVWiErPkwV4YKg7HP
	1S9d6E9ur0PkTS/5xojO+zinvIXS9VIFPdBC38JY436XZ6noFyW2QngMTrZ8aIss6bM6Lnf7l3a
	dbUOejdu0EoJHQ6wqPA1gInYnMWxhUXah/2ztpFnOU2kXFZbWd/d9wGP9k/kKd792ltiAzfFc2s
	6sW//Yj8eraFM0f4e3CZxAdDYBBKy0FfGHRkSVljUtFsdNO3ip3Ha/BJiOIWuddVA==
X-Received: by 2002:a05:620a:461f:b0:93c:c73b:39ed with SMTP id af79cd13be357-945f353723fmr742412985a.39.1794018581222;
        Fri, 06 Nov 2026 18:29:41 -0800 (PST)
Received: from [172.17.0.2] ([172.190.118.238])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945f599bd5fsm278556385a.9.2026.11.06.18.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:29:40 -0800 (PST)
Message-ID: <6aee8d14.4001fe38.37437.e453@mx.google.com>
Date: Fri, 06 Nov 2026 18:29:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5090561434217079308=="
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
To: linux-bluetooth@vger.kernel.org, roman.gushchin@linux.dev
Subject: RE: [net] 6lowpan: fix netdev_priv() type confusion in lowpan_event()
In-Reply-To: <20261106225930.1379968-1-roman.gushchin@linux.dev>
References: <20261106225930.1379968-1-roman.gushchin@linux.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5090561434217079308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1204595/

---Test result---

Test Summary:
CheckPatch                    PASS      3.26 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.90 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 FAIL      0.18 seconds
BuildKernel                   PASS      31.03 seconds
CheckAllWarning               PASS      35.02 seconds
CheckSparse                   PASS      39.77 seconds
BuildKernel32                 PASS      31.26 seconds
CheckKernelLLVM               PASS      35.89 seconds
TestRunnerSetup               PASS      748.50 seconds
TestRunner_l2cap-tester       PASS      12.85 seconds
TestRunner_iso-tester         PASS      11.04 seconds
TestRunner_bnep-tester        PASS      4.13 seconds
TestRunner_mgmt-tester        PASS      89.48 seconds
TestRunner_rfcomm-tester      PASS      8.33 seconds
TestRunner_sco-tester         PASS      5.80 seconds
TestRunner_ioctl-tester       PASS      4.76 seconds
TestRunner_mesh-tester        PASS      5.59 seconds
TestRunner_smp-tester         PASS      4.44 seconds
TestRunner_userchan-tester    PASS      3.30 seconds
TestRunner_6lowpan-tester     PASS      4.55 seconds
IncrementalBuild              PASS      28.41 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/1083

---
Regards,
Linux Bluetooth


--===============5090561434217079308==--
