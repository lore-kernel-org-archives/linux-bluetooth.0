Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA0B41DE18
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 Oct 2026 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791026766; cv=pass; b=FlAwQyxBXuuBql1vFwZhT5lDLSL59eMliBl+fyordkSVrTvr72yw+ZByOilj2ZbPbItt5xtBVaOd46ATFm1HC4k4UY2Jak7wQek/PgkBYxmJ4FX0ez+3XyO9Mra+keV7MmHMQWFXsv5rDT/II+jEs5Pw7scRWTY7ewD4/S9Y0qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791026766; c=relaxed/simple;
	bh=lBLmndi97S1WKeBFgGiKj82sLyoJqct98pipvkFSyZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGB8Z5M39wm4mzK9c6nEge0JX3p1A9hxt0s1eIWhafN+P/FWsjGLVK/eMlC5NE2okbQCt2KUpNXTNFTpcNF9DTyybEyHgun2+bcDGRW+YoKBw8uQbEUcOp4YV0P6ID3x8sw/I28wPZZW6Dlzcv25YfWjEfWaAkn8JQq7ar3/2AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=opJvjkwN; arc=pass smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opJvjkwN"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34daf1b9a1fso128637eec.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 03 Oct 2026 04:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791026763; cv=none;
        d=google.com; s=arc-20260327;
        b=WQuiOVDgEVMCfhNFR87vqY1EovJlohvgA7mhwcZQnSL1ITQ9MqdZpC3ACEoxeKlA5J
         OjZnUrMhCjgdX4BOFlTPJ+Ug0pM0pIArZz1Kp0/XFWrghfZtV9UYlLXoMa9k2Ovurz8G
         b3obUM7bLFqP0wJLaTBsgJuwFtOVk0vB8Ltizj+XPhxUfxFCCKnKp8Y/hVL8Qc7yIUCb
         ExwH8fnA3P00Ojwj7aO8PQy8hRdW7tpGvxIu2pVOB6yhyG07bf6nYtsRYuQL/sqD7ZD3
         SnfVAJxSlyw/TvSY80ZhVHgKhDHnnRXj/viGjHjvXKBy1/JOwLJQTv++pINlhh8BNZCi
         OqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5ORazFD3WD1rKxpd4RdCNH7N7Ig54yxyJrV0ajj3sYw=;
        fh=P4ptTnbrqA6aV5S6l3Wg0+otRLnR2KaX+KECHxUJNZo=;
        b=GAG9E4KmmGEVpC3hIs7ZVg8xPUZNJEhmjt275yeLjSf55etNUHW2bnmQEZFKRWIUK2
         +aFYzjnFnI2z6DdBx5un++IWU5BuaTYOMUk+Ysles1UGceVnWSnElVYgoFg6Q4Ip3vkC
         IpvuwESJwCFd+ZD0z+/OTdXR0EuniKSfrL3yl6pY1iy5WPa3bequREKumY1+tw2CRelu
         y47rDuH/fcxQ/6SfOgbKInpI+zvGQm4lt1nydkJhg35tBTX5hExOPkZL+g4wx9ft58Sj
         7hKySw3fCWrWjjp9ulC1o9hs/CD5aq5qEjwaBgBnEEYD2i6M7XeXLrqVpDtIMCSmMiRo
         sDcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791026763; x=1791631563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5ORazFD3WD1rKxpd4RdCNH7N7Ig54yxyJrV0ajj3sYw=;
        b=opJvjkwNPeRNEPWhSX4fMiP3QIpybnZwXh3z1IlQGNEDPaXH+R6t0dVh4N/cYqdYrH
         93uNRDCCwoTnjyX7QxIj8RbtvO7vISjkcCluwoT3Vk7OUp2pC3ZeV6BGU7gea04I/p/W
         jMEJ51tzgQaqvEs6TVsX+wpIzIBnYqT+kurG9cQoCCnA/NydBlafwBjwpB1Lu4TKVfg2
         PpIQr0/L8sMloKJh82UwPMqhgxF1qoGKa3pxCj+hymVlkb3qtiJD8x3tzwSXM0tdcC1c
         PDiqJaSkO8H6B3WxDOSOyl2cuB5IOyzbFJJLTOFQOq5zh0tJlI4hHPm3ahDiWaxSHKsr
         m86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791026763; x=1791631563;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ORazFD3WD1rKxpd4RdCNH7N7Ig54yxyJrV0ajj3sYw=;
        b=BEb0G6ZsKh0QeKmApON4hh4+JnjoYWGKmoqw5vRmfub80rTPVfbaMpReZ9W7RHTro3
         UjCI1A1RGD6lDgExOFZVvwhUWAvwxMxQfcT11pRQH38dvhloOwTceet1W/XVuGsXKbLX
         /n6xodobrcra2OK+SVtJMNfrIrUlueWeVgN8AzQ4+e+x0Voy88YYixPd6hTJ2it7NxWv
         M2AndC49kxHLjSjkR839WCNw3HhGD+KfN3xXv+K4j/ASJAQUzywdLZnJcaFmxkOhMwX2
         BVWgv3Sfy1v5y8VquIakupwuQAc07CTVAP2icsP5KQbGtt5/t7EUecxgAjut/Z9+/Tbo
         18+w==
X-Forwarded-Encrypted: i=1; AKwUvBxMwCBahCrLOe2LaTPT+CKarYRpfRfRXsjTVN4VfrxnCtqMro+hOsSuMfJf57R54cfmNSwEu1aPNkq1rL+1ZZE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrqGHJrn5PUkNYcvZQ+iwz9REOQr3j0IpG8a5HQ32BXHL7ABNf
	Evnm3bm1iLDEmHHWpPsJbQUZjpvWGr4RIXU/bSnMGi7X69QCm70Rfrjk4uBTmb/dBv3S1Nyy/lm
	lxjLBVA/BnfaPyvhhsgHs8Rrs4CvDDIw=
X-Gm-Gg: AYBFou3VoqdUsbk+AlWJo200hEbrDbjcpb8QmthHudwgTy9J+6bJ9EIrbj0rDS1tG5c
	F669xTYjErDdQmwGtbdsX5dTzbX+kQNWlStlycGdg1obnes7CMVPOLfEUY2m6ar9ybXe8OV4mX9
	ZfXiVKtyX/Xix73XGHLy7e0yoLgEtDcJmRacYAdvraf0UUX+AJtnQqqMsvPX4tcwohpEjsrxV7w
	EeJqD1sOJeOzFGX3MRLuvolbu8vUbzeKEICE6GC4FDUpi2WyFpecmYPSYC852oDsvkQmRMDg+f9
	+B1yyS59s8RRCufO9MEtTNozF+1w6qG42APn6lLP88n/XLPAcyStPi61Be6nCFywHfR7Ztx/BWg
	Fjujfzkoh3ULbQOD70ModfEBAImUxdVEBPEot7EuRT3NHHqhvlmODcVANjGPOzymKea7YwPDgYv
	ywCX7qHN2cp9/sxxVLVEE3MB0r93mg
X-Received: by 2002:a05:693c:66cc:10b0:34e:e479:723 with SMTP id
 5a478bee46e88-34f14f12d95mr5749579eec.5.1791026762760; Sat, 03 Oct 2026
 04:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002044810.80340-1-rabindrameher116@gmail.com>
 <CABBYNZLeHVQjsnjbPn76LVKT1RxSadYPZDqoNY7Lj-zEysU8-A@mail.gmail.com>
 <CABBYNZ+870EdpRWDpx22ZZX4=_+bVwjf3Fv4HazoV5u9+_ab6g@mail.gmail.com> <CAOa02aN_YgSB7L6eG-+Og3dx103kZpoRy1Ho27aMvo2dsoQCVw@mail.gmail.com>
In-Reply-To: <CAOa02aN_YgSB7L6eG-+Og3dx103kZpoRy1Ho27aMvo2dsoQCVw@mail.gmail.com>
From: Rabindra Kumar Meher <rabindrameher116@gmail.com>
Date: Sat, 3 Oct 2026 16:55:51 +0530
X-Gm-Features: AclHuK_4iYTRP4PQYtFMnSnx18fAYG0DGr1u7iStbi2UrNIiSRRh501rDzqoMNs
Message-ID: <CAOa02aNrsiuvT-J+Wd3LTYEVRr2D0jdBQ=vsR0-CSeKUmRfuYA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Cancel cmd_timer before draining workqueue
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Pauli Virtanen <pav@iki.fi>, 
	Chengfeng Ye <nicoyip.dev@gmail.com>, linux-bluetooth@vger.kernel.org, 
	syzbot+48fc5b35b350240fd465@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

Thanks, I checked the reported path again. And the warning is from a
cmd_timer already armed before hci_dev_close_sync(). The re-arm path
is already blocked by HCI_CMD_DRAIN_WORKQUEUE + synchronize_rcu().
I think cmd_timer still needs to be canceled before drain_workqueue().
Moving cancel_delayed_work_sync() into hci_cmd_sync_cancel_sync()
would make hci_cmd_timeout() synchronouslly cancel its own cmd_timer.
Also, in the reported path req_status has already been reset to 0
before hci_dev_close_sync() calls hci_cmd_sync_cancel_sync(), so the
HCI_REQ_PEND casewould not cover this warning.

Thanks,
Rabindra


On Sat, Oct 3, 2026 at 4:52=E2=80=AFPM Rabindra Kumar Meher
<rabindrameher116@gmail.com> wrote:
>
> Hi Luiz,
>
> Thanks, I checked the reported path again. And the warning is from a cmd_=
timer already armed before hci_dev_close_sync(). The re-arm path is already=
 blocked by HCI_CMD_DRAIN_WORKQUEUE + synchronize_rcu().
> I think cmd_timer still needs to be canceled before drain_workqueue(). Mo=
ving cancel_delayed_work_sync() into hci_cmd_sync_cancel_sync() would make =
hci_cmd_timeout() synchronousllly cancel its own cmd_timer. Also, in the re=
ported path req_status has already been reset to 0 before hci_dev_close_syn=
c() calls hci_cmd_sync_cancel_sync() so the HCI_REQ_PEND case would not cov=
er this warning.
>
> Thanks,
> Rabindra
>
> On Fri, Oct 2, 2026 at 8:02=E2=80=AFPM Luiz Augusto von Dentz <luiz.dentz=
@gmail.com> wrote:
>>
>> Hi,
>>
>> On Fri, Oct 2, 2026 at 10:29=E2=80=AFAM Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>> >
>> > Hi Rabindra,
>> >
>> > On Fri, Oct 2, 2026 at 12:48=E2=80=AFAM rabindra789 <rabindrameher116@=
gmail.com> wrote:
>> > >
>> > > cmd_timer can expire while hdev->workqueue is being drained,
>> > > causing hci_cmd_timeout to be queued on a draining workqueue.
>> > >
>> > > Cancel cmd_timer before draining the workqueue.
>> > >
>> > > Reported-by: syzbot+48fc5b35b350240fd465@syzkaller.appspotmail.com
>> > > Closes: https://syzkaller.appspot.com/bug?extid=3D48fc5b35b350240fd4=
65
>> > > Fixes: 40b87657200c ("Bluetooth: hci_core: Rework hci_dev_do_reset()=
 to use hci_sync functions")
>> > >
>> > > Signed-off-by: rabindra789 <rabindrameher116@gmail.com>
>> > > ---
>> > >  net/bluetooth/hci_sync.c | 2 ++
>> > >  1 file changed, 2 insertions(+)
>> > >
>> > > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>> > > index c01c8b58d9e8..e1c28bffdc15 100644
>> > > --- a/net/bluetooth/hci_sync.c
>> > > +++ b/net/bluetooth/hci_sync.c
>> > > @@ -5545,6 +5545,8 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>> > >          */
>> > >         hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
>> > >         synchronize_rcu();
>> > > +       /* Explicitly cancel works in case scheduled after setting t=
he flag. */
>> > > +       cancel_delayed_work_sync(&hdev->cmd_timer);
>> >
>> > I'm not following here. If a command is outstanding and times out
>> > while we are draining the queue that should be flagged. Or perhaps the
>> > problem is that hci_cmd_sync_cancel_sync don't actually behave like
>> > hci_cmd_sync_cancel which clears the cmd_timer whenever it cancels the
>> > cmd_sync work:
>> >
>> > static void hci_cmd_sync_cancel_work(struct work_struct *work)
>> > {
>> >         struct hci_dev *hdev =3D container_of(work, struct hci_dev,
>> > cmd_sync_cancel_work);
>> >
>> >         cancel_delayed_work_sync(&hdev->cmd_timer);
>> >         cancel_delayed_work_sync(&hdev->ncmd_timer);
>> >         atomic_set(&hdev->cmd_cnt, 1);
>> >
>> >         wake_up_interruptible(&hdev->req_wait_q);
>> > }
>>
>> Maybe something like the following:
>>
>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>> index 1fe11d3ef1aa..87b9f96af057 100644
>> --- a/net/bluetooth/hci_sync.c
>> +++ b/net/bluetooth/hci_sync.c
>> @@ -702,6 +702,12 @@ void hci_cmd_sync_cancel_sync(struct hci_dev
>> *hdev, int err)
>>                 hdev->req_result =3D err < 0 ? -err : err;
>>                 WRITE_ONCE(hdev->req_status, HCI_REQ_CANCELED);
>>
>> +               if (!hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
>> +                       cancel_delayed_work_sync(&hdev->cmd_timer);
>> +                       cancel_delayed_work_sync(&hdev->ncmd_timer);
>> +                       atomic_set(&hdev->cmd_cnt, 1);
>> +               }
>> +
>>                 wake_up_interruptible(&hdev->req_wait_q);
>>         }
>>  }
>>
>> > >         if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
>> > >                 disable_delayed_work(&hdev->power_off);
>> > > --
>> > > 2.43.0
>> > >
>> >
>> >
>> > --
>> > Luiz Augusto von Dentz
>>
>>
>>
>> --
>> Luiz Augusto von Dentz
>
>
>
> --
> Rabindra Kumar Meher



--=20
Rabindra Kumar Meher
