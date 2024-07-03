Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781CD17BB17;
	Wed,  3 Jul 2024 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720016745; cv=none; b=QZeINkVQYakpPHjy+NBSuRlJ8qEttIa/gp7MSaWUHN5n5N0/xBr21igAjLTgmTpHBXQKNwP62Prhgj2KdmklK5LgK33EmPmmA6/z75mjKijx0MuLnonYXoCBHYsU7Tux5HEzjlCpA4It9e98LAajoJbQFgpq+3HUXZD2guBckro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720016745; c=relaxed/simple;
	bh=RLBDeWJJnciluhpKNeNW05gnO5DYZt8QYueK8TTf1XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMj6BEnx/Hf08di/9KF6HW7u7iVGpd2cXoK9uuK9X1N5MM2sTKVyxmnkMRixHVlEIdllcCrZ2u6vD+yWOPtv2IgYmNfWsAsLq+0cbkvGQQpj5OymUqD7G/q7hW3axNrB54cOHicTyszuZQlr8ViaABpU+AlLbsKaf3FyTuLS3C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFdEzpU1; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFdEzpU1"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ec408c6d94so56373721fa.3;
        Wed, 03 Jul 2024 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720016741; x=1720621541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1/QGpys67tuMelSYVoj+4DsPH18BLPCFczi/cUE7E4=;
        b=LFdEzpU1ac/h/uKu8lS3O12jc4p4YXmWZ0jTWKL1yhrOKd+15MpjLGUl8AdItVVqVm
         TROHjdFJpJ4sI2ad4wtEY+U1LUdBiQdAQ61tMFJCV5gwfa7ZNbqSj/uDaP+Ljvd3y/LZ
         XoE3Bhuo66EAHbAjjJrreIji09PQx/qwWCkCbhrQ5pFGDxaqty2ng//zEcZTv5N/g6GW
         LXrdqiWKibcKOl9ng1TdeMXq/C0XRvFBhCVN1T1CixOg7Sc3Qr4lQpd91qTMQIND+vNZ
         PJ/4771f3+dYxKdpLwJXElcqxvM1Wp7kEsgYjoX0zpL4gBNZZa7Ua0KjHLPgOsY48tab
         fpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720016741; x=1720621541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1/QGpys67tuMelSYVoj+4DsPH18BLPCFczi/cUE7E4=;
        b=dDCecg5+rFWj6FsQMnp7BG6Gozgtu+tzTOQqL/mng7f+laQfDqkoVTxr+NYEDg1Eck
         LyGqSNqz9z7fg1oKUpzBHlGbQ2dnlKvuq0D50CdlWbynMtnxFzdJvrVAu2fwnM/TPSks
         yDXlxnRxe1exL7elu4s3ivOAG2NFRn73k1QEldID6UojADhO9p9IwW6sCpQpCQp4fT78
         N01S20ydBb01WogQYttCHbH1TBrfNnNrvzZjbRLHDSca7gjCdkXfOhsMzaDlYiROcqPe
         QtJCg2cjwfeHWBfy7qtmBqyOJter6benz8WfMDHk9fWGgbqOIG542ZsRBzN+jfDJ+rIP
         ly0A==
X-Forwarded-Encrypted: i=1; AJvYcCV6thoMcjWu2pWphfLuIVC6nbJJ1onRvs+uYqnMnv+7BZ1ELkeWkXG4L0RXX5WkBxLd7fZ2yq5YkwTMfrVxX60HUZ0vpa+vVHQgZlcHjQDe2nZf0W/9gTElfEsR5YdA86Kii+7Tj9MtZFWUESxl
X-Gm-Message-State: AOJu0YzsYaK6J2ZacUEtN4JpSi2IbNe4/uC+TweIXpoWPtw7eksNqboZ
	QqsH8jSsbnJfMofZd50xSvMcFQxtl5OjayUL/eE62EgBmxs2QTyAzOAQ0+TJavKaptuqgOGCHu/
	rk+C3FGCnusBenmA2VpD/agmxB7U=
X-Google-Smtp-Source: AGHT+IGGxoob76qWvpX08mtOXO1RKDafeqXegfSyr0+CJ4sRJU9QMdm8JZnmPY7OQFK7MeDbnwskN6oMntcPd0IPNnQ=
X-Received: by 2002:a2e:a786:0:b0:2ec:56ce:d51f with SMTP id
 38308e7fff4ca-2ee5e3adc1dmr91206141fa.20.1720016741337; Wed, 03 Jul 2024
 07:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703113936.228226-1-iam@sung-woo.kim>
In-Reply-To: <20240703113936.228226-1-iam@sung-woo.kim>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Jul 2024 10:25:27 -0400
Message-ID: <CABBYNZJBmbjB6ZwT7JogaABE3d0-vWwNQq4NwUGCHsmgNuKXLA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: daveti@purdue.edu, benquike@gmail.com, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 3, 2024 at 7:40=E2=80=AFAM Sungwoo Kim <iam@sung-woo.kim> wrote=
:
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
> Fixes: 8961987f3f5f ("Bluetooth: Enumerate local supported codec and cach=
e details")
> Fixes: 9ae664028a9e ("Bluetooth: Add support for Read Local Supported Cod=
ecs V2")
>
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> ---
>  net/bluetooth/hci_codec.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
> index 3cc135bb1..5c98eec2c 100644
> --- a/net/bluetooth/hci_codec.c
> +++ b/net/bluetooth/hci_codec.c
> @@ -74,6 +74,9 @@ static void hci_read_codec_capabilities(struct hci_dev =
*hdev, __u8 transport,
>
>                         skb =3D __hci_cmd_sync_sk(hdev, HCI_OP_READ_LOCAL=
_CODEC_CAPS,
>                                                 sizeof(*cmd), cmd, 0, HCI=
_CMD_TIMEOUT, NULL);
> +
> +                       if (!skb)
> +                               skb =3D ERR_PTR(-EINVAL);
>                         if (IS_ERR(skb)) {
>                                 bt_dev_err(hdev, "Failed to read codec ca=
pabilities (%ld)",
>                                            PTR_ERR(skb));
> @@ -129,6 +132,8 @@ void hci_read_supported_codecs(struct hci_dev *hdev)
>         skb =3D __hci_cmd_sync_sk(hdev, HCI_OP_READ_LOCAL_CODECS, 0, NULL=
,
>                                 0, HCI_CMD_TIMEOUT, NULL);
>
> +       if (!skb)
> +               skb =3D ERR_PTR(-EINVAL);
>         if (IS_ERR(skb)) {
>                 bt_dev_err(hdev, "Failed to read local supported codecs (=
%ld)",
>                            PTR_ERR(skb));
> @@ -198,6 +203,8 @@ void hci_read_supported_codecs_v2(struct hci_dev *hde=
v)
>         skb =3D __hci_cmd_sync_sk(hdev, HCI_OP_READ_LOCAL_CODECS_V2, 0, N=
ULL,
>                                 0, HCI_CMD_TIMEOUT, NULL);
>
> +       if (!skb)
> +               skb =3D ERR_PTR(-EINVAL);
>         if (IS_ERR(skb)) {
>                 bt_dev_err(hdev, "Failed to read local supported codecs (=
%ld)",
>                            PTR_ERR(skb));
> --
> 2.34.1


There is something that doesn't quite add here, we don't return NULL
on __hci_cmd_sync_sk, if there is an error it will always return
ERR_PTR or perhaps this is the result of rsp_skb being NULL in which
case we shall check it and actually return ERR_PTR directly from
__hci_cmd_sync_sk but Id like to understand under what circumstances
does rsp_skb can be NULL.


--=20
Luiz Augusto von Dentz
