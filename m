Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B851FA27C;
	Tue,  3 Dec 2024 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246938; cv=none; b=iENEdWz41421KkYjz4Lc15b/EUYTaEOhma4BZxd4RAk2n3e5horUryxWVJuNHSNmwf22lExnAhqBGccnWl9KyUE5M5QfPaUg5fLu4xE3iAwga8C7rAqcOwhe0tHBwYdt0OYFXk1XWhLt7BYt2AWSQlOk2Ea72TlWhhGZLtkpVwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246938; c=relaxed/simple;
	bh=qAWvSaEF5fW5UQN0IfVUrspiEuMUIbiYFRL9y/TNi0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slBPwadNdDD6DSpvzZyi2pMMU2bVrGd4AaXfr5GF2iIkWFPhcY/73XqPg0oJW5Xo5NCZjJcFYL8TOyvp9Gm5OOuvzhCUtgo8oM71lUc2l7zanNGEa8XOjok+T7VHKX63vuDmmHHW9LpW1OxIw4ETrUko+T3eT802BajYmRq1nRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5zi2pi/; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5zi2pi/"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffa974b2b0so58976691fa.3;
        Tue, 03 Dec 2024 09:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733246934; x=1733851734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JtReny1oxaP2v46gqv/zCxffW8Pl5xWh/av9Hdrv54=;
        b=M5zi2pi/WM7U3lZrzLVF0fBnuQnRnEUl6YMOE3UNaCn3of5deR0WvoefOm4wGiwVIq
         ZD0zmx6RHI/qa3QqTs4YXPwLLtFh9lUxkArAePe6QDNafnAz/6ATMOtDifNRBDJJYA67
         F/39679DiPUWOaNgqXxFxSOGGNT1ywH9ZaUgtuo0eoaz/J3shBXKMQMPzzkaL7WVU22D
         RzQA5QSLR79SEAQ2E3JAx9p8bk8e3DRt6G7k6u26r6Hm/I8gQB9C2n0ZErd+AyVGN0FO
         NgXsRmYcU4vk/liMdZdj1XQUgggutMpnD4y6517rBI9KVF4rSykIuLuQlFBL7ls2UuLQ
         y+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733246934; x=1733851734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JtReny1oxaP2v46gqv/zCxffW8Pl5xWh/av9Hdrv54=;
        b=b6FKQIrPOv08SQRfBAUG8p4CJpzhsizJshd2ahxOp6m6NepyeaPl1U3zyqqrL+sTA2
         IV7CLsf3nhooz2Ng4Ur/d69+76IdmjiN36Ql1eFA0sNBOOf41rQM77lKxvxH6wWwfwAc
         ZnPnaMxKxykLgyEGJgqjjPuBDiMOhnMeAPWjnsw40h19R5JJfAfzA++o3BtnclgPAgVS
         /CcBlrhXG0mgoH1WccR0ikTyjN+HSEQgsrpr6FAjvk3beju3ydDvo7UPSHGYPJORE+1u
         aAEnTYqiJ2nEyenHgOIYFnkj8//UkhmWPpZZEuK/5q4Gx6Kvz/56RhKQrYed5Ep4Qtht
         I8dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl7vHRpEsLr5o9wtv7B3ksyomxL7dZjw7yCxvo1+sa5aPFnmselSZIXlIALH2l+ELB6nLpaLvq3d7N5Srv@vger.kernel.org, AJvYcCWaT7XQDNcBYBvcpG4SMnhGeYYyXWjb/69B09MfKwZojW+FSwkSgyb/7ovNSjtZr/TI+FLTc2fvl/GkCviJ9Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9nfqUSr2WbOIEv7PRFjwAG5QCfvYyyMpuwIFoRDdN1i4aX+CS
	UetpDsaQF6ttEvfKzSxicIMYPaR9TiD+W+ErgO3UhiuclKzrxeADS239cHNfVt5t/h1yYU43Amj
	YtaDBD3QKRr4dkS7hf3ctSWWmSq0=
X-Gm-Gg: ASbGncvC7o8p2zXiPhvuHgKXgV1qVj5zTbRtM4ykNGQliIuZBCw3Um2jordztiZU4t+
	12cLDl4bT2G8912si+PeFApkuFGl2F3W4
X-Google-Smtp-Source: AGHT+IHFzwmYLx2Q99rVaBGLWA4PSj6q+E3nnTHhWXHTMrzOp2AKj2C8RIGWJ4XCXIRKQ27wYKKaoRFl8TnVSa6OMoo=
X-Received: by 2002:a05:651c:199e:b0:2ff:c080:e4f with SMTP id
 38308e7fff4ca-30009c8aaefmr29943711fa.33.1733246934071; Tue, 03 Dec 2024
 09:28:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125175111.8598-1-quic_jiaymao@quicinc.com>
 <CABBYNZLY_PAA0jPiHwGKUmdd3SKqwViLSHAkNHH0=trdqrDRnQ@mail.gmail.com> <8107a53f-5967-461b-8c89-773096a316d1@quicinc.com>
In-Reply-To: <8107a53f-5967-461b-8c89-773096a316d1@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 3 Dec 2024 12:28:42 -0500
Message-ID: <CABBYNZJarA24Sy5qXKy77Jtnn+RBYhSg7Hxj9wUxENNvwkiyTg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_sync: clear cmd_sync_work_list when
 power off
To: Jiayang Mao <quic_jiaymao@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_chejiang@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiayang,

On Tue, Dec 3, 2024 at 12:19=E2=80=AFPM Jiayang Mao <quic_jiaymao@quicinc.c=
om> wrote:
>
> Hi Luiz,
>
> On 2024/12/3 4:41, Luiz Augusto von Dentz wrote:
> > Hi Jiayang,
> >
> > On Mon, Nov 25, 2024 at 12:51=E2=80=AFPM Jiayang Mao <quic_jiaymao@quic=
inc.com> wrote:
> >>
> >> Clear the remaining command in cmd_sync_work_list when BT is
> >> performing power off. In some cases, this list is not empty after
> >> power off. BT host will try to send more HCI commands.
> >> This can cause unexpected results.
> >
> > What commands are in the queue?
>
> If turning off BT during pairing, "hci_acl_create_conn_sync" has chances
> to be left in the queue. Then the driver will try to send the HCI
> command of creating connection but failed.

There shouldn't be happening though:

    /* Terminated due to Power Off */
    err =3D hci_disconnect_all_sync(hdev, HCI_ERROR_REMOTE_POWER_OFF);
    if (err)
        goto out;

    err =3D hci_dev_close_sync(hdev);

Perhaps there is something attempting to connect after
hci_disconnect_all_sync has completed, in that case there is a bug
around this sequence or we need to check HCI_POWERING_DOWN to not
attempt to process the connection attempts.

> >
> >> Signed-off-by: Jiayang Mao <quic_jiaymao@quicinc.com>
> >> ---
> >>   net/bluetooth/hci_sync.c | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> >> index c86f4e42e..bc622d074 100644
> >> --- a/net/bluetooth/hci_sync.c
> >> +++ b/net/bluetooth/hci_sync.c
> >> @@ -5139,6 +5139,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
> >>   {
> >>          bool auto_off;
> >>          int err =3D 0;
> >> +       struct hci_cmd_sync_work_entry *entry, *tmp;
> >>
> >>          bt_dev_dbg(hdev, "");
> >>
> >> @@ -5258,6 +5259,11 @@ int hci_dev_close_sync(struct hci_dev *hdev)
> >>          clear_bit(HCI_RUNNING, &hdev->flags);
> >>          hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
> >>
> >> +       mutex_lock(&hdev->cmd_sync_work_lock);
> >> +       list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list=
, list)
> >> +               _hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
> >> +       mutex_unlock(&hdev->cmd_sync_work_lock);
> >
> > Seems equivalent to hci_cmd_sync_clear, that said we should have been
> > running with that lock already, also if there is a sequence like
> > close/open the close may cancel the subsequent open, so I don't think
> > we should be canceling every subsequent callback like this.
>
> In hci_cmd_sync_clear, the work cmd_sync_work and reenable_adv_work are
> canceled. hci_cmd_sync_clear is not directly called because these two
> works should not be canceled during power off.
> Do you mean the added code should be moved to other functions to avoid
> the risk of lock?
>
> Yes. This change lacks considering sequence of close/open. I will update
> the implementation to ensure it does not remove the opening and the
> operations after re-opening.
> >
> >>          /* After this point our queues are empty and no tasks are sch=
eduled. */
> >>          hdev->close(hdev);
> >>
> >> --
> >> 2.25.1
> >>
> >
> >
>


--=20
Luiz Augusto von Dentz
