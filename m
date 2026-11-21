Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795253445;
	b=pK3npfjdJ8Ngvu5OEo6L8eJgHnXpyIDoXO/k3FWdG08nIAtjTGSFhg5j4+w3WAcjxpQz
	 btXvWO/+ZVuVFLpSHslo0xTxFFlX0hTN0G1Xy1NCJJ5SUGvvAEn2SVOi7NZ837xamLL77
	 VcpiGuayRgYVCpknRrD4OuzNnaxS9dlys/ozJQYDPwTefaIC0YImpsUrZdkDEUFOqSTFk
	 IgZ2tt+jtvrMQruncN0jH6acO2BgFmINQ9VqYwCLtX+l+FzQpDJqSiuXpJBUoZ4ntQhpb
	 lozSpuknTiLY0t/OhTdc87q8gU7eO+B4NzMobnyte3X26zB15RU2aBdKM73UrzM5EkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795253445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=WwGuAlENnm68Lky6FngrNw3Bx/AumUOr/fPeOKPeBSI=;
	b=3ytjE0A7D6NVOOr0JmsPJjPZjQPSY4/s3P/ocu5uikMP33nq/owNM5VYz7an4qBQoRqU
	 Si75nihXXXoSA9+g/pqSEaeOwXVAIAvQHhPrqP864rhHRmIKILV/TrEWl5v1crkVpTUqW
	 pO6DXRl9CBKpolblTsa2BJUFo/Jlu+q8ND9+TyHSbPVwIqcZjNzcjvzWtgMo1SYad7JRR
	 T1LaaxcqCmwgnouHT9gFFL9EUbG7/ECRkFwjPQYIRj0e2KjJSFLr+s+BMOLH+dBUJ9iQ+
	 AEtT4UncGwJweSy2CDhviM/QkoiZ0PeRTVgArd/6SO16eKmk9lGhA7x2gLlhWquH9QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JwcxlVLC;
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73500606A330
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 09:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73500606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JwcxlVLC
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-490d838b425so890171fac.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 01:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795253444; x=1795858244; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WwGuAlENnm68Lky6FngrNw3Bx/AumUOr/fPeOKPeBSI=;
        b=JwcxlVLCjzTY4n+fDoJQfre7CQQFe5p3LItHNwWOVSz0Q2Ty8aBHJPX2Pw6kjmPeQD
         U0utrgUhZE32NidDMl0dkx3OyggM4P9MTfHkDc3VaOygnTZy7FD8lCdm9l9m3/UM42WL
         rQbYieyKtahg4hXSb8QWKtjVPiJth/JgZwHIuMb2OgrxWgijau5oVV+cox26B0Kx0uUD
         abuikCdCKX12480CsKbB3mFpMVr4QM21wf6gDn7oPZyT8yB1PNhiJCCHl/HTIFjHbH6c
         9Nweexr+Sqtfnh5dHUOpb3nfxVB/b+FDeNF+HkJ9yvMYXw/OTZDqqIMZguzkgoTRwxBL
         scnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795253444; x=1795858244;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WwGuAlENnm68Lky6FngrNw3Bx/AumUOr/fPeOKPeBSI=;
        b=PoiPig/5Dyf8At+IJQVRylpM68x3q6T6NSPrKyrWQe2PnQcyhIsIbSTYb03vCpzPiC
         t4o0u5BFgES2QwOxps8lOmi80nUEq491NQA41Dr9l+j/cWlt0H2jQSLEl/3NgrpH98mn
         0zEPSYbyIc0/h+iqE0ixvcpO4f5vQrWBWTl7UkONzFzofsL9fVD7+Wr2129BT8mA81DB
         IKaCh5MdTWR+48despt6gXUo0IKZGVZY4nwaBdEAzoob6L562Kigc8z9C7VZTig+2bL4
         f2kzAJiRlJZNMSvX6zSyKaWudFcn+4CIINZgfiuhZAzlCS0y8gCo6tpnMqSKQxrJJ7ks
         WJKg==
X-Gm-Message-State: APuU4Z/k6A7GMQw4zThsxatEZpXsc4wiDlg6z99/een2y9eUAV114Glh
	IB40+hPK7+kYwCmm5mEbslMak42zkQri115FcwV4wHKa5iedrmxto12p4Yjbiw==
X-Gm-Gg: AZFdTZfAeYUh99BPTlFbCNMxKXT3DKIuNkponilZnVUVTAl7x8od+yEeO5P0RG+BoZ7
	fVcJHDeHtZlyCsUSN90Wz8lnJWVyUFczg7X5PNgGdV9zjv/yVaJdCq+JmbcpvNQp75H6PEbma6+
	L41+5ZBSbpanw+hTPfhoAQspy9gID80TWGxi4ol/cw6nX5+2Td8XniC6PeW2PBGM97IUIjHSyVC
	OPgyJ69+py2KAkUTHU8/hYWfyQgt/qwKjRpUlj4uxkM0DKzVGThAhXaNkuKBLY0R+q5h5/d1vKO
	npN4VUJdf+9ZCeydnMglDYPv4AU3IGnI7TgS6xum5jxVuiv1iB1PTmSSSFwfEk3nImviu1BC/JD
	RJqlUIn3dnwTbx6IC5VApcqlpsI6r7+si4DzlwK9wAol35LxNMLp81nPt1cNii6D+FbjVMdcMpn
	CUkjAifsSnCEdDbnkxWDLlduodjQ7d9CLakf8S1LdAx9GMnjbaoNTa4Y8DonIrTQkSkVM9SZXVX
	5xcAqfGku6mzj1VlfJPRaBUNB34x7roqzn8f9L/Ml5oZ0vq+pzR57q0nr1WTBg6
X-Received: by 2002:a05:6870:961e:b0:4a7:c737:5a13 with SMTP id 586e51a60fabf-4bc7bea3541mr5121492fac.4.1795253444228;
        Sat, 21 Nov 2026 01:30:44 -0800 (PST)
Received: from [172.17.0.2] ([40.124.227.100])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc60891cf6sm5612648fac.13.2026.11.21.01.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 01:30:43 -0800 (PST)
Message-ID: <6b0164c3.318e7587.4cd93.2eea@mx.google.com>
Date: Sat, 21 Nov 2026 01:30:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7433469758301297963=="
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
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: 6lowpan: Protect adapter use and notification lifetime
In-Reply-To: <pm-bluetooth-objects-candidate-0228-v10-f6ced931e2322aa5c7b3-1@gmail.com>
References: <pm-bluetooth-objects-candidate-0228-v10-f6ced931e2322aa5c7b3-1@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7433469758301297963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1217950/

---Test result---

Test Summary:
CheckPatch                    PASS      1.14 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.53 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      21.46 seconds
CheckAllWarning               PASS      24.32 seconds
CheckSparse                   PASS      25.75 seconds
BuildKernel32                 PASS      20.53 seconds
CheckKernelLLVM               PASS      21.41 seconds
TestRunnerSetup               PASS      455.03 seconds
TestRunner_6lowpan-tester     PASS      6.76 seconds
IncrementalBuild              PASS      21.32 seconds



https://github.com/bluez/bluetooth-next/pull/1174

---
Regards,
Linux Bluetooth


--===============7433469758301297963==--
