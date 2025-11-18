Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E58262FFF
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475420; cv=none; b=cEihhoDc1A9PdfR3ASY+hn0r+/9ScuInH8+nYelbI5VJ4LxvcDpLj0VqB8/dtZ+StJ9qSX/FK655Jj1WGXXIobXoAPxD/4WVs94+ucBX6XtzImgydJHUbqFB7iOcZTBhC3ysQWBf4vTcysGN7KqKLcmiswn6sSJIfagf1bbQYY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475420; c=relaxed/simple;
	bh=CqBjDtM1crxZGg59Ped+qgYdm+cvqUzxKPFQkbNmcOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Na0QQZY5citJam6MWeRHtNUvgzPkPbWf01XqXbY26VJw/MBjM562Wpxrfdc1n4gRleo9l2NLrZ9W+DvuNC1/klsDm37o5QLBlKEisvJjneYeDk6Eum+ZbbfaK3SE8VgZ29fzX19itXLRtNEGE5khmvMZ6HkNeDToIRV0/uPZ6sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2HiIc6t; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2HiIc6t"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37bbb36c990so22861901fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 06:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763475415; x=1764080215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUPvUGEPJ8Vhtcep1QPb9+qLVU0+ShDWpXHZEE3Vv9Y=;
        b=K2HiIc6tDfhscQMsC0GNQfDkA+ZfD+F2Z5hXnCJaUEgBJ2D7HKNsypEGoo0nl+aTV3
         j5ITJd1NUgYcgAlnRpoWAkO5AtVZwbhev9pGv9JRaQeETVUGJT5rq6+SaExKqY80+/3k
         rF4Pwq4IUdA5rzHdfUiAHd5EX2Fx67Fibx/t3tcQZo/mnOMSq7IJonQ88/hTchTWgyuI
         Fx2EmTaJYJh9ke52J8z/8xt4q9ygG/BQ9ndEOcnl6ovWN5uKWHxS3lsudvE+DrvNi1Ul
         0wjAaes4Iydg0X5LbilqhbRzDZZnFl4cpfG+2fd0ElzwWMqgJLvEjf1/lhZrRm/Da8dk
         w9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763475415; x=1764080215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yUPvUGEPJ8Vhtcep1QPb9+qLVU0+ShDWpXHZEE3Vv9Y=;
        b=hng3j14hE4y1oAFmXOeiT+jbWP4Mr6+hWqSvrP5YcPyW+MM7Yf4glNXC4fopYDUbS1
         atkurb91l3bBTl+PtvmSh5rDAHoPznmapncWAzY3l4oOxKwlwpHbozjrErMziDtOszUM
         HbiA1rBd3xP7Wd0X0KgKh9NJZQY+OXltgteUwGlUnWU7BEljNIAOStuSY6SNSjRZpvg4
         gQEDxLLuU85gZS1iMI8krzRpR0iT/wiUaq/ZVXxyzr+AKeI6qX7khNG7UGdQrlXvmPoy
         baFssCEVoG3bYtUlNU3UGd+wqjWLdBVrz/32lw66YUMQmQJFT+UG7wAZLUyj6H0BFZ7S
         rvMQ==
X-Gm-Message-State: AOJu0YxXQjbIEkWIZS2sJTU6G4fjc7qfaDlLWgBTf0A/FfXPCYg4jWxn
	rZSsjIYaNXzQMpM2U0O7Rc5ZC2nuiz9d7VDH1D0yJd4iGZX2H2zzXkDJiNYuJCappl3ZYa+vz2Z
	qOeIPSXwMF5pB/Xx2Znehkb1UJ475dsolnDbY
X-Gm-Gg: ASbGncvgHv2dBmnoKRqqrfzTEAK2kJsCU3C+Iy35mVblry8NX6twBqJ5z9riqVHkjBa
	ELoFpnHnIovZWS5kfj34DKWl/AQZicNwZqWQhWquUptu2C9JetSJzzUMiXFc2Mct838ocKXRFTc
	tnbdRDrsL1fjI+QGESsCSez4pcWcTZZfK18/G7lFLACP3GWucCWOsryTHTrWDP4d/2XOuUafxDj
	GqQseoAPhcJYt5DJtwRpq4T48zCgKqmnPpnoD/sjYO09Mn8JT6zqTofSg85Iu04S5KwGQ==
X-Google-Smtp-Source: AGHT+IHrOr9S7E1oN24VB7xkbSZXqxWEiWxVJRemb8qMlMDzpqNOOWgTX++vC5EUTGOSk2NXfxengifX7Ho0lVH8dGs=
X-Received: by 2002:a05:651c:3043:b0:37b:ce39:219d with SMTP id
 38308e7fff4ca-37bce3921b4mr2188251fa.0.1763475415262; Tue, 18 Nov 2025
 06:16:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117215103.3990708-1-luiz.dentz@gmail.com>
In-Reply-To: <20251117215103.3990708-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 18 Nov 2025 09:16:42 -0500
X-Gm-Features: AWmQ_bmOV36FoYUKiLlBcCoQcvtEkNWnTNfcuF2i1k7d0DDNTK_ScAwLdmsW9M8
Message-ID: <CABBYNZKmb5riJmos9DCmw5L0fDXEoqUJuvMn4afcAmKYRcTY9g@mail.gmail.com>
Subject: Re: [PATCH v2] fixup! Bluetooth: hci_core: Fix triggering cmd_timer
 for HCI_OP_NOP
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Nov 17, 2025 at 4:51=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Fixes: 486a25d25a4b3 ("Bluetooth: hci_core: Fix triggering cmd_timer for =
HCI_OP_NOP")
> Reported-by: syzbot+25e9c406cbd26c66c417@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D25e9c406cbd26c66c417
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_core.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 9f686e5903a1..1920e3d62bda 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -4121,7 +4121,7 @@ static void hci_rx_work(struct work_struct *work)
>         }
>  }
>
> -static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
> +static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>         int err;
>
> @@ -4133,16 +4133,19 @@ static void hci_send_cmd_sync(struct hci_dev *hde=
v, struct sk_buff *skb)
>         if (!hdev->sent_cmd) {
>                 skb_queue_head(&hdev->cmd_q, skb);
>                 queue_work(hdev->workqueue, &hdev->cmd_work);
> -               return;
> +               return -EINVAL;
>         }
>
>         if (hci_skb_opcode(skb) !=3D HCI_OP_NOP) {
>                 err =3D hci_send_frame(hdev, skb);
>                 if (err < 0) {
>                         hci_cmd_sync_cancel_sync(hdev, -err);
> -                       return;
> +                       return err;
>                 }
>                 atomic_dec(&hdev->cmd_cnt);
> +       } else {
> +               err =3D -ENODATA;
> +               kfree_skb(skb);

Does this address your concern about the skb not being consumed/leaking?

>         }
>
>         if (hdev->req_status =3D=3D HCI_REQ_PEND &&
> @@ -4150,12 +4153,15 @@ static void hci_send_cmd_sync(struct hci_dev *hde=
v, struct sk_buff *skb)
>                 kfree_skb(hdev->req_skb);
>                 hdev->req_skb =3D skb_clone(hdev->sent_cmd, GFP_KERNEL);
>         }
> +
> +       return err;
>  }
>
>  static void hci_cmd_work(struct work_struct *work)
>  {
>         struct hci_dev *hdev =3D container_of(work, struct hci_dev, cmd_w=
ork);
>         struct sk_buff *skb;
> +       int err;
>
>         BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
>                atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd_q));
> @@ -4166,12 +4172,8 @@ static void hci_cmd_work(struct work_struct *work)
>                 if (!skb)
>                         return;
>
> -               hci_send_cmd_sync(hdev, skb);
> -
> -               /* Don't trigger cmd_timer in case of HCI_OP_NOP since th=
ere is
> -                * no command pending.
> -                */
> -               if (hci_skb_opcode(skb) =3D=3D HCI_OP_NOP)
> +               err =3D hci_send_cmd_sync(hdev, skb);
> +               if (err)
>                         return;
>
>                 rcu_read_lock();
> --
> 2.51.1
>


--=20
Luiz Augusto von Dentz
