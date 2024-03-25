Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71E914273
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386009; cv=none; b=pCrZnQ0BRpuCAyNm+A7uSc2x6XdzhsfTNZwe6X9lr/nx4DUv32pN/G3rRnOwEzPZWdG4dhj3KD9ZjR3uWTEbmaxCxqA1tWd3a+DwKfwyuZIx7mUF43QwXGD/pnGD/kGxi/ilc8ih9Tez8VlDaMsbpUxvZJ5OTQjgojTCB2JpWh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386009; c=relaxed/simple;
	bh=sU2N+3VMbYpctRrmkqNvMSsDe5DH8U6ybHQNS3FaOfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrYADmYKEJo+iZBsYukMLZEdbyGQxOAf0WWcQ+RY3vD1YmVg+ALNRevESD357GACnCXRkBm652rOuMMFRYSD9sZnZq4aG8XSxbkRnoQ6Cn8sedOTmGwiLQKvX0e1HAqyxmvlpHndz/XJbDUYOWjPaBeaXQY9knVgTYn5+dVOfJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsQNWs+Z; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsQNWs+Z"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so63112391fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 10:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711386006; x=1711990806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20c2gjbqNq6L0248iIcu+8YTQSmCYw9fp1rS1tfrVSU=;
        b=FsQNWs+Ze1rzzbq4HUWR+zRJnB8jwhtY+gHn+reYXaPu/JPmO6RynZxQfxpu75idDz
         ErrkeFRkvuERS48P5Epb6Zfy1CfpKSs+l8+/OHSkOvTcJknEP8kkvf5swl6deIskSABp
         4FxBKeVGV19J07QIdAAVTtFkSkNmf4MsRzUnDCQN1zoOzJlIuXaFd+Br0Xvzw5ypPL8S
         HTo/yTiKO8bvcPerzqWs0KNobAAEHQmI4abb3udWW4h5qeXMCgDXEKHUf9LPVIqYuikK
         35qpFc3QjaCK9hSmv45IM2M1i3EVcTQ+tmVusz6gzYf2A5HcyBfxgkBFSKjbnnLxuaaB
         sSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711386006; x=1711990806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20c2gjbqNq6L0248iIcu+8YTQSmCYw9fp1rS1tfrVSU=;
        b=H3ocFRiFQIfeJrMM2RmWiaOK+4tiWmP0hXsgyYA2VK2QY64IVm3/tC3JRWnCHVisXK
         VGKkh5Kgc9xEvcq6COo2jjK/1nMYioG4bZY7GwJUlCfGYXsZg92ljzX+jHlWyQt157LN
         qOxokrhlToeg+v5Jr/97M2+QPmr5Uuo7Fgkdzo9qBfQSJ4mLsu+1Gg+vdxp3S2abkULZ
         igbZ1mf+x0CXjphTx1BWpZLbqbppTbuQn5VLzHDfiiozeThJZjDOdCwj4YLLNkv2aYTu
         ctFDAG24iG1zxwntDVIR4OTDf/0dOhktSDF+iOo0CJ5FG7cQsxmJ0ZCXfgYCMSqcfew+
         khwA==
X-Gm-Message-State: AOJu0Yxe1/kFf4U2MuUBQ4VS4+8IcZE+ZssJjo7BswPW+hTNT1nPDYR8
	2Jfvw5ti1oDy55NPa52AbHsN87zltBsRF5GOmrDfDJwkTCVFBR8NG47M1FJiJF3LiBD75vTCjhb
	8/QsRfbRT4HK9sFbGYMk0NBlzDPi13lVoQfE=
X-Google-Smtp-Source: AGHT+IG03NWXbXGbGLacfY9NNJ5UZ9oFvp4GC2ltOWzWrCSXnJVwuITv9bqA9mnPzT2wsmOZMqUQOlz7AIKaLqwjLZk=
X-Received: by 2002:a2e:9846:0:b0:2d6:dd11:94f0 with SMTP id
 e6-20020a2e9846000000b002d6dd1194f0mr1684470ljj.30.1711386005611; Mon, 25 Mar
 2024 10:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325061841.22387-1-hui.wang@canonical.com>
In-Reply-To: <20240325061841.22387-1-hui.wang@canonical.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 25 Mar 2024 12:59:53 -0400
Message-ID: <CABBYNZLNQtYnh=DbPV7vzmt_Aje87dBuEJrhXiJRabOr5a3O0w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: conn is already encryped before
 conn establishes
To: Hui Wang <hui.wang@canonical.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	johan.hedberg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hui,

On Mon, Mar 25, 2024 at 2:19=E2=80=AFAM Hui Wang <hui.wang@canonical.com> w=
rote:
>
> We have a BT headset (Lenovo Thinkplus XT99), the pairing and
> connecting has no problem, once this headset is paired, bluez will
> remember this device and will auto re-connect it whenever the device
> is power on. The auto re-connecting works well with Windows and
> Android, but with Linux, it always fails. Through debugging, we found
> at the rfcomm connection stage, the bluetooth stack reports
> "Connection refused - security block (0x0003)".
>
> For this device, the re-connecting negotiation process is different
> from other BT headsets, it sends the Link_KEY_REQUEST command before
> the CONNECT_REQUEST completes, and it doesn't send ENCRYPT_CHANGE
> command during the negotiation. When the device sends the "connect
> complete" to hci, the ev->encr_mode is 1.
>
> So here in the conn_complete_evt(), if ev->encr_mode is 1, link type
> is ACL and HCI_CONN_ENCRYPT is not set, we set HCI_CONN_ENCRYPT to
> this conn, and update conn->enc_key_size accordingly.
>
> After this change, this BT headset could re-connect with Linux
> successfully.

I suspect it is doing Security Mode 3, so it establishes the
encryption _before_ the connection handle which probably disables
EncryptionChange since there is no handle at that point. That said I
don't remember what we shall do with respect to AES since the
Encryption_Enabled field can only be set to 0x00 or 0x01 so I assume
the later can only be:

Link Level Encryption is ON with E0 for BR/EDR.

> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
> This is the btmon log for auto re-connecting negotiation:
> Before applying this patch:
> https://pastebin.com/NUa9RJv8
>
> After applying the patch:
> https://pastebin.com/GqviChTC

Lets add these to the patch description to be more informative about
the change, you can strip the unrelated traffic at the start and end
and just focus on what changes to the traffic the patches introduces.


> net/bluetooth/hci_event.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 4ae224824012..0c45beb08cb2 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3208,6 +3208,32 @@ static void hci_conn_complete_evt(struct hci_dev *=
hdev, void *data,
>                 if (test_bit(HCI_ENCRYPT, &hdev->flags))
>                         set_bit(HCI_CONN_ENCRYPT, &conn->flags);
>
> +               /* "Link key request" completed ahead of "connect request=
" completes */
> +               if (ev->encr_mode =3D=3D 1 && !test_bit(HCI_CONN_ENCRYPT,=
 &conn->flags) &&
> +                   ev->link_type =3D=3D ACL_LINK) {
> +                       struct link_key *key;
> +                       struct hci_cp_read_enc_key_size cp;
> +
> +                       key =3D hci_find_link_key(hdev, &ev->bdaddr);
> +                       if (key) {
> +                               set_bit(HCI_CONN_ENCRYPT, &conn->flags);
> +
> +                               if (!(hdev->commands[20] & 0x10)) {
> +                                       conn->enc_key_size =3D HCI_LINK_K=
EY_SIZE;
> +                                       goto notify;
> +                               }
> +
> +                               cp.handle =3D cpu_to_le16(conn->handle);
> +                               if (hci_send_cmd(hdev, HCI_OP_READ_ENC_KE=
Y_SIZE,
> +                                                sizeof(cp), &cp)) {
> +                                       bt_dev_err(hdev, "sending read ke=
y size failed");
> +                                       conn->enc_key_size =3D HCI_LINK_K=
EY_SIZE;
> +                               }
> +notify:
> +                               hci_encrypt_cfm(conn, ev->status);
> +                       }
> +               }
> +
>                 /* Get remote features */
>                 if (conn->type =3D=3D ACL_LINK) {
>                         struct hci_cp_read_remote_features cp;
> --
> 2.34.1
>


--
Luiz Augusto von Dentz
