Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98412232D
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jan 2024 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295711; cv=none; b=eDWbiz4WWJczBmC2SHjd7kN0uTJxh0Y3KjW/Bx9KZN7NcfmWguO6GmVTxcy2BmUU2LBmsEzuqSL54hqnU8Hq4dM+8lBoq37YtjAOXPgdR9fFyfaNdA+uX5Rnu6/d7bSm/aRAD4nki2unWf+UTMoL8RAZxKuiQcUvRBFZPiEhZes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295711; c=relaxed/simple;
	bh=2dtJAE3olhfnRYzBSWBO4VL2i9+7eXcCBnEg/aVMOCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLPJCD1RuBiPZnYRhbG5X4vtNhZjrsa+z5wCMnlZY0aALw6pNn5oh5deF7GVUEa1A/APinupua8TJKaaLhcGqcEfoQ38SUd+cwzwgOoP/RY4Tbcq0IxAG3ZV83thZx4Jn7mcL/hANwFAGrNrBlHj0XCW2xGJ83H3TNUBCvKL//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1pR4MSS; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1pR4MSS"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cf338e1438so7482621fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jan 2024 11:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706295708; x=1706900508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyGrxJ9MwUPYz33bGO4oXV3lXOtlIo5dJXVcqmBysYU=;
        b=S1pR4MSSamoH3e33+5oUCm6RgSzOW109ImS/ITArhBNHyZViCSoITg97IYsIC3m5i9
         wpo3pKOWWZoo2JQqQP+wXcG2q2KL7bCDOhfp0tZb+iaYZsjfCex2p1q2bZL7tB7IO08X
         MzVA8ulWjywsFnDidkEewsTjwAGpDpikEvHSmPIV4By78M2foKwKK8BUx5CO32dzPNuD
         1DGT735WJw+dq90geNYTkb00Kuu392iSx1KNnKaVw7F2FoLIxxKvmvz0uHHk4vHqC0vJ
         rMvL/Bg5XEbzus4LibHuRW6pv3BdheNsNuCmanPEOL0A7odvyNC9IpzL248BRL+iNUwx
         KVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706295708; x=1706900508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyGrxJ9MwUPYz33bGO4oXV3lXOtlIo5dJXVcqmBysYU=;
        b=clVhLTIMiMTYX19nkwizXBVOotYDXHCJ42OcTneUDWD9qRv0IXPdzuH3LAd/MGXPh2
         bXKRAEIRd5bwntemnZfSUoJP1BI9rrcjkuR85C6yahpl+MKQJOqdj9ujRqrBHzaeDkxh
         NWmBIGiYXhS6tFF06OL5qV0RSlaCJp5AdJPLJoQdS6Fzxqh9jRTMid7cPY3ldyK769gR
         aTO3QBRqsFJWpKzhf5x8jSbX9hW8GrnrsOsppkA8h7tEKiYEqCPeDXfDDVwyXOTTWKak
         PMtUxbGeEvwB0MQl8NEQLxpxsPcvBPZI7Q62DhfezKO2Kadq500SbNwRjAay6PZZ2SV/
         hR5g==
X-Gm-Message-State: AOJu0YyPXsLQSj7RL3aBsE3k8Kagaz7vGh5VBoAT5MwJNgQWgLxcNJxx
	9zdtBEX41PGZUF5lKn+Ah2ZkbyfTsHGBTExI6fcRzVP7z4KD6zx4BkTxSPTJq3WJWsQFAzFAEvC
	FappqAF16/7AFSgHsZvyKUOaB4tFQifA/
X-Google-Smtp-Source: AGHT+IH1zpgEBP9/hwQKH8sEpTdRxsYXZSeBl/I0UUA/BNvBJxxT2DTclLpd+1VjYZbqGi73qK4zDF78w3jgLXSpYeU=
X-Received: by 2002:a2e:91d2:0:b0:2cd:2771:a2fb with SMTP id
 u18-20020a2e91d2000000b002cd2771a2fbmr995438ljg.2.1706295707551; Fri, 26 Jan
 2024 11:01:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126144120.Bluez.1.If74ccbca4d541c5f576765a3a78cb8923b5f85b1@changeid>
In-Reply-To: <20240126144120.Bluez.1.If74ccbca4d541c5f576765a3a78cb8923b5f85b1@changeid>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 26 Jan 2024 14:01:35 -0500
Message-ID: <CABBYNZL3yZ1_7wVyGg6fMZ=a3thqia2i+WSBFFyvBxTt4KPEgA@mail.gmail.com>
Subject: Re: [Bluez PATCH] Monitor: Remove handle before assigning
To: Archie Pusaka <apusaka@google.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>, Zhengping Jiang <jiangzp@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Archie,

On Fri, Jan 26, 2024 at 1:42=E2=80=AFAM Archie Pusaka <apusaka@google.com> =
wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> It is possible to have some handles not removed, for example the host
> may decide not to wait for disconnection complete event when it is
> suspending. In this case, when the peer device reconnected, we might
> have two of the same handle assigned and create problem down the road.
>
> This patch solves the issue by always removing any previous handles
> when assigning a new handle if they are the same.
>
> Reviewed-by: Zhengping Jiang <jiangzp@google.com>
>
> ---
>
>  monitor/packet.c | 50 +++++++++++++++++++++++++-----------------------
>  1 file changed, 26 insertions(+), 24 deletions(-)
>
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 42e711cafa..b5dea6384a 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -189,11 +189,33 @@ static struct packet_conn_data *lookup_parent(uint1=
6_t handle)
>         return NULL;
>  }
>
> +static void release_handle(uint16_t handle)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < MAX_CONN; i++) {
> +               struct packet_conn_data *conn =3D &conn_list[i];
> +
> +               if (conn->handle =3D=3D handle) {
> +                       if (conn->destroy)
> +                               conn->destroy(conn->data);
> +
> +                       queue_destroy(conn->tx_q, free);
> +                       queue_destroy(conn->chan_q, free);
> +                       memset(conn, 0, sizeof(*conn));
> +                       conn->handle =3D 0xffff;
> +                       break;
> +               }
> +       }
> +}

We might as well return if we find out there is a packet_conn_data,
that way we don't need to do 2 lookups in a row.

>  static void assign_handle(uint16_t index, uint16_t handle, uint8_t type,
>                                         uint8_t *dst, uint8_t dst_type)
>  {
>         int i;
>
> +       release_handle(handle);
> +
>         for (i =3D 0; i < MAX_CONN; i++) {
>                 if (conn_list[i].handle =3D=3D 0xffff) {
>                         hci_devba(index, (bdaddr_t *)conn_list[i].src);
> @@ -225,26 +247,6 @@ static void assign_handle(uint16_t index, uint16_t h=
andle, uint8_t type,
>         }
>  }
>
> -static void release_handle(uint16_t handle)
> -{
> -       int i;
> -
> -       for (i =3D 0; i < MAX_CONN; i++) {
> -               struct packet_conn_data *conn =3D &conn_list[i];
> -
> -               if (conn->handle =3D=3D handle) {
> -                       if (conn->destroy)
> -                               conn->destroy(conn->data);
> -
> -                       queue_destroy(conn->tx_q, free);
> -                       queue_destroy(conn->chan_q, free);
> -                       memset(conn, 0, sizeof(*conn));
> -                       conn->handle =3D 0xffff;
> -                       break;
> -               }
> -       }
> -}
> -
>  struct packet_conn_data *packet_get_conn_data(uint16_t handle)
>  {
>         int i;
> @@ -10076,7 +10078,7 @@ static void conn_complete_evt(struct timeval *tv,=
 uint16_t index,
>         const struct bt_hci_evt_conn_complete *evt =3D data;
>
>         print_status(evt->status);
> -       print_handle(evt->handle);
> +       print_field("Handle: %d", le16_to_cpu(evt->handle));
>         print_bdaddr(evt->bdaddr);
>         print_link_type(evt->link_type);
>         print_enable("Encryption", evt->encr_mode);
> @@ -10648,7 +10650,7 @@ static void sync_conn_complete_evt(struct timeval=
 *tv, uint16_t index,
>         const struct bt_hci_evt_sync_conn_complete *evt =3D data;
>
>         print_status(evt->status);
> -       print_handle(evt->handle);
> +       print_field("Handle: %d", le16_to_cpu(evt->handle));
>         print_bdaddr(evt->bdaddr);
>         print_link_type(evt->link_type);
>         print_field("Transmission interval: 0x%2.2x", evt->tx_interval);
> @@ -11077,7 +11079,7 @@ static void le_conn_complete_evt(struct timeval *=
tv, uint16_t index,
>         const struct bt_hci_evt_le_conn_complete *evt =3D data;
>
>         print_status(evt->status);
> -       print_handle(evt->handle);
> +       print_field("Handle: %d", le16_to_cpu(evt->handle));
>         print_role(evt->role);
>         print_peer_addr_type("Peer address type", evt->peer_addr_type);
>         print_addr("Peer address", evt->peer_addr, evt->peer_addr_type);
> @@ -11206,7 +11208,7 @@ static void le_enhanced_conn_complete_evt(struct =
timeval *tv, uint16_t index,
>         const struct bt_hci_evt_le_enhanced_conn_complete *evt =3D data;
>
>         print_status(evt->status);
> -       print_handle(evt->handle);
> +       print_field("Handle: %d", le16_to_cpu(evt->handle));
>         print_role(evt->role);
>         print_peer_addr_type("Peer address type", evt->peer_addr_type);
>         print_addr("Peer address", evt->peer_addr, evt->peer_addr_type);

Are these changes really intentional? Or perhaps we don't want to
attempt to resolve the address since these are the event that would
assign them in the first place? In that case I had these fixed
separately with a proper patch description.

> --
> 2.43.0.429.g432eaa2c6b-goog
>


--=20
Luiz Augusto von Dentz
