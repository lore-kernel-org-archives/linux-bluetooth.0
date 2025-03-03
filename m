Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B6F1B4247
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741036308; cv=none; b=MedO5siw/Hwn+613bPpOPrg3F2sX0uXmhHMERfm6Qq/Gi+Bl3atBomiHbOL4fJs1Ii/WITrRAFHrlj+O+b6RxsJwA4EGIZdD2HzlL1nM0+M8N7zcVKoeC1xEHuxYhA/CkWzcJy2XPZLl88MpF3grJuw7Mq2i/vn4qI+ngRx+dCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741036308; c=relaxed/simple;
	bh=9s2vMN5PGl/rLNsBekm0HBxdQltlARWJLd7fEIwAsk8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TU08rSpTL3A5TewGWasTBHBPE67gPY2AtaTX+MG2IdN0IzDUssiB2k40z6yHYCZ9YQXT0DVXKxmRH4VJeEpfA5BHWUH9MuiADT4sG5uXMqLkY2NKwDvgqB52C/z/F2bbOvBl3/FLmGef04XNJHzyu4lxkqv2CAnrKNURw/SiN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXdbl0jq; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXdbl0jq"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dd01781b56so57657346d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Mar 2025 13:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741036305; x=1741641105; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KcxxsdQw1m96lSphY6c8C383mQ+XI2beoMuBlymw/ik=;
        b=YXdbl0jqvVB1qc8kaz0pis1rzeRyrJ2rC8CbYIoVaxjiGD3pQocVoMNoe4NoAhkrtU
         1Y89wGTCL+EA0XSalWFU0L22NqgTsV11vIQqYUfZntJ+SfdDCOF6j5saAU9/iPGLK8ol
         U/+zCcBySCtgsIds+oaWQyS/MiCOPLvFSdI1LgyEoXPglhNaM9xzwefv7y52FzigQC1g
         Erjvndhg2ui9/ld8RzP8NaAquaxmftrydF/dgN4RJCPXh9tHKHKct50Oq+ilACN/71+M
         cPycx+QgEg1Wdl+tJNOXe/DoS4AgYh29KPHMCtcD8eaMjH0BmK7k6dyKVyX0ddnhvUoh
         gRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741036305; x=1741641105;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KcxxsdQw1m96lSphY6c8C383mQ+XI2beoMuBlymw/ik=;
        b=adScfJkY4umRrZzyA7u2H9ixB9wsr1wQ8wlsaGFOLZ4G7P3PleZqrJrdKOxQ/dsaYv
         2wibABmeEPqnH39Ivg7+G8B9uRa5QQY7KbBW+NBlttEqe1j0gQSoq0b2wOy6CHbSff49
         180j2BWQGEqqTT9F2xoMxCMcYgBhz33thr88SRbQ1EHqRL+lqX5j0RxOcsZ7aXdDIQ5f
         cOn73o6ZRb8K3tNthR6auvflRQAKKsTn9IEA1soWErpJWvmOdiS9t5yFV/Folj8FCkBr
         JHPiDGCuctayCJFx5iPxwa8upRQI+/RaHXRbO3biwvBry+BB/rocUas0Gk8OZHqNfKgW
         4yCA==
X-Gm-Message-State: AOJu0YyWg2GfweqjrzaL2LlDwVKQu5L4N/Bpqts1Y+1uDBg9g5P7EBLK
	oMf9oodvNghMfZw9qrHbf/oCH3/UDzwt3OP1kXjg5yT14tTUIZkMurzyDA==
X-Gm-Gg: ASbGncsut+ttZv63xXZXXUEZKFV3vPLMepkfsXhrvwkmBtPFz2roi+43eJg0QD4rSfK
	goVsYOjcI8jGRXkjra7NLAp0xIDH9URegiKPIozLwWgyl35A0G5XbY36wdt6cKUThv1Uz+hYKes
	SkSlqjsgBIorLEX/3GUDkSfWVg4/cFafnAiJtc6/3UdcqZT6BdUp2iE7TipmlZDUeGRpfZRMD83
	TiLgLpJ0pLcxThu+YoQ9554ehQdAuGW9Dyer7m1WD2AX3TaZC94zCVG0VaeQD+jDY1J8lKSrVRd
	HlGHsmcS76macV0e8jY3Ts7Kp6XS5/bfPy3Sr0K32+RhJLVbp84=
X-Google-Smtp-Source: AGHT+IFG1qc8sHjN+rI7XluEeyWxI2Avxuhvg9oTDh/wTYQ/xxi9FbwXRCP8flYBvgGbs+xcnQKF/w==
X-Received: by 2002:ad4:5f87:0:b0:6e8:9eac:f850 with SMTP id 6a1803df08f44-6e8a0d4a49dmr248296936d6.28.1741036305318;
        Mon, 03 Mar 2025 13:11:45 -0800 (PST)
Received: from [172.17.0.2] ([20.161.77.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976608f2sm57456296d6.53.2025.03.03.13.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 13:11:44 -0800 (PST)
Message-ID: <67c61b10.0c0a0220.148ee.472a@mx.google.com>
Date: Mon, 03 Mar 2025 13:11:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2386985275259126003=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ,v2] client: Support single profile connection/disconnection
In-Reply-To: <20250303195140.30908-1-arkadiusz.bokowy@gmail.com>
References: <20250303195140.30908-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2386985275259126003==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=939743

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.19 seconds
BuildEll                      PASS      20.29 seconds
BluezMake                     PASS      1486.28 seconds
MakeCheck                     PASS      13.01 seconds
MakeDistcheck                 PASS      156.62 seconds
CheckValgrind                 PASS      213.03 seconds
CheckSmatch                   PASS      282.52 seconds
bluezmakeextell               PASS      97.56 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      863.01 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2386985275259126003==--
