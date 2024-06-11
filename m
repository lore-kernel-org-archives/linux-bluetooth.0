Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF0F14A96
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jun 2024 18:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131060; cv=none; b=hRn1uY9fmos7/jOfeIpnmg9Mo9A4PqwnMmm7Afw/0wA+vOGQHMzsxzQTXZosVLGQlT77r11LNIWEni2JbrEEx8Aum+OyKBPD2zDAA6AA0OM3J5lwuppPpZB9Vjl4SFk5GNYRoAs447j951tZN6yXZYiKy6CP+mCE4d5ZE1ACdsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131060; c=relaxed/simple;
	bh=lDy0BUgzlu2Sso5OyR/3Qe4CheUyp7/uD6ZgV5tsonQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=acGBp117IYpuK71direalgLC8IQ8qTvvHZYf9WQpOXDnY/NKlZtW+4+dL0wfBsLsuNfDnxXkLMMIDZIJ3Kz40L1dHEHCzbPIG6wnGYPDQLMQZhqma6XmZ4B0T9zHeKg9IXACO85992Fvz/cN4Kxx/jk2sED/JY4zupW8r6Skv0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFOVD4Xt; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFOVD4Xt"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f99555c922so1732177a34.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jun 2024 11:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718131058; x=1718735858; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oA0sUvKKE0PrFUV9aBM7z6UHrS3IHz+O2DYiW+Hjb58=;
        b=cFOVD4XtI776ho9N0xpeawqBL/KFhnkPwBFsGgifx7eGMxbSMrgWJlIWwp5m9hFs7M
         SyO2ofpFMk401dJVxxb7/flYb434N3crtzfXKL6ivDPymT8BeAzk46DGpbYJ9xyiZuEs
         5y9POgqSBgaoln2kiryeSjNiQPnAyT57bADUbOJlG+MihzS4SIOTdkPqdyiI0/CzyGmy
         55lkNOyQ7e7nlWHOWRS4KbFAr9nhs4Oxq0Z2ZOLF+e03aEjFH7rsKvLblUTrzQLF5QF3
         0ojn/Vvd9usdYDKomww9LncOPGGAI61rX18d9nJoSM2ZA25cadpEdpfIni3fB3v1uUjL
         K8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718131058; x=1718735858;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oA0sUvKKE0PrFUV9aBM7z6UHrS3IHz+O2DYiW+Hjb58=;
        b=sdB0EA7tBnqbYbqWpZMqVFUBkMeom9w2S0vqWlKCuBY5bC7nEiV1vERXkOl+v0ecXc
         E7fFc15oNIShOjLEp2RuFgeYCVWn4wpygre+tGBWt3/tcjZQcJcbGCY5CWhNm6y/dqMh
         biEeozTmTp1Mflz2Uz+ORshIOkIgoeTeihfAF3W8U3854N+n1g3ZrLXS7drq9u0LUUBw
         NB4MccyPXVi9JGZpRqDvWxSKYHxQj6dAr3pN7NClC9nZ6teC4WHuY1a4a3umGIcgQemi
         XX9ObP2AAMv6dkZZWQknVAsHxcn8K+15jh+zJ8GPdIh96ANNa79HlVGFS3cEQZ7GfRpf
         yqqQ==
X-Gm-Message-State: AOJu0YxZCXnhp7nWNRL6SuH9cgEht3ePiAC0l9VSEkBYoZt80SA7Zky+
	C92J7eUbkzyiedtHU4LGcLmUcFib8M1EKm0SA41jjRwlCnEaFHruj27iDQ==
X-Google-Smtp-Source: AGHT+IG9jmt+vGo7JBSXexWhrDsWyvKB+4qcRHEQL+xnneH1CR/ngu8bBa7cG/idsXDqO5xPNZJXJA==
X-Received: by 2002:a05:6808:1482:b0:3d2:2512:5a45 with SMTP id 5614622812f47-3d225125ce1mr9195888b6e.54.1718131058085;
        Tue, 11 Jun 2024 11:37:38 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.254.132])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4405526e8c0sm34988041cf.60.2024.06.11.11.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:37:37 -0700 (PDT)
Message-ID: <66689971.050a0220.393a2.dbc9@mx.google.com>
Date: Tue, 11 Jun 2024 11:37:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5980642162796221262=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] shared/gatt-db: Fix gatt_db_clone
In-Reply-To: <20240611163542.1161789-1-luiz.dentz@gmail.com>
References: <20240611163542.1161789-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5980642162796221262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=860868

---Test result---

Test Summary:
CheckPatch                    PASS      1.03 seconds
GitLint                       PASS      0.71 seconds
BuildEll                      PASS      25.32 seconds
BluezMake                     PASS      1756.78 seconds
MakeCheck                     PASS      13.33 seconds
MakeDistcheck                 PASS      185.65 seconds
CheckValgrind                 PASS      260.47 seconds
CheckSmatch                   PASS      366.67 seconds
bluezmakeextell               PASS      122.96 seconds
IncrementalBuild              PASS      3149.71 seconds
ScanBuild                     PASS      1051.62 seconds



---
Regards,
Linux Bluetooth


--===============5980642162796221262==--
