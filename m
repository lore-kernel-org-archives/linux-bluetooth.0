Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2552E417
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716206873; cv=none; b=s5VntYVeeiIQsCoekKzs23cQ+Bgo5ULnB0YLk+fc4jGOkD0+tLaapnFyAWo4oYmUYaTCZ1Ghgia5nss/VgM141intbDcJLKCFTfDokvEkxAMBU2EOLVjFtmhgJvtKqqtKhUMIev05zK5McEeup/+HCQOpaHZ2fxjkGuZR5xuygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716206873; c=relaxed/simple;
	bh=tZKpQq/0GfaKZEjIXJ7/PGWAIP2DzZ+y2MuIo/lTGsQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=A9tw7FBamBPSM0D5jjFHScgStoT1kaRfgY90C9rt29ZFOp5fto8o0ZYtkRFV3GcTYVZLmvVOBgz8AGCTw9uebDVouLydyTXhDNrpJIqEu4Se6WiItnJgKHmlyO0/G8gQcPrEvlMXjERpq6u53fh0x9qMU8yrG/Kh79LO4nRa/1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3mNlUir; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3mNlUir"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7948b7e4e5dso27477085a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 05:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716206871; x=1716811671; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vzgl/sEH5yJTXYaRvvWIerFH2pzyEvEwZ0124tBRFrg=;
        b=X3mNlUirSO3Upq82TaQCtqDiRlQF9BW+/dl+ZVNOfTsW9UjIKHrbHe7rpZeEenaCz4
         EKMh2LqyAoq1JK8CrOCvp0RDfzwBBZfa9bz8NFysRvXQ8bMDuDOW9yenIu2QFrF0jgw5
         6k+ruQ1zx2iLw36F7eiwiGLm+evvFWXBtfULtIbEPBl32PJYhaj8s4bhwEDAgpwtZKw4
         ThOKwJy2NSVDXFog4LOfYWp9g6Fl7aaJC/RV6YZYD3nH8GNT2+TMXFPIkEUvueD5o3EX
         LX4Jp7Cr5PrwCCi6Yn5qJdMP83gjutiC49vJsfvDF/SrOEaiYV0lJY+Fu2PohXXGkNId
         ogXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716206871; x=1716811671;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vzgl/sEH5yJTXYaRvvWIerFH2pzyEvEwZ0124tBRFrg=;
        b=KgyqQw/gGlLgQgr6ZrAI8dVoEA17Pf0FssesWer0dAXa1bgaTh1a/TZ76x5TNBGQT4
         Fr+Om90R1Bu/ecb6Z/XONWUW0BqP6Wb1QrtqM8KpjcjH/ptiDMICaeFWQz1bXfPi77Om
         6LoERByauYcUPk4KPOgD0UlECkJEX5xH+NJwR7kHKNbn1aNjTxQ8lihuvgG+N5qJ9oUn
         sLEuY6TpBNk4QKi8qIXhCInnF6BxhrFxwA7wlgybRywerps9oxHHcDRSaGAxGNfZxrSl
         ANgRhWCJS8Xy7cL1YsaulFGDZRQ1fOHx05FOTVRXk9qZPgK3/8E7yzeYX6BZxY3UogVG
         ry7A==
X-Gm-Message-State: AOJu0YzcalbXro/VVdhYDCNzzOaPvGSjYbfZC8aMWFeQFutxcZT/myFZ
	/+PX5vI8hfd0vfXuqSsE37gqmapWBmlR+/eeIERxdpOOlw456F9MECEyvA==
X-Google-Smtp-Source: AGHT+IF53l7QrNxVtk/L+ToN4qt7Ta9CHU8JWjkIp9FfHW1i8+XnjUQjn1MStr5iWpPcitxwrsbRmw==
X-Received: by 2002:a05:620a:201c:b0:78d:67de:50a0 with SMTP id af79cd13be357-792c75af7f1mr2984565885a.44.1716206870873;
        Mon, 20 May 2024 05:07:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.46.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf275b12sm1183854785a.22.2024.05.20.05.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 05:07:50 -0700 (PDT)
Message-ID: <664b3d16.050a0220.b9860.54f1@mx.google.com>
Date: Mon, 20 May 2024 05:07:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4124727940867779333=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: test-bap: Add Broadcast Sink STR one BIS tests
In-Reply-To: <20240520102014.24236-2-iulia.tanasescu@nxp.com>
References: <20240520102014.24236-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4124727940867779333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=854371

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      24.47 seconds
BluezMake                     PASS      1748.69 seconds
MakeCheck                     PASS      13.21 seconds
MakeDistcheck                 PASS      180.58 seconds
CheckValgrind                 PASS      254.29 seconds
CheckSmatch                   PASS      352.87 seconds
bluezmakeextell               PASS      120.27 seconds
IncrementalBuild              PASS      1602.87 seconds
ScanBuild                     PASS      1062.29 seconds



---
Regards,
Linux Bluetooth


--===============4124727940867779333==--
