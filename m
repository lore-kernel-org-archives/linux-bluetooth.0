Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B973FEB32
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364506; cv=pass; b=exJlmO8t6X43CPjXdmEjy4KNhimIcNBE/hhAeefFS2hF4I6uIywO0txb7VbRmm2ZdGokdHTw4b9j3SXrQ+E/aovBja2GYurP0gHKggz3ggoxXGlIEo/RmYQKXcJJozPJtVL7qW74kFRWETJG8pAEC28G6VfnwEc++9UULZV9a1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364506; c=relaxed/simple;
	bh=5X5ikEUkrLr3W+elU/oKtWc8p5BK55vXpcxRrxxvmd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwaaVe4/smscoTVWdDMbrdWMs6jgnIZ+bX+nYgIFfEPVTlXbmCraquPHcUID9Rb0taPESmX5gYKxq1rAHZyBGwXyAQRL0ZV6oojuNcVChKkW/N0zfDEWz12gwe1HFRYWUsmcMXUq2WA8sVn7auP4TIlBJ+97ktG+6L+FKuCTpzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUKDWsVv; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUKDWsVv"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79801df3e42so70895187b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 08:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774364504; cv=none;
        d=google.com; s=arc-20240605;
        b=OcM9Dr1uTyZbTKACbtjLDihr7bqcBCwbYXAhpqrum7H8CX0AdJb6m+3C7ke14RBhWu
         SC0gg9ZNKYXYzXhsa45DoJe7qslGO06mC+UUF80hIvb9SXLvQ8zVIiPB2gEu3IgKA2L4
         HC2AXUKw5h2BWz0AzDQvNc8WQ5+NSzyrzA4kOH+uPHmKXmE4r6e45UiedKutigbIAsq5
         8G0VN1haHbZEsylTitWxlcgncxjZFPZvflrSDNxWC/4FWvBzs6ms++iVGgD98NVbJxFM
         kNCeJImoaVVjg/9+EgSFGxZZWLxWZs0L8tqSESGWLqIy40QRqiuhTxnkwkyXb9AgwNoc
         HHEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jab7Qyi3sjxcOLHZMHGnaQCm701Nu3r0Qqe7p8/jOXU=;
        fh=LfkRTB89bk5cFCtllE11lDFqEUL67hyTdOY0lk17lvQ=;
        b=i43bINau5FBDUMj7Mp1SYGByU49mYJQbJdL+CkQG8aQOFmGgkrngXgGsMbeBaHt6TL
         O3MwHrIWYbzDvmSiEaOwQMOMiEhdghiBqpW4o6+w8zS7itCy5Rnk6zI5GykUOnbHnIYQ
         5sESSryPoCYAwpThTCPxA7q50gMk8GWMLx7Cxt+CSfJiq97spaONZMt7Sjp4QCe9ldAt
         vkpRRcb1mz0jpVq7EG/WXWnSPVEJggMYoRafp+Uyf7qgYUtwLNb5UjoSsijx5x/sWrnf
         tam++C/ZYICRVWF8TFwObdk/yBn4pAphsBTNN8VCwVdqtRMc3Mru9k3DBOsNCF7MMZEL
         ZOMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774364504; x=1774969304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jab7Qyi3sjxcOLHZMHGnaQCm701Nu3r0Qqe7p8/jOXU=;
        b=DUKDWsVv0Smug5azT70bREYYsnvvWhHIc1w34Dn5cgUW7AeBGQZm4K3CPQhsuVMNkf
         OMtm3dpIPzl66ZEwbiRwRKKO/l/8OgI4HqLeNJPLPlCW9ekDeaK7NRU1hFKnHV24C5aP
         OxMX7R7L5ueL8rMu6aPSk2mjLqdqQpDfeskbAfnIUNyF4WFLSsBLZJEMJ4lMAFgl6LvM
         B+cJPsfqe1TgXmwDE+P6WeBBPXaClJEc0cBoJODNU/bPvLELEswAxD3ESVp+EjRkxZel
         yqx/Niw2T7GvIJYa7FEPcz8PSRlQLYVjtEL3UPljjMZSEY60QifsWtdmmBjDp8pWAnry
         DSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364504; x=1774969304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jab7Qyi3sjxcOLHZMHGnaQCm701Nu3r0Qqe7p8/jOXU=;
        b=IP6p4UCUFMUXdyGf08bMyZnrDtNUDWnPfEJpUH0CI+uRxuEaqf1Verlfdlzzdrx9n3
         S+3cN6azzGrmWwydzOgUek3f3GeBCz5e7rDZ/Fq5dHA9k+zu0pz2Tkeq8i1jhCL3K6rb
         THLjQFFIHul4lrfWScZLfOfaoecaixCtFhCFVaq3xVj9SXom2r/eqOOAWBNXh82AfsuV
         APbTRPuh1SogRJ2Jrxvm5uLRqkmCak8bM+P98oJjVP7T2mEmqhKThFMr4Is07BniYJsC
         MoPMY+/QcxvU4SoVyXAqoZLMytH94DieelICSt5OE9/SuH/X2B5eLW+PdFy4beq5xKyD
         XSjg==
X-Forwarded-Encrypted: i=1; AJvYcCVJIJ2j5Wmfq35U245cUOFCQIvf5DJo/bzXYA1rPXEPWqLadXBOFARLpykWOk+U5riSNZTIKZQ0LmoPH16FtzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGlNowh6AEg6HfFRL/ffa8u6e3od//SZd6Hx0z8a9AQYJLJsBV
	1JdNOCVyH5dHo5LX5D6ApSOsWBI0Ox6nv1bD7h0JCcCp2xu9ypHqi88gSKjXjUYSFu5+TuU8Oxd
	IWIoxN62FlJx8WygXezKmZ4JrR/HtiZY=
X-Gm-Gg: ATEYQzzQ9x68YPQ391PU2xJLi2WFle5xaNj6GTDdc/iexwaUWo7j2gcJBSgFSGO7LyM
	UJ5iZ7MGrUW4/jR7d7ZyO9mmiRxA/SlRcsypzT4bhcKv4RYsPAHKuRxdxfF7jaS6yCXMQ+Db4sx
	GHczvHpoBr/EQzftKmUJy33FCb2jWHzi3sQUPT9r1uaMtRDMakI3guY58GKCz6QvR5RGZj1RXdh
	qhI3jqGz6R+4o/Bf4RybYn8LXpHypvXT+KYxnneAt8UNudq+hIs3WM6X6W/IDifhm7ujY8upoBT
	Jml8OxTl4Ud/kxVOclT8CLnkPBFHp1M4twIl7N24ZNe+zDzGXQzzWHVD1FSrkGzJOUM=
X-Received: by 2002:a05:690c:6907:b0:79a:31ca:6663 with SMTP id
 00721157ae682-79ac2f6abdamr35480677b3.28.1774364502533; Tue, 24 Mar 2026
 08:01:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320-hci-init-fix-v1-1-e1960a41baf2@axis.com>
 <CABBYNZKkK-SU51kjexh0uKx0N9m-63dZf0vnGA3c5LsSkmFPOg@mail.gmail.com> <d118906b-6a94-41d8-9d2a-74bddc0fd81f@axis.com>
In-Reply-To: <d118906b-6a94-41d8-9d2a-74bddc0fd81f@axis.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Mar 2026 11:01:29 -0400
X-Gm-Features: AaiRm53-TOyfFTbZU_LiYJWXUQXPif73PSC-DRNgGmN7_REs6v7O2jMffcuIoh4
Message-ID: <CABBYNZJM52cNsje2eS85gnKvf9sAfp-RF7TwA4-OyXkr9YvhRA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_h4: Fix race during initialization
To: Jonathan Rissanen <jonathan.rissanen@axis.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@axis.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Tue, Mar 24, 2026 at 6:04=E2=80=AFAM Jonathan Rissanen
<jonathan.rissanen@axis.com> wrote:
>
> Hello Luiz,
>
> On 3/20/26 21:04, Luiz Augusto von Dentz wrote:
> > [You don't often get email from luiz.dentz@gmail.com. Learn why this is=
 important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Hi Jonathan,
> >
> > On Fri, Mar 20, 2026 at 8:10=E2=80=AFAM Jonathan Rissanen
> > <jonathan.rissanen@axis.com> wrote:
> >>
> >> Commit 5df5dafc171b ("Bluetooth: hci_uart: Fix another race during
> >> initialization") fixed a race for hci commands sent during initializat=
ion.
> >> However, there is still a race that happens if an hci event from one o=
f
> >> these commands is received before HCI_UART_REGISTERED has been set at
> >> the end of hci_uart_register_dev(). The event will be ignored which
> >> causes the command to fail with a timeout in the log:
> >>
> >> "Bluetooth: hci0: command 0x1003 tx timeout"
> >>
> >> This is because the hci event receive path (hci_uart_tty_receive ->
> >> h4_recv) requires HCI_UART_REGISTERED to be set in h4_recv(), while th=
e
> >> hci command transmit path (hci_uart_send_frame -> h4_enqueue) only
> >> requires HCI_UART_PROTO_INIT to be set in hci_uart_send_frame().
> >>
> >> The check for HCI_UART_REGISTERED was originally added in commit
> >> c2578202919a ("Bluetooth: Fix H4 crash from incoming UART packets")
> >> to fix a crash caused by hu->hdev being null dereferenced. That can no
> >> longer happen: once HCI_UART_PROTO_INIT is set in hci_uart_register_de=
v()
> >> all pointers (hu, hu->priv and hu->hdev) are valid, and
> >> hci_uart_tty_receive() already calls h4_recv() on HCI_UART_PROTO_INIT
> >> or HCI_UART_PROTO_READY.
> >>
> >> Remove the check for HCI_UART_REGISTERED in h4_recv() to fix the race
> >> condition.
> >>
> >> Signed-off-by: Jonathan Rissanen <jonathan.rissanen@axis.com>
> >> ---
> >>   drivers/bluetooth/hci_h4.c | 3 ---
> >>   1 file changed, 3 deletions(-)
> >>
> >> diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
> >> index ec017df8572c..1e9e2cad9ddf 100644
> >> --- a/drivers/bluetooth/hci_h4.c
> >> +++ b/drivers/bluetooth/hci_h4.c
> >> @@ -109,9 +109,6 @@ static int h4_recv(struct hci_uart *hu, const void=
 *data, int count)
> >>   {
> >>          struct h4_struct *h4 =3D hu->priv;
> >>
> >> -       if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
> >> -               return -EUNATCH;
> >> -
> >>          h4->rx_skb =3D h4_recv_buf(hu, h4->rx_skb, data, count,
> >>                                   h4_recv_pkts, ARRAY_SIZE(h4_recv_pkt=
s));
> >>          if (IS_ERR(h4->rx_skb)) {
> >>
> >> ---
> >
> > There is some interesting comments on:
> >
> > https://sashiko.dev/#/patchset/20260320-hci-init-fix-v1-1-e1960a41baf2%=
40axis.com
>
> I see. Yeah there seem to be some valid comments:
>
> > If hci_register_dev() fails, the error path calls hu->proto->close(hu)
> > which frees the protocol-private data in hu->priv and sets it to NULL.
> > However, the error path fails to clear the HCI_UART_PROTO_INIT flag.
>
> I think regardless of this patch it makes sense to clear
> HCI_UART_PROTO_INIT if hci_register_dev() fails, since we're no longer
> in the initializing state. It becomes more important with this patch
> since it will lead to a null pointer dereference if h4_recv() is called
> after hci_register_dev() fails.
>
> > Additionally, since hci_uart_register_dev() is called without holding t=
he
> > write-side of hu->proto_lock, can concurrent incoming UART data during
> > the failure window trigger a use-after-free while hu->priv is actively
> > being freed by h4_close()?
>
> I believe adding a write lock and clearing the bit would solve these issu=
es:
>
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.=
c
> index 2b28515de92c..5455990ab211 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -692,6 +692,9 @@ static int hci_uart_register_dev(struct hci_uart *hu)
>
>         if (hci_register_dev(hdev) < 0) {
>                 BT_ERR("Can't register HCI device");
> +               percpu_down_write(&hu->proto_lock);
> +               clear_bit(HCI_UART_PROTO_INIT, &hu->flags);
> +               percpu_up_write(&hu->proto_lock);
>                 hu->proto->close(hu);
>                 hu->hdev =3D NULL;
>                 hci_free_dev(hdev);

LGTM

>
>
> > It seems the issues pointed out there are unrelated to this change,
> > but I guess it is worth double checking just in case.
>
> I think it's best to fix it before applying this change as it can cause
> null pointer dereference in error path. I can send a new patchset with
> the fix.

Please do.

>
> --
> Best regards, Jonathan



--=20
Luiz Augusto von Dentz
