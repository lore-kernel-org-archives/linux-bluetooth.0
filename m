Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382B532B99F
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769805455; cv=none; b=oPtTl0Py9Mjkov9KxvbCoXO09z9OF5A7tLd4sewb9HRlxqd9rA6qUyXipY1OUw1AdQM+3qih6JWzFFt/DnhhFY1d8QSCCuObhegiBSvdjhEho2EYyQBm9Up8dxkEHwwIEUkiNWRIgzEbkDxqrFwPh1X90Lfn7wecihLYDnoCDwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769805455; c=relaxed/simple;
	bh=H+kExBMcRBAZn7Nk6moGPxvJl9yI8ASarCoBM5xfaBk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=T62D8cwz17MD1g01cP6f8bzz5W7ju8hMkAdOlLM/OafxzzDBKRfXz7NvWbyIFBGdEkVv9kdniOP2d4YPj9ecVLbzj+vsVKj6oNhMrR7rR7C2DhAUkKpCtHc2SVm9h5I9SnRAaKL/PS/sOATUmBOvJp20yBmPuYR/b0gNXFqS+ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpMKLzVI; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpMKLzVI"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8c07bc2ad13so198198085a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 12:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769805453; x=1770410253; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ANR1ZRMV5B7ei0JVL7qUO2FUcXdPFx0Zjuc4ianxrb8=;
        b=NpMKLzVI5SAuSHYmzUa5wTMRyv0vkOpyoMb5zXxREk7g/eKBzUyNbKOn2DRg87oPuC
         ZavEQcgSimV6UamIHt6j2oj9LgRMx1DvLlp4vWfRU60sEaRtJAah1fJdIAKFs7CA3JQK
         GxVoo+CK32zFQcYpND2Y6CS8zuBfu43bvzRtQn5xh24RO0VC3+5eTipUCiugKdKseKm4
         k4yzByWiCwJ/5HTdkPi2xjOIwAuZtRbc+teoFvvoK4iM3z6C0C4vYky66DhXW0zOuxm1
         A0QQ5ppWuBpnj10aHHj4oJoOulb67b8NcnPv+WH9o39DijzTaBrymSKv/pnIPI8oxtNQ
         ynVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769805453; x=1770410253;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANR1ZRMV5B7ei0JVL7qUO2FUcXdPFx0Zjuc4ianxrb8=;
        b=M+TRgDY7kl4/ByUfQ/WKN4JOS1UhxDpOWN1f8UPhoNwzGh2cl9zgh4VmGva4bQe92y
         8DXSOgYAPQU4dvdrUvSfM/pZcVR9RNQIMDrjADUZbnzNHanCYhiufB24ARaDIBKtxb8L
         xvcNdmRQsy+5h2olDCIK0IDNMucs6KHFuWmtl1zUHvZ7HFmSJ3E56QwNgmqgYsjif9Gf
         dnwSyn0lggKYxzWXeREgvn9zSx/rq0WhsjrcVf2cHcKGQyJC4NeEeRBYOYpLoG8j9I64
         WJ96gR2buaYI5NtStwijKXV202Q1Wd10npRBCw79zx5jaY5wuC0FQ2KOxxRexvaPoCbp
         mRaQ==
X-Gm-Message-State: AOJu0Yy+Y7HwALwn3AEY15mgHrTgiIc6tJvfyIOcX5JRhbGFaZP8klkz
	so/UHBNPEZRgsqwjRlkG6V3vJ4C/afHln7lCed25NLtK1iqhZlz7mPHbqxhP6dMv
X-Gm-Gg: AZuq6aKuPkg2wh2K/+uoX/vi+ZYmZX7CtZtGggVTkmofg8u2BJ2wMoc1Ezkz0oXfMc8
	sMKhWr7FUQOiaKm2i26m23LZJsUwyvtcOEViXuPBnxSOYfhseEJcvdq0ilAwpp77dqdRYh51lkA
	sqrwtdHH+Hxduy3SDmd0RYthMmpxIgkle3b0yIqgQyUJXl/2W9kaB1EICQuAE5pDHO3x0Xhmjul
	aqGThncgtadOkZD0pYapthLNoGmfMmYS+j/+q7bRBQPbpBCio7CW8goDDx1WH/knpmmPv7W9K+o
	iNR9PEMwP7shnUPEMTbq7zY45MF0SIVgWrZCECGf2mGtupZZ0I92Q4l3G6McPa4F8PM/M/BSo5F
	7stTzk4VG7GRBTQgRIBHfsiO86suA8z24SKlWXxAw9RGB5tn7pmomc2K7YQ1yf2LjOExjigGXxF
	DZAhatlLSpu5Mkght/1t2iI2sLGzW/
X-Received: by 2002:a05:620a:3704:b0:8c5:310d:3b39 with SMTP id af79cd13be357-8c9eb276cccmr531917085a.33.1769805452909;
        Fri, 30 Jan 2026 12:37:32 -0800 (PST)
Received: from [172.17.0.2] ([135.232.225.19])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745d7a9sm60711321cf.5.2026.01.30.12.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 12:37:32 -0800 (PST)
Message-ID: <697d168c.050a0220.236269.4fba@mx.google.com>
Date: Fri, 30 Jan 2026 12:37:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8783903629231291401=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: doc: Add cross-references between bluetoothctl and D-Bus API documentation
In-Reply-To: <20260130193921.1273263-2-luiz.dentz@gmail.com>
References: <20260130193921.1273263-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8783903629231291401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1049133

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      21.05 seconds
BluezMake                     PASS      661.04 seconds
MakeCheck                     PASS      18.38 seconds
MakeDistcheck                 PASS      246.26 seconds
CheckValgrind                 PASS      298.17 seconds
CheckSmatch                   PASS      357.79 seconds
bluezmakeextell               PASS      183.36 seconds
IncrementalBuild              PENDING   0.37 seconds
ScanBuild                     PASS      1034.66 seconds

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


--===============8783903629231291401==--
