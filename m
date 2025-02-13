Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD01D206F31
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441309; cv=none; b=SC/C6yI0rtWL0TfrLLJLJ65dFmAUK3GcQquJ4IH+Ckw0UZ0YM8oizTsd+rJEbwYTPIu/qX2WKbp3c4J3y3MSRaS8fwIH9hQMLCY4sr1Pn5Vj6FfXBMO3qMsuxvq+yuHDlOJg5NXP5K7I5PpY2f+wsvMEcer9aR3sIR2/c/v1XME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441309; c=relaxed/simple;
	bh=MPp5OyNG8huFeTnYvXndU5Mwduu7zQqNOU5UvvAsCkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDp0fx4GLhryPVbH4IncyvDyAl+09kuDJX7Ry5CveY6z1pvz0xQMfFE0CywToXGRRLi1cZSENi1HhZjDEyxRR+bx86H8TAWhX4Ck5PALBlsUXPN7Zn+k1LPl3tIYD2k4/K72qmAimWaGMOleaf+CkUwg138rBlwy4iwWLuBkGTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QikCWkuh; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QikCWkuh"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e5db2d767f2so215788276.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 02:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739441307; x=1740046107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lwzp97aD2QWWDIwey7i2KBlb6xs1j2oYUuVqrLaH8/Q=;
        b=QikCWkuhm0qdcLNebI4nTy4kTbUCqYS6jXhcgbpuP/D5qt93N41mz4VW1ADk8GbQJ5
         V/7GyKmGZzcUjj2N42zrb/FlmRVwynCz1bQ5DmdXsd3wziV0YbofQ/YfRl/kw7E0U/g7
         ZveXwp5ZLsBv6BNiFS6ZWeeYQ6pvPxgnrHXZeX6pe4PuboDZsWsqzDpzYf80BqJUoNXW
         /VmkrnSDYJ7huSq2Qo+EvgCYA+bYWAsYIox6yAdhGALaqLCxj0MyVpWsz5lfk4xHTtPp
         1F7qccXvMtZcJTeol4ilrhhoF35J8pT0Oucasm9aqbmUlDUfcW/pmZpA4Zp++FJmf0Bu
         KHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739441307; x=1740046107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lwzp97aD2QWWDIwey7i2KBlb6xs1j2oYUuVqrLaH8/Q=;
        b=UKBpYzEc2RNMZTAAlLiH54jAgPrUdvuHYpG4nnXP6RB7DfePtYMKEOAQNOUnAemwGo
         46HLDZUuGlD14zByw3jhEs6NZoIORnMbIZvivA9asmAF1MQ7Cg4nkLjKGTOhb+eleFa6
         /+fBJUIuvU257ZoPVhimNJt3t9BEZypFWjqNNIImf+Pslj7kz5lTXj1fcG3z5tB4t+ke
         BLNrcLb37+kCquj/uuyeThjLNB5gfmKOE4GU5r3soXIE0vysQwNQ7JduVennU6KL8JNo
         gk2xGiZ6vuFtgQb7W1e/jNkRIXmfxuf+vNvGWMbNsw2jv6q3IJW71Ne9esQqypLJd3Xe
         67Tw==
X-Gm-Message-State: AOJu0YwagEv6NKMQGg5nPKOygYreUJ5POHch6HeasQEXY/ivauoJj3K1
	h+j5vcMtlWpuJjfu1e0e6Lc2wi1HP3dkx0KDaJBm/u76cpg8ecISEXQ9GbIQwSRw+mjrFQkuscW
	7/bGbk3EyUUMhZcPfeaA/xfBiay7T2Hz37Va7
X-Gm-Gg: ASbGncupARWTYLFMFQLHayv590yRcAanc/Dc+1w77utTaMzhF6nIq5HXc/pSUr8zkDF
	FUhjtbgWs2tJ0Yj/I6xBtfTeUFTo72wHMt+MT4w9jQOebqLswgN53vvPph4y2vwURCkpOFPkhow
	==
X-Google-Smtp-Source: AGHT+IGy4AJIYMekfNAzT8Z669VTj2mjB/mXyVh8a7WY2PmXyOtQ1vdxc4L5aI9AOjbt6SKGda4JhxZUJ0EYYviQToQ=
X-Received: by 2002:a05:6902:1b0a:b0:e5b:2472:f4dc with SMTP id
 3f1490d57ef6-e5d9f12cfebmr6415584276.29.1739441306723; Thu, 13 Feb 2025
 02:08:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <20250213034413.3808375-1-chharry@google.com> <2025021325-faction-upward-6395@gregkh>
In-Reply-To: <2025021325-faction-upward-6395@gregkh>
From: Hsin-chen Chuang <chharry@google.com>
Date: Thu, 13 Feb 2025 18:07:59 +0800
X-Gm-Features: AWEUYZk_Ij80igDm-p1nzK0NlpnpJH5yG0GRLFkOsZRlsL3i7fgedcKSuNj0Q00
Message-ID: <CADg1FFc9_QH10UqxGqjf8hnJkHWjhy6EMPrfDCgvBx2OdOydLg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] Bluetooth: Add ABI doc for sysfs isoc_alt
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 6:01=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Feb 13, 2025 at 11:44:01AM +0800, Hsin-chen Chuang wrote:
> > From: Hsin-chen Chuang <chharry@chromium.org>
> >
> > The functionality was completed in commit c04f2e4f4ea1 ("Bluetooth: Fix
> > possible race with userspace of sysfs isoc_alt")
> >
> > Fixes: c04f2e4f4ea1 ("Bluetooth: Fix possible race with userspace of sy=
sfs isoc_alt")
>
> Where is this git id?  I don't see it in linux-next, are you sure it is
> correct?

This hash is the first patch of this series. So I guess I should send
this patch after the ancestors are all applied then.

>
> thanks,
>
> greg k-h

--=20
Best Regards,
Hsin-chen
