Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE05F2135AA
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453644; cv=none; b=qiB5RrbxeNSosgGTxV37eJcSELBR8hnAiv1xC8pHyeuH2jjP0Cmyvj7YB4rmsQGmtMNG0+4F1/TKCrUCtujTQ0JbykivHXClI3XwO5AlfgcQiSrcuVKSkaVvVdpsjGdC/q6LXGQkVdgFkORpZkmQfS3Zzj7QrimNjnDVr14kkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453644; c=relaxed/simple;
	bh=1Zo/b2fnH+KRJJ+uyJsBTTf+jevAOBBplgRMa6qKklE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+SawP5FfF+NP6ybKVYrfG6OQERY/dSrPrIytCOeUj7y6fLwogUKBPzfuq4SthfZcJ7xMPbuvZtpNl5CZxivKa4weMoC4XrAzx4KR8KQawd3222YzJoGTjW4a7OikV5V8gROt/9VH6rJ1zgY5xcr2w2Io83kC4H1aKnXwUV4w20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q9zWcLC5; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q9zWcLC5"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6f9b1bc594dso8097607b3.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 05:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739453642; x=1740058442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRxuVvwSNDjMnXgRSeSCG5b6A90Xszx88z8fNg1clK0=;
        b=Q9zWcLC5MOx55iLr+RiiOPTjRTERPPm4EWn/zqn2wlrkxZnS6VXwKq1pH2VLIwFJ1r
         w5VyxYwXWSHYbEEXMf8guc0ASjNIMgR8lBkJ8ceRF5jW0ZGL10eFRYOuPNqKidKrQZ1u
         RhtYaYOyCXpGvrlO4p+AHgPB8cDGvlg6DOJ6DJLlTIwKcsUVQpMTc6Fl3gH1l+4uzOUD
         npjEhZDmLQ7gNQ0jN6adx3moD3WpPZcODqwnxcuR1FhqjuEGNvf+Jqvxh9iltVHlVm6a
         z55KGMtEOhvunWUcq3enTH+KtfxpXbvVon0pbki5rOxjpwXD5gmOvdsge+mq50Ew2qHF
         i8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739453642; x=1740058442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRxuVvwSNDjMnXgRSeSCG5b6A90Xszx88z8fNg1clK0=;
        b=X3Q81DbTQ+w5EaJgb5dzmB3u9KAZTr7cU5dpDHx8rJ9tdbpy/cQV/nWN7owkt7IDvA
         odyL6EOz0JyEL5jy0zG7munFiS1fxcq4zIH+2vhaN37P1vgarFGHwnDFHfn5DSP4QVA8
         KE+PItXqad0Lak6h0ZOEVVXVZgXXAAz6vuVt149lneS5DVtsmwyWlhXvZAPdsFo2SkXj
         6Tw1MKaA2qVpu/mdl1PS98wi6wzx3ABuMfpVwv/cstsplXlhR819gywrz05ddFhF7gpU
         lL/bZ9DNfku2dv8vsE5DdG3wIDAA7Qs17LwS3DrW2yvCWqSNK7h9vTjE77KPTERhe73R
         bp/g==
X-Forwarded-Encrypted: i=1; AJvYcCWyM7MCug+TrK02xmHJIVJLQoquIXmTuj5qyrkZ2bi8n/1ETUTYT9oLMvxbrzhMcHSz7tBXBOI9THRLd/Ai6PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXD0bho9QBJDdHimBR2HVkD/kOCQFcoPengxslJS3W+2/Mqbe4
	3uH8+4zffRtA4zoXAqtMjiCPQkskTCRkgvpMzombfIEGC8rTqCNFavX1/FAv6PH/k4JKw49qT7f
	YhMfcPkyf970Y6ba4nD9zcLwLLyFgC3ijxxHA
X-Gm-Gg: ASbGncuZIy6BEnn49PjtxOpw+9gs7nNB+YGhY0+ncbp41ijksO5pr3qUKP0e0DZesrR
	FGIk0ZzwcvHpB+dbL+0Z31RYHlTIlrasGQbfN5OTHkhfKQGqMUTYIVYYKFufdNN9pWb1fhw==
X-Google-Smtp-Source: AGHT+IF30ZkMMq8IrQ1Se84n4sKD0GvX5J7aA84qCQbXLCMSoSpfvD+rGWf1JdZYduPjA+px3O11cfkJuPs60tUkK7k=
X-Received: by 2002:a05:690c:9a05:b0:6f7:50b7:8fe0 with SMTP id
 00721157ae682-6fb1f171ef9mr76470707b3.1.1739453641740; Thu, 13 Feb 2025
 05:34:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <2025021352-dairy-whomever-f8bd@gregkh> <CADg1FFdez0OdNDPRFPFxNHL_JcKmHE6KNxnYvt4sK7i+Uw6opA@mail.gmail.com>
 <2025021347-washboard-slashed-5d08@gregkh>
In-Reply-To: <2025021347-washboard-slashed-5d08@gregkh>
From: Hsin-chen Chuang <chharry@google.com>
Date: Thu, 13 Feb 2025 21:33:34 +0800
X-Gm-Features: AWEUYZm_SnsYMtD42yF00_gIA0hMGPrnexms2cvVn9JmpgVsDbzt-5pObZIgJMo
Message-ID: <CADg1FFdbKx3z+SPWFmY4+xZmewh0MnnZp_gmYEdY0z-mxutmEw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] Bluetooth: Fix possible race with userspace of
 sysfs isoc_alt
To: Greg KH <gregkh@linuxfoundation.org>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 8:10=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
> A: No.
> Q: Should I include quotations after my reply?
>
> http://daringfireball.net/2007/07/on_top
>
> On Thu, Feb 13, 2025 at 07:57:15PM +0800, Hsin-chen Chuang wrote:
> > The btusb driver data is allocated by devm_kzalloc and is
> > automatically freed on driver detach, so I guess we don't have
> > anything to do here.
>
> What?  A struct device should NEVER be allocated with devm_kzalloc.
> That's just not going to work at all.

Noted. Perhaps that needs to be refactored together.

>
> > Or perhaps we should move btusb_disconnect's content here? Luiz, what
> > do you think?
>
> I think something is really wrong here.  Why are you adding a new struct
> device to the system?  What requires that?  What is this new device
> going to be used for?

The new device is only for exposing a new sysfs attribute.

So originally we had a device called hci_dev, indicating the
implementation of the Bluetooth HCI layer. hci_dev is directly the
child of the usb_interface (the Bluetooth chip connected through USB).
Now I would like to add an attribute for something that's not defined
in the HCI layer, but lower layer only in Bluetooth USB.
Thus we want to rephrase the structure: usb_interface -> btusb (new
device) -> hci_dev, and then we could place the new attribute in the
new device.

Basically I kept the memory management in btusb unchanged in this
patch, as the new device is only used for a new attribute.
Would you suggest we revise the memory management since we added a
device in this module?

>
> confused,
>
>
> greg k-h

--=20
Best Regards,
Hsin-chen
