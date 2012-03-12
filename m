Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331520186-30184-1-git-send-email-marcel@holtmann.org>
References: <1331520186-30184-1-git-send-email-marcel@holtmann.org>
Date: Mon, 12 Mar 2012 06:34:01 -0400
Message-ID: <CAJdJm_PVtxF3qQY0+UWFr-6cXQFxXwXt4Qt4K6hZ5-FBNJ=0bw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix broken usage of put_unaligned_le16
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Mar 11, 2012 at 10:43 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> @@ -275,7 +275,7 @@ static int read_version(struct sock *sk, struct hci_d=
ev *hdev, void *data,
> =A0 =A0 =A0 =A0BT_DBG("sock %p", sk);
>
> =A0 =A0 =A0 =A0rp.version =3D MGMT_VERSION;
> - =A0 =A0 =A0 put_unaligned_le16(MGMT_REVISION, &rp.revision);
> + =A0 =A0 =A0 rp.revision =3D __constant_cpu_to_le16(MGMT_VERSION);

Looks like a typo here: MGMT_VERSION -> MGMT_REVISION

>
> =A0 =A0 =A0 =A0return cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_VERS=
ION, 0, &rp,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(rp));

Regards,
--=20
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
