Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3401F4713;
	Wed, 30 Oct 2024 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300251; cv=none; b=OAUNi7dxiZU4RrsUEYmHaIUlbHZFPczcg5ATraTdliZCeDiViq3ZFgU1ukuo+HanfMCLE6j7bERDMrU0ULSp3RmX1LDAllsefMgfp5h7S9QSICNvHIGN7yu5fklUUMq6PtGMnV+PKqz3XrI6fixZrJmjVfqerALaDiLr0RcfvuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300251; c=relaxed/simple;
	bh=1PkTZ/sr5+jPoLtMDdQ7SNFpPF5pWoox0qUOFFl3wnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZccQ2M2le3yyC23GGVUAYP4SMsmxvUfAHReLEke4DAci95HXKB+V6IQabixRNv9h/XrpP25gIJmFwta/V90amljQssCHpV8AXjjYd4zAMwaqUa7BbTd0YAcpJELU/Qmkfef6sfkbCtQdgajAN42xnz54lEChx2jTBv56d7aXOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfLhrTtI; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfLhrTtI"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb5a9c7420so65099801fa.3;
        Wed, 30 Oct 2024 07:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730300247; x=1730905047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWegzEF7jpi2NlYHtiTQk5MIofRy3uYyVb0aEGedgW0=;
        b=VfLhrTtIuoHIFo81mvsH1viFYUIW1JlI0VeRdtRb/YzhurLRteFaIjQhjQsQS1yZ9y
         mNVHawAdJxI7Tl6jzpQNOeAdofKwA1eqdKsilO5lW+GShqkb+Rk1cChHGOwERaMZOE2P
         ZDJCD4G3UKpeBnR9QKOWD/cPOpS0bnfe3NtgCYg48X8Ema4wQwi51LxffE7uf21pB+6i
         LtPKwfABqb5+kIlzYGWxegBWJQwWz/CyKktR6++Bvp9Y8DwYfWhIXFr3BKF2qaHE7OHC
         b3ALKm9JO0fx+AbAFEbX5nSZL/0KebnymiP9Mg9UdyIAqKKf1BFUJllVJYi7r7Ixo2K9
         G8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300247; x=1730905047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWegzEF7jpi2NlYHtiTQk5MIofRy3uYyVb0aEGedgW0=;
        b=PFUw4NGbZetxBfyWbyxCiJPVC2uodpK46aK420Cx4Z0N28QnoMQC+cHjMwkWIioX5k
         Xi7Xy4K7KdyHtmkF6aq7CgQXhOUImrwKplr5yxWosD0cDr+x8z1djGhakkqQnwi48q58
         g7OFPo+mAppCBLNqnsgbdyArStETc6wDUwRXIOdSoS0ZBnFElF58ykc9dorMf2f/EisP
         Jsfa+2+b1B+d39Dj8vyLj5PKmNnMmfcEyY5o/V2DGfSfNVcj3xTR16XYz5JgufUJbZDI
         LyvzPG0oeMlLVkKjzb6lMO1VZrFHHMtMhCEXUlUesGVzyPbFO1vwTWi3M4pZ8A7izKNV
         Ww0g==
X-Forwarded-Encrypted: i=1; AJvYcCXCsE5yuHDTN9WQwWqg9aIPTqzycJDmOfBsrw3EdNLjAQDXP7QxY5IWwyS8YAoRscfv/kqJZzTjC5qLakrA@vger.kernel.org, AJvYcCXmlSOqgEo2y+dgyaWFhRqLMObZJbfJicGxtMGdu987/0ozxiTtNZSGjGcVoGOpSq2urVUbAa1TIyfeSufqIEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK+8PUo6gUnwhEmQ0Afv0ZaHU3VFXoGYgWm1IgxoiaHC6PPLKA
	lHOxl05nLFftXiqHgczJM8CI/R61wJgnUQCUunGTDSFgb76szCFR6PdmrB+rD9StawhLYdz3uLo
	T9uHqAAVN6O7YapaFBBT6dGsQrLk=
X-Google-Smtp-Source: AGHT+IEwYNy+fbSX+6mbfEVZWRuSOTlkV0B31irMQggIpLyT6TjCZn6jbN5cdx4XizWQgfs6QBLs4OpdzSaRxgamlbo=
X-Received: by 2002:a2e:130a:0:b0:2fa:d7bf:6f43 with SMTP id
 38308e7fff4ca-2fcbdffc0dcmr65506761fa.27.1730300246610; Wed, 30 Oct 2024
 07:57:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029194505.2094645-2-iam@sung-woo.kim> <CABBYNZKsxeUim=DtUR2KR2UyD4fxLzSqY452UQKkw+nK5auPpw@mail.gmail.com>
In-Reply-To: <CABBYNZKsxeUim=DtUR2KR2UyD4fxLzSqY452UQKkw+nK5auPpw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 30 Oct 2024 10:57:12 -0400
Message-ID: <CABBYNZKipxG2pTSRyk+7d+dcis+M4Ehj_+W7y3FxV2vzFAQAkQ@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: daveti@purdue.edu, benquike@gmail.com, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sungwoo,

On Wed, Oct 30, 2024 at 10:26=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sungwoo,
>
> On Tue, Oct 29, 2024 at 3:47=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wr=
ote:
> >
> > Fix __hci_cmd_sync_sk() to return not NULL for unknown opcodes.
> >
> > __hci_cmd_sync_sk() returns NULL if a command returns a status event.
> > However, it also returns NULL where an opcode doesn't exist in the
> > hci_cc table because hci_cmd_complete_evt() assumes status =3D skb->dat=
a[0]
> > for unknown opcodes.
> > This leads to null-ptr-deref in cmd_sync for HCI_OP_READ_LOCAL_CODECS a=
s
> > there is no hci_cc for HCI_OP_READ_LOCAL_CODECS, which always assumes
> > status =3D skb->data[0].
> >
> > KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
> > CPU: 1 PID: 2000 Comm: kworker/u9:5 Not tainted 6.9.0-ga6bcb805883c-dir=
ty #10
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > Workqueue: hci7 hci_power_on
> > RIP: 0010:hci_read_supported_codecs+0xb9/0x870 net/bluetooth/hci_codec.=
c:138
> > Code: 08 48 89 ef e8 b8 c1 8f fd 48 8b 75 00 e9 96 00 00 00 49 89 c6 48=
 ba 00 00 00 00 00 fc ff df 4c 8d 60 70 4c 89 e3 48 c1 eb 03 <0f> b6 04 13 =
84 c0 0f 85 82 06 00 00 41 83 3c 24 02 77 0a e8 bf 78
> > RSP: 0018:ffff888120bafac8 EFLAGS: 00010212
> > RAX: 0000000000000000 RBX: 000000000000000e RCX: ffff8881173f0040
> > RDX: dffffc0000000000 RSI: ffffffffa58496c0 RDI: ffff88810b9ad1e4
> > RBP: ffff88810b9ac000 R08: ffffffffa77882a7 R09: 1ffffffff4ef1054
> > R10: dffffc0000000000 R11: fffffbfff4ef1055 R12: 0000000000000070
> > R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810b9ac000
> > FS:  0000000000000000(0000) GS:ffff8881f6c00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f6ddaa3439e CR3: 0000000139764003 CR4: 0000000000770ef0
> > PKRU: 55555554
> > Call Trace:
> >  <TASK>
> >  hci_read_local_codecs_sync net/bluetooth/hci_sync.c:4546 [inline]
> >  hci_init_stage_sync net/bluetooth/hci_sync.c:3441 [inline]
> >  hci_init4_sync net/bluetooth/hci_sync.c:4706 [inline]
> >  hci_init_sync net/bluetooth/hci_sync.c:4742 [inline]
> >  hci_dev_init_sync net/bluetooth/hci_sync.c:4912 [inline]
> >  hci_dev_open_sync+0x19a9/0x2d30 net/bluetooth/hci_sync.c:4994
> >  hci_dev_do_open net/bluetooth/hci_core.c:483 [inline]
> >  hci_power_on+0x11e/0x560 net/bluetooth/hci_core.c:1015
> >  process_one_work kernel/workqueue.c:3267 [inline]
> >  process_scheduled_works+0x8ef/0x14f0 kernel/workqueue.c:3348
> >  worker_thread+0x91f/0xe50 kernel/workqueue.c:3429
> >  kthread+0x2cb/0x360 kernel/kthread.c:388
> >  ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >
> > Fixes: abfeea476c68 ("Bluetooth: hci_sync: Convert MGMT_OP_START_DISCOV=
ERY")
> >
> > Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> > ---
> > v1 -> v2: make __hci_cmd_sync_sk() not return NULL
> > v2 -> v3: elaborate reasoning
> >
> >  net/bluetooth/hci_sync.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 9482bd562..c86f4e42e 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -206,6 +206,12 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *=
hdev, u16 opcode, u32 plen,
> >                 return ERR_PTR(err);
> >         }
> >
> > +       /* If command return a status event skb will be set to NULL as =
there are
> > +        * no parameters.
> > +        */
> > +       if (!skb)
> > +               return ERR_PTR(-ENODATA);
> > +
> >         return skb;
> >  }
> >  EXPORT_SYMBOL(__hci_cmd_sync_sk);
> > @@ -255,6 +261,11 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev,=
 u16 opcode, u32 plen,
> >         u8 status;
> >
> >         skb =3D __hci_cmd_sync_sk(hdev, opcode, plen, param, event, tim=
eout, sk);
> > +
> > +       /* If command return a status event, skb will be set to -ENODAT=
A */
> > +       if (skb =3D=3D ERR_PTR(-ENODATA))
> > +               return 0;
> > +
> >         if (IS_ERR(skb)) {
> >                 if (!event)
> >                         bt_dev_err(hdev, "Opcode 0x%4.4x failed: %ld", =
opcode,
> > @@ -262,13 +273,6 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev,=
 u16 opcode, u32 plen,
> >                 return PTR_ERR(skb);
> >         }
> >
> > -       /* If command return a status event skb will be set to NULL as =
there are
> > -        * no parameters, in case of failure IS_ERR(skb) would have be =
set to
> > -        * the actual error would be found with PTR_ERR(skb).
> > -        */
> > -       if (!skb)
> > -               return 0;
> > -
> >         status =3D skb->data[0];
> >
> >         kfree_skb(skb);
> > --
> > 2.43.0
>
> There is something not quite right with this one, it seems to be
> causing some errors with the likes of mgmt-tester in particular 'Read
> Ext Controller Info', for some reason the index is not 0 so I suspect
> something is not working as intended due to these changes.

Nevermind, the culprit is another change.

> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
