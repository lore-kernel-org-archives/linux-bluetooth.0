Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795109852;
	b=1GgWRXP8QwoFrt7EsqFffKFzkv7EvaXg9SwqKa+a4txISxv5WKfnUUrXfgTkJbXvaw0P
	 tFOUtwOMbQX0iDru52Otf61NuTMYlgiF8RAjJnPB0MrBww9bcNwp4BDrbLBdLdkoKTHQY
	 LlIWdF8IdtFC8Lzhp6aQ147YYnYEOXFZjE7KwWXoywLaW/qoz4HYsq7TCVp7i8f7wcGBU
	 Vw5xnwKV0V6BTpdnJNjWo7muspcIdv5s7kQpZyuWsFhprAKw4fafNO2+Q5i8daYBzvGe3
	 hV5YMNS1xFqg5OfhCR+GotWEnJcmhxpODz7oDzWnefgwYGQV+gimHwr4dbNgkxPwgRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=rCcjalpi291nHPXGOJpc6UD5YTDOe+4Zu4aTNNdWKmI=;
	b=Go5jFuwPU/Q7QbWEbWl2o5HMI95QEC+rhA40n9cfzVYYFB4n1Qdzw9gHEFrYcmCNvHDX
	 cEZfz7fv8/cNtzJH6Ijlu73jOk0nEZol/kF0sDgOBlOH6ohFVGS8xP3ttUHI4WpD+z9pH
	 Wp0+LK8UWmLdcupbn/v645Fr6Pgf9UwHUx8PlyfYM7H/lMzpmTwy2I3pbNrkiLkzyD6DX
	 69NBDnQaye2kKp2cEr5RFu45yM1dTItTqlyBM1tn10lYl3GAxgTOoYlBYTWnk4bngfNIw
	 Ec3p6XEt/XGvdMmTFZf05kzR9ZbxPub7BJ+iXbAJtKzGVBROtY+2YGFweQGD39mOfXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="An6rjm/p";
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F17606A320
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 17:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6F17606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=An6rjm/p
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b244fb7fffso2569333c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 09:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795109851; x=1795714651; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rCcjalpi291nHPXGOJpc6UD5YTDOe+4Zu4aTNNdWKmI=;
        b=An6rjm/pizaroR0RTehMTWLaxCeIXb541iPy5gnlXrf98cKmNbIJH9HXSXZc4vlieW
         mrmegWj62U81OfvsV+NeRVuR8KrU2g7M7JTwNbqHBvYJjJNrQ8LxkFp53g8t4oPUlIH5
         oFucrAlT05jkd92VgLrV3amFI6MpktDjclC2eHK5Z/uAxWhAiDMEI57jfiB8XYAi3Neu
         389NC6ZJISZsaE4F6mXm39BHBs8PNmDmJcqCv8GoMp1jKDjXH6cKseu747ibiFbWloK5
         UvHvG/N3BksFVMEdkOeZdncbWr0plYwfRzUewN6835C+yKYdtpyVJn7bUlIlfEpJ7gw/
         kYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795109851; x=1795714651;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rCcjalpi291nHPXGOJpc6UD5YTDOe+4Zu4aTNNdWKmI=;
        b=bqhdIQNM5ZQGSiSnw80ROdXiLrJLhpkIlzxLP1+2bksZzXlKMGWFPwobRJmeK8GV1N
         +rhze8gMlQEv7Q3nGRGFFY4GlHiV9ET33uzjV0Ed5E2113qXn8OANRstC+bZWR8GnXAH
         KCCPWae8snDsNUAjsKwFvNA/sc0+LZ9RecRyIc8og8er4j4YT9COnZdHg4VBjhUEbExm
         k+mWZ3x6jhJm7aRP/1y+4UwRJzDeKNrxr3pZnuJNkXXCgE3pPzyov+rPm/vH/R1Gwkbf
         ff91arCb34K4FXw+DlNt9ic78wPDD+iNiNY1huXe6lK6Rqgwr7q73KZoVKABX16VgHQ4
         +pnA==
X-Gm-Message-State: APuU4Z/Efx4QbPFyIuroAWpjN09pe2U9SsILHKGHWUD4ZSg3JhS2Lytu
	lXbAUA/KsJoIi7pe9v2U4GVb2G76uM/b0rVlwWjBk1QdIUJiAP+444I6cUxFaw==
X-Gm-Gg: AYBFou2ZRUJCLp8nrk1rypazPYlxcGcdc0Q7AJJG2W7vVCEEZpc72d0jDe1qJSmMBF7
	yY2kd8/qeGkwAwU1ttCLVQdxvx6Z5B6dPOdrf5DjlMcMwlwhV5bZGPme2kAHkrj778sIcgpbq+T
	4RC22vf6ZMsy6h623aP36k5M8S6c5OyhOJTquBjfjDBT8OeiGK+jk2aQ5RJBoeFbSk8gkS7jHDV
	p5lvjOGmMULJkIAvWX1kJ4nK+rrofM0uyCDiVlF9EszXfabZIDUrDyt4Azu62vjWV4m8LPOcFTI
	fDECGwpNLR8fEiFWuYWdICPMcyRbXTvuhIVBQ2XZ5AXDSsV0Eku4FtMHB8KL0ICsir2mUyL2r6+
	D8BKfffj7xgwWBfwOx8ebO4WlfdflO/bBLlILu5dQdiR5OhuOqWmkbAVCqv7dETqRyuwK41WbDN
	JhI3lfrvOrGf/WVQUzFvh1zAfe0hOAPZER5H+g/DJVLhhGRfpr0KQI/ujrRX00nQ2qjS0FdYrHi
	LnSCvfel7gDLMl7gZn8FTlK877wl4FMuLh/f71aoVPzaWZqCvCjidCpPbDVVoJ8Ug==
X-Received: by 2002:a05:701b:4205:20b0:1b5:32d6:677f with SMTP id a92af1059eb24-1b5568eeb95mr287779c88.34.1795109850898;
        Thu, 19 Nov 2026 09:37:30 -0800 (PST)
Received: from [172.17.0.2] ([172.184.211.120])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55681301asm636904c88.8.2026.11.19.09.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:37:30 -0800 (PST)
Message-ID: <6aff33da.45417901.4f93f.c85d@mx.google.com>
Date: Thu, 19 Nov 2026 09:37:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8398108555322125880=="
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
To: linux-bluetooth@vger.kernel.org, enderaoelyther@gmail.com
Subject: RE: Bluetooth: MGMT: Retain the selected legacy advertising schedule ID
In-Reply-To: <20261119112359.34543-1-enderaoelyther@gmail.com>
References: <20261119112359.34543-1-enderaoelyther@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8398108555322125880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1216056/

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      33.30 seconds
CheckAllWarning               PASS      37.87 seconds
CheckSparse                   PASS      39.81 seconds
BuildKernel32                 PASS      32.23 seconds
CheckKernelLLVM               PASS      34.75 seconds
TestRunnerSetup               PASS      785.31 seconds
TestRunner_mgmt-tester        PASS      89.71 seconds
TestRunner_mesh-tester        PASS      5.51 seconds
IncrementalBuild              PASS      30.63 seconds



https://github.com/bluez/bluetooth-next/pull/1159

---
Regards,
Linux Bluetooth


--===============8398108555322125880==--
