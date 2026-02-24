Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD5E38E5E3
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 12:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935232; cv=none; b=BNlRqVZqrvQr7cwixthPtEpVn/cnuthMsar71uJMtg7I+laqBkkcatAeR9jqI3zBpiASVlwzLIhm3z5Y173/vRi8V3dHQmuaictglqnNTPgMQvutELRLkvuJX1qnzliZZ3keta5PBa5blRzqMMBkQbHJCCFS8TAWzw3WvcEMeqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935232; c=relaxed/simple;
	bh=tigUdylrFZYvsM87adDMeJBkgKu4mmQWqg3LZlsW704=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GwCYCnnSzn8KGVYIJKkNErivHg6ucTMEh1OKZPrSvx7OHB3yvXpdYmNq/akp7uzvYyJ6KzknidOrkxmirjALWneR/aZZpscwgfNEXLQVWvYywP/GKk4WhfcoHbHJdRgFn2e/L/IDSFNyuT4GXQ5WQZYSNJ1/OhZuSVrfZLnkwDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ca44REC/; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca44REC/"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8cb513e860cso582101085a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 04:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771935230; x=1772540030; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MAPA6ccKbuLt100UJziX64LPdA8RkJuRRaP1IRs6q5g=;
        b=ca44REC/fRMpv7yIZ3Ocxk84nwqynFWbHn0pWbmtEE3tFV3TCB4h5Zb5K8yoTpzQwZ
         g95Yjcwv/Ain4q8rrQjmwhdBSzrPiB/+dJFzvQb6TOuFAKh3RaRwWDMNfljrNSy0T8wB
         gq2OVFuHXeOVxJvRAPvBjH56lydEKNiBdjvgAM0uqd6/li89tQb/CgADfoV1GlMtBDye
         1Zf7XQPv0whwXmCOX+BeSfpO1hWa4cXbQYu+AeoovLEG+i/8ikZ2DUW32y3Tx4gTqGFb
         SaLIMTLC+Ezqvco/at0Bee1T9cNkizmyj746X8Bq1FmWUkeJjmB9v69JDUezHDNQqQXq
         ZB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771935230; x=1772540030;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAPA6ccKbuLt100UJziX64LPdA8RkJuRRaP1IRs6q5g=;
        b=UuRigNH0qsGv1uFmbKZL51q3yII8VWQBWKHtlUukDYsLX5A2WaQsHaa1lnYfXFXZyL
         6hEplvuebwUDRSxOyHXsMHS7SZoyR16SHI9zCxQnzgL0dejtY80RrJOKPRvcrEhDtodw
         ygTzQO8kj3eUjoqZ9Ggw7bbSqb6dYGLzeNvDVxUH6n8+6D0+wz9hq1RXeIyDs2sH9fEc
         +lF5LzhQBEAtYUpO19Tf2tSAeqxc4tm0xoOKwLmn2ULvPwQ67ZUPVdSY0LGyBIHUEjrc
         oj6NLXKNJwvEX1u+uGJnYcdDRMqnnQ+CMelOuhVI6NB8QRjffhDj5e2WtrB6LdZb8qlc
         81Aw==
X-Gm-Message-State: AOJu0Yz1Pyz3Az6PVw/CqACSnLlNu/p0b8Spw66atmI2ilwpyTLhuT2I
	Mu2Cwk+FBLd9iEylChI8P17xb0e1ISC0ARwD4lqZxdAaHOjgT5/VlbaMo20S6dFI
X-Gm-Gg: AZuq6aIluEiNX5e3Aw6uohZIgOxr643MxekH9IqKhNZV3usw/yMEAVl139n/w09Opjq
	YLZ7zwOil663fQA+UiLAIBC51u5ZV4Gk/3sTOTUbvjr/y7fIjRdumZSVCixAsu4LBEEa1gCCPRD
	b7wsIn9E392/xYfhYEMlT5vhfTRZ8PKVkv28wQZpzHZU1r6xNFc8mFzKNScF/UBWsP3ckqEg2CW
	CRlqabynMHH3YWH0LfHYROEFz9mxFWMm7I2GRluF8uYrAy2PhFja7wLtk17+wrGuDMd6A5Hev8O
	601EkJwmCkY/0QlkfvGuULSbsBF15urcDQWqwLM8OOQQZI7d5IadzoQNLxjEpPGskDR+2cT4Arb
	KBwSZIgV7CZ5eeyVSdlVjjewqo9QpTmS5d5Fr/E4sXjTJBgocimchyc3P3GDWe81+IlRxVPUEBp
	Thxa94m7/5lzoJsgyRhZpc7WaLjsLX9A==
X-Received: by 2002:a05:620a:25c6:b0:8c7:1a0d:7d9d with SMTP id af79cd13be357-8cb8ca92e73mr1335277585a.81.1771935229640;
        Tue, 24 Feb 2026 04:13:49 -0800 (PST)
Received: from [172.17.0.2] ([64.236.192.151])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d064007sm1134497185a.19.2026.02.24.04.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 04:13:49 -0800 (PST)
Message-ID: <699d95fd.050a0220.a28e5.fdb8@mx.google.com>
Date: Tue, 24 Feb 2026 04:13:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4409160715639104622=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mengshi.wu@oss.qualcomm.com
Subject: RE: [v5] gatt-client:Implement error handling for DB_OUT_OF_SYNC in GATT caching
In-Reply-To: <20260224105747.2718150-1-mengshi.wu@oss.qualcomm.com>
References: <20260224105747.2718150-1-mengshi.wu@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4409160715639104622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1057153

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      21.27 seconds
BluezMake                     PASS      667.50 seconds
MakeCheck                     PASS      18.87 seconds
MakeDistcheck                 PASS      241.89 seconds
CheckValgrind                 PASS      296.72 seconds
CheckSmatch                   WARNING   352.17 seconds
bluezmakeextell               PASS      180.76 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      1011.19 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/gatt-helpers.c:768:31: warning: Variable length array is used.src/shared/gatt-helpers.c:846:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1339:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1370:23: warning: Variable length array is used.src/shared/gatt-helpers.c:768:31: warning: Variable length array is used.src/shared/gatt-helpers.c:846:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1339:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1370:23: warning: Variable length array is used.src/shared/gatt-helpers.c:768:31: warning: Variable length array is used.src/shared/gatt-helpers.c:846:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1339:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1370:23: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4409160715639104622==--
