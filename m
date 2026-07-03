Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9406384232
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 06:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060901; cv=none; b=p7JG6SsP0WPSM9sGHpUbsbZHH2NUGxwNontgmHlLgmzjldk3WLR7fIIQ9gdGMLKedgHucNb3d+nldHTtGcPcAmDS+516iHrSgPkvnaoSxbsUebwZ7j3btv2yk3D4/NrIrcNyD8iGlou4SJCPeeJCjZH6LA6Cc0pcHNpAJ6w0FUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060901; c=relaxed/simple;
	bh=a5ASXpRDUlFXufGaUDfROrayHQTbVVbXbEon07u391g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UkUrfu7MfV4rSY1baveUc8wQ7RfzpMTdm2R+0PXeLpmRSrN+cgdEYvyhcLd3N81oH/qwWyn30djgzqkp7fgp0KcgebebTElbUfGfSXlvdntD6oCrkrCUyI+AzHXHJMi8BpQqAG1lkGaslzYfxPwi/HI6NV8y6hCAw1ukaUfwp5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUbOHjpv; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUbOHjpv"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6a31efdda0bso287241eaf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 23:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783060898; x=1783665698; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a+SKOs5VtpKC+kNkSPrNEDfU0OkxvBrXupKrZoEQp6Y=;
        b=fUbOHjpvSs9a5qU/ovFauMGrT25n69TeFLYNILqMz4OM485G9gZZHksG8jhlCRthLI
         ZoZAXzwdeBZuJwf0qfU153wN03I77NUYlY4FGQZInDCyWYR9PGb/qO7aNLFES09uNYk5
         wrBIyRYbN01ijOwFXjvt+JZo+7SruKqnQ95KutxCghBMudLl1O4KgJgO53n8N1/Mnvip
         cCEvEAZwQkXQP+Epc02gBsBKF4QM99dp951WEez4ZOOwO4OcADVeF5lXcBWEQU7Br42p
         ZFkZ4j6ya6vXtIdk+3KUpX2LX4jLK1mrHBV7MV6NC0GYADP1CILLCdKvQuqlQcy5+0yn
         K+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783060898; x=1783665698;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+SKOs5VtpKC+kNkSPrNEDfU0OkxvBrXupKrZoEQp6Y=;
        b=gOIfhRr4WKzwwuOMRW1lKsNTbhoDV0tpHMNL42gqh0+8GO7c9VyAXxv7e0zG8QggAp
         FKCQfpLHISpMqWoReV8d3KNKnlZ/9wMKohQLWCVO7cglHkLNmBpi/Y5KclDKns/3mgXw
         aGTkhe9VbLMeYHsB9v+TlA4kgmf87xO8Hc1SpWx8HTHJAVM+2EieGOW0lshZI3XvM0tO
         y+6mqCuyJHHBvuiHhCbhR0giV371fo+7ulcMj67prfBxt143YOkynNOqy4n4UgVnCXad
         JXxQ6FVzWwkR96eiCYH0LKmTtRxdiHNWdb4chCZdKAPzcL8eZGWvGgGQ6yEOTcNHmvku
         QG1Q==
X-Gm-Message-State: AOJu0YwQui4fQy5cVnQU5/nPOxtZCmqdP7dubXN1RMEXaYsuuaFaf7k9
	uV5WAAetB1DIvKI3PEZqhZflyNSfegSVfD1VMGpbxLAZ7azGSzMWs+vRa0WB7g==
X-Gm-Gg: AfdE7clJEOeKE1kj6GK964g+MeH1DQE1mxNvvdRGLqfdekjX7SPg7zBJTNzwyutCn/j
	7VBAzBlQy1megPgd0Tvok3sohETRaLrIIR0VhVRsZeeFyHYXcdWi5FKjyupQRucCVG0OsGHtJag
	RaTfq5Mk8vyO+KsbdckxclFHvFXQEDqprCwocX75YuZ9/Kgh6isoFF3/UcrdA76JfhtdSU9VTCr
	DHblTvpS7BjdaZ6FAyxsLH3oeU+a/UIUqYO+/rm4aMKc2eyes6HFgfrpkB2cIyszOvWQNgK9usA
	CanUVKK6qEkVipc8yNkpP0GC8thYVZ/cSfOqSXOxVtzA3QTdDJiDiQQxKGAYxKRAa4XUvlRuoxs
	Qr01G6JLHcBjhmzKczvcX3KG7yn4Uy89wD6BCb+oqxyT8U+o7kaZ0ca97HEBNMN4NbAgGwkPRzH
	b25SG5FtDE7FGsp7UdD5Mb
X-Received: by 2002:a05:6820:997:b0:6a1:794b:614 with SMTP id 006d021491bc7-6a31d4ac167mr1524631eaf.28.1783060897566;
        Thu, 02 Jul 2026 23:41:37 -0700 (PDT)
Received: from [172.17.0.2] ([52.154.131.101])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a310020e13sm3666277eaf.7.2026.07.02.23.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 23:41:37 -0700 (PDT)
Message-ID: <6a4759a1.0f7373e4.358a24.d1f8@mx.google.com>
Date: Thu, 02 Jul 2026 23:41:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4134806436101064841=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: MGMT: dequeue queued mesh send before freeing canceled tx
In-Reply-To: <20260703060024.570535-1-zzzccc427@gmail.com>
References: <20260703060024.570535-1-zzzccc427@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4134806436101064841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1120897

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.72 seconds
CheckAllWarning               PASS      29.69 seconds
CheckSparse                   PASS      28.42 seconds
BuildKernel32                 PASS      24.95 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      466.81 seconds
TestRunner_mgmt-tester        FAIL      207.37 seconds
TestRunner_mesh-tester        FAIL      25.91 seconds
IncrementalBuild              PASS      23.83 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.237 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.743 seconds
Mesh - Send cancel - 2                               Timed out    1.987 seconds


https://github.com/bluez/bluetooth-next/pull/389

---
Regards,
Linux Bluetooth


--===============4134806436101064841==--
