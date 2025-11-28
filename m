Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2A821FF4C
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764343051; cv=none; b=Oi+/naNqBEuszQorNu5BBdiUZkzjA39EKvfNktCwXZXV022b/i0N5jlbnvVrJQZkLLVPAZs55Q0oK+YPZI/PhVDXOWJ0He9YfiGophqD6dBjuhU414AtkrCCz17aJDIJig4PA/UREApS8FRoVUdl+qB2ukd3YLht8UiqUGwsKZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764343051; c=relaxed/simple;
	bh=Nh/eDAor8sCVcidh6vsBDI2qfAMw5bA5fpoCXzyd1Yo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=U/rLReWibseNyg7XjQWaPAUUH3BcAA8DaeqOXdt+w1m+BL4ADkMjAnA2uGdNCzmLmN9CwPy4zO3h7I+FEh1Af6EfQ3Tg8GQMi41Q3t7icXvF8xeqE/Cu9utK1XQW/5ckAaMKqHC+Z7Jiqah8rc5vDBnxJBA3CbGcxUW4IcOspx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lv9UZG6n; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lv9UZG6n"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo2381338b3a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 07:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764343049; x=1764947849; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nh/eDAor8sCVcidh6vsBDI2qfAMw5bA5fpoCXzyd1Yo=;
        b=lv9UZG6nuOK/kep9NiAQMfoqZfshSjT82f4qmOHPgsas7NmWCeYY0G5XSjv5e8+CSP
         C9FyPPXLQhDX5A5mlLlblndV9aY1Hvd1mMaHhYrAXQdRUaozwfjvcUzHWyP+ZsODE6W1
         WOAcW5iFUQUuKlftohQbQNbzjnn2oqgUw05XjZ6CfIroZo6bdz0W9AtMEwMTpSmiCI35
         xkU8hZV7lm8XzNEucB843eCVhsdCdhnyasev4Yr1uvKJ3KquEsTM4xTPY/r5tAz1D2Ly
         FZRTeHu4P6t9NQ9vg4pglZovdNlPKqNwL+cFKhVUW2fAnMBKXMlzli8W4sMGfcC8Ntht
         IuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764343049; x=1764947849;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nh/eDAor8sCVcidh6vsBDI2qfAMw5bA5fpoCXzyd1Yo=;
        b=somub7gMwVgfjRWdSbBXCSx5KH+n/ptcBUjZ1YTU/qiZUQVtYFZMvV4hHZRpSVdV5W
         oLEoTUg+Kcod8XsQ2fVt7k/AYIjET6YcLBVsmPXnhFO9YPaJXstI0dufe0SAukdwEkPF
         Owamc9J7s7OCt5RqbnqV0fx51f0CMAGL41G5295tftXb2zpKDWw+qaagVHL5mBPbwKvJ
         eIMyydpFLRwUUGAKnduBFJ/GtjGppyHowvfPBg1NVk4/OrfennuVy4YIr/5h1S3LivPO
         p9nhoIdSEo7hS6HsEDwJU6ovxCryvAXkrJ+qzExqm0JcOcl+jyULUV4rWEoEENwFjOhk
         sDXg==
X-Gm-Message-State: AOJu0Yx9zL3tx1B1SPDJLJtH1HnZFWXLACxN+HTF18nUM4JxffZzgGqO
	QVVQ+OQxMiNsh8MwvGLEjonZA8SjkNKgRNRgou6Un5vwYygWp2Dy5ldn2dU3fg==
X-Gm-Gg: ASbGncvA5sISTfm76522UnOLvjXfZfi2kK/EPaKV+Ql3XJTEb9goSTkqeUll87rJe7h
	KlCmeP1Kydy02XXZ2J6TKlTd95CAFLGEp+B9P5ke3db/JN0d3XhGrDoXZyYc6JbCQFYFyv/Z1wx
	iY69rNKKCJSWJwC/02MquULwheuDVYGWUTnv+7D4mKwVYNAVGGDDiE6XXJq2LS8z82oKLwmVOKd
	JxBQLYqyur8OxVYe34vPwkBm50bF/CVCjoAzr1r7YvcX99JIk+l1XsXs8TF/NJ+7GEOn3qKMkxn
	hC01wqWOGJBd697TqTE1s3+joudPjGIUTCpQqo5nUHhnnVEv3z0mr+KGBKsP1yLuUyr6ZhfZzC1
	mAMPdGiAQdJY3gsNqvjNt2l5aE4OU6qAH/HSV9+LjJZUqd84oooP21rORLKnzBQ3aKYtktP6bv0
	qDwvBReDeAw+BamdGgV3q9l8Y+E6Rl
X-Google-Smtp-Source: AGHT+IHzUl2i1bXC0JkVxoLgFuYmBxyFnr2NSYUaYxEyzk2wGArljGaHCuIEOQkppTf3ahUUNANDuQ==
X-Received: by 2002:a05:7022:629f:b0:11b:9386:a3bf with SMTP id a92af1059eb24-11c9d87286fmr23665602c88.42.1764343049179;
        Fri, 28 Nov 2025 07:17:29 -0800 (PST)
Received: from [172.17.0.2] ([52.159.229.150])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee7076sm19375024c88.4.2025.11.28.07.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 07:17:28 -0800 (PST)
Message-ID: <6929bd08.050a0220.b7f77.295a@mx.google.com>
Date: Fri, 28 Nov 2025 07:17:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5420155276424048799=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sivartiwe@gmail.com
Subject: RE: [5.10/5.15] Bluetooth: Add more enc key size check
In-Reply-To: <20251128144535.55357-1-sivartiwe@gmail.com>
References: <20251128144535.55357-1-sivartiwe@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5420155276424048799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_event.c:3043
error: net/bluetooth/hci_event.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5420155276424048799==--
