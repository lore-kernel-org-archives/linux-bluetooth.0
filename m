Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E84214F102
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563054; cv=none; b=Z6An71FmtgosO3F8YxFeRQ2djPiDjPy5ExTcuUI9K62bQfrpSLN95AW75Z9p3SeQK1Qn6bRia6AiEopLvcaMAUfpapWlOSoKvnS4Z5D59yIQ6xvX5tvIJkNuHeN79AOpmSt2+KGx1eC5WMfMC/3bowNBrH7h4Uq+BWAKW/ws8rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563054; c=relaxed/simple;
	bh=yYV9QCF7XAARtHcw4QfM7IhXu14vd9E0Yle4lD1yW2Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=papjhSJv45YQ4w9Bffc14UhYleY2O+DmCPh6ToYvBuy5r8rzN93W0lZSJWV+zoT+4CGodnIxQevX0gMrW3j1zDHMj+xBIy7ZTat7XfxV3Rl2fBQmBpL9H/gVKjhwvdBPZjb5eMsYSOK662rXtcropwI9T6KV0Wjmd2jZorjfwMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SftG8FL9; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SftG8FL9"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-222a9eae9a7so71365fac.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 11:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711563051; x=1712167851; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tFce7JgGfSXOAp8O2DjBcffOpTvplFe97chZb0GkglA=;
        b=SftG8FL9Nzhl4IPPu5iWfzfxUfDhOrxSMjWBOoC8wITlZBpYJWnNDuO0u7LHEu7Rc2
         nYy9SzgmbnMFtbPAXvg583E6MlGC76O5pIFiRGhldKvxQhTeANXQrafc6MN5E7wgv1I/
         k+yeNpigzy1rQMSHYmGArdae0toGQt6Bc9c9+RLOGJF64lTptJ02+fvxUnYS4cXRDD9V
         pHEVN7LLCUwzOoLEyaSedK9yBBfA7Q7MsXc6YK8wG+0pgvNJ+44Lq8WoPBZjSghVWW4m
         0FUmgdlObJMIN5QvB5+3mZX1FKlTCfappVM8Wp7mfAYquWRdUndKOXZM0Mu2RPGS9HLW
         1KsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711563051; x=1712167851;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFce7JgGfSXOAp8O2DjBcffOpTvplFe97chZb0GkglA=;
        b=etsz4kppJx3v7PPJeCaeIDvSXmP5Nwn94e6BZVXS8UXv+tUZsz/h2MTi+HCOnMenHJ
         gFqejPFKMXUimWVlrZ/QfEOfDA3u8UBuCTTQRkqePzLFGkABzJbdgBSPJ0br98p3eXsM
         LIwslUq+mXVTRGfvWJuTZ8jjBsXE5yzeBmtiEuCfX+4oor82Mj1YNS+8adi20eSiLqP0
         b2lzttUpf7pCw4TxvqDJpJIJaUaL3lcYr3LU4EqNVNyJj5fjZqlCnzzE27GsuG09D8N7
         Ubpfg/cF1KCQKLQtUxbp4FQ54TI5hlqVaE+kS5tp4y0hj4DpJ1pTcmDBtwjr+kOlo1Qi
         KKsA==
X-Gm-Message-State: AOJu0YxsTqLJckc/ZkavXRA7V0p13ei3tZJeA3cBs0nF+TKLxAb/Gj62
	Q+aIA+VQiQ7A/BN8xa2PnyaM/wmQmTkC7uRQ4F4VV2OAQw4k4mBi2TJVyufs
X-Google-Smtp-Source: AGHT+IHTikhVR8Q9wvCTxeroUE2hFAjXhtEgFSlTHVYQiGYn7o3gu2z95tJtPb43hhpqZUxzGQ8zIQ==
X-Received: by 2002:a05:6870:6f08:b0:229:8389:a0d2 with SMTP id qw8-20020a0568706f0800b002298389a0d2mr480801oab.43.1711563051395;
        Wed, 27 Mar 2024 11:10:51 -0700 (PDT)
Received: from [172.17.0.2] ([23.96.249.165])
        by smtp.gmail.com with ESMTPSA id hh9-20020a05622a618900b004313b4ccfa6sm4963557qtb.13.2024.03.27.11.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 11:10:51 -0700 (PDT)
Message-ID: <6604612b.050a0220.23bac.7d18@mx.google.com>
Date: Wed, 27 Mar 2024 11:10:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4037168997154763759=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Remove POLLOUT check before bcast defer accept
In-Reply-To: <20240327161019.3078-2-iulia.tanasescu@nxp.com>
References: <20240327161019.3078-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4037168997154763759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=838961

---Test result---

Test Summary:
CheckPatch                    PASS      0.90 seconds
GitLint                       PASS      0.61 seconds
BuildEll                      PASS      24.41 seconds
BluezMake                     PASS      1708.45 seconds
MakeCheck                     PASS      12.78 seconds
MakeDistcheck                 PASS      180.35 seconds
CheckValgrind                 PASS      245.99 seconds
CheckSmatch                   PASS      362.14 seconds
bluezmakeextell               PASS      120.19 seconds
IncrementalBuild              PASS      3072.32 seconds
ScanBuild                     PASS      1022.92 seconds



---
Regards,
Linux Bluetooth


--===============4037168997154763759==--
