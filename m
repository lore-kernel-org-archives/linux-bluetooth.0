Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6835C361666
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787085761; cv=none; b=Iaq5KJuDuExkfXqRjQKpCXE8lmLnYN7ElF1888P6QG7ZUO9lCNDY3JGH1JKnCvobJIlaPJRvpx0BbLNf3qvkQPn3Ln4wJyTt51lsXtGWuNPZd6hmkil1OcvYcFr9EkM3KKQesa2vgsvMihQKFyiH69p2cK2laO9LoxEwzZjRC1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787085761; c=relaxed/simple;
	bh=iDa4w5JXzilynv6r3Lb6dnnaMbGSqCcb8LZdJ3SptWw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nwagWZ7+K2ke97hfuC99a/+Pvjt8GAS2/A+9fR3J59DyQrL61AgRqL9YgQpoiG35NEXUpPGXvKmQzDZ/uMtxCAX06Jgcyuw+RZ13lkGhGK3FUjElY5e0KdgfJjzfsSlSsnqtcIfQJkNYIVNGhDxhLFD+NN1bAY9qMwVCUXY8qC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tKPoZEYc; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKPoZEYc"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so278348a91.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 13:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787085760; x=1787690560; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iDa4w5JXzilynv6r3Lb6dnnaMbGSqCcb8LZdJ3SptWw=;
        b=tKPoZEYc1onyMDw/JRdlY6nLIJ2UH5LRzA1ZrDzW4RX2cKhOAAWFZGjhfIqUxXHGUm
         ODwhXrptDDN61QYiOREBzqd248eHsqfhSuXVGmBJO4XTzBA2aVJZQZnD4RLrokraD3F6
         4lyd7TZ3sivL5rtODsVQFr5VuZG/3REUF8dUByU3cDi5Z9f6yTF18W6RzYcN9AuKZBup
         g0xVD/c1Cy2N1oFCwvSz8JCEhEnFH0AYKNYfz8iu7BgyEFW2fdT5bQG5GThiljiYmiif
         JKhUX/lF5IbmNi5Hq6+26ZL2HzqO8lgCirHSiOQaWl4aCbbOK2GRonaImF6fC2/auqWd
         v1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787085760; x=1787690560;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iDa4w5JXzilynv6r3Lb6dnnaMbGSqCcb8LZdJ3SptWw=;
        b=TWJs3Q3vMaJhMASV54htbG3z5WEaNjynWaLYbU6x0haEcmN45WEiseqVSysbsY0IPy
         aqxboM88HIZAhcYW0xvqr8g0PJc5/ND4xShgfz9L36QGfWTMZ5A4ynLE/McAvrVi3mCo
         x6gxK12zLIt2d2TQt6rx0+5iewA9XXkc7fvFNPx3Db3LJOOuKR4v21FTWzk5+kdEJl2E
         tdUC3gDIM5zPF+lEDGK5A+V2JA8BPx0n0d6WkTA9n8q20uAl8I5TbxQWboM2Y6hXWV4K
         w47g9wruX9M2iZUYFH5qsn8msOIcISdsfQJW0UTwB0NgWKKqmhi8tpuCnj9I5JEh5DKL
         qFiQ==
X-Gm-Message-State: AOJu0YxOFCs3h9iq6onBhC+oWHRUiqxy2WFctEy8zHtvBGzaw24xsTqK
	B4hn4dJxc5hdY+2lf3E+Fz+AQlhIHgzizkmoI6ev+DUWt6at5dxgsMMDz7RaIx87
X-Gm-Gg: AR+sD12tD2KYWQfABHgRS04YblcQCIZvvBxQTVufEXyOWC6+1FNpyCEJtF5RIsVGvEq
	bkDzzi6g9JhI0gf5OGgaWU416HALG8Q113oXOXdOQIsTDuMB1ZNWlOlmgy8J8nFZfgjQGByFUFy
	P3cKW6xBbue+6EKJ73SU5MNKXwR9+qhcqEexB+OaMTaiMffO/fX4rBbXDrukhN0I7jxlveZGOaU
	VoJTUMYZHr59YgAewa/iBl+OImZ4MctrNQgKsR4HLSmGUwG4EOFSe0+5bPU5Dzweq0n1+4HKf8j
	bLOuy3iom1W6qI7lBG+Y+2LFFgJhgiXcgQR+k0gBnzOUrl0jpgEW2SY0/hjH1OOdybxXfMRO8na
	QmiULCPgYPIqLzrLr95TsZzHO9suxoI8FKg+Y1D4I1U7v793vMvxwtXs56uYzvoeU4LlS0EjsJq
	TTTmTyXYLXzCR1fxxFNoo2EgWvDJfVD0eNVRMg7lYekwXe3tjsSVATeXMIwRzQKjV7NA==
X-Received: by 2002:a17:90b:3c89:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-3957b303e5fmr725075a91.10.1787085759595;
        Tue, 18 Aug 2026 13:42:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.97.243])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1415305e48esm20781533c88.5.2026.08.18.13.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 13:42:38 -0700 (PDT)
Message-ID: <6a84c3be.4987c784.36d8d6.b21e@mx.google.com>
Date: Tue, 18 Aug 2026 13:42:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0210634489341355373=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ali@iusegentoo.com
Subject: RE: [v4] Bluetooth: btnxpuart: Validate the FW dump header length
In-Reply-To: <20260818202211.617795-1-ali@iusegentoo.com>
References: <20260818202211.617795-1-ali@iusegentoo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0210634489341355373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btnxpuart.c:1361
error: drivers/bluetooth/btnxpuart.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0210634489341355373==--
