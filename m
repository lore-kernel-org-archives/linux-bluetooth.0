Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF42302156
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049298; cv=none; b=J/6zVUyAdPh1VARO1ge7eQyJ7cCX50FYXyswVymvbPkPBpeaLf8+TOW49okTSf/65r8H/9FVdG31A/XbpWvpjr1L0It69z5VkOQiC3awBVO/YWnxulCokA2ubzRy+SfUFpHI4TIy1FUUqRzO/Qcwbe4w1eEYvOJG+lBKUj/K6kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049298; c=relaxed/simple;
	bh=qnunkpHgdL88oStyrB9Og3L10aA7Nv+B1YUWHupfaeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m20Sbb+CBFeWG1ksRHiMqfvBBh5IRKBO/Z7vMOstUwsvXU44UfonMqNG41QO8L8I84d/Ywfk4F3ovN0Tg9mK00o5XBjT7k2vy4EzGWLKkMjlS+jTfnA3cTpoggfjikfBfyzmScO2QFtXX6/IxNKAp1LLTESLiHUN8gRzpwkfx4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTVgCHy6; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTVgCHy6"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37a34702a20so8126941fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 07:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763049294; x=1763654094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzjM/KW6EVcnW1f41H5c7iD7raLHQrtmC2HRbV+2gNo=;
        b=KTVgCHy6DLc0nlBg+bU6eyWTgEvTTDb2ZIWeRWVK1q2dufW0X7BuMq3hFLOkdPzz5H
         cTvX+73FIwDOZY2ic+SkJbhK+zMc35bIbwzItbjNKyuWuST36bU2oFqZOwkqxnotOAKx
         A0elLrHwaZVgqWFCPG7OLHU0zJ+6ldFm3pCJYpAjH4zAe14iL080VOiJ4HOknrgQPRKJ
         D67waZN8uDBgZhpiK4Fw1HDDVxIxzRmbLd8oelcflRDUKC7SSY0N/TdGwsEVjs1sTRGV
         syiBM1FRAIZT1/Hp9KQAm7jhz+pXHQSC3F4WzbfgPnrHlH8HzxxAHvjh15iAEH9UmyNZ
         7jRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049294; x=1763654094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tzjM/KW6EVcnW1f41H5c7iD7raLHQrtmC2HRbV+2gNo=;
        b=Vsouwz5b08BEwT3txSvPWPQFU/+9JXGxW9/x2NaDbzl93Pr5nmgp17Su1J7bPtBTio
         GUESO/LNRsh6R0b6cqNDw+38bF+LXpy9dB1/tPkjEIrUVzYBg54ZUgJEE64XiSgtvTgl
         VgdUW4y9bQRkSvvMDGimf8KBtEeuRLQfHONV4aegiP3gdCwereEB43z/lFw1W6VjVz7I
         wY89UKINONDuF8nqfqF02/EkeNarYELD/+Pnj6mBoKmnWjIyPugYR4i8Jrjb+lGFFR4/
         7d+vvEy8Yac5zAU2mYi69y9+OrvgAeQHM7D6wIz+4ZO67Kt/VqkMcvgwViFHzDxYJafK
         M08w==
X-Forwarded-Encrypted: i=1; AJvYcCV09VQtdOizYcUFhCq40c1TswSjM72K/Z038uSETWGuRgOyBJ2W3L7n6HaUnuMwMR+IxOexQzV8fqnHRWauSyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHWErvg5tsE9pwCbiNdS31ivgOysGXJ3Gn8a/+j3UHngx0ok1y
	M1EcBY5Jt3CZl7KfZ7hLH4p3EQFWH9w467uBnVZbI8E1baHQjKObCLQuYPujptg63C4fVqsxZ9E
	Eka12tVqGicEnJ/2Kkyj9GvCTVZqtkR0=
X-Gm-Gg: ASbGnctqLqgX9uPYjUjC5NiO30lh1r+gx6X67U35DD+eTWi/BfmuXZs1jMcnUjcSbl+
	t8boY4ZL3Np6HK2e+vQG0t0Fu81egspWXmrUoPVEGfktzeWS2gzesIPVNqTpWCyplMbDZxe4lWv
	T3DY8QmiXvFpt1xH4jiOCpKAP09CZjpLSEU8ltVkgerbrp+BEMKUuEeqGISS7HxZTTJHu2sPE0+
	PmL6+1fuS6ihAdPW/lHknC++lLb6kc7EU2zSogSniUKSdx/2Fa7ncx+QtH/hPgdRDU3Ew==
X-Google-Smtp-Source: AGHT+IFF3d8l8hKkFNN3WpNDMaeU54TNVuY/IQPhXpaqWIN2fluhDY6tdcKvbu5SZZFbVH1WlZBmwPlKzn/LFs+NKEg=
X-Received: by 2002:a05:651c:41d5:b0:37a:2d23:9e90 with SMTP id
 38308e7fff4ca-37b8c349116mr20936411fa.15.1763049294152; Thu, 13 Nov 2025
 07:54:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112094843.173238-1-13875017792@163.com> <20251113061117.114625-1-13875017792@163.com>
In-Reply-To: <20251113061117.114625-1-13875017792@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 13 Nov 2025 10:54:40 -0500
X-Gm-Features: AWmQ_blvczs3HH-VhTGl0hZ9vAEVEHq4woa2SGmawlb6nkgx3ZBGn_-2SLlYyRM
Message-ID: <CABBYNZKiyj9G6O9HZFh2PArD2uebh5cEG_xFzWXrNZ_dD=pudQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: Process Read Remote Version evt
To: Gongwei Li <13875017792@163.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gongwei Li <ligongwei@kylinos.cn>, 
	Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 13, 2025 at 1:12=E2=80=AFAM Gongwei Li <13875017792@163.com> wr=
ote:
>
> From: Gongwei Li <ligongwei@kylinos.cn>
>
> Add processing for HCI Process Read Remote Version event.
> Used to query the lmp version of remote devices.
>
> Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> v1->v2: Add bt_dev_dbg to print remote_ver
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_event.c        | 25 +++++++++++++++++++++++++
>  net/bluetooth/mgmt.c             |  5 +++++
>  3 files changed, 31 insertions(+)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 9efdefed3..424349b74 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -750,6 +750,7 @@ struct hci_conn {
>
>         __u8            remote_cap;
>         __u8            remote_auth;
> +       __u8            remote_ver;
>
>         unsigned int    sent;
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 7c4ca14f1..762a3e58b 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3738,6 +3738,28 @@ static void hci_remote_features_evt(struct hci_dev=
 *hdev, void *data,
>         hci_dev_unlock(hdev);
>  }
>
> +static void hci_remote_version_evt(struct hci_dev *hdev, void *data,
> +                                  struct sk_buff *skb)
> +{
> +       struct hci_ev_remote_version *ev =3D (void *)skb->data;
> +       struct hci_conn *conn;
> +
> +       bt_dev_dbg(hdev, "");
> +
> +       hci_dev_lock(hdev);
> +
> +       conn =3D hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->hand=
le));
> +       if (!conn)
> +               goto unlock;
> +
> +       conn->remote_ver =3D ev->lmp_ver;
> +
> +       bt_dev_dbg(hdev, "remote_ver 0x%2.2x", conn->remote_ver);
> +
> +unlock:
> +       hci_dev_unlock(hdev);
> +}
> +
>  static inline void handle_cmd_cnt_and_timer(struct hci_dev *hdev, u8 ncm=
d)
>  {
>         cancel_delayed_work(&hdev->cmd_timer);
> @@ -7523,6 +7545,9 @@ static const struct hci_ev {
>         /* [0x0b =3D HCI_EV_REMOTE_FEATURES] */
>         HCI_EV(HCI_EV_REMOTE_FEATURES, hci_remote_features_evt,
>                sizeof(struct hci_ev_remote_features)),
> +       /* [0x0c =3D HCI_EV_REMOTE_VERSION] */
> +       HCI_EV(HCI_EV_REMOTE_VERSION, hci_remote_version_evt,
> +              sizeof(struct hci_ev_remote_version)),
>         /* [0x0e =3D HCI_EV_CMD_COMPLETE] */
>         HCI_EV_REQ_VL(HCI_EV_CMD_COMPLETE, hci_cmd_complete_evt,
>                       sizeof(struct hci_ev_cmd_complete), HCI_MAX_EVENT_S=
IZE),
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index c11cdef42..9b8add6a2 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -9745,6 +9745,9 @@ void mgmt_device_connected(struct hci_dev *hdev, st=
ruct hci_conn *conn,
>  {
>         struct sk_buff *skb;
>         struct mgmt_ev_device_connected *ev;
> +       struct hci_cp_read_remote_version cp;
> +
> +       memset(&cp, 0, sizeof(cp));
>         u16 eir_len =3D 0;
>         u32 flags =3D 0;
>
> @@ -9791,6 +9794,8 @@ void mgmt_device_connected(struct hci_dev *hdev, st=
ruct hci_conn *conn,
>         ev->eir_len =3D cpu_to_le16(eir_len);
>
>         mgmt_event_skb(skb, NULL);
> +
> +       hci_send_cmd(hdev, HCI_OP_READ_REMOTE_VERSION, sizeof(cp), &cp);

This should probably be made into hci_event.c and write a helper in
hci_sync.c that properly queues the command instead of using the
hci_send_cmd to send the command directly.

>  }
>
>  static void unpair_device_rsp(struct mgmt_pending_cmd *cmd, void *data)
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz
