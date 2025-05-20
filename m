Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF8535893
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757040; cv=none; b=iP9KDZ6FAMQpdLmLUuxbwRg/JvOVYY7gpNDczS/SrcFMhzLZEZYOjOGOIuRpNHLQ/hPU7FxT5OhaSn2ZTmFS1M/srvNOUHxH7mvhjL3du4xuJ6WZNBcPvqPBp6FFduB5RobfwLzHM1SBeTxZLLd5sbGbJj4H92vgD7e8N0GypLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757040; c=relaxed/simple;
	bh=orYdAdXzf2VYaa8lleGzeS1PDplmn9ZAMkw5rPEM11s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2DYl6qHTVsIbCWEMl2VdewscdYHXB2bCJ/k070gFIeuP7lqA81sHNbuTwOL0GveKm/PPBs2b7URnkuQXViXbPR5yqIwsAoWnBHsGtHPC99HV7kro/5jC6xkSlHN3KFsJaq85vYgWTsc//jc/O01IC6CIKjh/An4NJLk/cK7h8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dm6SaBUe; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm6SaBUe"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32909637624so34864651fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 09:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747757037; x=1748361837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orYdAdXzf2VYaa8lleGzeS1PDplmn9ZAMkw5rPEM11s=;
        b=dm6SaBUe6u6bBM7vcHn4uVsEd40gTlzPKFr0V7uJkvJuIpCzlBK3OxKiE39k9BAb/4
         7h5rv02WKeRXasbAo7BncOb+D38TaMzbOwce+uh8yc5A2b1arV2nVMVweN3kCacMGWje
         LYZ/h8mm0AjjppDIQwdgPD+QCgKcGX/kXxgFX1WspXkjbg7GcnsChcmkQ2yKOYfgIF1m
         nHXO6TH47igzyt9UlT2ToQpeKo+DDG0ypy7gm4jchpJm2ZBByiiC2C26S1/FzOgG+3tH
         oPt2GnTR3SdlPYkG8YKmTjLtnptDcpxNOIbaN5pQe1Ik8W/Ps7nykzgVAqrXJ8xUnKVn
         uqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747757037; x=1748361837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orYdAdXzf2VYaa8lleGzeS1PDplmn9ZAMkw5rPEM11s=;
        b=Qkshfg28Ixy2P2hnkEkKtBTql4V2jTVjQN+ftUlwFGcjKeA0+UuCXlN4nej+O2FlaY
         gJG/dfGi2bHr7mMlKUVoEduO0v+b6iBQwQOJKiwQEUwq3tcL/xgXAwPGJ1W4WXEzdugN
         B3N0bWIZW+yj7Oz7PdHFE2kt1hdc3puDVpI3p0qox3KvfZPy3fN7BoetBe7EawcJSL5t
         Ei90y0mYNP7bKt28J/ntb1W7MnMziCZL8+S31RHoYGwOcVUJZ12RA/PwjAXS7QeMH6h6
         W56U7HR6U3w6Aj3Eod6KUxXfr4lzPrI620uYJagsr7sJv6CNJn8TZSxaZ+TAamgQA/mr
         0VDA==
X-Forwarded-Encrypted: i=1; AJvYcCXfabUkr5T8mlXsFig+H2rAci26GmcbZLa8ezJASFBmQGudOBJT8W+Z0ke6moIrVrk/csCfQzEF+lEkVnULAao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSiZ2YqyAyArLZN1VUladP6EJjsBufQDSJ7LsrRe2QoN/MW9Wr
	821ioSHENzZas8wlKUnf1wgv2EE/39lR3mDNIBB2uk4AJntudUKSJT3MDJafyXgZz2qNSYs/qBo
	kU9+tNXaB8HCDPf+1jlggQn32nf8a9J8=
X-Gm-Gg: ASbGncvzjMqwmZYBJMxO30UjjW0HXiDv+MT95LPRkUEu9nDYHnzOitPJFQlKtIuR0CE
	l4LKyvR4qnRxUIiaVogqsJnHblLQ3U/6Nxr42BS2c3ZCcxTbNd7nqMSzav+zWfRokbvbYmrgg0h
	4M9yA9FGSeoL8mnAGZgV20jwDqD01SS+jz9fAwDnoUWg==
X-Google-Smtp-Source: AGHT+IEB4ijydSukWa3QPKfMkL+Zqn5Pz6YMrkd+gFeVoWQZTY2DyOCbken0TEFW/rCXyF32NvG2Z8b9HUBSt2pRNkU=
X-Received: by 2002:a05:651c:146f:b0:329:1802:2cc7 with SMTP id
 38308e7fff4ca-3291802310fmr27428661fa.38.1747757036760; Tue, 20 May 2025
 09:03:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZLJGwmPSe9Me+OLpr8WLGOenRrwJt_JxVmWfPO_X1YWJg@mail.gmail.com>
 <20250520144935.595774-1-dmantipov@yandex.ru> <CABBYNZ+i56pg+Rs=mu8HvJ1LC+aeyDAt7=pYJ3ksNOrehj0ZUQ@mail.gmail.com>
 <624a7fcd-1e25-4cd9-9e6b-b2315905bb2e@yandex.ru>
In-Reply-To: <624a7fcd-1e25-4cd9-9e6b-b2315905bb2e@yandex.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 20 May 2025 12:03:41 -0400
X-Gm-Features: AX0GCFs0ArdXx71zZdKvlU1DCPAyhsayubCcLANjVTVtIia2MyVDdkGnM0gTTZI
Message-ID: <CABBYNZ+nu69A5GN=VTH-jB-0mVjNihMFT=hHQmDiNrZXnEVwEw@mail.gmail.com>
Subject: Re: [PATCH RFC] Bluetooth: use RCU-protected list to process mgmt commands
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Tue, May 20, 2025 at 11:45=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.r=
u> wrote:
>
> On 5/20/25 6:31 PM, Luiz Augusto von Dentz wrote:
>
> > I'm afraid you were not looking into other places of the code
> > regarding this, what you should have done is:
> >
> > list_del_rcu
> > synchronize_rcu
> > free
> >
> > synchronize_rcu will wait the threads holding rcu_read_lock so by the
> > time it returns we can proceed to free because all existing readers
> > should be done already and if in the meantime another thread attempts
> > to iterate in the list that shall already been update given that
> > list_del_rcu has updated the list.
>
> Got your point. OTOH 'mgmt_pending' may be currently altered by both
> mgmt_pending_add() and mgmt_pending_remove(), and they may be called
> from the different threads at the same time. If so, there are two
> concurrent writers, and the whole thing requires an extra synchronization
> beyond the one provided by RCU primitives. Am I missing something?

Afaik that is no different to hci_chan_create/hci_chan_del, and other
versions, which don't seem to have any problems with and they have
been around for quite a while, I assume that is because of the usage
of synchronize_rcu.

> Dmitry
>


--=20
Luiz Augusto von Dentz
