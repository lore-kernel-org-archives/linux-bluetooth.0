Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB3821128A
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441698; cv=none; b=QSTFDMwPgLdjRLOJ5ugGDMazF/SChysWd9OBG1kzaRbmhVoi9lGPVj8/6aoZN8VgF+mQt1I+c3hpAXfE7rLvaitT8w+IydGGn5kRTJNDg0aJEizeWkt7hsgAOAdeI/UMD2FpUDlLeJr3anSliBsjTEoNGfBnqr5/moNeiytwBp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441698; c=relaxed/simple;
	bh=0JHLjjH3wN3gKoNMAITUlA/dbwq1/cIECi2PiVJ/tcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNghVzS85O9Tp0tTE1lcNGfZP35D9K824yr5OiIWrPHk5re/L6jsss0rzHCFWckKlHsfG62ulJFg3w/2h0B7oL07TeBZQPdhAhoJqD1+aA6dAmQkPtAh5EIFmglVOyQjs0VJeLSdKS/zk/3npQXAD5OIuWwko+FbuhGX+7sf25M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+ge+sL5; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+ge+sL5"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e46ebe19489so492868276.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 02:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739441695; x=1740046495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1eVK89bhCPbjzPBOHZGvUXIBLjSrcJ0fLGshOR9gD0=;
        b=k+ge+sL5s+NtgrMD78bbbpj0c5kdlf3CEXSXixkz6hFKa5mgmkKiD/gGgWOGF1UHQd
         WM014bIJkqZ+UXdyzrCZ2E5pU5eZwChPNwYBINS4leYjTzdohJOoWrrenqVspQEJ6aAO
         hEo43dCFlzVmG2ci61UOCexZsT6lCMBEb2OtmHpjcy9xn53JSkFyuyZnI4UqskIL0y9V
         T8SlA8pwS/XNpf+e8iX0Z6zwTdQYZXqiCdnFlw1IZOnj1xe9L5cGcKxkdAmuroYQl9Vb
         7KQ0KtNeLNbMn5ZGzeM/4/KARbtwN8MGe/hdTG9cMPlZv3H0CE4FMD13ADaOUQ4LX1HY
         nLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739441695; x=1740046495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1eVK89bhCPbjzPBOHZGvUXIBLjSrcJ0fLGshOR9gD0=;
        b=fGa1nVMGuL2h9RY9409WdWn7aDumZU6FAg1vCFmxRWA6iIPY5r6Zy5wnV0mAyfdQuK
         /gWlv3s/wPECdsziExQmbk+DTC4gSGsUZWhplMirOdxIjl/x0tsKWwjfGoYfjnYqkLqR
         ImFCrSdxVtqk9XN/+Sg5Rk91DuGWmfpoVKw5BQTF1CFMbZDs0O97R643WTJsDJV0A6Da
         0V18s2RgN3d60U88G8dmrS2uyzadxzIdblpnaxvMCxchNmBzThG5HUy4GP/bmI1IkHqa
         priVNKZKE0pUOAYPy6WZ1N67S8u7QxIqKrTKqkzkOXRdsr39CZyHaQg2H0wHklRU1uRg
         aT1Q==
X-Gm-Message-State: AOJu0YyUABeq0oVXfug0iM5tx1E4yviO5Mg+POjDeu3chuShjPaHGMTr
	nZk5xP69DWOvk1ZaT+nf9MYKSW0hnpJbS/J1PLSi0LrtNH+QV+8bdhmCSadne93dab9SaYTogbk
	TEdhzgQh1KLf0pjDdLfDc/IwJZUF7yehjJkZw
X-Gm-Gg: ASbGncvgQGMZOiaEZvuOYX2KOu+aIW/4brPq61XTfR5kP7u1f9vGe7jC9qsP8FlGFNs
	8NrUrcZdqhdgAVCrPoe2izWTDGqjxP2M4b3LmEsHba7eDAZWftnBtx/olR6qg8KzIB97wyoEmGA
	==
X-Google-Smtp-Source: AGHT+IHPKl+ezhAUg4Kb41lGAKIH6dhZQultCWWIoAFnUW2zUViDxbcSm4BXT5TxbZk5VxwC8YkftKBAy5cgosM/gUE=
X-Received: by 2002:a05:6902:11c7:b0:e48:5b35:af2e with SMTP id
 3f1490d57ef6-e5d9f171fe3mr6630880276.33.1739441695278; Thu, 13 Feb 2025
 02:14:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <20250213034413.3808375-1-chharry@google.com> <2025021325-faction-upward-6395@gregkh>
 <CADg1FFc9_QH10UqxGqjf8hnJkHWjhy6EMPrfDCgvBx2OdOydLg@mail.gmail.com> <2025021328-limes-hacking-2ddc@gregkh>
In-Reply-To: <2025021328-limes-hacking-2ddc@gregkh>
From: Hsin-chen Chuang <chharry@google.com>
Date: Thu, 13 Feb 2025 18:14:27 +0800
X-Gm-Features: AWEUYZlfSGjZxS6z-uKid1N6mQEJpV4pvRzs3n_reJDY3tni8vqfLbrjLm6V2fQ
Message-ID: <CADg1FFc4XRc1fqYZj_J6xq0nBQFRLqyAsFhf1Pt0JNr8mizjjQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] Bluetooth: Add ABI doc for sysfs isoc_alt
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got it. Thanks for the feedback

On Thu, Feb 13, 2025 at 6:13=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Feb 13, 2025 at 06:07:59PM +0800, Hsin-chen Chuang wrote:
> > On Thu, Feb 13, 2025 at 6:01=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Thu, Feb 13, 2025 at 11:44:01AM +0800, Hsin-chen Chuang wrote:
> > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > >
> > > > The functionality was completed in commit c04f2e4f4ea1 ("Bluetooth:=
 Fix
> > > > possible race with userspace of sysfs isoc_alt")
> > > >
> > > > Fixes: c04f2e4f4ea1 ("Bluetooth: Fix possible race with userspace o=
f sysfs isoc_alt")
> > >
> > > Where is this git id?  I don't see it in linux-next, are you sure it =
is
> > > correct?
> >
> > This hash is the first patch of this series.
>
> That's not a valid git id as it only exists on your local system and no
> where else :(
>
> > So I guess I should send this patch after the ancestors are all
> > applied then.
>
> Or better yet, include the api addition as part of the patch that
> actually adds the new api.
>
> thanks,
>
> greg k-h
