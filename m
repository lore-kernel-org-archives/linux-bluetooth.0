Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476482;
	b=GHVb8sApXOJcrdctxcSxjhkZMtlQ2kqeZ63qPohtTELpSYbQPF+fSLh7Z0hjIHgchn9Y
	 NX6BSq+4lgrvPdIDF4HgDNfQXKHXinBndE3bXc9TqbTS4ucRRxOUD1Z/E5oThVXiCtbbo
	 p+WGZnBMDqe1pQV+qkRIuL5FF7rgpuN7KRClDn4Ly/5jpWsafLTE0iszBhVcQbooWIu1p
	 nCeFyEBwCG67bfyf1FVwkE2+h6GdJvGvhxptsNvSYeqod9wtVxIYF/8b+ALRWuuIM55eo
	 nibUF9CbpxFHGjsqTM0AAZUf5J0Yj5TQDzxtIcxMAv/KrkKT2mjK48wUDHII8cf03XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=KZb40d81kTnSgf9EnhrFvRgrOMuFY/egCeETDoEiZUM=;
	b=kjxWAukR2GvrZLAxZaVrohal7QAUlAn3aJBl1CgyUHoQ61LDi2DW2H7EeMlNSlc0YaFA
	 mSY3Q8bHzlGzFMP+ZaqKjP9aANfc7wNkii2AR8p4m8zH/vRxWVcKpANl5FLmydso+7N/x
	 wFslKEYrkY7H6Zi4iMz5dM4uk1brQU9O6RnU+qjCOiRD2E4r/nAEdGbQD1yLE2bLMMNCH
	 76V1jMCoXi8DrHgW/FMgceEqBWrwS7CWFWHo3AKHUS+unK72R/BjX78RIMdU+ohBjkqjp
	 UsOfyRfods5yiS+BcMKE45+vJudo6Yc7PleTOursE7fOcSXoFnDP4baxvWFpJWyOJSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VQhRibLN;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A25E606A31E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 23:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A25E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VQhRibLN
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a2af4c8d00so494140c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 15:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795476481; x=1796081281; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KZb40d81kTnSgf9EnhrFvRgrOMuFY/egCeETDoEiZUM=;
        b=VQhRibLNy5Yfsfzm3/3oM0GygdPbxNj8iwb5MIje4htXP85co08QLs18VfP7CbOqxs
         SvnKNVx+dzZ9e2IM/I5m42INiMVv3RKvuOFolhSyhKPbLb3Ta//czcdm9lzUWh7EfiHp
         7cwNHw+A7/WijuJ4iQQZnX1TuCOB3I7ZSJU7lJh58YeEYVV8eV3v6ZV1+vhW14x7wQS2
         DnWdu5MNzX0qaHUuCmlxD6QZMQTo2t99Z51VdhbgGhTuzweoWNTBWokXAAHW4f9wWDXn
         hSkT7hHy2jSjTzWFzp5RTMiZfLVN5Gxh4ExFMGoydxjtn8Q1+QZ+N8Ok7ioIjmc1t3LT
         ZzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795476481; x=1796081281;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KZb40d81kTnSgf9EnhrFvRgrOMuFY/egCeETDoEiZUM=;
        b=napl8iNV9RKMq/wiCDlt3FmmXuwE8dm0H4DElsFQNJc3fAGatEakYS4s2R3FoNdh+9
         64y/QPXkbCPfGkTLw7+eiDlcRkhsYmfWES9o1wa7qDuv4o4u9riglg+RpnIE5ryDx8tU
         Mmxg4cRZOQLQvc46t5IVdrNVVEasqnvghCNdHJZrGPDLq1LaizfRGPoXC0vfJxjLY9Uj
         YbyCokH6TwD66oFPBi8qSh3tJSCyqSz2tzoJSRep8P3OcpnN1aLfPlWjixmPDMrA9x3Z
         NVn7+CE6mnLej4o5qxI3ObQDVLHxoqQoR0QLnjuIrG6KjaQ34W10vNCoYMgrpv2xdqDR
         maFA==
X-Gm-Message-State: APuU4Z/8kSCfH5MxdC4RF5kByN5n04DX0lkoPDT2unZenBYp4OhuJxPI
	VYcTDBUndxoUeyky13k1OU/If6HXC99D3QYZSHIfLu8D5Bk7hrqBqUj0izd+KA==
X-Gm-Gg: AZFdTZejAM7ydaem9+CpbNL1lYjlVOe3nGD9GqtY9GXEF7j+TWk/HhCaj3duIMvIqXV
	D6LDjoDPqOQ/LYM89qAHPM0ziJMSyXnZGmaZCfBhvwfc1tvnHsAhqoCF6aUXvctl6e25x2NnT9o
	TAVhJx+UbAcnB4SvjyxYd/xsaVQfSPyuUApMpaNy0RwpOEm35QGRv8VcwbYg8GHfVYeaTIou01q
	MQnFQNLg55Ze0WL0hbmqTVHMYc+21O4vgGrPI5pX57zTMm5NSeZnMiuZeq90tvGzxcoTpcGjtCN
	Ll3GKS0TD4/YmhULNMzwVk9EdaRB1zTdxBrpPL5awY/dIBgKR0HqX9FkH8+AR75/FFsWpIzXegn
	WRthF66sUVySlwOwXSx5EaZkQ5gWxS1m/r3Crjr0YwDqSdSO1f9t799NTNhmD72y+sFjVMI1kyj
	XEo9lZEnW5ndkd8hyOVl77w3Hhqra7cVvukEUtGzG1KMTMmlVRjv3KujgJXw/Yj6tZd2WwN/a/Z
	XQLRy8ed+E1pu5DqTxTKThcCCf2wkFQ27T2T6HJwYlesWJKaPZ8AuzDghk=
X-Received: by 2002:a05:7022:38b:b0:1b5:2dce:1b6d with SMTP id a92af1059eb24-1b55689ab30mr15430080c88.17.1795476480709;
        Mon, 23 Nov 2026 15:28:00 -0800 (PST)
Received: from [172.17.0.2] ([57.154.7.99])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5568592adsm30137507c88.15.2026.11.23.15.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 15:28:00 -0800 (PST)
Message-ID: <6b04cc00.8af4976c.1dde1b.a425@mx.google.com>
Date: Mon, 23 Nov 2026 15:28:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6600330742638809439=="
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
To: linux-bluetooth@vger.kernel.org, loic.poulain@oss.qualcomm.com
Subject: RE: Support for block device NVMEM providers
In-Reply-To: <20261123-block-as-nvmem-v13-1-96ffe1f59332@oss.qualcomm.com>
References: <20261123-block-as-nvmem-v13-1-96ffe1f59332@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6600330742638809439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1219596/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.72 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.46 seconds
SubjectPrefix                 FAIL      0.15 seconds
BuildKernel                   PASS      23.96 seconds
CheckAllWarning               PASS      26.87 seconds
CheckSparse                   PASS      29.70 seconds
BuildKernel32                 PASS      23.97 seconds
CheckKernelLLVM               PASS      25.61 seconds
TestRunnerSetup               PASS      551.31 seconds
TestRunner_l2cap-tester       PASS      15.28 seconds
TestRunner_iso-tester         PASS      11.58 seconds
TestRunner_bnep-tester        PASS      2.85 seconds
TestRunner_mgmt-tester        PASS      85.05 seconds
TestRunner_rfcomm-tester      PASS      4.07 seconds
TestRunner_sco-tester         PASS      5.13 seconds
TestRunner_ioctl-tester       PASS      4.27 seconds
TestRunner_mesh-tester        PASS      4.23 seconds
TestRunner_smp-tester         PASS      4.00 seconds
TestRunner_userchan-tester    PASS      3.07 seconds
TestRunner_6lowpan-tester     PASS      4.06 seconds
IncrementalBuild              PASS      40.29 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v13,2/2] block: implement NVMEM provider
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#287: 
new file mode 100644

total: 0 errors, 1 warnings, 279 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15012731.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/1203

---
Regards,
Linux Bluetooth


--===============6600330742638809439==--
