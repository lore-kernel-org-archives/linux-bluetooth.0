Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795519854;
	b=dyXvqeuzdZTvcBTAMjSJNXmd6qaNPXG776mx7Kukt5rkjhbGOlLV5GIKvEUD5qxMlCIJ
	 0pXhVP83DSGa6k5L9GnLL3/UKKVDSyV78Og8oniMl9pwLHIZcmq4IB1KjZa2cvJB9IGlD
	 XlMQVngY7KjkFELp+76YxYK0riBqoGLg+MHXmYoIJSiGLDSHSt9OMuF5QRJjtAGupyl4t
	 bsUc+K8gClO5koRAL/1PsGUqic+ZhzK7xR9VOYCIqbKXsM7oJ9s/P82uux3K6euyQgc1R
	 lKRargsqj3WT2oFp5IZBrOxy58laBmeP9YQdGVIFaCl9XJi4gzcLVatf2doMy4Lrl1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=L57APOj0LfrvxmSpjc+v2+MZQW6/ZCH1bT70HmIRJFQ=;
	b=ijdF3L6XCGI0X73ZumVYet2besrbTYuNIXKFPF3z9FAGG83TjCm1r2NQrLtjqgAZvIPk
	 jTo6WH9lomSdfyhQj24jCnxKVBeHO/o6DgCOE8f/NCqxT6mSaLUaP63LaFDyxz6Da1Hpq
	 /B+/y9o898BX256r7Er60U0OXyQITiruaQMLixIBaeD3YKzRkYzzreIzj2HN6Ylo9oXeQ
	 wV8DMK8iTGMhb64oi2kUnYY6IsMCD+0rUnMxeCzhngeaXuhivXjfscGgr+BpXF7fBL4p+
	 /hXi5aC06xZ+5OdHsB91ysPWsU5dUJcU4ZiNlt4x8qsEKXQsNvwPBSbveElIZzxBrFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lzVnPMJk;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE2C606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 11:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDE2C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lzVnPMJk
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b546061d58so9840918c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 03:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795519853; x=1796124653; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=L57APOj0LfrvxmSpjc+v2+MZQW6/ZCH1bT70HmIRJFQ=;
        b=lzVnPMJkP8nJn6KsRUQ4l/4punUauM/0D3bG5YT6SgHSICHpjmrIoStay4E6fpCTPx
         MFlJdefP9cj5ofcD9lM9WCRv2//w19bwEpWEaQzS66Iv7toFo+/Nr3SBZv2PMlc+OjFm
         dg1x+H48ql/dVe26eu1LgvVYJPT2vu6LhdMgPYU17PIUTr1Ha2Q8myAFAcY1Kck1JDXG
         zg2o7gplMmve0gmuJso2V59ypus/6ZbbwavuC72huBoLVlBZVVO/TxBysSMKWOoBVEIX
         ZPFWIidDOPSxPZUk5UZx6Sj4sKDZmnPFvIew6FdDjc4aNrMMPFPmNySNlW4CWnjjlLy1
         9Iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795519853; x=1796124653;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L57APOj0LfrvxmSpjc+v2+MZQW6/ZCH1bT70HmIRJFQ=;
        b=tCDJD0JAZUnAGOFuN3zJldFuoKFa1zzc1vDyV+ODJgvD+D/YrwD003y5ngBFVZ1TYG
         GgtOcG941GfEDCfgWfX4pwVoTwJiMowRQmp6rEcpn6A5+EZC+K/QE46mbq1C2yTHoJvq
         eKxDGdVHqCNM0t56cRvKCG0pTOvqfqx5GlyLxhROuPKrAz3szx2Zemdu4MbpQbd73b/W
         BmcmnCgUhIaV87tHHFa89DFC40cyXjTSKTfuLwo340urGKPq3dwpc4/GW6VTVE+dc4rz
         6pNvUUgGOf2BZXmOsLAht3Iy1aDDexex+UOdZGJ7Pd5Um70vAYul6FqrFal1/PTa8Tp7
         XOiw==
X-Gm-Message-State: APuU4Z9SCnOgEq08m5car1mq215G4ZwyAfI8iTCKiXI37g+xjbFZ5U3q
	7utpe82cOI8F7/srA+wHXaCriBW7W8zPaI5iNWDncWYcfMFOMlQWst5W0aDj4g==
X-Gm-Gg: AZFdTZcaBv1lThbXrP8STvJQMB/Vbxqo0bpZKZnzRbjA65TWB5jMwJ139c/qJi1so8J
	eJI6gXIzaN6GFwJM0CNh2/EO3WzUK0YB9dW++E762Huqzmxd89PL3giGEsnygaE1KD2/GfZedPd
	SXs9Z6Z0uXVhMTiVrsY10ukGn2/7B4G/3f1zjD9MDhbXSVRc7xTyI0HVcci7LOCQFVgzSvz62fN
	BRruRc6Tl7bnOvRYs7wibdBg31nPScAR6TSpUcOR2jOfDDGAbgO107Dm4x2SG7jwv0o1c4DIyj1
	y0itiMvyspcZgzgDBgrwtQs/j2RcqOfKHD2WfBDzKPfQVkCMOD2co7zJU/oE/4oUBnyYSQpxQC3
	7lGcuQhVpI4cVfgNIwobI0HFzRWuvhogJPJkLKu6OwddvSSAShoI59k6eKa06HPJhqMwhW1NTtp
	FbJUFk93IPj3nL1Pgaf4GohTVtreAv0ZyPJb7EqT+aSo7GcozLgL2fwXpdVPf4UxQVyFyqHrEkV
	T1FopLH0CdCANvJHmvB0erQSZJhOkPJGQuB4IfKdA4xlhzBqbZI26RR2yK5Y98=
X-Received: by 2002:a05:701b:428a:20b0:1b5:1a0d:b544 with SMTP id a92af1059eb24-1b5568a145bmr16052259c88.7.1795519852931;
        Tue, 24 Nov 2026 03:30:52 -0800 (PST)
Received: from [172.17.0.2] ([52.161.177.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm50010765c88.14.2026.11.24.03.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 03:30:52 -0800 (PST)
Message-ID: <6b05756c.018c0331.11d296.c08e@mx.google.com>
Date: Tue, 24 Nov 2026 03:30:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7305918419504844751=="
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
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: client/btpclient: Security Level reporting
In-Reply-To: <20261124100035.245953-2-frederic.danis@collabora.com>
References: <20261124100035.245953-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7305918419504844751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220644/

---Test result---

Test Summary:
CheckPatch                    PASS      0.99 seconds
GitLint                       PASS      0.69 seconds
BuildEll                      PASS      15.91 seconds
BluezMake                     PASS      229.50 seconds
MakeCheck                     PASS      13.53 seconds
MakeDistcheck                 PASS      117.21 seconds
CheckValgrind                 PASS      280.36 seconds
CheckSmatch                   PASS      234.25 seconds
bluezmakeextell               PASS      75.46 seconds
TestFunctional                PASS      1003.52 seconds
IncrementalBuild              PASS      235.64 seconds
ScanBuild                     PASS      844.91 seconds



https://github.com/bluez/bluez/pull/2896

---
Regards,
Linux Bluetooth


--===============7305918419504844751==--
