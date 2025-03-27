Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058461D5170
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743110150; cv=none; b=XTrqz3XweJFAfUyp0bV4GUXAVA+PmzcXNnxlaOIQ8Ui+OseEKwFZOacjmIU8SyybpeU7BxLIVS7IN+MRrNybhkVPIf1wSHaFgublgVIdnRuHJK3/tbNmhiZNoKScqCzml5deNwuVa7x1iRNaPbpUS2sy8zIatj8q1fprpUvoXow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743110150; c=relaxed/simple;
	bh=bofh+hDAnpNvQzVXGTeJEUjEwhifDuhr8FCJ7haOeng=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=l1cm/iGhw286A5ZLk6ofIHDJsN40YWAi/UQd2WSUZZdL7CIE+x1PeodwZYRLDZF27RAGMnh2qW4/QToWpKf6Wmo1W9wtDb9HEMyT0eHU2HJuinOtfOyDN932fs5RONbH9Dfc9Z7m2Eg8vOh4/qRZQkh8o1I8WlkoTj7tv1s4AoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDgC7p4m; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDgC7p4m"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47686580529so14858771cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 14:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743110148; x=1743714948; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bofh+hDAnpNvQzVXGTeJEUjEwhifDuhr8FCJ7haOeng=;
        b=hDgC7p4mQMcRSPHsaLNS9oK9woAVuwsdNMNi2tYRRe6SAg68uXBRt/T8uaeIurVn9M
         RddSGl+MWtZaE5KYvyzB//dxQKZ91BFjje1iZmfxYEIveAYnFfs5Fybx980F7T2hhH0o
         /N9COYisXTHgM6mdM6PhJhgeR8Z9V8R3ejc3w7HODQHKz/Se5yyJfm+FvDAQwFPCZcBl
         L9CU2u2CcEjFEsgtB16viDphof1Lz68PNPrIUEIPshAuq3eCvZ+wBWHTk2p0zuId2hBz
         nfcbgGa2m28GN+5qgJVkvFbq+yLjNlzP8z3Wu6nE/eP60OKXDPK8/WguBbknzTq0wXzh
         3OzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743110148; x=1743714948;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bofh+hDAnpNvQzVXGTeJEUjEwhifDuhr8FCJ7haOeng=;
        b=WL/CVAhlZ/15MB3RUpTiAPZDZ5ACWF9ZxMW8qzuz5arFRQEfFHzsDy1g2G/+AfKx0Y
         cBKLHFbjm9DRsHQ7AFvUL2LECHlKwTh4PBFVhov/E+kwY8p5jlTkTvy+tkMXDvOEdywk
         9NTSYSz66+2wjZC1F1kaD3gjmJL0CbnnAkgh5Hn8bLXqrXq6wdiUyzplvdOGvjLO0zRN
         MFrE5e1H5/ktFgYWkghHSOUyPWrd403DuJ8duUIz+Hmm2KqcTaG73EA5sXBrrnlOQAp2
         A7YfigL/v6FJgHJ88AbvUUWQJZBY4wGH2LmXSLvYqD2ZACL429gfuP2enrijsDoirbcR
         Cprg==
X-Gm-Message-State: AOJu0YzOTFtN/hBZ1QZbF0NPxqW3389/3kXoBu3BiefxewySE5XTnkbb
	ds/zWgnxnpLQw6cSggYizxHWLDhLaDKSVN1PG37rXz+EPEfA/AvnqJ3GqA==
X-Gm-Gg: ASbGncvgVESaKLmIdYxPY+rNK8oCWCmleJ8G4VF08PA66f5uo8Ggl273P2YiI/JDd0u
	E5RThlPRd5FwP3XncoKYL+MMrZcjo0Mq8jzxW8f5NWnP4b3viwJ+uTjMko7GBsPLhdvF0vAFXRk
	qWzFWBsV7Qph3tjiexRpbVdIS1GJmkv0Dx+2O9Sav/cD4HoD8hukH+lmzkquckgCTyOOoGvpK2P
	WrFrqZExTIs1WDBsoile1V+uPOo0K6BoHqPY5noObwsuw13CULLKVgVhsdv3JV+P25zYrw6Rndt
	eHiXER/v5FWcsDBWbM1N/aeQ6RBmV73ELsxGlTwHGKZhFgv4Uw==
X-Google-Smtp-Source: AGHT+IHkjPSZTSSAI8hb4sW3KlyXfo5nB1QymHciG0TvnnSniMWpWoYhwdWkK9yTZdJeO2Vmwxp6AA==
X-Received: by 2002:a05:622a:4118:b0:476:6215:eaf6 with SMTP id d75a77b69052e-4776e182be8mr96397191cf.31.1743110147588;
        Thu, 27 Mar 2025 14:15:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.17.118])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4778317b3ffsm2233651cf.54.2025.03.27.14.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 14:15:47 -0700 (PDT)
Message-ID: <67e5c003.050a0220.1afbc.1ea9@mx.google.com>
Date: Thu, 27 Mar 2025 14:15:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8093006596711030898=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, g@b4.vu
Subject: RE: [v2] Revert "Bluetooth: btusb: mediatek: reset the controller before downloading the fw"
In-Reply-To: <Z+W6dmZFfC7SBhza@m.b4.vu>
References: <Z+W6dmZFfC7SBhza@m.b4.vu>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8093006596711030898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btmtk.c:1330
error: drivers/bluetooth/btmtk.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8093006596711030898==--
