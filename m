Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309614;
	b=3Uuv42pf1euPfxlxpmT8CX85TeaHR5+sDAdvXw0IKInbspbZjA7T6qmaxLOx7NCiR87h
	 rrCiWvYrXowcg6wQm282qxU7idPtmQZISE83BuTIgaYdiLeg8674vkB27Sg4FPKc/HHwr
	 W51Cq1y6357604QFyZ+d/F23hddFvy0egcld7jvQkvjS9WjsDN9uYcZXUeKI2Uqi76e+j
	 6dusAsVx5v9vWl93QxDCVk7CvjBjXE5EdKm5yVhClgjebKD42H+28L5kApPLjeI5epWCr
	 yNoAihKQD3TPJzPPKzhVmBb+XCXXndN1qgcb5B+NP6BZlSCq+SNezv0h6YvyLr+rm1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=PUEwfYR0qIAWoypd/pFqJLwmnlvY+14VyHzw8ksGYkY=;
	b=UwKoTY4p1DUtAeFRrtZ9bp+/YyErajxYF0RIbnmcDl3CWHM6/45Nsx5I6Cg53XKJbJHE
	 Ax2RCqLxoe1PB9ITx16F/uYmiTO7QAcbttn5+ZVz9DVZUC470D5BzreUAbrJ30TclSjLb
	 BbOgKRpwSruZlZGmRxWZ+oN0DOOmi30WrwHCZF2LfikyD1YQP3Ri/nd7ZuW/lC/QYL3r3
	 Hra7MxUZsLXWuapzEP3bsxVpYf8Q/uQTtOldKO15huTXu9AXBUVcW2gQMZcOf5+PjuR/+
	 mbglj8mBIIabg/lSdX0gpItGldR+y0pdhTN/+iyYmLl5bwoz9nwRgQA4jFcT8tRrk/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FimiP4Mj;
	arc=none smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD67606A336
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 11:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CD67606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FimiP4Mj
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-70bf1671c21so1063660eaf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 03:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794309613; x=1794914413; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PUEwfYR0qIAWoypd/pFqJLwmnlvY+14VyHzw8ksGYkY=;
        b=FimiP4Mj/NknZZJhWfA6t4DAFnpfHVqwQtkeERZysy6zZmFv8rMVHoBVIQlvRexCCz
         ILj3WVm6FVg89X1n0GMttriTygCrI5w980lpxOzKkCVSJKeVBLBz7g+V2nqafdkEyWoj
         NWNUjkkxEDmnqqqxZrGmVYpcMt7gsP84yuQuSiedt9ZDWNTXcHOIi/eNjmkON4R0svSd
         zSQaf2j0a/wT8oNn7dn+KV9cdT3mXvvnHV1kzOCi8ogVYPbqwaO2w9yoxM90gV+GzFUC
         m/D+pxSpkNrhv71yQfPem9TrodZkttX4adkHoCAGbclqWSf8I5sNymgbDqtFAZsKczzq
         /xGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309613; x=1794914413;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PUEwfYR0qIAWoypd/pFqJLwmnlvY+14VyHzw8ksGYkY=;
        b=Ivdxrh96n+jcamGg3gxpTSwXmIm6qUEwRnpc2lLOYhClv3Z1oaFKFFr2HXW3i34UXD
         9dvIeO+2oKapHt5Rs1Hvr4x/sBfTSXI6XKiTOD3yr7WjVEG5M3I1blP5fMp8OHwNKhGv
         rY40WYaAVx1VrTqZJL19kemIO5AnsuLUsh2WE5H0lWOG9VNTz4kUAwg6L7N3ZMN21P2t
         SpRHsi6damWyDus6BG6i9darjG/AsF4x/e9+xgGNlKb2EsTfcyVRs4F4vINn6I1tLU9Q
         /Wjl3awO0qWH6A0QHagoVznS0CHkmyT/ULEUtt5+1YJbvw84UUmvSIyQ++CRjC48CzdR
         nWgg==
X-Gm-Message-State: APuU4Z9hI6nbyqFBFM4ireChDHIfvKr5zC68PBV+gIldfNm3zUFaEGzy
	Mn819jaXLRtlmCsTrr6+3CZAaeN2HiM6PmYWBTNDIDKup5zykVqEiP1GFXpQCA==
X-Gm-Gg: AYBFou1b3rG6mIFFv+VY6lUq3E2IBGzIO6x+A2hzny3q3BG7hwgNfFUYzsbnz+ZBKw6
	JI4QtUR6Z+jODkqhjH9eoSLaqNAURx7hSe0UAXhiNHx0up4dB/+Y1YcpzykHvEgTeIwU3dXovC4
	J4VqElb0XtF6qF39ZhNZXzFF71rTWMfBnx2jgLZFzh5p+hTPC64fnY5GhiKftaHRDSGxbIMzeLs
	B7Q7lsEH7pJs0byBKNWthVY1TH2Estdf/krvaXVL6HciK7P2NyYG7MnLbKWYs24WHlxjpUOAcWb
	LO/6iOj5vQaBcNkJr0fnfW3bmxdeuv1cJ26J19O4SotZ1BITVxFpWaBajVQxeiP5HNEpM6GciJG
	awbYrogc6xqN2MQXDak466wSzQjWyp1IXYt6LBzFG2k/zxRTkUCjRmKrYO7+Soiv5u0EGt1tMtG
	exbjMNh3j/NjFi/GMetqS5McGhd+rN4xi1BiiqOsCS7zlUha+lYhp2KfVPyiUjSI/9RJnkCjAha
	4zMt7LayOuuTQP6orGtLkco1qID39Ie02ItORgjYbvGNVua9rnbOnJnHSuEAek=
X-Received: by 2002:a05:6820:6fc8:b0:716:cf77:fa86 with SMTP id 006d021491bc7-718a7bd9f29mr753407eaf.86.1794309613240;
        Tue, 10 Nov 2026 03:20:13 -0800 (PST)
Received: from [172.17.0.2] ([52.173.181.17])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-718a6f2a08bsm1435045eaf.2.2026.11.10.03.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:20:12 -0800 (PST)
Message-ID: <6af2fdec.446579d6.1ef847.f670@mx.google.com>
Date: Tue, 10 Nov 2026 03:20:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3820222118535205984=="
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
To: linux-bluetooth@vger.kernel.org, joasantonio108@gmail.com
Subject: RE: Bluetooth: hci_qca: clear qca_memdump when discarding dump packets
In-Reply-To: <20261110-hci-qca-memdump-v1-1-239974fc4944@gmail.com>
References: <20261110-hci-qca-memdump-v1-1-239974fc4944@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3820222118535205984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1206701/

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      6.78 seconds
BuildKernel                   PASS      31.23 seconds
CheckAllWarning               PASS      35.32 seconds
CheckSparse                   PASS      37.60 seconds
BuildKernel32                 PASS      30.67 seconds
CheckKernelLLVM               PASS      34.80 seconds
TestRunnerSetup               PASS      748.42 seconds
IncrementalBuild              PASS      28.74 seconds



https://github.com/bluez/bluetooth-next/pull/1098

---
Regards,
Linux Bluetooth


--===============3820222118535205984==--
