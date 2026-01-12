Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D987F319859
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jan 2026 07:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204219; cv=none; b=p39np6bXSTyD6eI1H1X4A1vca7CLPfXHMNXggrZbJAb0vkFyvyh63b8/9tw5fZArNi7Nq4OK0K7+GOrYrRu/1rdAsjOee+rSqDxCoqjA0cr3NZ04T3vVosKHBF+BAOm+f9HsYlm+OZZwab2OMSMsQYwCeZ0eA74dOwfX2QC/gTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204219; c=relaxed/simple;
	bh=CEotChEvM+MQOOgdBMnzuses347ATbQnhX/TNla+Mjg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YwvcZCTrVbtwYS+hgOXscbTnxqgSUE6XPXz/tLuAi5224Z6LH+vIbuIfzR5MgJ8DPBcnGh7v3DC58mT+WUefAnnXXtVrHNFrJeyZKQ6ZNNgmVOZE0fOdYGyNrA7o5/zHliTfpr+rDKBJ7Ks57Jl6iG9OI8rt1pWUmwh0bwlcBb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4sMyFC5; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4sMyFC5"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-4edb6e678ddso98228081cf.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 23:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768204216; x=1768809016; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ErXTFHRni5c57AhrO4x9fM7UDoQ1Po4FVRmyamzvMpI=;
        b=O4sMyFC5CX4zrf2zK3k28wgEXv4Q73cMEcGSeXqWrggsD5PeYt766w+6swiYWk+fpU
         MQYvD1l/xVmmlhw+bSvEUPiAfOr7DDsvFsHjFzd5EjuG9w/6O8nthzPMWERw8ap1126N
         XiUjewvKAVqZKC0cJ+fv0Qf0mNiaKBMOpCnZ2EutLkwXUpzIbzoYuC1/uMuhhfxz9Ktq
         wkgEe1PUUfwRLYJPdKUZdTpj3jZOcbcSw3t3BkZ+IqIzBkU38tRHGLjN9CrSY2nl8Q8Z
         WNzo84EX1kVVxELGqnOB9EjbnmhxWelnqktvtk5Fqg2KWGo3+qW3HLMMkpH0XlGNGN9D
         ebVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768204216; x=1768809016;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErXTFHRni5c57AhrO4x9fM7UDoQ1Po4FVRmyamzvMpI=;
        b=dT3wILyOasWZj5vVXk88vRC5NOAcDkXb5GCD42SOlBjr7dxVkZUePQB/bDUTxBzXiW
         cqnuNVZVXCvPPNAgaPGZY7Ia4XHwySvdz8xFGFxFcHGaceBpIejsE9j271jEkgeCQWLj
         Nd7/I7plrdyDuPLhb+wJhGO0DkR50+hRh1aAHio/5LxE49ssFkoMA/4gJkepgIMmDRJZ
         7rFBV6eiZbcvYzZ1X2YvSIBDwSNy1mVLUu4rNTQMZ9K8Jd5xGkNPzk7Jn6jbE4i9aMMJ
         Mz2tjYOC4C0dwuOtQrL3SrhFBAYSqKuOtJlReATMyiZZMPz6sLup21oirnYtjs/Bnsje
         SXSA==
X-Gm-Message-State: AOJu0YwRCBx8FAIqnsC4XwdGMkVLrAnoc1HTnvP8OuHgcHaEZ+FbFijR
	L8bq3T65h3yEFk6biDsC/hAvfLKdPi2ScTtK1OCkxxgVhaOYB4fXPHRk8iYkDBm1
X-Gm-Gg: AY/fxX5lXma2pgphpNIlSpLJhRzdW0sXjA3irRpAm/36Vst4a+vIvjx8sqZPcekfr9N
	uwcVitrLfb5xZxnaqOG26EcZaKHkhti+oSggno5EFroVj0zlSoRG7chAquOP9v7brfSuk2yHoJi
	UIFx6NV8GvwviONRBgkDtnxOZoo644YPmNS0RiLpkOgo2jz85yb2+UFB5K/EU9WT1AwdXW5Esk8
	t3jN/DOJKy9kzIFs1em0Rn1suwA4DJq4f6wWq36o1xn6c2Jh+vXxB3upIMWGLlHegImFlWA/Xz2
	iVAFWG+5R/6rEkKA1ujsf3rlnZTK7EsUwX0Rgfu+mYyOT+emFfgdZrysPKV9JVuUC50Awp/6gno
	SVXIHLyu3aNHTlOWKYNaZFAhgpY/IxH4KUJtNZjsDNZVs7Ep1oeEFlEXM02fX6To6RUz0etBqQ9
	e7SUW8Cc4TQSrGaw==
X-Google-Smtp-Source: AGHT+IHVwklfX2YgkpYNxDRCSBUfMXFxAVrWXIUGukol1ajI/AMEYr0KUd41BorhLTrn2RNKSEAM2A==
X-Received: by 2002:a05:622a:1a92:b0:4f1:e988:d786 with SMTP id d75a77b69052e-4ffb4a1e896mr235036641cf.80.1768204216616;
        Sun, 11 Jan 2026 23:50:16 -0800 (PST)
Received: from [172.17.0.2] ([20.55.87.50])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8c00acesm122185361cf.0.2026.01.11.23.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 23:50:16 -0800 (PST)
Message-ID: <6964a7b8.c80a0220.25af93.dcbb@mx.google.com>
Date: Sun, 11 Jan 2026 23:50:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8510721424068975344=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [BlueZ,bluez] bap: reduce ISO sync timeout to 2s
In-Reply-To: <20260112-iso_sync_timeout-v1-1-9a3e99259a3f@amlogic.com>
References: <20260112-iso_sync_timeout-v1-1-9a3e99259a3f@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8510721424068975344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1041012

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.03 seconds
BluezMake                     PASS      634.54 seconds
MakeCheck                     PASS      19.21 seconds
MakeDistcheck                 PASS      241.94 seconds
CheckValgrind                 PASS      289.19 seconds
CheckSmatch                   PASS      351.19 seconds
bluezmakeextell               PASS      181.90 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      1022.63 seconds

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


--===============8510721424068975344==--
