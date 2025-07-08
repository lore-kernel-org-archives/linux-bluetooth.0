Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7185383
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752000340; cv=none; b=FZVYGpsLwUrM0vh7wWLnvaFDciIxSEQNF/mLsz9kKd404yCePoZF7I9jp6UOiEYtGeuve3oEk2yFJBG75cqq7tuG+C2rNalHoi23l4C+aJEekI28y3UzHtuvUmx6vi4fc6kBAxaAfdvW+vurXkOnezWvcBz9YEP3iTFHpu1i91w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752000340; c=relaxed/simple;
	bh=smnsKD3hUhuw1VD0JOeKLEmD0sVO7+TlW71GQaCaEnw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XhLi59IXW2TEBLjGqwf06suEqYfYBBNGgRkSJwWyxB5iDJsokLBG/+DhwJPkho2Dj7yGNt+O5ZoQ8SKfvkwNRyxGYnCOerOp9liMiiE4HceHa6pB4bgpCdqb36Xr4wdZPdGEwffU4kliMot4acqG/SomAzGc1VdlyijtREVT3WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Op8F8nfQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op8F8nfQ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23636167afeso47659765ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 11:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752000338; x=1752605138; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RxgQJSaQiTW45tBcYXfLunyr8qQIBw3ElbdqLpxFVTA=;
        b=Op8F8nfQAUaqEisT48POLSfV872cMnMDelm7xrULZiXYpSZXH8b6pQbACaievexcoQ
         lL1k5BKiVUSVlmjXf7bH37CwGaK1+r44ey9Ex+e4Wa20A5d38dOorUfs6ePhDVfUeSL/
         gEpLr1d0mm9b3p2EqrYDkUr2X3xDJcMOx7CHwevtI8QaGmtMxj5P1LK628Og9sEnDIMd
         1ExY2Z6DSMYNUKoUkOu9sKeL68Y2UEraxvdD9iAxcwWoVGJ3KmjgTPvba96acSwWOhMt
         NfV8rq3QQIVawp/AXv975O4ofNIAIXW5LvjthG58uFoJadfjtCQD13ahiWCcb48PUxWT
         4fYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752000338; x=1752605138;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxgQJSaQiTW45tBcYXfLunyr8qQIBw3ElbdqLpxFVTA=;
        b=wV6pyBcsM5CT2EBfF6kLUaa+PXmZrKY1MBx8tX6k7o1oGOOheOGB10Eq4Mxst/8etS
         lW9DLjT+2f1OEV5G4Vfo5Zazay8BWgG6JUbTlSKJPO2Xp/wARXaZ0fdIXQ/8KsOqMIOO
         0HkOxwoqi1ShQyI9bUuJeYU58PYKBwksFjDBxzN0O1lF9a92RnZG3z/pW+2XuR/YKfmA
         XWbkxXKnsi8U1KARRG3C/MYHsQjclCHxWZW6WG+H8Kb4wSZ+iY3nz0CUNDqBcso6mMKm
         Hoe/Yd6L1wFkEbZFTebfVvsPzdX6mIv9gKCz209Axi4s/YmdP0XT0iDnLP6EOPaXQA7J
         1j7A==
X-Gm-Message-State: AOJu0YzmnzaUEKPaUAILFua0fUCJsw9PbJSPRs8SmU+wWwXYOX1mq5rA
	2XnAQHAOOquuxiGvrdsSRgrdgrhN0a9FKTc7g+sbPjnqR9wBhaMSRYDzVcZ+Kw==
X-Gm-Gg: ASbGncvHhpnUu2nQP4qshNbJmY+zxAAhkPQE/dWSp7WbuIlVclHd9UrpUtN8zK2qOl8
	/5iOW1WYOLl8l9sq2iu23S6RWBSbIAsBwUu+THkGxViV6Vw/6ZG7fTeb5AUldGB6mJzy4dqNpXF
	FCmnRoIm4aLfW2Oi58bvumzd10cwjFswGPiUhoxkGAbojGROmH1dShEoNJyN5dHsgySUwyi8Da0
	6odfj/pPXi4ZZXuW7hlfAPZzRVP/kLVkWpfg3mCaKdQsL72sPGrhT4iSZAgIrE476a8jL20Im2b
	cj3UYEX8JHI5lQV+O1Ijbcj5qZSsZ/0+OfoGbLBgPcE7SSrhnOxiB12BIrIULBpkdG4=
X-Google-Smtp-Source: AGHT+IHF6PSQmcxR4yXi9R5GUvl8TrjWJ748375XeE2v5v6ZNiHY65onyVmPInflBr8Z5HQG5z0f4g==
X-Received: by 2002:a17:902:e5d0:b0:234:c8ec:51b5 with SMTP id d9443c01a7336-23c875e4d89mr248702285ad.53.1752000337747;
        Tue, 08 Jul 2025 11:45:37 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.164.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457b2cesm117945845ad.157.2025.07.08.11.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:45:37 -0700 (PDT)
Message-ID: <686d6751.170a0220.12d250.7c39@mx.google.com>
Date: Tue, 08 Jul 2025 11:45:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5926563624517767474=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] build: Fix typo in configure option help string
In-Reply-To: <20250708171411.1927181-1-hadess@hadess.net>
References: <20250708171411.1927181-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5926563624517767474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=980136

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.36 seconds
BuildEll                      PASS      20.07 seconds
BluezMake                     PASS      2568.49 seconds
MakeCheck                     PASS      20.14 seconds
MakeDistcheck                 PASS      185.08 seconds
CheckValgrind                 PASS      236.13 seconds
CheckSmatch                   PASS      304.06 seconds
bluezmakeextell               PASS      130.48 seconds
IncrementalBuild              PENDING   0.41 seconds
ScanBuild                     PASS      914.31 seconds

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


--===============5926563624517767474==--
