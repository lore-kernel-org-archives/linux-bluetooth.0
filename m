Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435620;
	b=3yUPZWhTMzulgp14JWIbqwN8vbfh1abyv4XAQ4CBOAtZAIFe1jm7OFTr+6OreKcUeWPn
	 DMtcWWhTiV/POIB4fbGwlX7sptPhH2nn/nRMYwSarn9/BDDi9n08Wx4MQbmY15eFzEiOi
	 uomvRUe/uo2lUAXaDJl27qbKOSk5pwrsT3B5RMLB9fxy07Y+Ulnu48U2ySc1gYamFVCS3
	 gxToTiMki/0K6DmW42BHqqb8oesvXljrRINy994tGi95xkjWtQxY34H6OuuOdpDUqeZjv
	 urny8ih0btSS7NN49gOadWH/y4TVcwXCSmp9i9LhyMpSCOYoet4qIWJCehqFRtubkbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=zuOzwx1eEH7lCvBtxIN50buTdXCDLX7nM/exoafsIvQ=;
	b=axPKmq9d6X6z0WVqB//0KtYdCH0luPWLGr60/gI0AfIVaJRjkLmt9xx9dCThhyxlOyz6
	 xvWN5XwmKdTr84wn2x+/EFUm3/kEb72GA7jKv9DPDkLMXVAZFdqpQP2tdgJNGZfL5g1n8
	 BZe3hVxTLeztljGlAhbkWmgIHF5Oc9UpPNUgnYoKzzz67wbpXwwvHdK6lfrJUsAtC7/H1
	 ddxWFjTOFJoD2A+GaSS6HeihH1C2iFOnpcnyabhu/nl0IDkwu8u4DOnua7/9MDYt+tTM3
	 MBiawSfMif87J9UhP1RE/hLHeC57CkICje7PsSKTOEK/s+axPMccPzd/zziGOzbk8OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x9G0ZyAh;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69789606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 12:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69789606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x9G0ZyAh
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-94958650b09so334337685a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 04:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795435619; x=1796040419; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zuOzwx1eEH7lCvBtxIN50buTdXCDLX7nM/exoafsIvQ=;
        b=x9G0ZyAh+t11QjPrRbiZ9R+7D+CdqINAT+FKygDcQYH/ibHCB7JSBSCkqyVdSL9L4r
         wZipqR86iOO84H/ACRZ8a4Z5eFnpdfcvEXJfHIIAg4JFI5oKODvuboiF/NPofmkk5IDH
         aZr1QAzo3vio8wmMrLuJkHViUQQrWdeipkpP8+KEDQGTl961wXFfJjYTg2RlDQCIbhI+
         GL98MblsvbWuctNCOUlnPcc5b7m8qZI7PR1AuT2YbS2egBHm9UYDN0klT6wqJW1UPvb1
         lF5GtlUIrJf1YPc/wW1nQsw6s7vpC6pMC4/BZcho6bgxKJrjHpo07wgRqqCHuwkNOaWp
         5BHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435619; x=1796040419;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zuOzwx1eEH7lCvBtxIN50buTdXCDLX7nM/exoafsIvQ=;
        b=snxxfUEsTxP5NNVjaUmZbq5xj8ak7qM8NdRDf1jehl2jGP3V3SUlfTZorTXQHG+zws
         siIjrjTmuShO94vb5KcKAY1zDYmZ6HSPXmktG7ZVkQGnW44XGCEAG3p09WhKWBT66zIP
         d+um0AKDvlK4J8yaqR33tycK0b3woXu+YgDwTOPlRyBMFSuYYbSmO2UD7ZpIFHwu5ka3
         1huV5S/5JJGmhKW6tjt9r6yBZoMFBPETRZEgMPsm3q/9ejtgHajtOJWJHDKdwfX2PVkg
         p0S7OR299hJ3BsF3UBY4anRD1vS8ZDWjZOOVEPs85sSmAn1caI/QQ0nFQq7U8rBokXsn
         lViw==
X-Gm-Message-State: APuU4Z+8+COZ5CWIJYQOWCcfVi2mwcjDu1a+bssSUh1KxZf71wLHSS89
	jxAA+GZFgXfj5tbtPZ/7U4NsZ9z2a50cISCbgtwKmxSa58h6DHFCJhNXLmsBAcTvmAA=
X-Gm-Gg: AZFdTZeNjYVSyYGUHZGxzJRjoM0z/kixEJArh/YTnpKsa/curaS/c0EDFeU673cf+F1
	AQZJ8dLdOYgUL99Ih6w0hds7W8qda7SVEXwcte39WKtkLy46JxC8Ns1HOu3Plc/peqFedndFHiw
	aIHXd6mD7AC3nGbVznLvX1MnHQWPs9jV1a/f/yt7hg/uIYaq1pBAhNpZOsUX/lO+qrDJ233kVk6
	1Qlr4Hos0V13LBt0CO8AX+I1J9so6xz//VQk5ruAZkuJBevRl/RaMKtaqVpyyrAM9XJ49cocEkL
	HEAjK2sCFAmyoHLrvKqB3e1yib7KXe3rCsZYAeW64Ym6TDrKzhHKwxhXtfe2uJhwlkzglY10/V8
	toKoc6kiob1wULS2F7DCqkBgZq5ZJO/lq2hGutLJ90jX8p1lv09YEyPpjnNFxZ4OLBx3+cWbmaW
	6jSUG6o+PTNBDg4UfkN0Bt3OVwyJQHicOdhfUkfjyTIgJLVGamFghmUB3MdQ1haQZ81TzXjoR2G
	YycH3Agir+dPRSs1DKV4oa5kWb3mNEnHjKGMULTBBDqfh90sLQtaRsC3PIJ6Bw5vuvP7IOccewX
	P1yoG4SKNg==
X-Received: by 2002:a05:620a:3188:b0:947:3673:f902 with SMTP id af79cd13be357-949ba9e9297mr1866071685a.55.1795435619387;
        Mon, 23 Nov 2026 04:06:59 -0800 (PST)
Received: from [172.17.0.2] ([172.210.148.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb34ac11sm789296985a.14.2026.11.23.04.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 04:06:59 -0800 (PST)
Message-ID: <6b042c63.58979103.20c118.1db7@mx.google.com>
Date: Mon, 23 Nov 2026 04:06:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0706227459029226895=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [v3] Bluetooth: hci_sync: Don't enable instance 0 on Set Connectable
In-Reply-To: <20261123092510.4085202-1-simon.mikuda@streamunlimited.com>
References: <20261123092510.4085202-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0706227459029226895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1219365/

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.76 seconds
CheckAllWarning               PASS      32.97 seconds
CheckSparse                   PASS      35.26 seconds
BuildKernel32                 PASS      28.87 seconds
CheckKernelLLVM               PASS      29.52 seconds
TestRunnerSetup               PASS      692.84 seconds
TestRunner_l2cap-tester       PASS      14.71 seconds
TestRunner_iso-tester         PASS      12.91 seconds
TestRunner_bnep-tester        PASS      3.00 seconds
TestRunner_mgmt-tester        PASS      87.89 seconds
TestRunner_rfcomm-tester      PASS      4.29 seconds
TestRunner_sco-tester         PASS      5.42 seconds
TestRunner_ioctl-tester       PASS      4.49 seconds
TestRunner_mesh-tester        PASS      4.33 seconds
TestRunner_smp-tester         PASS      4.19 seconds
TestRunner_userchan-tester    PASS      3.09 seconds
TestRunner_6lowpan-tester     PASS      4.28 seconds
IncrementalBuild              PASS      26.30 seconds



https://github.com/bluez/bluetooth-next/pull/1202

---
Regards,
Linux Bluetooth


--===============0706227459029226895==--
