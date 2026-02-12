Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3468C3EBF3C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770909336; cv=none; b=Elv51jFXrHvzT8RtZ0DdtGuVJFYdTBQ2j0OICCZIVZvUrQJ72dhf1zF4BYcJslnAluWbGwlV+feDTV5zu/PU7C5cyJUp393xHxnWjkhdJebOWShccU/VaOLZBKX1a7AEMFh7VLLaSzgErA/w5RYaKTP1t9hUyjyYqwxbAMxnFGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770909336; c=relaxed/simple;
	bh=q5rKMS1EmjJh4LbBZlsDIhraeVvFTZ+mE/gy3xMNM7o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=b8lYxfz4LCohGGVi/To28RmN8kTFKKjKwfHszQJzP62POi744jI5oKpqc3Zd1jgJMG99m+sWjX0nZMd3NcxAcFSOwftMHwBE/ljFPF5BsPJYbwwc7crfEJMBKiSWGUWJ2OtEtq9wtvwwHQnLjCp0f4yudv+erSCytGwtDry0XB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdTogRSh; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdTogRSh"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c7146b0854so820839885a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 07:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770909334; x=1771514134; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q5rKMS1EmjJh4LbBZlsDIhraeVvFTZ+mE/gy3xMNM7o=;
        b=TdTogRShDgeB1tGFMuvMOc+hfUhJHjq4WxHA7BYjaVLuPpOHWXW5RLkxdbxe+I6Mt7
         ZPxjuVXhVzFLataPILP/dOc2JRAtpsaz1OiNpMntjKcLRQ6b3XJtwc6QAlZidX7QDqVf
         RPKMJ2FRIernHKl49Hwe4goFNht6w0hheGvSRm2xzgoPe+QAu32bXoo2i1rbZcO1ioGm
         tnYisZ/8mu2j3JKp3Xl7dePAKXCJ20FAd0kKQ/U7NABliR1+eWSXV9CytqxRSNIFDqKc
         HkjDRLf3JW5ixOv9P71zxDg08Atst2o0Mq7d/UD4OYuWXMItzXcqm9EfWamAR98k9Ih5
         0qFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770909334; x=1771514134;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5rKMS1EmjJh4LbBZlsDIhraeVvFTZ+mE/gy3xMNM7o=;
        b=j24U7S+1J1GY+1G9HyeHWbLt9ggNVURJJ6/OvxG6sYeJvTk4N5dc4SzWlhM3zDB2zp
         p/GGI7ULZFnFBaP3eVU9iDXMWnR2deinF3+WsA5IcG15QSF5qn3bjijNL97knI+0hz+F
         Ac9bcSeIcQAePxY6EsQrJUV7ZfBmjz4Jk9DgBl9p85xjUDSx100URCuSmR3FyXLZXgUp
         nkOgLeXHL8AnZDeHm97v8pntwItEqwZIK2400ZJz3NBDqWLZn858XbJmBMWPxE71COtY
         KcEFGZ0T8cjc0feySLt1JPjFBMzegy2QYTvgpgegf9n4KjZX3reVz7dh8WxMR8POwEGE
         yvxw==
X-Gm-Message-State: AOJu0YxuHmP7HLuR+h6BxGGedI3kC0uFeT53pauM+Vv/gq+sLAsIUIfv
	j212leJ4ud8GYUqUVbj4o0C1UuEZCFscvbuD61LVtc8Nc6cHaCT4bIKOkBcdc5Vt
X-Gm-Gg: AZuq6aLU8ICygToo3TLdk2hktTGcSS0Ze8H5neb+/2khid4SP7vbnOOPGIIlOYbDImI
	HHlGVbXVOI3Lznun1F2pfHnihR/8dW8WxMyJRe8wl0pgQZ10BzlqsUddjZkgzP98wtWEYpEvIfw
	r7ZCOgvkKQOjrqFHniwpWk54jaxuteytl+PiqdqD4hUEiYpItnIK/z8R7w+x2cK9f9/5yejnFUm
	qwEwdXPv4WF2iYJjr6oOiBkCuNwoQQTBfsI580B9quwexmm7x7givjj3uBbSwn1nlLbWNr5g4NN
	KLpuP6lw711ofUIfUVAVmQYxIZ7OxbxBKvZH37sqsfyG3QaINyq2m0xYDAhvjxYuo/7oUfnRyXZ
	4XGudHHF3h4a04e6FB7aCAemeLVEXm3JotoxwtY/LsG0YGo2aZ7ab653kYvwtdRSV3YwLKRNojn
	2a/JsD1Sywwe9ynQxfThS/Fw50ru2k
X-Received: by 2002:a05:620a:4046:b0:8ca:90de:43f1 with SMTP id af79cd13be357-8cb331607f3mr369959485a.63.1770909333486;
        Thu, 12 Feb 2026 07:15:33 -0800 (PST)
Received: from [172.17.0.2] ([20.109.38.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b1f73ecsm392458985a.38.2026.02.12.07.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 07:15:33 -0800 (PST)
Message-ID: <698dee95.050a0220.21fcdc.09ed@mx.google.com>
Date: Thu, 12 Feb 2026 07:15:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5273936093398178758=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johannes.goede@oss.qualcomm.com
Subject: RE: [1/2] Bluetooth: hci_qca: Fix confusing shutdown() and power_off() naming
In-Reply-To: <20260212141721.69961-1-johannes.goede@oss.qualcomm.com>
References: <20260212141721.69961-1-johannes.goede@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5273936093398178758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/hci_qca.c:2015
error: drivers/bluetooth/hci_qca.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5273936093398178758==--
