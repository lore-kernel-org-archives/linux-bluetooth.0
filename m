Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C631EBA03
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Nov 2024 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088854; cv=none; b=bR/uGA8p9KgAuogadZ9iIoFhh1oVwuf1m5FeT24C2ugZIvELclp+ntEsB7fJqLDvai54Mb2YHMyyFO/kplHa2pYzPTBIqJjWHjmzOup+BOiVlgjT3AhDx8XWDpc24e90xCHOZHnTQclhqR5vzEuyhxRTdhWoFnrIzEPkpJVRT9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088854; c=relaxed/simple;
	bh=TH8onJwrB0ziw/RT7mcMYw46Xhd144NODu67Y0/n1Js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A89PC23YZ4ggfuIbCbI/F89psoQJ8UySoloznQrkVecLAWoc/XCgQ7ByjRgBpWnljTxvjylfrL2IPjMNHC2YGKROjqQTRIsUTM2l7Z0SZT1uiH4kce7xbKV6eGaSm6mtuCWZO4uui0fFSsIhfhS3EBz7uuiRDo3YnYHIp6AE4Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fp9yknNJ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fp9yknNJ"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53a0c160b94so3141887e87.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Nov 2024 10:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731088851; x=1731693651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9o3wl4AEWKpFwzfyp00HHZcLcgvd5TvVO0TcNWL6T1Y=;
        b=Fp9yknNJW1XuYDmSL4brnfDxo8L/oDqLEU7rPCYTEdXZg6KdZ4UJV42tcpz+wvlruJ
         7N6gOPPsMz9cPghShnoquq3ywGvmcxOn2jgjAvBUKW91PcOMV41sXCcap+IGyShGu1XP
         kGhGbtlnOTAycF7AAzO3rr+DKqQsievprrZeThakvXj9PHTeuzMJu+sRAvYpgTT6yKF3
         ytjqaoTKIy4pcz/7B1e/5UC+nBs1WKrPT3vbR1gxY2zDosncRIhltSyzy5m3yMoht+0F
         h+gQfolhnVDZ/TiQFhsQ+HBXcFmIEXbwSyfCpsz4Z6OaFyrJ18I2BURH6NGAFd9ufc4K
         ghXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731088851; x=1731693651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9o3wl4AEWKpFwzfyp00HHZcLcgvd5TvVO0TcNWL6T1Y=;
        b=Em3nlttemH0hf549OaWt75wGFMJ7ZUpZ1XWTeTmvCndfRy2zq02ssbx8ES/MIfQJ05
         dTHQIHAA0HdEL9KMjFC4G2zKfczZ3cvZCne8XeUxxaYwDNqtGb2h8Kt93j9VjfA/1SQf
         xxsTOAUOcBwbGRO0AFnmCQmpcMTz+1BO/rOuFDdL1EseLu1us8PNkuW/jl3Tujh4ldjI
         TZwboUubWNpD5eW1Y9v0k2Pmuq62pOG5lpiHfPfS/f19DrfVBqPJfdgKAjJ1Zr0BAgKL
         Xe1N25M5je6BmIfMYc5Hld4XczsLFjAdKbyt5sUx9bBU+kRnF9eGUF0vTtcdsTjSm+zv
         Kj1Q==
X-Gm-Message-State: AOJu0YwnHMa2pPGcu5dwaQX2gUnY2KEXMX8sbfU0FLXTEv52P4P0sebw
	bGOtaiq6LlJv+tnVQmK5kp3HA1AoJHZzviDAZQc2VL6LO41OkaP7NB9HFyE/0XgDVIFdhoxNLvJ
	CuPo5RMMNCRmWaKw/GaGYDnqtgFqA/i3p
X-Google-Smtp-Source: AGHT+IH8E7llcBpC22fW6FsXzVfYvBVOlUzjTRj1TC9zyiUL2gFSxr65SlCBfCJkXegicAmnM1AGUN16TgZagPQqneg=
X-Received: by 2002:a05:651c:2209:b0:2fa:cf82:a1b2 with SMTP id
 38308e7fff4ca-2ff202230c1mr20988041fa.31.1731088848842; Fri, 08 Nov 2024
 10:00:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108160723.3399-1-iulia.tanasescu@nxp.com> <20241108160723.3399-3-iulia.tanasescu@nxp.com>
In-Reply-To: <20241108160723.3399-3-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 8 Nov 2024 13:00:36 -0500
Message-ID: <CABBYNZKSfcSeDehE0bJj7F6XBP10hknC6GDzqDQ3CrXEofjy7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: ISO: Send BIG Create Sync via hci_sync
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Fri, Nov 8, 2024 at 11:07=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> Before issuing the LE BIG Create Sync command, an available BIG handle
> is chosen by iterating through the conn_hash list and finding the first
> unused value.
>
> If a BIG is terminated, the associated hcons are removed from the list
> and the LE BIG Terminate Sync command is sent via hci_sync queue.
> However, a new LE BIG Create sync command might be issued via
> hci_send_cmd, before the previous BIG sync was terminated. This
> can cause the same BIG handle to be reused and the LE BIG Create Sync
> to fail with Command Disallowed.

We should be using hci_send_cmd anymore, so
hci_le_big_create_sync_pending shall be used whenever we want to queue
LE BIG Create Sync command, we shall also make it safe to be called
multiple times by using hci_cmd_sync_queue_once so it doesn't get
queued multiple times.

> < HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b)
>         BIG Handle: 0x00
>         BIG Sync Handle: 0x0002
>         Encryption: Unencrypted (0x00)
>         Broadcast Code[16]: 00000000000000000000000000000000
>         Maximum Number Subevents: 0x00
>         Timeout: 20000 ms (0x07d0)
>         Number of BIS: 1
>         BIS ID: 0x01
> > HCI Event: Command Status (0x0f) plen 4
>       LE Broadcast Isochronous Group Create Sync (0x08|0x006b) ncmd 1
>         Status: Command Disallowed (0x0c)
> < HCI Command: LE Broadcast Isochronous Group Terminate Sync (0x08|0x006c=
)
>         BIG Handle: 0x00
>
> This commit fixes the ordering of the LE BIG Create Sync/LE BIG Terminate
> Sync commands, to make sure that either the previous BIG sync is
> terminated before reusing the handle, or that a new handle is chosen
> for a new sync.

If it is a fix of a previous change then we need to add the Fixes tag.
Regarding the order, hci_cmd_sync_queue also fix that since then the
command shall be executed in the order and in the situation where it
needs to be canceled we can do so with hci_cmd_sync_dequeue.

> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>  net/bluetooth/hci_conn.c | 19 ++++++++++++++++++-
>  net/bluetooth/iso.c      |  4 ++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index b5b78d469d54..ba74fac823c5 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -2180,11 +2180,20 @@ static bool hci_conn_check_create_big_sync(struct=
 hci_conn *conn)
>         return true;
>  }
>
> -int hci_le_big_create_sync_pending(struct hci_dev *hdev)
> +static void big_create_sync_complete(struct hci_dev *hdev, void *data, i=
nt err)
> +{
> +       bt_dev_dbg(hdev, "");
> +
> +       if (err)
> +               bt_dev_err(hdev, "Unable to create BIG sync: %d", err);
> +}
> +
> +static int big_create_sync(struct hci_dev *hdev, void *data)
>  {
>         DEFINE_FLEX(struct hci_cp_le_big_create_sync, pdu, bis, num_bis, =
0x11);
>         struct hci_conn *conn;
>
> +       hci_dev_lock(hdev);

I'd add a comment why we are acquiring the dev lock here, sync
functions typically aren't allowed to do that except for minor updates
but never when you can sleep/yield waiting for something to complete.

>         rcu_read_lock();
>
>         pdu->num_bis =3D 0;
> @@ -2229,6 +2238,7 @@ int hci_le_big_create_sync_pending(struct hci_dev *=
hdev)
>
>  unlock:
>         rcu_read_unlock();
> +       hci_dev_unlock(hdev);
>
>         if (!pdu->num_bis)
>                 return 0;
> @@ -2237,6 +2247,13 @@ int hci_le_big_create_sync_pending(struct hci_dev =
*hdev)
>                             struct_size(pdu, bis, pdu->num_bis), pdu);
>  }
>
> +int hci_le_big_create_sync_pending(struct hci_dev *hdev)
> +{
> +       /* Queue big_create_sync */
> +       return hci_cmd_sync_queue(hdev, big_create_sync,
> +                                 NULL, big_create_sync_complete);
> +}
> +
>  int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
>                            struct bt_iso_qos *qos,
>                            __u16 sync_handle, __u8 num_bis, __u8 bis[])
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 9e119da43147..ac1598b1e1b6 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -1338,6 +1338,8 @@ static void iso_conn_big_sync(struct sock *sk)
>         if (!hdev)
>                 return;
>
> +       hci_dev_lock(hdev);

Same thing here, typically we don't use hci_dev_lock at the socket
layer as there is the likes of iso_conn to interface with HCI layer,
so we need to put some comments when there really is no other way and
hci_dev_lock must be used.

>         if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
>                 err =3D hci_le_big_create_sync(hdev, iso_pi(sk)->conn->hc=
on,
>                                              &iso_pi(sk)->qos,
> @@ -1348,6 +1350,8 @@ static void iso_conn_big_sync(struct sock *sk)
>                         bt_dev_err(hdev, "hci_le_big_create_sync: %d",
>                                    err);
>         }
> +
> +       hci_dev_unlock(hdev);
>  }
>
>  static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
