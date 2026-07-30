Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEB8437473
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418049; cv=none; b=uzrgPI/eumBk4GqWg+mZrkIMBukPgws6oFr3qXQXVQHWZdZLHmqEYnGx0efvkYpRZHvKvnOfMmXgu+PVEpNQ0J5YR6X7YUaxQx4PbyHJ+mUj4qpz9cDavi1NWIPkY7rwOsWOsiYk2bGqlbpui+2sC025Hs+f2aPdKK6H4vvWxLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418049; c=relaxed/simple;
	bh=R4BWgGxv0js64R1KyyJEPvswM5NZqym7GkcNuMVBWvM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BvxZ7KSbkOxiN4dol56wDpjpFj3gSK2toGS+aC2IY1QVWJCRW7cMsJH1GpGlfuyEOwu4JtDVcfcsmOL6er/JhORSq5kQqWuI2ZrVPGS4wk7AR0eQODsBAlGT0onMw5VYAbac+3HiFNcpua6mAx1p5kSMMyEuxwvQEh4NqqRXyUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWF6hRTj; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWF6hRTj"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c04bf4711so19247371cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 06:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785418046; x=1786022846; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YDVt3wYhKQt14GYinaH8YDmmJ6cRFa61pUl8MzTFyDg=;
        b=bWF6hRTjs6DE4d5h3ZdNokRgVMxLPscUoSmmJvgVSmiKQF7FhFeLDnEEeg1FdKckFN
         7ELJb4D6KowOY+msHWs3UTgymFQ+uNL52vHGNiD7R9LSPx8e151mB0lRqtgqRf5dVtZV
         w4Tis0oQNLGQwOtiSjLPsrGAN7j6R9V7+JINTFniuPlqDe0zco/31uOlWYU/s8hR3148
         KqN/a8fQjfy6U3nHQxzY67/qYDiEvACyhSZw9fuRtGXpyauiVr1riKj4tJTxjYXXfsRi
         E9RIRJlRltpMU0XIxnArKQ89M7H2L1Y+hbP03BzweW8DnmcpSQIffBI7YtKbYKZSHicl
         ZPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785418046; x=1786022846;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YDVt3wYhKQt14GYinaH8YDmmJ6cRFa61pUl8MzTFyDg=;
        b=CNSRhSzcEjWDTGTIuuawL4biAisYsbtvucq4NrcBGTUGF+IsDB4GPBWN+RxMnHs3tc
         CMe9MbDCdad8i1xAkuC7L34AsoWGpxTLuHNKdcY+hduhfXH35ln9box/qRbOsn8SNP+i
         4yitZb3JFrzvqElNt/4MkvWi1J4W6BF39tnmBbSnH93TwbfCZAvzAGx0mtv4g9XvlM+K
         4x4bK47MPp6zbQZfpWh2oLW1uzyvvniu83A04szEECK67zoesukA/B/kGptTvcz2fgyV
         8d0KCLJBjGg/gdyFN47L3twRbWyKvgqqMacuEccHqygleApnky9kqG1KIUPrUjF0k4Qr
         95Vw==
X-Gm-Message-State: AOJu0YxnL40kSCVTWVPh0/OYgX83q7I+NJ2h93s+AjKc4LMn7uii7cTx
	jmm+FaRhPr8X2iFtjnEvCdCL0cXMJRFJXa8YwIesfRQcsKshrQa/zUYii+nyww==
X-Gm-Gg: AR+sD10JT2gKa3QJ1EiMlubp3Nhr/vVRQpGhjRLh/oeLeqG1+LguJxZA3zUpcCsDJ1v
	Vwt/YlTzDQxlilTqIukX8niER6ZyvivPdJaEa5QpwUds40duvJ4kouxYQOUdFCaQLdoeKjlb7bp
	IxDNBgNGcse+7rgGf+ZhDjxwOGFiBXKDH4lOSX9vKuIlK38O4nZ0992/4pnOqFg9rk7/3CyRS+l
	OO4+uEvv7Ry6BxcPFEsifMIf76IZgF7D7tDP1fKNCyrvV1NeRXY2JKVu3UIELJuTGiEmvlNrG0k
	ftIBGQ1c/yjMW88jSI5cAy+Vzt7KUu6D21llhjLs34C8F5aNfOSXKI0UW3PTz0uqhN5uhRFbLlm
	DpUItk7qEGe2Z4OgVuRuYY+9eTWRK45R2PTpsupWnNx/KShH48CwCsDzsa5Aw+vW5A+nKq1DmnQ
	8PnYeEgbaEOs6aFmbNxEjcqQA0WdvSboPQY6jB22oSl5uD94nzT4YGf/A4RqIxdpVlsHL+MkzfL
	RsnIBcWyxXJSzDuMf0=
X-Received: by 2002:a05:622a:1e17:b0:521:8ef0:b4e0 with SMTP id d75a77b69052e-52b3838612emr25803271cf.17.1785418045682;
        Thu, 30 Jul 2026 06:27:25 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.100.83])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908324f9186sm17973576d6.34.2026.07.30.06.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:27:25 -0700 (PDT)
Message-ID: <6a6b513d.d0999061.2d6f51.28ad@mx.google.com>
Date: Thu, 30 Jul 2026 06:27:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1594603208924785339=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, acharyalaxman8848@gmail.com
Subject: RE: Bluetooth: hci_aml: validate firmware segment lengths
In-Reply-To: <20260730122028.98159-1-acharyalaxman8848@gmail.com>
References: <20260730122028.98159-1-acharyalaxman8848@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1594603208924785339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1137388

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.21 seconds
CheckAllWarning               PASS      28.29 seconds
CheckSparse                   PASS      26.82 seconds
BuildKernel32                 PASS      24.67 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      458.17 seconds
IncrementalBuild              PASS      24.40 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/517

---
Regards,
Linux Bluetooth


--===============1594603208924785339==--
