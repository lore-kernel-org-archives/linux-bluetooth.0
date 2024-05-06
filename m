Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4F413DDD2;
	Mon,  6 May 2024 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016336; cv=none; b=Jg6wjLs5jO8xS/vPX0eWUN/24zAkbisJ8UX3SFNVgkXfUd+6bd3ApHWfMqBP3WFq8m95mKbUyLU+rHucUZePyN0YYhN8QnPp6mSpAKeNhZWp03Dpy651/4QuXtyR6QQ/K9cwxKiSX6QJpHHDJYaWNHiINDRXuYeLv7aaGqpW4M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016336; c=relaxed/simple;
	bh=QbjlCOhO3X6SirjjksKEpwib8y+ESglXZO/TxYTLekk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sP2l+/pyfm5ipn2v0oK1HAb5/SlfNKW5bKRCaaFn3z/wwqRGvceTRjzfV24G+D24XzhTfqdvNpJa6UdJfDusE66yuORHI7Np/sGvxcIg6uag6IJkD7SLWMSsatCTmik3VQQ1GqFe/epDImX1786pJtjiO8xUPVdU79yN5mEPUMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jx9opyvl; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jx9opyvl"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e3e18c240fso177441fa.0;
        Mon, 06 May 2024 10:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715016333; x=1715621133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlSTRPnhOb9YugNVwB0fhclhKlg1U2+rfxRwVC8H+3o=;
        b=jx9opyvlYv/OxTZztrIq+O8C7r2v6axlcOVKchfEInH1YGuNogGbXX0txJm4OXIOh/
         a7cs89kIKTiItGldrnjN5jv65j/TwrlIPMsPDN3WdEO5VwwllCD5gv8TC5wzIpGropV4
         G+X0Ju8c2EgiIB8yctlYFM1ztMCzbMvUf4pUtLeCnWfZl6a/02Z3E9F2tuWbe4P3W3Hj
         xk9lHWNR83bD0rDdIZ7EAt5oxQEnu1ZbsD8b8KzQc6dSquo7b+9g9zRHTKb2+t7X/tul
         WPNYVI8nWtwfLy94hlAb1bLhITd2Iqt4yRltDnRkn41zbraICQ9akuLzU7Abw2bV3lhx
         eGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715016333; x=1715621133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlSTRPnhOb9YugNVwB0fhclhKlg1U2+rfxRwVC8H+3o=;
        b=D/ebVVwLLQvLh8bkP6MUjCepgiR1iDaOrKjLD6mqIPMFQ2/KzeI4FMqIVqL0QtI70L
         wd5Gpq91HCxip9El4e28tlhuUEBqRJ0q9XhUiTY7jWksJanLVGMgExNIYBEfi4aHirVc
         aDLhVU2vyHa4zFjds4TBsPbb0cs8Jj2t0UtYv8+jxJsxH8SZiFxy/2AOY7fVHIK9vH8y
         M8oavfN0fwIc2AahZhMc9jaDeY+o3oEeZZSTfcgsoLbKX9/KZmaougd0+g8Q0X0zSCYj
         tnOCsQvw6Gmqq6LOdIfSrNn6gj4SoOcld9PZiUhJhyV6S2HAByt1R9Jx7ZLpFaYYeNy1
         /1/w==
X-Forwarded-Encrypted: i=1; AJvYcCVWmE6c4G2cT5pz/NWW0DJs92MUf/jhn7Z9WQBYjP9CWkGfXTgRi2hYN83/2614lyniSIvFqNWz2pvGaGXzMUgBAjpFvCabBnsV2TZ6uARnVHe/5ehtOBb1RWYe1/br/+Ugvu3C2krfDbq+dio8
X-Gm-Message-State: AOJu0Yw+kN44zhFZBOhCwEEm45bRTZ4xDpkgKY5I9wVaELLJWwpPjq7p
	0CgvKLctt4Gq0d8I86S42h2Ap1KGPXnKrj7OhaxZ6M0Vr1XlLbx9TiAgrsN2oyus2HGKRucYrbh
	gPI7sFIdQE4/bZETj3dC83BE/Abw=
X-Google-Smtp-Source: AGHT+IE5IAuXqwrHSF2S6NDVOy+UTtC7fVhprycyI+gVY/X+RAwA9koL/O02RD9Mv9Y4RKVYPeP7BwOxWaYZ249mWr8=
X-Received: by 2002:a2e:b8d2:0:b0:2da:7944:9547 with SMTP id
 s18-20020a2eb8d2000000b002da79449547mr11484426ljp.5.1715016332375; Mon, 06
 May 2024 10:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506022035.663102-1-iam@sung-woo.kim>
In-Reply-To: <20240506022035.663102-1-iam@sung-woo.kim>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 6 May 2024 13:25:19 -0400
Message-ID: <CABBYNZJPA_a0LmAArNcV4pyskhyeXzSRpe98Ksf=BSZ56ZA0zA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: HCI: fix divide error in __get_blocks()
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: daveti@purdue.edu, benquike@gmail.com, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 5, 2024 at 10:21=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wrot=
e:
>
> hdev->block_len could be 0. Fix this by adding a check.
>
> divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 0 PID: 9622 Comm: kworker/u5:4 Tainted: G        W          6.9.0-rc=
6-00001-g38e1170f515d-dirty #32
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> Workqueue: hci11 hci_tx_work
> RIP: 0010:__get_blocks net/bluetooth/hci_core.c:3618 [inline]
> RIP: 0010:hci_sched_acl_blk net/bluetooth/hci_core.c:3766 [inline]
> RIP: 0010:hci_sched_acl net/bluetooth/hci_core.c:3806 [inline]
> RIP: 0010:hci_tx_work+0x73e/0x1d10 net/bluetooth/hci_core.c:3901
>
> Fixes: b71d385a18cd ("Bluetooth: Recalculate sched HCI blk/pkt flow ctrl"=
)
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> ---
>  net/bluetooth/hci_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 0efd59760..20b1cd7f3 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3762,7 +3762,7 @@ static void hci_sched_acl_blk(struct hci_dev *hdev)
>
>         __check_timeout(hdev, cnt, type);
>
> -       while (hdev->block_cnt > 0 &&
> +       while (hdev->block_len > 0 && hdev->block_cnt > 0 &&
>                (chan =3D hci_chan_sent(hdev, type, &quote))) {
>                 u32 priority =3D (skb_peek(&chan->data_q))->priority;
>                 while (quote > 0 && (skb =3D skb_peek(&chan->data_q))) {
> --
> 2.34.1

Hmm, this code shall probably be removed as well since
HCI_FLOW_CTL_MODE_BLOCK_BASED was sort of tight to AMP support which
we have removed support for, anyway this is failing late actually
since we might have to check this during hci_conn_add with:

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 171a667bc991..73b9d08438fe 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -907,8 +907,16 @@ struct hci_conn *hci_conn_add(struct hci_dev
*hdev, int type, bdaddr_t *dst,

        switch (type) {
        case ACL_LINK:
-               if (!hdev->acl_mtu)
-                       return ERR_PTR(-ECONNREFUSED);
+               switch (hdev->flow_ctl_mode) {
+               case HCI_FLOW_CTL_MODE_PACKET_BASED:
+                       if (!hdev->acl_mtu)
+                               return ERR_PTR(-ECONNREFUSED);
+                       break;
+               case HCI_FLOW_CTL_MODE_BLOCK_BASED:
+                       if (!hdev->block_mtu)
+                               return ERR_PTR(-ECONNREFUSED);
+                       break;
+               }
                break;
        case ISO_LINK:
                if (hdev->iso_mtu)
@@ -966,7 +974,14 @@ struct hci_conn *hci_conn_add(struct hci_dev
*hdev, int type, bdaddr_t *dst,
        switch (type) {
        case ACL_LINK:
                conn->pkt_type =3D hdev->pkt_type & ACL_PTYPE_MASK;
-               conn->mtu =3D hdev->acl_mtu;
+               switch (hdev->flow_ctl_mode) {
+               case HCI_FLOW_CTL_MODE_PACKET_BASED:
+                       conn->mtu =3D hdev->acl_mtu;
+                       break;
+               case HCI_FLOW_CTL_MODE_BLOCK_BASED:
+                       conn->mtu =3D hdev->block_mtu;
+                       break;
+               }
                break;
        case LE_LINK:
                /* conn->src should reflect the local identity address */

--=20
Luiz Augusto von Dentz
