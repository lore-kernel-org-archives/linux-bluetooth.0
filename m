Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D786368287
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781046143; cv=none; b=h+CKW0FTEQfQWGV1DyloL++e/ZJuxzECTqnT1d52NcVApBJC8GUsI1R1eMwYr8RpZPq2zlz6Piqf4uZPwOjn0vIlXfhymAi3Vwux/pXR0mmcxhgQQshmxLKpCmt6OqSZ3Pz+ivQes7Nv92rRDo46Ab47k/7UroXZwT4q7B6RYoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781046143; c=relaxed/simple;
	bh=BSSc6dR6Ms3QTSs9IHD6AL/Wz83FSf4VX0D+pFZKhFM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YglZQthQSGLbeE8yDEFGofiTt4JL0lCnf2gshqnQ1TCtWPolrLjCSkNMyT/DgBbF/kF4OJs2ctZKL+X8mspudaA6LcT1f/MDIP9LLaYDP5tarHhTUZUBJDBaWJ2i5dRPRRbnKU7B2aO3L+gZZubtdtPZOGQ7kw/IggQonhEYQMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4bsxHMd; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4bsxHMd"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304f0039c02so10982310eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 16:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781046141; x=1781650941; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RWcaDhchcqaIh1wzbF4TRx0DuV404L02zzJuj5+GaVQ=;
        b=R4bsxHMdzVmGzwsDBmXgOWWP43wdyHV9Iq4fErxpdeUqZTRwOlN6DqMxlpFAh/vSbW
         ENcd77k24i4fBz09XPt68ej6xje93sex2y7PGP9yIPGdKtyH3zqi56d3pMrujSpXH4Qf
         4UvN4Tjw+jJGADHInPGGj5sHUGcAsA+d93NIwMHeskUf64L9jJyvWQc5VyF2d/Ic7+5K
         y8yq93ETVDaIJYear6v+MvbwHDaKYLoAWdRxcwhPm4dzByi1ez8aMOOrmt+jdiSUrOfR
         IP7gzsYHTfKv4zdxKAi9h+b3NlL4i2R3eTkuHyt0eSZsoTp97kwXuUqvt8EgP3fTBXBV
         eqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781046141; x=1781650941;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWcaDhchcqaIh1wzbF4TRx0DuV404L02zzJuj5+GaVQ=;
        b=r9DUUREwJEOayyKBGBsquplQPx0yGwNWqdtldd1xe5DoeMP6LCPn6udseGK1cj8+Ej
         M5TcLEeJBS16r0ugnfrnXfgQeLYbH1GWmQ9q8IimU05aCLk4ev9lgG9KqN3ERUdFuTRF
         SrJjoBGxxwYAnUk87mDxb2bwo2l2TzYTQ25boYEgMftN91na3P4SFpw3/FsayzgpVljd
         VRjpHcwfBIdRbFzUhF55An1cub75liGjzUhj+uLmHZZnGUs+Te8fYxgE7lFImCUtAANG
         WsudlB/MsuH3HBj92bOdAcvRSYFAXsQpy9oDdGcAgJax5dz7CUQRjRNwulCPgAOm45+w
         86Fw==
X-Gm-Message-State: AOJu0Yw8vBvOCK6jGVy8qgWk8z1+KvRQTKpptlli5FrCsooVZnUa4ke3
	nUnRlod9yBcMX7foUhvsdo2MUsKxgpC3huHRspnNn8bd/Uvrkh3JH/OpNJfRZw==
X-Gm-Gg: Acq92OHMs4CxxbX1h317K0wybb5mApA5QfLkjriTzPxTsfa6XbzQ7P4v4/lQRUaOXlP
	8sbXtb/UZCWT8OD12pnH9879QoFVb/FroMvZq0tAS+1oU0BM2cDKWrbHY0svT5rcHU70b2OatrD
	NGUDV2fSHyjDweE6HfJUnSrQWfhdZfUH8Sodi2mEEnUic3EMX7o0eHzkOAJU7jZN3pqAvmARe23
	aWAIZwRi4itjcR7fg/Ap/Wr5TpqkA5j2E8ne/bv48ET9akJAcIA+p7BIPTeS5rLrlcEjOiGGD6X
	CU2la8RWOUSpEf3EX2MwxKoImQi/PuuXJ4UNN3dM0/3qMi7Ujjrtv83Q7khU6F8DsDmSEqBHm2W
	Yp1SKfIMk4/bI/sFYruBQf8oiQoR9XlWwrX0krcraPdwSevHGyAfeqh1iC9mwyXps05LeRbD8+c
	oOSahNp/P6+tj4uqN9ykx0q0PnJoXltxvlzdiKsWpqtz5TF4NxU3g=
X-Received: by 2002:a05:7300:8c1b:b0:304:18be:55a5 with SMTP id 5a478bee46e88-307d62ddc82mr4262783eec.22.1781046140945;
        Tue, 09 Jun 2026 16:02:20 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.163.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcad34esm33643666eec.11.2026.06.09.16.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 16:02:19 -0700 (PDT)
Message-ID: <6a289b7b.5b037ca5.1804a0.21a7@mx.google.com>
Date: Tue, 09 Jun 2026 16:02:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7341099359640143950=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] shared/bap: Report invalid-length ASE CP write via notification
In-Reply-To: <20260609211104.3887577-1-simon.mikuda@streamunlimited.com>
References: <20260609211104.3887577-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7341099359640143950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1108823

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      18.69 seconds
BluezMake                     PASS      685.55 seconds
MakeCheck                     PASS      12.43 seconds
MakeDistcheck                 PASS      225.68 seconds
CheckValgrind                 PASS      256.41 seconds
CheckSmatch                   WARNING   313.77 seconds
bluezmakeextell               PASS      167.62 seconds
IncrementalBuild              PASS      619.95 seconds
ScanBuild                     PASS      919.45 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2207

---
Regards,
Linux Bluetooth


--===============7341099359640143950==--
