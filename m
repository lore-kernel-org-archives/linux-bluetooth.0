Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B60E1C27
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jun 2025 00:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749945722; cv=none; b=qD5xAg9ANcijLbLCg09paYVDJ9MS3fpb/JH2J7lrE9Ne7uPGJL1feVPTRkcuUnNXEaPqVwbWcZlqB+Rhz1BxSua04Q2OUCnHzH6N9E0iViQbiafmYm1qLy/kt1znm/WGeaxuGYuETVIsmR4f69IQJgtFcozTn25jzIt2ZGcinis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749945722; c=relaxed/simple;
	bh=vu+69M1W9bCA1VawEfeC9yqTwoFw9deSRFO7WfW+AmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0ac16sPUCTiqfupiv7kwPEWBlLx5pLhpUz0kNeD7fhScHYdgfe9FDAbvteXE/R8l8cRbP4dBFNznh7Jk43MBv0Jx8VJM++Vy6YdyGL820tsfqTjTX68hptBl6fXO5FJw9OqojPZJT9Azt19+7Xtx53aFBb0YpKLyPr26JuMsVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCxlV4bi; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCxlV4bi"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-313a188174fso3746640a91.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Jun 2025 17:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749945720; x=1750550520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aU2AVK3YB+4TXYk1spZiZuslo1kGmNBWVIcxGXyJxw=;
        b=OCxlV4bie94orDuAMR77xhQqZ/IhhGD/wagLEtiEWVbRgpMAu1iFeF/kk2FQo+Pfos
         MdZ+ol5/eYCiRLQmH7Ao62v3uy/YNuOLqHbr/E+evLmbGHs7Dybe0j0dwKlw5Aw6ANEi
         RItQ7duhtpHiEt6KsCEqrfY3+YhJufyQOvLCtcS40wN5adNnuROBiIM9EECPdDmegHfK
         8Jx2xcFItlF42d5Iq6F+h+OQReb9gkJqpL1jcmZYpgJ+X2wms9d2AHgspaIujP8NAkg7
         hI3OlBuLRmwk1OrO35ATjCRNc7BP326e1Ra002EB5P4IMzw03gl2yj4k5wjvrHyBKAoh
         lxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749945720; x=1750550520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aU2AVK3YB+4TXYk1spZiZuslo1kGmNBWVIcxGXyJxw=;
        b=GZXK2CSVE8llmzZ5gVq5waEzLgi1nYqXspzN2fYnsfdHvJWYQM3QP0IWD+ZAwambuu
         Remrgi+iMAFOxM9tgxLuX95QOShYaDvs9ZAxEPhtZddmx373UuY6pu/Rz7Q9GSlnbJV0
         wx/+V7aVyPh2JOsmQ6hzCXgo8jdxxjLasLINFF4UfpfLIjjPvu7ZVmYjiTLC1Nn/aI/n
         EoaTyXYBGewkfAMKUVsjD4WbLrdlLiXZpyAL7V2laFV+tt+cNe3CbcVu5zPbbx4iGEtl
         WUBh2eV05aSiug62peC7jq8JMwwGNF1QjmFz0UXk2ud8/51VgbindbUFHfYEn+FFtpPr
         zwpw==
X-Forwarded-Encrypted: i=1; AJvYcCVa4iU1TvrNusGGniSHjdy1HA0PD9DvMVfXGRGYUNuwm6vr+ni2waI805GE7P3Sv4t6nPAcKhBT6C1Kfn2JiFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoEX7so52i8z7/oFSdCyxK8a6IhoL1J3QUqzImHnHGHfPW23L0
	x87pzoXWeAkeJ5DPB7wwC6hxYzQYqBaj7MH55TQiicB6m642gaUAoLc=
X-Gm-Gg: ASbGncsxYgbE9X3WSeI2eSyYiU3O6fyVmDTqjPAAZ2Yb3XNjdihJSesXGACwVXE1/oD
	zIoZ59t8AVDkJeUNYW8OfabPJ3akwF17d/F3F9PR+P0PFqOIyah7vqI3CrZiWiWF06EfTIKJ6sX
	A8Ea6pzcO9Er6hWr5+SxsRB+64rwFPZO8Lk3QhVZLkuCva/digaet3n25bmpZWLfgjk7DGEp7j+
	8qCRwcJsLn/cvOagJvaM6w3DTv2AM3ZEoxQiMDT9uWCEaLYNoMUEy1tkdAV/yAwumZJUzVFvmV7
	6gtCDl5KeRtP8RE1gF4SrDFFkx9mW5xrbU9d2ms=
X-Google-Smtp-Source: AGHT+IEvMiMloH5KoYg8qmOoTrvFoGdxncg3sx1S2u4TJ6kobapk6luTQcB/ITzr93CXPos00ikXCw==
X-Received: by 2002:a17:90b:540e:b0:311:482a:f956 with SMTP id 98e67ed59e1d1-313e9046fd9mr7227624a91.5.1749945720386;
        Sat, 14 Jun 2025 17:02:00 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1c4e4cbsm5635116a91.27.2025.06.14.17.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 17:01:59 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: pmenzel@molgen.mpg.de
Cc: david@readahead.eu,
	johan.hedberg@gmail.com,
	kuni1840@gmail.com,
	kuniyu@google.com,
	linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com
Subject: Re: [PATCH v1] bluetooth: hci_core: Fix use-after-free in vhci_flush().
Date: Sat, 14 Jun 2025 17:01:51 -0700
Message-ID: <20250615000157.2327721-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2e2edd54-4bd4-4c60-bc99-d7c183077cb5@molgen.mpg.de>
References: <2e2edd54-4bd4-4c60-bc99-d7c183077cb5@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Sat, 14 Jun 2025 07:38:11 +0200
> Dear Kuniyuki,
> 
> 
> Thank you for your patch with a well written commit message. Just a 
> minor request to remove the dot/period from the end of the commit 
> message summary.

Sure, will remove it.

> 
> Am 14.06.25 um 01:02 schrieb Kuniyuki Iwashima:
> > From: Kuniyuki Iwashima <kuniyu@google.com>
> 
> […]
> 
> Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thanks!
