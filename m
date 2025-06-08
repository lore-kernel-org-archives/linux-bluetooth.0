Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45091B040B
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Jun 2025 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749423333; cv=none; b=bp9vqXWz1pEy/2Y7N/0wHfqHNjspeSt2cweH446E3tpELrTCwt2zznLDS81kC8q6kLF6oyKNCKSjOkWwunAK2BAM4BwzIFYNZ2Rbp+InW+hIoXRFjmvs7fT6eihQxkJHWxVQeS155BgckNiZvirNAhXkbpiSIGtjTE8SzrLx7NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749423333; c=relaxed/simple;
	bh=sm3y3OIGDpm2QVfuu6d0gUm38fV4qe73X1jUKw6P7wo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=krUinkJdo9xf39lM1BCoFH2mYH8XCrTblQRL4mb8zFkkG2IrU6SZFVQe8+Uca6BVF77R0qrU/swo63pSCFFemO9tOxvRgJUmZ9j7rm7LRuJSMMObEjtSws8e/K96VRoMGWpRodY03dhzSUyZ2kuqhF6tRk8jl0t0a0rDnAKDBhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llHrzUBU; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llHrzUBU"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fafc79bca8so45664586d6.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Jun 2025 15:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749423330; x=1750028130; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=15Zagche4zoSRxOSi1pnCpcwZyygAD5n4LjUw4jcI1c=;
        b=llHrzUBUoLLo5MSfs1FbrLFUe8/SEdciRzB1x1psOsMTbYM6UEjuSgqqigILQefrxS
         6v+k0USnM3xGOGBlpyr0KgmXU9OOoOGQkUt2s8AGbuj2K3UD+5Lc6rr/LmwdGaRvZAMm
         eMj4D2E/ckiFbQRWwE1K3h6lbcuuDWWh8qSwr1rdiHvFx0Ci/6EftUAB6edWPBojhoNQ
         pahghxN3PO901Qi4hSpP4X+FXJQSgbb5/x7f9DuOJlKGw288fOQs0YSql19btfMMIC2U
         XIV1YuM3Xenv7w7JIDRBTYTtR9fjIAl3NK4VOeUh4K9qkjjAGSvPHgtKigwj4YLSIoCX
         4w+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749423330; x=1750028130;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15Zagche4zoSRxOSi1pnCpcwZyygAD5n4LjUw4jcI1c=;
        b=pgIXTDH2LMgVNbDrYaJfCBzufCekHElBp+bSZDGnELStJcT7VAa8eCHEcy2mX1DgiF
         g6s+7j0JlDyqVHiKIgS54UlGiOi53BojGTpoVQGN32h00fn/IVkbKznPtwK9ZOwbwuhE
         2EjkHZYMIwCjfNg4Si0oqkmwLnMr3KbiUf+kNV6T79ctzUPHLssyPh6et5hhXkKoMBY1
         rPr7+iLsxVuE9qKrwzkYvNZb9TwfGTC/62C6qKJgHIkgV4RsCfIJKridR3j1KwBDMm82
         tW4tZFtuD3N/a4B3AsMnQjoPpyaINJztBHhGg4KNv+HFBkuRGEBskKEhMSvLAh4+H9p/
         9xWg==
X-Gm-Message-State: AOJu0Ywuk6uUDUSxXO0eA7/8pUMrADn8kWevyOGS4cUtHdi4KlI0Zl4u
	0JSnkyMyzUswLbH5vsOSYxPmziX53iQ4yrketY266+tLc9sITbQJBdqRhVQEsw==
X-Gm-Gg: ASbGncuS3w/nT71TWKT4MTJ0yJ7WRep+Ve030TG405zHb0NqZzua+Pw5UPcOs/ga3S/
	7tOUv4z5SAo78wedxX4iRStpHH6X5KaCkkwF0mDy518/95XF0HPcswPVjfmPpt9fADb1hFP+jMm
	FTHYbxdhfcBo8s4RTvWGpRCBQIS85lBkkAtRGteh44guJsJ8SInbpoPW6+3hca1+wGq2zHndZUv
	SNGd39KnqSKvP6jo0P+sqkXRcvvqQx/Le98EMCzgk0LSQx+onfm0kOXkaLeW8SfO6jPSOunphH3
	0Ou1Vl405j+WYfY2ezaMNPh6ur5vN4uKWxkPR48vtXE4sb7rH9a9EzG6Ew==
X-Google-Smtp-Source: AGHT+IFQwxgOvwoKxtj5RVUzLRJ2q1pP/z/nwQ6bQGAYfimkR+ylKO5vrVUWgzGLeoIzI2UcCRSgiQ==
X-Received: by 2002:a05:6214:5297:b0:6fa:c246:c363 with SMTP id 6a1803df08f44-6fb08f78bf5mr162104006d6.13.1749423330474;
        Sun, 08 Jun 2025 15:55:30 -0700 (PDT)
Received: from [172.17.0.2] ([23.96.242.192])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d38f63dd31sm168762385a.5.2025.06.08.15.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 15:55:30 -0700 (PDT)
Message-ID: <684614e2.050a0220.8fc8f.2380@mx.google.com>
Date: Sun, 08 Jun 2025 15:55:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3174561804323257245=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: BAP stream reconfiguration
In-Reply-To: <2256956d28dcf399854f542e03ed35e265a5c860.1749418319.git.pav@iki.fi>
References: <2256956d28dcf399854f542e03ed35e265a5c860.1749418319.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3174561804323257245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=969627

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.03 seconds
BluezMake                     PASS      2603.71 seconds
MakeCheck                     PASS      20.48 seconds
MakeDistcheck                 PASS      197.56 seconds
CheckValgrind                 PASS      273.63 seconds
CheckSmatch                   WARNING   301.96 seconds
bluezmakeextell               PASS      130.84 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      901.38 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3174561804323257245==--
