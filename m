Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA581386D5
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217236; cv=none; b=XpXuW3dFzVCmjcjvTyAf5McYqtjHrZZl1GOi175IqEFUc38Rejq1VQCaGJRJOHwqusv4suscnLwsK2cqpqNMFjpPrRiIR8yN/BVnoAaVntNiuw41aDvKMn/jNC8Bh8MiUgvcaw2+ml7GcdY/tPo/W38l164s54GNAMkE0yQL+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217236; c=relaxed/simple;
	bh=dk+ryiIxxcaIarG79Z7pZh3IwfoehedVrRHTwij49d4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nwKX9lVxDmA10ItMLPhfAnv/YZUPxTbsT5BP6g4g4Of9UupzG1pohMO6jGlvpevIFM3djBpZr3HoZlzsPQ1vlw9CD+k0nLq33pL+DXkMVkyk7YcmX/GUxmzeiyJgNtAcRy7JmF5cI5Ys3NAxoScBcgUnWmw7d6Q2l09329RCQdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ef2dkxvG; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef2dkxvG"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-290d59df3f0so2633919a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 13:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706217234; x=1706822034; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VCBKBgWaaKzyzXVWYrZ3spwLiT4b5mhMArA8NLt0y2g=;
        b=ef2dkxvGH+nnIDGTPNlgGqWTafjCmj6dBokeXFjFq0T+1wpdFe3lsmagrVWlbNvvQC
         +mBYJA8IXoZ3q+gzWiYBr4x8e/cj1JLYGpzYsTylEukWIw4WtTdpStcwep5fiWc6dse5
         MGxVaoHCTjF2nxKsLXS0VdzvOIgt5XxV1ONzi1+i2tFRTplJUlsJzwW+y9Duq/cicdLs
         JQGU7Lal8cs2pyfrtleh/ohNWsBV/5ovDZ2utVIghzm/a5FPmkgxvfsibt9/672yfrBT
         8jF2lA0R6GaUv/Sd+3Rphsd9LAmgLKLOwEyoU2e3g9OLRjyY6w7WYPX43X2DTr7psvSF
         tv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706217234; x=1706822034;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCBKBgWaaKzyzXVWYrZ3spwLiT4b5mhMArA8NLt0y2g=;
        b=e3shzt70crHroi2MYPO6xAGK68rRZqLK3trJd0rAlFcygrYHuzcZrNWXz2PQQgf8qI
         btGfh41YWCLu3osrs//N6tZ5QtlxRD0dWjt4hBe202TCy2dv/QX8DHsP1LSrjKvJZ8si
         AxAvUMRi019jAMBamqd8uWrRKllAKkNXQAGGoldr6QBG9BgcuBexMxpgxLpVgjMHUoPX
         t5IvcoZ4lp9ApU/wz8RXQJqdl4DxuViDoApJs2y/3l2sItldrxSCsesCKiBu/BHh0R8/
         lCaWnM6GHTKDtt2CWHrWhWdgEDfYyUXhshOF278RK0SRKggB/v4qjCjtZI1o9jlYwIza
         gZ6g==
X-Gm-Message-State: AOJu0Yz3npV/iI3WCoY7naOMhgstP//+d4kb7Lw2LsPTAfyOU4wC7DvW
	JPGgTj7G+P7hgoOFomp38BixIWXxtIi2HC1pzsZb0GuDOuJdH3VVjjrRPV5s
X-Google-Smtp-Source: AGHT+IHZ3k9B/gtlCp5D+hgRRrXXt0yR/p+94lNQH5sbqPTT2XfffARydscSGIRbkmTTz33P1apX4g==
X-Received: by 2002:a17:90b:1d86:b0:28b:831f:187 with SMTP id pf6-20020a17090b1d8600b0028b831f0187mr234799pjb.19.1706217233628;
        Thu, 25 Jan 2024 13:13:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVCECjb0bkCmY5hhNzUrRD3C6wiIwETFmIcwoFCl+Yhg9yIzDJPCR2tvjG9C4S/IBZ9D++esu7pn+t8JF12ZvYP1CtPZyHZmvMsrI/c
Received: from [172.17.0.2] ([4.227.115.6])
        by smtp.gmail.com with ESMTPSA id v16-20020a17090abb9000b0028afdb88d08sm2001985pjr.23.2024.01.25.13.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 13:13:53 -0800 (PST)
Message-ID: <65b2cf11.170a0220.f70b4.8099@mx.google.com>
Date: Thu, 25 Jan 2024 13:13:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7160662541156723089=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Enhance GATT to pass PTS tests
In-Reply-To: <20240125190805.1244787-2-frederic.danis@collabora.com>
References: <20240125190805.1244787-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7160662541156723089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=819996

---Test result---

Test Summary:
CheckPatch                    PASS      1.77 seconds
GitLint                       PASS      1.18 seconds
BuildEll                      PASS      23.97 seconds
BluezMake                     PASS      720.09 seconds
MakeCheck                     PASS      12.02 seconds
MakeDistcheck                 PASS      162.59 seconds
CheckValgrind                 PASS      227.38 seconds
CheckSmatch                   PASS      329.62 seconds
bluezmakeextell               PASS      108.21 seconds
IncrementalBuild              PASS      3305.31 seconds
ScanBuild                     WARNING   923.40 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
tools/btgatt-client.c:1824:2: warning: Value stored to 'argv' is never read
        argv += optind;
        ^       ~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============7160662541156723089==--
