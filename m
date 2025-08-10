Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870AD14885D
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754813389; cv=none; b=S/e6UCMEm9Uby10Dc3q2J3vk0jrnOipiI/5Hll//DXYO8411GT+F03gNENKsVD2s1Ks2DeD2VvPL/mTobCd3p1AS+g0CP70t65Tb8a2XPWTTOU6Baw5tVvB49tja6/NmRcSueA0/4MxafrIWEqYMf/b2jH83tUxGNuuHtiA7m18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754813389; c=relaxed/simple;
	bh=9hIKm4x09v6aHamGpaNnyvcTI9n29VY3e/mJw7KYNw8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ktd9oJX5IZ24N6zgtpSVUT5C8Ofh4+xWV5HP/GPLf5T2okbQUlCab7lDHotA+FuNbyP6FirQ/yUfBtCiiB5PgcxxTq1iB2usW4qy5MWj9L1WEfDOwY/BwcwnwcFVrWmvjdhlCmeD1K3+TYYCFyPPAZ6xBAQmbUP4yENY4m3+K5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJ4sNfQz; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ4sNfQz"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b0770954faso55944771cf.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 01:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754813386; x=1755418186; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bkLiywDbOpEEE9kkMzk83WFJgx5r5Q+hmNOOriwGm4I=;
        b=QJ4sNfQzatdF1/8Z5yAo/s6qWlHc+GcEBZ8+3fYN0CKBz1UT2E6JBDSVNz1U2QMJ/c
         7KJxNBiYhnyOjtTxYXsoJt7VUklKG3ZKggX0L9sWmi6C7bCUjieK1o00lJq1Zr4Z/JoP
         qx1utHUcFm6Dr+UZI02setW1ILuqC35Tk5UEgCF7QRPCTeGhqbyVqYgIWip2J7l+a99c
         HvJvpP+0McI91p8N3gFa6jiT28kmRtECJ/CayyLFVYrP45Imu+wMNaFgYgOenA6uAMfa
         S4Vd3dr7c8pBjgKoATmWs+hYdC4V1FHkXCzyW87G0XJFa2H9EXK1+OrYl6OoahGEBXFp
         nLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754813386; x=1755418186;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bkLiywDbOpEEE9kkMzk83WFJgx5r5Q+hmNOOriwGm4I=;
        b=Geq7wuC1pPyF0zCp31OffM01GU0LnTsUDj5b4QNxfCmsdB2oWHcxdfljg1776bRf3c
         +5sEH2oPtAmkdWcgrXFNi7PuF3sITGKxXahWD52pprmxM+/R+KeRGEvfG48+S/jAHkcP
         0hkf2S40EX+k0SGpmlYAVsjX6RNNfG9qP6aLAbFEnL6gqHRz96F1TWAMSrHArF1c2WMD
         s6v6BR1OTAm+3IGg6yVeKgZJ0tbxBa2ZZ5odqIs0J9qX9HQS4PaSt9l/wPULaQgau4km
         8N+JHG1tj09oCVHF+SXhCzDkOiG8/HwqgDl1FELPVZc+2pibvl7lUdGmiER7spOtRt85
         WsvQ==
X-Gm-Message-State: AOJu0Yz0Gu4mgC2KXXmdYrwMoiiGRpjSZx4QRL0zmpieR+CukRATT2OI
	Hc7wMxE/w6I3bJt4iyHz3a3LivYp/5Rv1U5of4YcmYFUPMCdLL0tI64D96rb7A==
X-Gm-Gg: ASbGnctEh9IOaYNQont6OTpGNEoxylr7J2p90bViQrkfPuXjGYogUWeJ3yGyXk3yQAZ
	9tcXBDpSYkGr9p9CBNXCXXw4yFiho3fGLDxLhwyjM1xkEEClF5/cduD5PQesOKqPgfOXXpHKIAl
	q3N85KzrIORiR7DVz4kViGPhiGAijMM2IX3P77cAJWf32cabrMfxysrAd6OL0FDkztQKKufuUPZ
	l9tpT0vFm6g8sd3zGI+6qWJV8a1JL7jwTIOq5AbJl1iYp0q1Q3rGBGnUd6Bd94oP6LUIQKmElST
	cEc96GTXwKe86bBV9a0MKCJ9X6/lLKTyUIqhrYvMFpK0o4Fqcm88qHR+aEjd90zFgzg+VMvm3/v
	PrMG/M//Ayk7I0zN2I9XiyusSeYGp
X-Google-Smtp-Source: AGHT+IE7AoSV1ldoS00zRPMI6NAXur/0IEeq7P1G8DV1IQrTTkPbBJ2/RgwALUP1V6XBDSNUnQuUGA==
X-Received: by 2002:a05:622a:1a97:b0:4b0:67e1:6028 with SMTP id d75a77b69052e-4b0aec8035bmr134589361cf.14.1754813386108;
        Sun, 10 Aug 2025 01:09:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.77.161])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4af7b43e8bdsm93691901cf.45.2025.08.10.01.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 01:09:45 -0700 (PDT)
Message-ID: <689853c9.050a0220.13ac8e.466c@mx.google.com>
Date: Sun, 10 Aug 2025 01:09:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2271055928421013197=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ochang@google.com
Subject: RE: *** Fixed heap-buffer-overflow in `compute_seq_size` ***
In-Reply-To: <20250810064656.1810093-4-ochang@google.com>
References: <20250810064656.1810093-4-ochang@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2271055928421013197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=989673

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.03 seconds
BluezMake                     PASS      2526.03 seconds
MakeCheck                     PASS      19.93 seconds
MakeDistcheck                 PASS      184.27 seconds
CheckValgrind                 PASS      235.46 seconds
CheckSmatch                   PASS      304.85 seconds
bluezmakeextell               PASS      126.86 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      906.18 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2271055928421013197==--
