Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022D018D640
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Oct 2024 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287549; cv=none; b=Ly07XS4LYdbpoj0aREzOK3Wx24X4vUzZPExl4Q2UNxMgy5yfMQtXpdA5lJV6QoPRDJUvaC/6MveSwbGm3acTPCgG3oRFqk+BYcVAt4xrrX11teIc8ibpAIYMx5Pi0DQTVeYq9xE9+e/IAtrVcM4OcvtJJRa/rOPuNqoK87/64Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287549; c=relaxed/simple;
	bh=ENTf33ML6OaRXcCEz42U+ueBlK0tubySeRVBc+EVzcI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gLZOGbgsIYCtShOtWyMegWh9unhyNXvO1dzFjDpZgG/2DQJWgT4OJuCr4gKWvMHn1f1l8DOGiJ/S6XNiBqmBM0sVnxku2BNgZ6M+5XknYk0A6Oxmov0QYR5wLlAfsR+LEMb2xrXKykUjlMY97Ahu4WDxmxSv0ZUNDcfV90hyaLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5WDs1PQ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5WDs1PQ"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbcc2bd800so21299746d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Oct 2024 14:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729287546; x=1729892346; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fb4wm78hpcvDx8IYd5jCQn/RHw0qel5ON8UfS3nM8eg=;
        b=P5WDs1PQBNsGXl5x1NYjGsf2VQmoWALN5RfeK9U+xstpFbtYux1bQNEdFJHA/p5ZUA
         JI+WB6KFYNStXawPsxEivOccS+BQG8uWmtLSyn9VfqBSVVhUvBim8m206Bx0bGjBk1KM
         q1Nb9ltQSep0/acqrJDFsxvYdSAp5seW40xuD6FvIfEqb4JxNCyxizaFjADBVna9cOIu
         6EdUi2VNzpEHc8awEu5xAkPdTYNwLPXv5IK7490gfZBZmvontnXozC2f9EH4bFjEwfQp
         /0R27HG7iuO3SMROI53/Yc7YFIFcYFpAHX7fWGbhgb+0u88nr9uTa3//pVhywRvokaSz
         U/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729287546; x=1729892346;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fb4wm78hpcvDx8IYd5jCQn/RHw0qel5ON8UfS3nM8eg=;
        b=J9Lkigb2CpM7AMlT28oxjlFR0VAZhq+GlJRMGLZH+uoBmq//WrKteyo0tQRMZfAFaq
         Fepx4y8jE4SI02z5CXzgWpr+9VeXMPF6Q/DXAJiFCNMCgEaTnBYraKoFsZZZa+C4QqeJ
         +RsJzHf8R4AieAQUzr57Z0LyNGfcEWMpDbCNMNoW3zN6IUPt2tHVDl82QmwMynPwuvWa
         lepOhPNCqq8bN8znkGZAeZohQq0UjJw7b8IfHthem7FNuPcDh8sElrAuZrN3os80wgZ+
         ST8dhyLZQEFOVZI+MWggD31Kxq/NPIUopJhKQubRBCxWyFsrVSydSwGMv7QmNrcqQssY
         IwQw==
X-Gm-Message-State: AOJu0YyE+8ey8ndJ30RNfxXICxAPKe72dnuZURgDQ9EDOVOdqpd3Ukft
	lIwsUvw2rhgKJQGdbTZrZvV7aXFCG8itgBqu2NdfwLZIqhYr69caWQIO3w==
X-Google-Smtp-Source: AGHT+IHrVA0Lo8nAAk8fGdZxfYu4wSDaFOw8GvpCeRdyJgopNyK4N/EvvL67Il4inNeaRX4Hb8r43g==
X-Received: by 2002:a05:6214:d6b:b0:6c3:5338:9116 with SMTP id 6a1803df08f44-6cc378cee11mr155003216d6.23.1729287546552;
        Fri, 18 Oct 2024 14:39:06 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.5.238])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde114d426sm10849486d6.39.2024.10.18.14.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:39:06 -0700 (PDT)
Message-ID: <6712d57a.050a0220.11faf3.5c27@mx.google.com>
Date: Fri, 18 Oct 2024 14:39:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1832901599367850724=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] doc: Add initial HCI(7) documentation
In-Reply-To: <20241018193730.1177359-1-luiz.dentz@gmail.com>
References: <20241018193730.1177359-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1832901599367850724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=900880

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.68 seconds
BluezMake                     PASS      1643.78 seconds
MakeCheck                     PASS      13.28 seconds
MakeDistcheck                 FAIL      9.03 seconds
CheckValgrind                 PASS      252.62 seconds
CheckSmatch                   PASS      356.76 seconds
bluezmakeextell               PASS      120.64 seconds
IncrementalBuild              PASS      1413.01 seconds
ScanBuild                     PASS      1016.29 seconds

Details
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

make[2]: *** No rule to make target 'doct/hci.7', needed by 'distdir-am'.  Stop.
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:12189: distdir] Error 2
make: *** [Makefile:12265: dist] Error 2


---
Regards,
Linux Bluetooth


--===============1832901599367850724==--
