Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jul 2014 15:39:27 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix SMP authentication requirement when
 initiator
Message-ID: <20140729123927.GA28262@t440s.lan>
References: <1406624859-17294-1-git-send-email-johan.hedberg@gmail.com>
 <20140729114812.GA26881@t440s.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140729114812.GA26881@t440s.lan>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jul 29, 2014, Johan Hedberg wrote:
> On Tue, Jul 29, 2014, johan.hedberg@gmail.com wrote:
> > Even if we're not pairable (the HCI_PAIRABLE flag is unset) we should
> > still allow initiating pairing with bonding. This patch adds a missing
> > check for SMP_FLAG_INITIATOR to build_pairing_cmd() and ensures this
> > flag is properly set before calling the function.
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> >  net/bluetooth/smp.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> > index a7c344b4acbc..7e914477721a 100644
> > --- a/net/bluetooth/smp.c
> > +++ b/net/bluetooth/smp.c
> > @@ -307,7 +307,8 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
> >  	struct hci_dev *hdev = hcon->hdev;
> >  	u8 local_dist = 0, remote_dist = 0;
> >  
> > -	if (test_bit(HCI_PAIRABLE, &conn->hcon->hdev->dev_flags)) {
> > +	if (test_bit(HCI_PAIRABLE, &conn->hcon->hdev->dev_flags) ||
> > +	    test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
> >  		local_dist = SMP_DIST_ENC_KEY | SMP_DIST_SIGN;
> >  		remote_dist = SMP_DIST_ENC_KEY | SMP_DIST_SIGN;
> >  		authreq |= SMP_AUTH_BONDING;
> > @@ -985,6 +986,8 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
> >  	    hcon->pending_sec_level > BT_SECURITY_MEDIUM)
> >  		authreq |= SMP_AUTH_MITM;
> >  
> > +	set_bit(SMP_FLAG_INITIATOR, &smp->flags);
> > +
> >  	if (hcon->role == HCI_ROLE_MASTER) {
> >  		struct smp_cmd_pairing cp;
> >  
> > @@ -999,8 +1002,6 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
> >  		smp_send_cmd(conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
> >  	}
> >  
> > -	set_bit(SMP_FLAG_INITIATOR, &smp->flags);
> > -
> >  	return 0;
> >  }
> 
> Hold on with this patch for a bit. There are some SM test cases that
> require us to be able to initiate no-bonding pairing (e.g.
> TP/JW/BV-01-C). So we have to retain somehow the capability of doing
> this.
> 
> A simple solution would be to revert bluez.git back to always enabling
> pairable and then forget about this kernel patch.

One more note: with BR/EDR this is less of an issue since no-bonding
initiator is done by setting MEDIUM or higher security level for an SDP
L2CAP socket. If we could come up with something similar for LE we could
keep the patch in question.

Johan
