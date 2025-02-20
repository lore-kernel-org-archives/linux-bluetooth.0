Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CFDDF58
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068732; cv=none; b=ZmwRYNQLehmzRDYIVancBIWXf7+vMuBerLNgBaKZTTwiAVtjalfsyJ72At1ugT+30ACaPMsr2LWjmr2Ok57Yp38v4mTVwHzg8LOwyn2N+gi1mN/5cVre2uju5kXIGv6yh5oua73wjt4tDfCqqHpEH20jd5pnMzu7i8tFB5JsJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068732; c=relaxed/simple;
	bh=0hrbesVQCyc9525tqh8U3KpwK3Emtb1aMRgsr+/k92c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r198dFPszqg090CeVeBW6tWauen2C5O9LojkSu5fDLlUCf/QXL0i7uGnZhiZAyZ+9XVm0H7tIz57uizFcDthXVzeCI4vhfx1P4BWClNuex8vzZwsmrT1/N24dflTVpN9XDyC5JbEn2U7hMXhfxeXP/t+z522FozPprcoKxqqsUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaygH8lm; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaygH8lm"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30a2f240156so10912171fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 08:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740068727; x=1740673527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hC3D92ka1zNLym3xoUQa+b2mLOeVK/XCr8x821I4cEE=;
        b=EaygH8lmoeRnr9yTLxh6O6Iw8snRJLjGVjMReKTc7feXPsMQC28JlJa2RRHspXYo+q
         HbunuIT7YdHiMGwIW7zk7zNzqRJnZzOCpFxAJ1zdnBgk83x/c1ioUtMrkFJFoThgd6Wv
         TIkXGTe/oagiJmJW6ske8UVO0UE3md+i2zZWDNt2TK2pRZS/xRMnN4tHzfIytVOXf4au
         DluDHVqVB5Ct6MGQTmci3xs+CnFaGOf2abDrzjB0NCJ8yNWb7rVrgBmMmMslT4e8+9dH
         izhZmA1+6bNdhmJ3QutDKFp4sfdf8pzZnyoyHfW1FQTnxE69DMx5diFTCRenIpE7EGkB
         syPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068727; x=1740673527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hC3D92ka1zNLym3xoUQa+b2mLOeVK/XCr8x821I4cEE=;
        b=an2z71kPVi4p91w/a95OU9RN63qU4WvrThtT/nrHUJEQ/yv8BPROwy4UWdf/t+OPSj
         1lQ1P1Q8t3YJbdxGNNSfhi7b9cNHQ1kuyinN4W6L71BjLrB9povttAzq1g70ieM6CutS
         4CryR0u9jY2pRqjh0zGjaYcN36Pu12rAfaov9HtwOFv6LvxZkYtOwhQ0hU1fzEO64/kR
         ky+dzUTXP8q/8C1Y+5mZAZJRgtB45J6ykP2Spu9WPRoi9Yy0JLaMrMwvY+OpfAMc8+cG
         k0+6iObljitNUMa6gEGA/2kQS6Dt6O7G304RJhFiJRwgv3KVjznL06s5WoKVLmF4vXXH
         r/2g==
X-Gm-Message-State: AOJu0YynsQx7K4hpE2en+q94fjLm+047nxQJFw063lha+lL0SmFSQUoo
	qZdJmFOeMdiTJ85QcQNb9JTmeJbD1L8d0YRt1BOEmNj9T+xCxSF6PotA3sJJBqhjlRfR4nU3cVt
	gNgZ8ZfJdb9TP35LqlJLmKUceRm7XUCfP
X-Gm-Gg: ASbGncujZ1oE8KrU8nJ6ouTSt5HetIt2bUgh1x2ohBlHXDqNDu5bBH6IzZWodZET/Q4
	651DoHifEMhgLmVhnSgN9Xki5K/a7u2lKbpgrzGoJgije+sITodMkrlM+L6LVwlaJTPNfK6I=
X-Google-Smtp-Source: AGHT+IEyDJU0GiBNfBA1uEWwoaqfcgZcHKo75WAzZ4kkTgzbIoRxJ6aAnuDXU5FSdemi3dzIyHd0aw9NoP8E8mICUVw=
X-Received: by 2002:a05:651c:b24:b0:30a:4484:3ee4 with SMTP id
 38308e7fff4ca-30a45043d8amr34470491fa.23.1740068726621; Thu, 20 Feb 2025
 08:25:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219215352.15605-1-nishiyama.pedro@gmail.com>
In-Reply-To: <20250219215352.15605-1-nishiyama.pedro@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 20 Feb 2025 11:25:13 -0500
X-Gm-Features: AWEUYZk3l9l0V5hUtd-jzPvgAEd7v3d3WrJx6oUNeVabYuikJmprqmg_vDF6BfI
Message-ID: <CABBYNZK-c1S=t+4U0e14=1a8+=M2Ww4-G50TH6i12=UzM-6AuA@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: btusb: Fix regression in the initialization of
 fake Bluetooth controllers
To: Pedro Nishiyama <nishiyama.pedro@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pedro,

On Wed, Feb 19, 2025 at 4:54=E2=80=AFPM Pedro Nishiyama
<nishiyama.pedro@gmail.com> wrote:
>
> Set HCI_OP_READ_VOICE_SETTING and HCI_OP_READ_PAGE_SCAN_TYPE as broken.
> These features are falsely reported as supported.
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

If it is a regression it needs the Fixes tag of the change when the
regression was introduced in order to determine if it should be
backported, etc.

> Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
> ---
>  drivers/bluetooth/btusb.c   |  2 ++
>  include/net/bluetooth/hci.h | 16 ++++++++++++++++
>  net/bluetooth/hci_sync.c    |  6 ++++++
>  3 files changed, 24 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 90966dfbd278..43403b0cb5cc 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2435,6 +2435,8 @@ static int btusb_setup_csr(struct hci_dev *hdev)
>                 set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirk=
s);
>                 set_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks)=
;
>                 set_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks);
> +               set_bit(HCI_QUIRK_BROKEN_READ_VOICE_SETTING, &hdev->quirk=
s);
> +               set_bit(HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE, &hdev->quir=
ks);

Can you please split the driver specific changes from the quirks?

>                 /* Clear the reset quirk since this is not an actual
>                  * early Bluetooth 1.1 device from CSR.
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 0d51970d809f..b99818df8ee7 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -354,6 +354,22 @@ enum {
>          * during the hdev->setup vendor callback.
>          */
>         HCI_QUIRK_FIXUP_LE_EXT_ADV_REPORT_PHY,
> +
> +       /* When this quirk is set, the HCI_OP_READ_VOICE_SETTING command =
is
> +        * skipped. This is required for a subset of the CSR controller c=
lones
> +        * which erroneously claim to support it.
> +        *
> +        * This quirk must be set before hci_register_dev is called.
> +        */
> +       HCI_QUIRK_BROKEN_READ_VOICE_SETTING,
> +
> +       /* When this quirk is set, the HCI_OP_READ_PAGE_SCAN_TYPE command=
 is
> +        * skipped. This is required for a subset of the CSR controller c=
lones
> +        * which erroneously claim to support it.
> +        *
> +        * This quirk must be set before hci_register_dev is called.
> +        */
> +       HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
>  };
>
>  /* HCI device flags */
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index dd770ef5ec36..e76012956020 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3696,6 +3696,9 @@ static int hci_read_local_name_sync(struct hci_dev =
*hdev)
>  /* Read Voice Setting */
>  static int hci_read_voice_setting_sync(struct hci_dev *hdev)
>  {
> +       if (test_bit(HCI_QUIRK_BROKEN_READ_VOICE_SETTING, &hdev->quirks))
> +               return 0;
> +
>         return __hci_cmd_sync_status(hdev, HCI_OP_READ_VOICE_SETTING,
>                                      0, NULL, HCI_CMD_TIMEOUT);
>  }
> @@ -4132,6 +4135,9 @@ static int hci_read_page_scan_type_sync(struct hci_=
dev *hdev)
>         if (!(hdev->commands[13] & 0x01))
>                 return 0;
>
> +       if (test_bit(HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE, &hdev->quirks)=
)
> +               return 0;
> +
>         return __hci_cmd_sync_status(hdev, HCI_OP_READ_PAGE_SCAN_TYPE,
>                                      0, NULL, HCI_CMD_TIMEOUT);
>  }
> --
> 2.48.1
>


--=20
Luiz Augusto von Dentz
