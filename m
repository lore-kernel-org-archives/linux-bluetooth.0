Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71611DE4C3;
	Mon,  2 Dec 2024 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172104; cv=none; b=JfS5kxq/jVwiaqDww3Clf/Ps5kgfKA0On0VpVl2nUwv7xjhYMB/gI/SlHOuCSq+XYbWvWmVDxqVuAxaBU2HvMpLYGfCQiBcTTWsfTVjj4BDv8HrggGt0X26DfMGRZykZqfh0+GmYOOmECN2XQfC0cRG+0Ygb7AiCUW/yuKQhjz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172104; c=relaxed/simple;
	bh=DDL5YUo82kmcLn4DeO7PW3cTvO4gulip68MP6Ah4Z5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osbMkxQZFD3UbascArJfWNNYEOrcQ9gQ4VvWPjm3s+9Af2L6d8E2U9k7gSUM+szdYel7TOg6T8B1JUjv+Z93xRfWqvzdOEPEO4eKGsErsZnsOw7lDOoN5b5x5+xHcwjH4wDtFPxn1XXS/1bCB4cP8rSKQM2g/ZWz8uqvJxnJB1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjJ9xplC; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjJ9xplC"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ffa8092e34so52169501fa.1;
        Mon, 02 Dec 2024 12:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733172101; x=1733776901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIrqk8hJrxjce170C6Tbv4S3+IHsSfOaMw1wDpVIl6s=;
        b=jjJ9xplC1SXaXEKS2JvxpkfoOUsX5vJGOOyipdLvv3nVv/Ej+e2sPZAf1p67Le0jo9
         g+aYdqW4d64R817vsxjy/r/inXNOgb/2EkWoopuAV5uMox0HO7ayz4Ek+B2yz+TVLh03
         yWnswQyQuqBvh7m8a6I8Pw8qg6HkCfsdeP0EeKFULWs/Zl/6c4tzG9ks1mvCc8b5N2ux
         udY/t4OjRX+smM9NiijmxjG5UK3k/Nt9LmdQhMB+RCIHAV6vQPzA+htnsOcCxAoGDBIP
         snPQtyAasp+qWh/2lCm/Mlfxmp6O37PqGvYVETW5P7PnRq944UuNWe6OKa/8vDLS2mAv
         RPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733172101; x=1733776901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIrqk8hJrxjce170C6Tbv4S3+IHsSfOaMw1wDpVIl6s=;
        b=l+mOBiPVGnLyTGxrKlgRXRBk8OSU4sbIsjKQ+ge4nRVwcMuUGc/cehvFDyWD4vHS66
         HKia8ktbcGdHeSExcK0u17D9K1o+aVSJEF5ife0qLqL/UaBUYlzpc++Qqo2mzhPLxMro
         +oF6y41sSujGDjODME6Aq0+/VEGNrtktxrN3v9HDuJNR0yT383VHjOkPuDJAijRZ/20E
         3OzCgOqlSM5kDszBnh+ZJbHf+jtbxR8OKNNBbOPmcF/nPEGNpzR8+plRI+VzrYr9FxMy
         sYyLSwzNKWZ6IjCrYi3HGYTIigRzru/FmxtN5rOj5pT4rYSw9APM5seNg2zta6k1SOJ6
         XXcw==
X-Forwarded-Encrypted: i=1; AJvYcCUGoI/UuifgAW/sfro1jh31cKJoMfDzlRvvlDq5VTVIX2YCuidVASsntWYs8QgZcz1RTlkSU637fVNlSHL2btU=@vger.kernel.org, AJvYcCWQzBMwWpUfA03BzLOuQwCxQpzMPnDw+nSwPkIBnT2SKU6OnFIXLb16a25K5EDPJnypQR6tz5TyLNi9um4Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0mIDxMMWCWh7BXMtI9xt8kYX3ra5cFKDtxNsFZzb8pcfndn/o
	MENPXdsQnA4mMjulCEzytXeasxgqhxz5dF7AnCWEwt3KC5+xwcxNZ5zhIL9u/Fa1Zura4Ljc+gi
	idVoWWWVz4PeWDws6Yt4DLPQDRkI=
X-Gm-Gg: ASbGnctRyEiJ97EtmI0GxXw2+HmscffV3za1sxzT1Y+SouBJs8R+16fQWxiEmv97+Q2
	YMnlcZW7e4iDlv5hG8oG5Qcr9ux4ymg==
X-Google-Smtp-Source: AGHT+IH+rq1aCdl9MJTyHCx58zHveb9qZgxb4C+eMCSGv/wFgSUv7VSSbeaJevGXD7vBs46qtn7gnkR9tGZTW4zV1jU=
X-Received: by 2002:a05:651c:503:b0:2ff:d410:6974 with SMTP id
 38308e7fff4ca-30009c2e272mr246741fa.15.1733172100685; Mon, 02 Dec 2024
 12:41:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125175111.8598-1-quic_jiaymao@quicinc.com>
In-Reply-To: <20241125175111.8598-1-quic_jiaymao@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 2 Dec 2024 15:41:28 -0500
Message-ID: <CABBYNZLY_PAA0jPiHwGKUmdd3SKqwViLSHAkNHH0=trdqrDRnQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_sync: clear cmd_sync_work_list when
 power off
To: Jiayang Mao <quic_jiaymao@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_chejiang@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiayang,

On Mon, Nov 25, 2024 at 12:51=E2=80=AFPM Jiayang Mao <quic_jiaymao@quicinc.=
com> wrote:
>
> Clear the remaining command in cmd_sync_work_list when BT is
> performing power off. In some cases, this list is not empty after
> power off. BT host will try to send more HCI commands.
> This can cause unexpected results.

What commands are in the queue?

> Signed-off-by: Jiayang Mao <quic_jiaymao@quicinc.com>
> ---
>  net/bluetooth/hci_sync.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index c86f4e42e..bc622d074 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5139,6 +5139,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>  {
>         bool auto_off;
>         int err =3D 0;
> +       struct hci_cmd_sync_work_entry *entry, *tmp;
>
>         bt_dev_dbg(hdev, "");
>
> @@ -5258,6 +5259,11 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>         clear_bit(HCI_RUNNING, &hdev->flags);
>         hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
>
> +       mutex_lock(&hdev->cmd_sync_work_lock);
> +       list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, l=
ist)
> +               _hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
> +       mutex_unlock(&hdev->cmd_sync_work_lock);

Seems equivalent to hci_cmd_sync_clear, that said we should have been
running with that lock already, also if there is a sequence like
close/open the close may cancel the subsequent open, so I don't think
we should be canceling every subsequent callback like this.

>         /* After this point our queues are empty and no tasks are schedul=
ed. */
>         hdev->close(hdev);
>
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz
