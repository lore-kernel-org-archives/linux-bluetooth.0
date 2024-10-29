Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019B61DDC3B;
	Tue, 29 Oct 2024 02:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730169702; cv=none; b=Cr60J4E1gsXxjY4slkwtEWHnmlZbVcs1S0WPOgLiituumrKPsKDzb+Ii/dYAdtjm+UoJeI8p7eoP0GQ3Tu4GjHXcDgN4Ohs/MIoLLEDbZygMRirCNbqQ7LVZ/2uz0Hh1NvJsZAkmogBYxBhfyPPw75QNUkIlqNHXKcdfNAtQwio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730169702; c=relaxed/simple;
	bh=QdRL8aQT/fsoGRqQ/aRmgF0WrC4Eq31ywdR0gAQ2Sto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpp6+XFsgccBG5ARMESoSPTYpKJex94E1v0iDaQNjabe0oP967SN2d5WQ64pp0Z8OPXUsE1rLHdyLc/5NPC3RVpB7l8rgPxA541YcJFkyvVQ6ZbJSddo5+4+L+02GP7FYZIt0WWuE0vKWHVMQm6f4KLhayM4Jwy0WqMTSt0oahI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539983beb19so5904393e87.3;
        Mon, 28 Oct 2024 19:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730169698; x=1730774498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqfq1qXdhdY1azJDVm4y9eX03VQ14BLURIuXYXjfQJg=;
        b=kmQD96ZZRKmXH3HLZ9IAnGUzSZ7jbfzfd7L92O03mIc41EvEIKZbfBHAmQHO2QdBlz
         R0frJ1QC3kgs+ig1A1qRlkK8pYrKcuKK9orXKPgt9WdU41zLXGffsOlcACZQUwEror/6
         2fk+JX+YvsOqS9/7p1o/YXyaRSWeotGsmpQDXpVlETRPhZ+A2qcVGVHzePqS90m5rsuo
         VFQsBBp1RmtHD/yAcsSGlctmsj69KsV+6VnbxdlICqIWle9Vh6mXIyIw9q+1XkHlTS1C
         Dt6WrkzJ5dnOqsk+o+xJShUymfUP++jhg0V57SIrDU5rJJdrZnPiTGgyUY4Fu4NXVsqw
         b6uA==
X-Forwarded-Encrypted: i=1; AJvYcCVMFfm8+3Tt/jVF3+HMF4RpzvlwhVDrlpyzuz0U8qyIJHpusgKoxUZjhiB7heOoWyKTcdQi02GAxBwbxhZno0U=@vger.kernel.org, AJvYcCWYtcRNR10Fl95nEB3NRTmW9yiBw2G++cG8nTuuf5Fwn6FgVA2Q9g6IbJFUa3DQOGSgbRNG1Yo6GpF/X1n0@vger.kernel.org
X-Gm-Message-State: AOJu0YzU6/sj0jRDLOy5TEak9HOf2dIdLsYTDS2gPA+goFw3oe6NnYjL
	FvyE9BXZxp0QBsvUDG2qaK2KmgjIGmJj2CV8Uo1A77HpIfCLTun1bnj8c6o+pdk=
X-Google-Smtp-Source: AGHT+IE5nVrOosDIQB5j4D/yRA2gkmssI9BMv9qHk24BUL2t06oIu3kjiZo74jpTqLi0T9vc+wc/GQ==
X-Received: by 2002:a05:6512:23a3:b0:539:8b49:8939 with SMTP id 2adb3069b0e04-53b3490efcdmr4345220e87.41.1730169697406;
        Mon, 28 Oct 2024 19:41:37 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1eab9asm1266876e87.273.2024.10.28.19.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 19:41:37 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539983beb19so5904386e87.3;
        Mon, 28 Oct 2024 19:41:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWtlk9vqXeUE/bcOz1l8dxhNSKCqpTKVEStDDEHdw4O8q7XT7HfeYV8STHBcGwRfbf2erkC44YAYDeTqriO9ug=@vger.kernel.org, AJvYcCWz3f59qoEv5ZlyHjy3CdkE1RIBP2LeGwSvvpvmNNylsnTzWs3ooJnez9/hjPN/pTB0KnHCYY3liWrPr9X9@vger.kernel.org
X-Received: by 2002:a05:6512:ea2:b0:539:9f52:9e4 with SMTP id
 2adb3069b0e04-53b34a195e4mr4476070e87.48.1730169697024; Mon, 28 Oct 2024
 19:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706225124.1247944-1-iam@sung-woo.kim>
In-Reply-To: <20240706225124.1247944-1-iam@sung-woo.kim>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Mon, 28 Oct 2024 22:41:20 -0400
X-Gmail-Original-Message-ID: <CAJNyHp+2eAeau9peWPL7J2Mq3p26FdFzk8mPOCchxCw+26sevA@mail.gmail.com>
Message-ID: <CAJNyHp+2eAeau9peWPL7J2Mq3p26FdFzk8mPOCchxCw+26sevA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: daveti@purdue.edu, benquike@gmail.com, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Luiz, could you review this? This bug and fix are still valid but
have been forgotten for some reason.

On Sat, Jul 6, 2024 at 6:53=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wrote=
:
>
> __hci_cmd_sync_sk() returns NULL if a command returns a status event
> as there are no parameters.
> Fix __hci_cmd_sync_sk() to not return NULL.
>
> KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
> CPU: 1 PID: 2000 Comm: kworker/u9:5 Not tainted 6.9.0-ga6bcb805883c-dirty=
 #10
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> Workqueue: hci7 hci_power_on
> RIP: 0010:hci_read_supported_codecs+0xb9/0x870 net/bluetooth/hci_codec.c:=
138
> Code: 08 48 89 ef e8 b8 c1 8f fd 48 8b 75 00 e9 96 00 00 00 49 89 c6 48 b=
a 00 00 00 00 00 fc ff df 4c 8d 60 70 4c 89 e3 48 c1 eb 03 <0f> b6 04 13 84=
 c0 0f 85 82 06 00 00 41 83 3c 24 02 77 0a e8 bf 78
> RSP: 0018:ffff888120bafac8 EFLAGS: 00010212
> RAX: 0000000000000000 RBX: 000000000000000e RCX: ffff8881173f0040
> RDX: dffffc0000000000 RSI: ffffffffa58496c0 RDI: ffff88810b9ad1e4
> RBP: ffff88810b9ac000 R08: ffffffffa77882a7 R09: 1ffffffff4ef1054
> R10: dffffc0000000000 R11: fffffbfff4ef1055 R12: 0000000000000070
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810b9ac000
> FS:  0000000000000000(0000) GS:ffff8881f6c00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f6ddaa3439e CR3: 0000000139764003 CR4: 0000000000770ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  hci_read_local_codecs_sync net/bluetooth/hci_sync.c:4546 [inline]
>  hci_init_stage_sync net/bluetooth/hci_sync.c:3441 [inline]
>  hci_init4_sync net/bluetooth/hci_sync.c:4706 [inline]
>  hci_init_sync net/bluetooth/hci_sync.c:4742 [inline]
>  hci_dev_init_sync net/bluetooth/hci_sync.c:4912 [inline]
>  hci_dev_open_sync+0x19a9/0x2d30 net/bluetooth/hci_sync.c:4994
>  hci_dev_do_open net/bluetooth/hci_core.c:483 [inline]
>  hci_power_on+0x11e/0x560 net/bluetooth/hci_core.c:1015
>  process_one_work kernel/workqueue.c:3267 [inline]
>  process_scheduled_works+0x8ef/0x14f0 kernel/workqueue.c:3348
>  worker_thread+0x91f/0xe50 kernel/workqueue.c:3429
>  kthread+0x2cb/0x360 kernel/kthread.c:388
>  ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Fixes: abfeea476c68 ("Bluetooth: hci_sync: Convert MGMT_OP_START_DISCOVER=
Y")
>
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> ---
> v1 -> v2: make __hci_cmd_sync_sk() not return NULL
>
>  net/bluetooth/hci_sync.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 76b283b8e..c4e4abc6e 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -201,6 +201,12 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hd=
ev, u16 opcode, u32 plen,
>                 return ERR_PTR(err);
>         }
>
> +       /* If command return a status event skb will be set to NULL as th=
ere are
> +        * no parameters.
> +        */
> +       if (!skb)
> +               return ERR_PTR(-ENODATA);
> +
>         return skb;
>  }
>  EXPORT_SYMBOL(__hci_cmd_sync_sk);
> @@ -250,6 +256,11 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u=
16 opcode, u32 plen,
>         u8 status;
>
>         skb =3D __hci_cmd_sync_sk(hdev, opcode, plen, param, event, timeo=
ut, sk);
> +
> +       /* If command return a status event, skb will be set to -ENODATA =
*/
> +       if (skb =3D=3D ERR_PTR(-ENODATA))
> +               return 0;
> +
>         if (IS_ERR(skb)) {
>                 if (!event)
>                         bt_dev_err(hdev, "Opcode 0x%4.4x failed: %ld", op=
code,
> @@ -257,13 +268,6 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u=
16 opcode, u32 plen,
>                 return PTR_ERR(skb);
>         }
>
> -       /* If command return a status event skb will be set to NULL as th=
ere are
> -        * no parameters, in case of failure IS_ERR(skb) would have be se=
t to
> -        * the actual error would be found with PTR_ERR(skb).
> -        */
> -       if (!skb)
> -               return 0;
> -
>         status =3D skb->data[0];
>
>         kfree_skb(skb);
> --
> 2.34.1
>
