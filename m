Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794917756;
	b=h5oD6sMpIkIgoVMZtUelI93CqCtxSs/ipmRH3Roz3vhY5phxz011CtYMmRx/ACv+hkaQ
	 UNMXTHBPHRHATE8f1Na/IUJffuvL6z5m1UG2PkvSSXaaWrA6X0+UUwLfQil5tlVfb0gA4
	 jmjZzKx4ETUyBnEnc5GZe5lFYstSyDHJ6K0HPD1+tFTKN2r5wtpAPNNV1p5pAMV10+YZ5
	 12ChsuLIA8AbST+ZFA6neqx2alz3nGumVnHEbF4QY9CEUrKEDlZig2hF1k9Y82BIWScc5
	 XFaWZYyY3uM2wpX9Zy1tzLLz6XpCX/Drn8cjeAeKLrHAdiGTveFTNrOFom+qQ3szy0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794917756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=wEgLXaGcamAUb/BXxOwfv3DLgsyzdX9gcJCw71vB/rc=;
	b=Zu0OyxvnKMmNPPXTKChMpTCkndAvEYHZth5QrtOBkGD3OUjNPZvNExMxobSQrxi9Vza7
	 kP0IsPBkmeeQbN0lN0oFfS5hWj4lS+aTdLOTl5t1bWgFy0V+48uZS9wdKFOIRqeckLr6M
	 7UxaSxbZelEpfM2OG944z+XspZm91ent/xme04f8bj2HvKAPRQq/Qmf7RH/InggwPUYz+
	 JTO5lBqwG5zugfxX3HRoILl0/iPYj1VbpwziSHqTSwJPYELno6TrTbfQx7149cpxyoIiJ
	 2q048zsuh5bfIur2eYkrXwh1hLL24vgOjhvfM/eJF/UDWl1J/rGbRY+Dh1cHGvHmCiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q68PbG6x;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8A5606A323
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA8A5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q68PbG6x
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5365f9a04c5so73774511cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 04:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794917755; x=1795522555; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wEgLXaGcamAUb/BXxOwfv3DLgsyzdX9gcJCw71vB/rc=;
        b=q68PbG6xGI8NTOeRZGlVN8mqpaqhUEHpZOOpAqk71SRJB2pUno8zmAFVqVQaiEwHhy
         e+X7sxPslGFeszpGr55jcHA0o5hNd0BYzT8R5kzu/XJq7E8Lto97/6kAWU+GWaQiNxQV
         N+JfmPwAbtCzatEIJaIrWQBSTssHxpjnmjMhc6C3sjN/KXBzgA+O/Ea49Px8E+doYDhB
         vWqBzIPCo6gnCZsTe55w968qCy2lrTBS1WPV3b7pdZFLxxJ5cv/BP5TceANR5pZflN5X
         K57JRiNscYV4SX8LG0haLFzmJGG1dZ+awcCnOgbHJQpvtBvC8CwgjBKzGOR876IfVxxV
         WAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794917755; x=1795522555;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wEgLXaGcamAUb/BXxOwfv3DLgsyzdX9gcJCw71vB/rc=;
        b=pCfhce/PciX7HXljhMvv8IizhNluQzHtdj96bnqgvr2KJ0vaREiEX5dls6v0/dFPYU
         KnG4cPFYVpzgf75/Q+yzKNDb/VEwjRHjg62nTB1TF4kBjEfaeUkuO1Z2gdCqifxt7TZ+
         w2TyAw+13f+O9q/7kQ409e6QadvonqXqRspXdC1JOAH0sFtVFZIfdadFZmyX0UPuYaE2
         qeGMm+grB3mwMqS8wyuMO7e5hZe6xykYCtXYsFHyt/RuD6GfFSwjqBWd4+VYxuJnFWv+
         xrWfgVU6n3U31LNdm8R63PJ8SowWnEy58H3y/AJvA9kpE1lnXmv8mHVO/xnwXlOeqvvX
         CzzQ==
X-Gm-Message-State: APuU4Z9g83804JjG4mY4z+ajO+SXQcU1/JZnanZ29gnzxSFdPsR0+VtV
	wpc9BkS1hRa/OwL3ee6JEH6VroaCgY8gKZR9EBDmQNUnKbGqCU4GGaKlw7poAw==
X-Gm-Gg: AYBFou1AJur5QolSwae3TVXsw7yD43mGHhDhtAZjvGwwWHUN4B0jJamKOyvQ8z0iUrL
	pjmOIUyOj+laMXBf/OWuhNxkcoWLAg7dj+4YA93AZXnkWxh3fkIhQvoBJ3xZK3qg3ny0A/BC4Df
	1Puvq2mf5eDFvnmy6dITK7tnozJItF16MCRiwkh3Ux5ZcBF1ckbCxydTER1uVhT47NkCI7gwsDd
	odHXRXPEkprbUf6xMfFf0h8DCUnzIX/eWMqtLEA2NKOL0fOQdddnfRa6SBM+EXdWhDR5gVnF8Yf
	yhNgeyFGj8ZaGSh16tOFTzda6WBYafbfSGjjLZEWc8UL6reYcYgCcCyAJ/n3lC/+kmRM4aXx8Vm
	95kDC+zQQedno5HiZvklkPKf9KcBMU0j32AeqDzqW7/EkXDh7yBxHTpFFen4P4WlVRehaQCTBnq
	lX5HoJJFxuPVwzsX4TjefpPXoyuRyAhKbmleKqPRPZ2Vp36c1lQ21QLZ8mn0W+NfJiHRAkYeo7Q
	heswqIqrB7E/YDjQEI3TNipUS2kPiYaJe/KQPpzIVuiBH43cMbo9AVQk4rpgssBc8k0YpXkCV4e
	Z9T5AMGepyVHFQvT85c1NuOMcyoPnUefyDzfYSZ9zof8hhreW7GA
X-Received: by 2002:a05:622a:894b:b0:55c:2cf5:350b with SMTP id d75a77b69052e-55c2cf555aamr145553131cf.31.1794917754682;
        Tue, 17 Nov 2026 04:15:54 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-41-210-118.compute-1.amazonaws.com. [3.41.210.118])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad1b11d9csm103764121cf.28.2026.11.17.04.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:15:53 -0800 (PST)
Message-ID: <6afc4579.d49f74f3.340818.6a7b@mx.google.com>
Date: Tue, 17 Nov 2026 04:15:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5087631861130044529=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com
Subject: RE: Channel Sounding and RAP fixes
In-Reply-To: <20261102081913.1623864-2-cheng.jiang@oss.qualcomm.com>
References: <20261102081913.1623864-2-cheng.jiang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5087631861130044529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       Channel Sounding and RAP fixes
   Pull Request: https://github.com/bluez/bluez/pull/2747
   Created:      2026-11-02 08:24:26+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============5087631861130044529==--
