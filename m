Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179EE1E53F
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 May 2024 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714847850; cv=none; b=e01Z+hKCKgcf/GEregwkSwXoDwSbNZ6/qjB5WAdGH5ByVmwpP2vGwm6ZUhI9k8xPxUHjT/T7xidgq8ASxLGmxdhwqhcq9oZVMTWQ+qtPSo4BlISSgFt62SMktg8p+n1yt5Y3kasBLrDN3YrFwxNLkMFPr5bYym57sFS3Ecg+PI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714847850; c=relaxed/simple;
	bh=anaysh6dr65PtGY4PplgrIvfNaz8WkYnRVnZrMIfd4U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BM2svaV34kDnGb3v4BNEJTr3TdJuL5Yq5iR9a36fRpZRnsn3s5phhgudxuvZq56cwxm7qCdzg9PZGcQ8s75lvBmNnPVLWQ8pKnVx1Cl3FPKU5bjYnS/kVqZDCGFhGa28fhC8N89NY7skcduMDdNb413EdlvSl66cSx99HOiJG6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jr0XOW78; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jr0XOW78"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43a317135a5so5202771cf.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 May 2024 11:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714847848; x=1715452648; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=anaysh6dr65PtGY4PplgrIvfNaz8WkYnRVnZrMIfd4U=;
        b=Jr0XOW78qo/zcBi1oajR8WpHs6QMt+Gla6i7yDBiM9iyEBf8tqOpHgPKZviXZ1cmBm
         +txIJuGdK3dYpXZkoTa6f6gKhqOtF2QIDtl+mPnMFqto8aOcqWDPiQvx+nv+0KvNUu2t
         oKtrRhd9zdhce6XTkRGZ+BkytD/xEWH3h/wF6VjjYCsFdgTEousp7yIU6XkgkLPD344s
         6J+1/cydcozYURFK59GazNHVekRlZ1bJsbdm6JUzw+sKmizCTONKZoFdqZp7Xa5uH4Cf
         cpnKiq40IWYs5Ok/pVlJ/dc9BqTlknxYWDmc+6XcHNU1uUW0s9WFhADiYg6dtBwr8H/E
         oQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714847848; x=1715452648;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=anaysh6dr65PtGY4PplgrIvfNaz8WkYnRVnZrMIfd4U=;
        b=r+UMcvK22lIprlwxJmoECRKwsuNKI/FBUzJK4oBkl7V3YgsRXTg5eViOO5UKxrOTel
         +ecO7ITrV1hokITBbsbY4dr1R6Sdm3VcZKUFHF8i5PsiY8wQNGpif/lv61Yz7W4Xf1nP
         e3jxDGwNYQy9O8q7YK7LWRyFL6Vjc0lqlivMhxXhpNL6eqp001E2QVhDDdVf0okzFTt4
         TN+qyp6bqcGWz8oRHpwvC09B7JO2YqStXAX1a8fN1fKZAzpGxbqJ/JzOdqFsKJ7G2gV4
         YSXVurHERIf4TwXx8zSmG61n/CWHBFUypc4klzrtaD3OeYCLb3XQlxXBfqo602Aemz/0
         sG9A==
X-Gm-Message-State: AOJu0YwaYBy0MJKMiZV+zttl211rXrvtj5vt0Jago+dVj5botyMMivrk
	MuY4aBvhjMiDjgfG1I3DXbb/1UReg1CNrtczOsplrCFEF57fPmgZ65cmSQ==
X-Google-Smtp-Source: AGHT+IFsUT79HfZhg7FecQhoWPodlXQ6oVY3E8vcCmklMYckwGjH2k+JXJICtv/xSlG9sGQvin6aNA==
X-Received: by 2002:a05:622a:5497:b0:439:de9d:620c with SMTP id ep23-20020a05622a549700b00439de9d620cmr15204768qtb.20.1714847847689;
        Sat, 04 May 2024 11:37:27 -0700 (PDT)
Received: from [172.17.0.2] ([13.90.174.197])
        by smtp.gmail.com with ESMTPSA id cq7-20020a05622a424700b0043a4a88f1cbsm413531qtb.85.2024.05.04.11.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 11:37:27 -0700 (PDT)
Message-ID: <66368067.050a0220.c4e43.13e7@mx.google.com>
Date: Sat, 04 May 2024 11:37:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1942987359030283627=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: [v3] Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()
In-Reply-To: <20240504182831.296757-1-iam@sung-woo.kim>
References: <20240504182831.296757-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1942987359030283627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_event.c:6498
error: net/bluetooth/hci_event.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1942987359030283627==--
