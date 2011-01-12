Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1294834111-29658-1-git-send-email-matti.j.aaltonen@nokia.com>
References: <1294834111-29658-1-git-send-email-matti.j.aaltonen@nokia.com>
Date: Thu, 13 Jan 2011 00:31:50 +0200
Message-ID: <AANLkTikm8_spOCzLAFytNfNEFxxaqNhTxK__YVjkSxe-@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Check authorization when sec_level goes high.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jan 12, 2011 at 2:08 PM, Matti J. Aaltonen
<matti.j.aaltonen@nokia.com> wrote:
> Initiate authorization check also in cases where the
> security level of an existing connection changes to
> BT_SECURITY_HIGH.
>
> This patch fixes a bug which makes commands bluez-test-device and
> bluez-simple-agent fail, if the latter is given before the connection
> created by bluez-test-device has expired.
>
> Signed-off-by: Matti J. Aaltonen <matti.j.aaltonen@nokia.com>
> ---
> =A0net/bluetooth/hci_conn.c | =A0 13 ++++++++++++-
> =A01 files changed, 12 insertions(+), 1 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 0b1e460..5df232b 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -380,8 +380,19 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, i=
nt type, bdaddr_t *dst, __u8
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acl->auth_type =3D auth_type;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hci_acl_connect(acl);
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (acl->sec_level < sec_level)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (acl->sec_level < sec_level) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acl->sec_level =3D sec_lev=
el;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (acl->sec_level =3D=3D B=
T_SECURITY_HIGH) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hci_=
cp_auth_requested ar;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acl->state =
=3D BT_CONFIG;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(&ar,=
 0, sizeof(ar));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ar.handle =
=3D cpu_to_le16(acl->handle);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_send_cm=
d(hdev, HCI_OP_AUTH_REQUESTED,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0sizeof(ar), &ar);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (acl->auth_type < auth_type)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acl->auth_type =3D auth_ty=
pe;
> =A0 =A0 =A0 =A0}

I don't think this fixes the problem properly, the authentication
request could have been sent before because other levels might require
it, also Im afraid this can break sockets using the same link since
the state got reseted to BT_CONFIG when it could previously be
BT_CONNECTED, what happens if there a socket in use and the link is
set back to BT_CONFIG after connected?
