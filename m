Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF28028725A
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998855; cv=none; b=fzdQ6zByjHQhaPW76UXUMsOs7KOMQcDUsOQ+hW9AgMWuvpo1CpOnyBdnvBeOUvGS6l5frulpqFN2ogbJNLKSckaF4pSurloFKPwmK8QRMW6a32Y5j8Zf3BrVtYcobw52YU9Fk+PxtfLRnYeKZu1YgKP8CVzpIe/TFwdnhtG6Csw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998855; c=relaxed/simple;
	bh=GqdhrFSt/7ahP4x+gVQkLyk5eFFRSy4XSrszPs0qa6E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XBSHddNCyi5dS9RaiJKiYYUpY8JvO2qfEZCNLyVZAD/4lXGmSoULmskHzHHCU1P8apCeckjV8mwKicEBz5gpoqhTTzOHtYceYyx1SNGTLh7Zo0W1NdWBhAKwhJy2g8+xHGu+Sf7MR90fwEkPmOuUxdkb+E3Xgec+f/aZfMxxGFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X00eJGlh; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X00eJGlh"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b429abd429aso2865653a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 04:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754998853; x=1755603653; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GqdhrFSt/7ahP4x+gVQkLyk5eFFRSy4XSrszPs0qa6E=;
        b=X00eJGlhatcrNs+J1IW24TF4CrT7ZNClrHVvzpf/b4fNAsjdr2ou3gwggrv+2zwUs4
         2vWvvS8ZEMEjNKIqMN8V4+HephFt8UlZpIoZzXiPaAjmZfQyxY2UXi0f5nP2MZztOOsz
         X7soq+wWb1K7RsrdYBPICGcWGW7Z0Pv3TgKBxQjeZr0g4v+vPU7n2hnnSLI2xc2+Cqp7
         mVdDGXMbr4e77mRROLt5US728hvFVcgaNpha2MuNJDA8nnBd9CigjOSpZlcydZRuftn6
         jgr7ZpM5bV+Qv7mXYqD/PlZJJV5JQCXbKt0JNnZM6Sanv9SL+9znpWIXxsPX6mc+ELTl
         COcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754998853; x=1755603653;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqdhrFSt/7ahP4x+gVQkLyk5eFFRSy4XSrszPs0qa6E=;
        b=lyxAGcs6S/eXUH/r/BQVzupkqHZOdFIRfDpGJsdXCqNBtFSJ9VAl5y3W4rzDeFGXR1
         /bf2oIDK5hwCrmor5smFlTOm39KtngCaliUleGnzjmRmANxIVUlMbq7sDIsbjC2dQq0C
         JYmYlNRVfM2seDZfbBVGWMPwCzXQ2sc19NHcdJT/ZscrhtUATUaZThF4jmS23lkh/3wQ
         cZDJ90ku+EmoJYueeQ77Ba8M6/rrAY0f977yR1dMiQCq+pF3OW1ttT0O9mNqT5culDRh
         MjZ6zBe5+aFk26ZhAIkQ/mvc0LW2R+dLmIPdItxqnQha/jcswh6ISR//AgmsjhcmS5Wl
         YJOQ==
X-Gm-Message-State: AOJu0Yya9U3KVQOAPCKnHr82ZEqUyDywlT0kwMM0W8eTV+RcwkYnUZ9S
	7hUU3O3hQXgPLvSfRSvkajmYeSDniSwEwhiMJtMCm/HozN+prbhF7c14z4zk1w==
X-Gm-Gg: ASbGncvmJ/IFBIatDCbPOH2Fgu3WPvbCreUq0B+TIYHK6jlDBWqmvFKjD0VDq5mee3t
	OYhAVN9egTuUdTZ8BVdK7OTLGxQQWJK7Pezu+vVyNhc4vuDj00i/Q3wW2lDINM15fauQjWrRNwX
	wgaRj1I2dgiqQ5saYohcjiGe2KyEWXGDQtk2VmcWbOeEdv8bvcEhGyP//3rtlVWlY/UCt+uCXhf
	zw+Gzv/BpVsrJaeRB+OaSvx2jxW3rzvBZU/D23m2ZwJEZfGIYYXzJ+PrSZ0VTSzg1mfOkhCxlGM
	vDfhAwK2h/OgUx3jPtKy/Tcwagg6tvJNczNlZ/Q4oBMCwlpHOyJSzUwc/49l+vfNlYBtQAqL93A
	o7L+AfaVYhPVAsh8/vJnIy2aOZQ==
X-Google-Smtp-Source: AGHT+IHaVqB+QZybrelhXrqEZ2JrFoYN/WC1fHtNinQreLBCD/xNjuMFS9vvhSMiOtkvBzlN6ndCNA==
X-Received: by 2002:a17:903:4b4b:b0:242:3105:1788 with SMTP id d9443c01a7336-242fc3a55ddmr36338295ad.45.1754998852617;
        Tue, 12 Aug 2025 04:40:52 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.58.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89768fcsm298276045ad.82.2025.08.12.04.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 04:40:52 -0700 (PDT)
Message-ID: <689b2844.170a0220.3914a1.557e@mx.google.com>
Date: Tue, 12 Aug 2025 04:40:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2581586356662072813=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v3,1/2] Bluetooth: btintel_pcie: Refactor Device Coredump
In-Reply-To: <20250812114704.1596969-1-kiran.k@intel.com>
References: <20250812114704.1596969-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2581586356662072813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel_pcie.c:15
error: drivers/bluetooth/btintel_pcie.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2581586356662072813==--
