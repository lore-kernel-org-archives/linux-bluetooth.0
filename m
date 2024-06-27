Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F861991C8
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502627; cv=none; b=ngBPVzJ+GRxf0Y82Hp24b519N7L2aWETb65cOCRhTb6Lo59K1fElydk+cspOlOK+ghBvu4FhRIqZOhRPwEMtts+bw/nktIBWtj0HzHyH2ieCXEKlDwI5qGuvFJACQUOZhWQVUSwRnUrk/XR9ktV6TMwUGG3nanXZAGIZesf+hjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502627; c=relaxed/simple;
	bh=3pPemRMAAH8l9RDafz98W5E4ZTAGB7UQUyXFXMncCfs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KV+DjhGFuUvgSrKSSKGriteuaU1dO7oa3turf2xNhffWTrZP7Ol7aIYpIWInzpNwSXVJWG3VRCaonRLbhi4Cb2XjopADMrVA+CJi38NXU82i3OmTPVc6mpVVN+URdvPwyu7VbxUhUv4bBTKFcjb2wTP5zod3ryYpZdqg928/3QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avJFCvy5; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avJFCvy5"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79d5d14fa8bso65323785a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 08:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719502625; x=1720107425; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SpmmtKrmgsmYMJePBJ63N38z0OqDE0ZkahoEmL9IAf4=;
        b=avJFCvy59fRZxjUNg5BR0SRKyU+1B+L0JU/EN7kFB7bsdKPqzfoSMt1GyppHR3wH7a
         vvieDuNJj431Q/tK2Fzdct2TRNNlC+eZmDGWg4wST+9RsgNXlusAQt8o3t6EDda4X0hI
         /OsVDLY3fb9CprS3OTYHMw4enzgC9nqFQvNeT8eOApOnWqEqXHwEC8WPn5W0eM2q8HsT
         v+EubMcW/z+QVXq0V1DPTn7QDBFr2lIjH/y6z2arjlsD2ESTLphne+Hg9wAbB9IC8qLK
         qtiA6YnFJijyynAfiNzuWGXUZ1qGafszEUA1tFbmMtd6CAJ6yMUJtoMVjnr9bD8F+kyi
         BdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719502625; x=1720107425;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SpmmtKrmgsmYMJePBJ63N38z0OqDE0ZkahoEmL9IAf4=;
        b=JqX0fiAyHLBGZBpSS124X3dgVHf41cnzTH2pqKjPvY8ife61FBiXgVBNMYC20vaxrb
         9uTV0AeoXdti6ZYJS97vo0P9tGFTBrVcr4Dz/V6uaaLNWz3ICPsniK2gW3hsPL+znFI/
         9gugt5GpJZBFQpb1LumIzYXyKtDz5RZwq9UtXDogD8V07qWiZ68roaw1A9jVJr9OfmV+
         fN+9Mc0YHcWjynjhKJjTNiyfmrk66X/B71o+ziQd40dedzFguHpU32mlq1RsTzzuz/MY
         RpYpqEI9OzqW+E5P5B2KUjA3GJTZjxLD/guEfDtFTOIxZY9EoTEh3zwUGg0o+1oI/Nzp
         bGKg==
X-Gm-Message-State: AOJu0Yw3dFOkArgP98aV+WKjZgSl74MVcIcg1CGce2qHxQ81bnLITfOJ
	T20hXmB+iMzX2tRddWgCjP1gityxUa4OEYDEdsXcT/amQOSctPOcpsz7vQ==
X-Google-Smtp-Source: AGHT+IHP1kela+OlwJI4jtPremtiYfpr2ALE6CZQOlVKCzINXP64KYVARqVXcocUpDDn5hQE1tHgwA==
X-Received: by 2002:a05:620a:218a:b0:79d:6647:65ba with SMTP id af79cd13be357-79d66476c98mr64085085a.26.1719502624867;
        Thu, 27 Jun 2024 08:37:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.39.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d5c8af0e0sm64525385a.79.2024.06.27.08.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:37:04 -0700 (PDT)
Message-ID: <667d8720.050a0220.b7edc.31e6@mx.google.com>
Date: Thu, 27 Jun 2024 08:37:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8122420158331133348=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] health/mcap: fix memory leak in mcap_create_mcl()
In-Reply-To: <20240627133222.82707-1-r.smirnov@omp.ru>
References: <20240627133222.82707-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8122420158331133348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866166

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.47 seconds
BuildEll                      PASS      24.40 seconds
BluezMake                     PASS      1627.52 seconds
MakeCheck                     PASS      13.50 seconds
MakeDistcheck                 PASS      176.38 seconds
CheckValgrind                 PASS      251.58 seconds
CheckSmatch                   PASS      352.26 seconds
bluezmakeextell               PASS      119.01 seconds
IncrementalBuild              PASS      1385.19 seconds
ScanBuild                     PASS      994.03 seconds



---
Regards,
Linux Bluetooth


--===============8122420158331133348==--
