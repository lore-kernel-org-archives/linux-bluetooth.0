Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A8E3E464
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745018; cv=none; b=ByXWZSH0TYWC4O2pSMWdLBu/fvHiTMqU/gqtHBKkDvDIocFpIpvumVX5G1fJcln8kusyd8ifDq0zXLwuvsuHk16NTAaaF+k+R69JbVyyrylvqbrjAEmuzxhA1DANqn8fIugpCNYrjJodPHT5IcJcp2FwZE514UOdKaHMCQCsaf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745018; c=relaxed/simple;
	bh=d0VgdnrP4U6gotPtuZzRM4hGBRZmKiDNd6axhw7iZ9Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nqGh+eSjBpmUGI38U7aBzREFdw5Y830LfQ+lkDbx+ClKaWwAO2P9vTMXDENKQOPXGFM1BDJsBGikjhinQ/3TvVuHIwfEfiy15fiND6vSLP+2AWpwaNU1L2WXex4Wb9/0jI/VZZiUcgHR8Q7hFO4XsKp5ZzFJkFAFDMk3PZlq7D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEERiD1n; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEERiD1n"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6818aa08a33so29082716d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 05:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707745015; x=1708349815; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d0VgdnrP4U6gotPtuZzRM4hGBRZmKiDNd6axhw7iZ9Q=;
        b=ZEERiD1nMwKmsw+Wt2XTLxGdVq+Jx27BoyXb5K4ZE7j+8h0OLuVFguaC8Wk3oo7Jvn
         f377wnCoKa4QIxcj6Q4bKPmQAfDmYzGUIhw1MKtROyHz/Bda82p5movh3F0FPvmMTCwU
         anNgcIjk6jYqKXy4SaOWEL2UpFJP0fUvUjcRdnqFHfqFFjBYP5M1FVI8btXgDsRrSDAx
         wuosvLFabyW/tPsPEK+hv0dgwhJjUhLuuVbhF5D/JF4IqIiUJmR/jaCBoBJpGp5oEEfX
         an6MlQIJ68yKjr+pr94rAW+QfJ+2xL66OEZ6aHpPz3IxRVtCFRLc+Nc7OEF4Ho/d8W84
         LatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707745015; x=1708349815;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0VgdnrP4U6gotPtuZzRM4hGBRZmKiDNd6axhw7iZ9Q=;
        b=RbhWsq+3NQZ9F9jxJCKPLfnNjFOLWE8KhpGOR2Z/AsVdFDgt+Fjstwz7HvErr1M5wj
         67KHUQJELcewyeABbqq7IrCEl5elFkhi80HxQfVNt44O6JCwbbSdInGVf+9zXUPcJ1X1
         YwpZiZ+cr2RWH3IoI4vXEi1TIFtuckHZnfPfYnwdQCtxt6p/y3UASWR13PvYx0LPFweV
         ADV7hP6dSG2Ws8l4HS/ylH+lfSxXek4SQEV0eX8W10hX35sSpGYOBIreyfOSC/jZZpzC
         ubRA3L90nlVz+rVlnUKvPIAPei1LSg7xtIBshH6+CfrwriE5m+deUH7yULaGkteGRE68
         AZ9A==
X-Gm-Message-State: AOJu0YzzLEZo1DTpMTRL8qv8ndytYVSpXbRZPcepNiNQmKOaZVVqB0YQ
	In6oal9GN9dzAVd4N7XKGvWenvwjEuf0QFINa8yoVT9/xbLnCJwnZg9pDzyh
X-Google-Smtp-Source: AGHT+IFF/37ChBRn2Pb22jaSGl+YgF5hJAu5zdK2m6fvTPYrvbq1d97xn48TuUotf2DcBFlhIinyrA==
X-Received: by 2002:a0c:db0a:0:b0:68c:c3a5:8120 with SMTP id d10-20020a0cdb0a000000b0068cc3a58120mr11935383qvk.3.1707745015254;
        Mon, 12 Feb 2024 05:36:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfAmuCNSDQBbgGfJ0h5lQtuMuJPgX6try9PDEv1317IqXE7Cq9sKXMyaRwZKj5xtZMGVxp1tgCpiq5fhJkxu0HrIbEZWzJlg==
Received: from [172.17.0.2] ([20.97.191.35])
        by smtp.gmail.com with ESMTPSA id ef11-20020a0562140a6b00b0068c9c9321a2sm156781qvb.35.2024.02.12.05.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 05:36:54 -0800 (PST)
Message-ID: <65ca1ef6.050a0220.e43f2.0e0f@mx.google.com>
Date: Mon, 12 Feb 2024 05:36:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0551604237324128921=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oficerovas@altlinux.org
Subject: RE: Bluetooth: SCO: possible deadlock in sco_conn_del
In-Reply-To: <20240212130933.3856081-2-oficerovas@altlinux.org>
References: <20240212130933.3856081-2-oficerovas@altlinux.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0551604237324128921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/sco.c:235
error: net/bluetooth/sco.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0551604237324128921==--
