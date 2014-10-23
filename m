Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 Oct 2014 19:30:53 +0200 (CEST)
From: Fabian Frederick <fabf@skynet.be>
Reply-To: Fabian Frederick <fabf@skynet.be>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Network Development <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-ID: <20326343.74480.1414085453988.open-xchange@webmail.nmp.skynet.be>
In-Reply-To: <2F67F6E8-CA99-4998-AE68-89E60D62C39D@holtmann.org>
References: <1414081365-6461-1-git-send-email-fabf@skynet.be> <2F67F6E8-CA99-4998-AE68-89E60D62C39D@holtmann.org>
Subject: Re: [PATCH 1/1 net-next] Bluetooth: fix shadow warning in
 hci_disconnect()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>



> On 23 October 2014 at 18:29 Marcel Holtmann <marcel@holtmann.org> wrote:
>
>
> Hi Fabian,
>
> > use cpr for hci_cp_read_clock_offset instead of cp
> > (already defined above).
> >
> > Signed-off-by: Fabian Frederick <fabf@skynet.be>
> > ---
> > net/bluetooth/hci_conn.c | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index b9517bd..6151e09 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -141,10 +141,10 @@ int hci_disconnect(struct hci_conn *conn, __u8 re=
ason)
> >=C2=A0 =C2=A0 =C2=A0 */
> >=C2=A0 =C2=A0 =C2=A0if (conn->type =3D=3D ACL_LINK && conn->role =3D=3D =
HCI_ROLE_MASTER) {
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hci_dev *hdev =3D=
 conn->hdev;
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hci_cp_read_clock_offs=
et cp;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hci_cp_read_clock_offs=
et cpr;
> >
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cp.handle =3D cpu_to_le16(con=
n->handle);
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hci_send_cmd(hdev, HCI_OP_REA=
D_CLOCK_OFFSET, sizeof(cp), &cp);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpr.handle =3D cpu_to_le16(co=
nn->handle);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hci_send_cmd(hdev, HCI_OP_REA=
D_CLOCK_OFFSET, sizeof(cpr), &cpr);
>
> valid change, but I do not like cpr as variable name. We need to come up =
with
> a better one. There are other places in the code where we had the same th=
ing.
> Please have a look there.
>
> Regards
>
> Marcel
>

Hi Marcel,

=C2=A0 Maybe read_cp (like commit c1f23a2bfc89 with struct hci_cp_auth_requ=
ested
auth_cp) ?

Regards,
Fabian
