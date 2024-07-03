Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E669D2BD19;
	Wed,  3 Jul 2024 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042533; cv=none; b=FWIANAgeKgv596otCcFsmNBLq4ThsAN9TfXHm8PtbnaxdAxsuj2MuCI1+aynvPWkhydtX7dWHBJD8XNmTH1EWmxQxvXAJ3NBj3G+T7tjsBb71sKq1j+c+GJA96G4BfJt+SQWytzQ5MMngz14eSrbnGrhlHLBbm+DVJcrJZzNOPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042533; c=relaxed/simple;
	bh=/POmpkkhYgWy/mPXPlQ0eeNoV4b6IxjYKaHnNCCVWp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WM2aBCJ18271+DokyrpS6dzrp7Uj3/a8fGAus4jlsZRt85OkUpZ68AhzeBcrMBJFzuJ4UATcBx2BUGd0G+3Dzur+qTBEILxizrAAhZEo/G7vAG5kCS2BJOdtVS4dwHrnZBaTdotJCqeRdbe7vHk66U29ybxpM7Qn5C+290++t4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so72467561fa.3;
        Wed, 03 Jul 2024 14:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042530; x=1720647330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLHZAIDRfl5jGy8ERupwEr0NqHp1u+e8SRdFl8K/+nw=;
        b=Pe19pg5LLQKLQpeslIJVejWXkMIR9eEvrZf6uZaWPRz7O2fm50Oor70CJwhwKnYPqG
         3cGUNC+lpxdrZFbl/MaB5QbUgGY3QC9rpVLP75G+cl5bisq+Jwhu8k2Dw3uhSe28DQVu
         fNw4CwPjpL0CUtk5NOFWNf24MWiftUm+YlxU2euNhrmYBNftBiAZh7B6N/xI+Xn8IP5F
         zx5JqHT8YlS2c5ITBg4bJd9ai6fPn4Lq2btMJupJwSKPYTWpHJT+YRPLzhb+F6T4+gGY
         avUS904y8x6RKCR2dJRmPa/CgusOUZw9BulPpcV+dj/MhzokovaNop+wpSwZHMycpGD9
         Wqrw==
X-Forwarded-Encrypted: i=1; AJvYcCUtbEwcPkNhLA+z/2m3VYXdI8DbP5jHismEoTGkJrGjt+xPMGvcDEWo0ZRNaZSd8kqYXol45cnEGbjMAy78XcwyzqOTVWZGtGb0KXzQJfdjJfMrz4BV8qOQy7AzSMty8y1S1kHadmAnVPDb5gbw
X-Gm-Message-State: AOJu0YxjhcGn7RvnEOyAHGoOSiKiBx22BRBp84ZtGjSBPaAX5jW6SJ/s
	9QCcSssI4BRWKKA2JdpRK7W2DXhDza6/lPh/fos1rD8s3dUe5LxfHZy8Z5J+2jk=
X-Google-Smtp-Source: AGHT+IGzkOHfqvSIUQFs+AGddCaoB8CxbWoxklvFUYSESRjm8CpmAHlK10wvXaOP1UeTHjT7YlXiIg==
X-Received: by 2002:a05:6512:1253:b0:52c:dfa7:53a0 with SMTP id 2adb3069b0e04-52e82701713mr7683528e87.48.1720042527851;
        Wed, 03 Jul 2024 14:35:27 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab3b401sm2281583e87.287.2024.07.03.14.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 14:35:27 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52cdfb69724so7117218e87.1;
        Wed, 03 Jul 2024 14:35:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVk2DgK4wiy5j16B3PTwMmw688cOUydMBzMWPv2rBmDkg/ca/YIcKBxujpSx1Iloef3uuA/ueOwuqVZn2OjV78RwQ0bRwpjsL56clIJIGzd8SrfqVL1haYPw4hWWAFfCfRhJGiaTr+zY+HmQ0Q5
X-Received: by 2002:a05:6512:3993:b0:52c:e030:144e with SMTP id
 2adb3069b0e04-52e827016e4mr8601776e87.47.1720042527348; Wed, 03 Jul 2024
 14:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703113936.228226-1-iam@sung-woo.kim> <CABBYNZJBmbjB6ZwT7JogaABE3d0-vWwNQq4NwUGCHsmgNuKXLA@mail.gmail.com>
In-Reply-To: <CABBYNZJBmbjB6ZwT7JogaABE3d0-vWwNQq4NwUGCHsmgNuKXLA@mail.gmail.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Wed, 3 Jul 2024 17:35:10 -0400
X-Gmail-Original-Message-ID: <CAJNyHpKJumXFTe2eExjuQAuewsVkm52DgKBGxRtmdo0ThT1V9A@mail.gmail.com>
Message-ID: <CAJNyHpKJumXFTe2eExjuQAuewsVkm52DgKBGxRtmdo0ThT1V9A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: daveti@purdue.edu, benquike@gmail.com, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Wed, Jul 3, 2024 at 10:25=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Wed, Jul 3, 2024 at 7:40=E2=80=AFAM Sungwoo Kim <iam@sung-woo.kim> wro=
te:
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
> > Fixes: 8961987f3f5f ("Bluetooth: Enumerate local supported codec and ca=
che details")
> > Fixes: 9ae664028a9e ("Bluetooth: Add support for Read Local Supported C=
odecs V2")
> >
> > Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> > ---
> >  net/bluetooth/hci_codec.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
> > index 3cc135bb1..5c98eec2c 100644
> > --- a/net/bluetooth/hci_codec.c
> > +++ b/net/bluetooth/hci_codec.c
> > @@ -74,6 +74,9 @@ static void hci_read_codec_capabilities(struct hci_de=
v *hdev, __u8 transport,
> >
> >                         skb =3D __hci_cmd_sync_sk(hdev, HCI_OP_READ_LOC=
AL_CODEC_CAPS,
> >                                                 sizeof(*cmd), cmd, 0, H=
CI_CMD_TIMEOUT, NULL);
> > +
> > +                       if (!skb)
> > +                               skb =3D ERR_PTR(-EINVAL);
> >                         if (IS_ERR(skb)) {
> >                                 bt_dev_err(hdev, "Failed to read codec =
capabilities (%ld)",
> >                                            PTR_ERR(skb));
> > @@ -129,6 +132,8 @@ void hci_read_supported_codecs(struct hci_dev *hdev=
)
> >         skb =3D __hci_cmd_sync_sk(hdev, HCI_OP_READ_LOCAL_CODECS, 0, NU=
LL,
> >                                 0, HCI_CMD_TIMEOUT, NULL);
> >
> > +       if (!skb)
> > +               skb =3D ERR_PTR(-EINVAL);
> >         if (IS_ERR(skb)) {
> >                 bt_dev_err(hdev, "Failed to read local supported codecs=
 (%ld)",
> >                            PTR_ERR(skb));
> > @@ -198,6 +203,8 @@ void hci_read_supported_codecs_v2(struct hci_dev *h=
dev)
> >         skb =3D __hci_cmd_sync_sk(hdev, HCI_OP_READ_LOCAL_CODECS_V2, 0,=
 NULL,
> >                                 0, HCI_CMD_TIMEOUT, NULL);
> >
> > +       if (!skb)
> > +               skb =3D ERR_PTR(-EINVAL);
> >         if (IS_ERR(skb)) {
> >                 bt_dev_err(hdev, "Failed to read local supported codecs=
 (%ld)",
> >                            PTR_ERR(skb));
> > --
> > 2.34.1
>
>
> There is something that doesn't quite add here, we don't return NULL
> on __hci_cmd_sync_sk, if there is an error it will always return

The skb can be NULL if a command returns a status event as there are
no parameters.

> ERR_PTR or perhaps this is the result of rsp_skb being NULL in which
> case we shall check it and actually return ERR_PTR directly from

If returning NULL is not intended, we should also remove a NULL
checking in __hci_cmd_sync_status_sk().

We can do this:
https://gist.github.com/swkim101/5346b4ce5d2b1d4be95ef8dbdcbd9820

> __hci_cmd_sync_sk but Id like to understand under what circumstances
> does rsp_skb can be NULL.

>
>
> --
> Luiz Augusto von Dentz
>

Thanks,
Sungwoo.
