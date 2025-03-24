Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D35CA52
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823960; cv=none; b=BAG8PiA2W73W2IEsivK8ZFS5AgYXVthIE63obShdYKXiiWujf4oX9doWrAjMSrjR0NQjQfEq4iA8C3+nLMlikvCkmPhf/p2mUtxJObtUg5RfEDSgL9nrRupSoT9VWOXEQI22SMchtE0unc181xAVyA6EIqVEftPsd0ecAYSVkLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823960; c=relaxed/simple;
	bh=uRxK9apprZBkecK2bCw4X1vqOsFhAdumO8/cgSrVmvc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pDuAJk1Dx6fInv+lsamYejwIuUCG136pI4mxMFJHNej/TC71f6CK5XDIGoxFqF1Jl/faZl2U+mKAJT+ISm9scQiIaLWuX5v8SisEYM5wo9NHNn5hgwgO2gyHQYNS4Sl+aS9D4zpOB3g3nOzDcJSAVefq4kPIRjNr8nu4JdzhFA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzpUAsXj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzpUAsXj"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2243803b776so5339345ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 06:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742823958; x=1743428758; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uRxK9apprZBkecK2bCw4X1vqOsFhAdumO8/cgSrVmvc=;
        b=JzpUAsXjrS9l9Hd8czerQ5z9k/2EoOp2q6FrZBswq6dWYVAqq7cXWxaua64I0SdDGR
         hCJfeu6YnHmYJ6fDPyS91Uj5XezpA1cM+7J2e3JJK/0blVUcmglzXgjtQZM7JjAv2da7
         IOzSPsvaMKp0F3g+dV8WHDdjPaHeA/A3iQOBLefgd2O0yv9fLYbf0PMzVh70mM/aoHxv
         XRNJae4KBc/uzCz9hOqoBJa46X8EJkZGrVQfdQg8A67kmM1IAcGeQ522kyeGEMHAOW0z
         kgwDyRKkodF7PjhGKUg54I7dZ9LBNt0w2G+75LiYfvPi5U+6h87J/KsE4Fau757xjZrt
         B9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742823958; x=1743428758;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRxK9apprZBkecK2bCw4X1vqOsFhAdumO8/cgSrVmvc=;
        b=astqPsEl7jIqIIkrMy+0nn7TNOOa2IgK1TUTN7mOwKW/xUCVoM4WXIoAq4xhISY1CS
         CKZ5nntKxWXFZYuRiDjDcPjqjnra8/y1CxbUb9QOST6eC8XFuL1le3AbN6m7v0Lgmiqp
         uPL9QF1+b7PAYnaN9jRaN6K9CGh4XEGokk4hkyoU5KDtaIsPeJ93Geve8wNJAGCkl7PP
         hWf/hPhXRrfEqM0wGHq5j+A95YRWdDM6V+IRGfvz8SkDhF+u0l4lLiYsVIJoFMFLBm4O
         O6apY1V0If/h7lCdgjksFeCjOtFqGPp9nSb1wyY6yarGqxj32R5DRzVE521FpA/fLlKL
         H+MA==
X-Gm-Message-State: AOJu0Yz/BRGGGjYjdfe2+GeEXHh9KUmR+xqF06lzKrXmr0yYKV1e39Ct
	O392ZDE9hhkMoXS5RdKGxElWAxZ2LPj36VOsKg8GYaDGGF4n3CL8z6HAWg==
X-Gm-Gg: ASbGnctfJDIfRAK5iRR1cIcQaoB+sYpegQNHZN4YONtMPbm1h/BlSsEaxZaNQwQlWiP
	HaB8qMUMCriINn8Z53Fzsd3Qlbx9FXbA4ibtNMDp0Is7eAlYV/JzokWwddRvQ+5Xw9zfKK7iiI0
	OxleWUaUU6lfEvyuKm+NUiHlqSLG4qHPFfcjB3exbFwObIWuCBk1JIvX/7agLE4RRHzTiWmjYb9
	PMAsmPdr+MZ88HN4MzC+Llu3g43lcwn6AQVFm8UTz01QFqSvUQMAfd1ZYnk6pYUZoOPQRhaFJde
	ifwtZCszpF2teahpwKywrVO9g7Iw3mhvqUscdM9gx7sHPz8up8M=
X-Google-Smtp-Source: AGHT+IEzwwhh/PP6e2AM9S4lA6Jr7xnBT/BZO/n0iHkvdATRo4pRyTFyo3RejjAx/cOSWQlY4FJB+Q==
X-Received: by 2002:a05:6a00:2291:b0:735:7bc0:dcda with SMTP id d2e1a72fcca58-7390597e330mr18846744b3a.5.1742823957874;
        Mon, 24 Mar 2025 06:45:57 -0700 (PDT)
Received: from [172.17.0.2] ([52.155.59.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618de84sm8239313b3a.171.2025.03.24.06.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:45:57 -0700 (PDT)
Message-ID: <67e16215.050a0220.497a7.f4c3@mx.google.com>
Date: Mon, 24 Mar 2025 06:45:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5115613571919500181=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bugzilla-daemon@kernel.org
Subject: RE: [Bug,219553] Intel Corp. Bluetooth 9460/9560 Jefferson Peak (JfP) not able to connnect to Logitech MX Master 3S
In-Reply-To: <bug-219553-62941-U0tjO3Dvzh@https.bugzilla.kernel.org/>
References: <bug-219553-62941-U0tjO3Dvzh@https.bugzilla.kernel.org/>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5115613571919500181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel.c:3249
error: drivers/bluetooth/btintel.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5115613571919500181==--
