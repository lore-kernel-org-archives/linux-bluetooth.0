Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Jul 2011 14:51:32 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 08/12] Bluetooth: Use the stored LTK for
 restabilishing security
Message-ID: <20110704175132.GB20837@piper>
References: <1309547267-9514-1-git-send-email-vinicius.gomes@openbossa.org>
 <1309547267-9514-9-git-send-email-vinicius.gomes@openbossa.org>
 <20110701192852.GH23683@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110701192852.GH23683@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 16:28 Fri 01 Jul, Gustavo F. Padovan wrote:
> * Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-07-01 16:07:43 -0300]:
> 
> > Now that it's possible that the exchanged key is present in
> > the link key list, we may be able to estabilish security with
> > an already existing key, without need to perform any SMP
> > procedure.
> > 
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> > ---
> >  net/bluetooth/smp.c |   15 +++++++++++++++
> >  1 files changed, 15 insertions(+), 0 deletions(-)
> > 
> > diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> > index 34d236d..191aaec 100644
> > --- a/net/bluetooth/smp.c
> > +++ b/net/bluetooth/smp.c
> > @@ -476,6 +476,20 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
> >  	authreq = seclevel_to_authreq(sec_level);
> >  
> >  	if (hcon->link_mode & HCI_LM_MASTER) {
> > +		struct link_key *key;
> > +
> > +		key = hci_find_link_key_type(hcon->hdev, conn->dst,
> > +							HCI_LK_SMP_LTK);
> > +		if (key) {
> > +			struct key_master_id *master = (void *) key->data;
> > +
> > +			hci_le_start_enc(hcon, master->ediv, master->rand,
> > +								key->val);
> > +			goto done;
> > +		}
> > +	}
> > +
> > +	if (hcon->link_mode & HCI_LM_MASTER) {
> 
> hey, why do you need this if? it is the same comparison as above.

Nothing too important, just to emphasize that each block is a different
step of the protocol: first we check if we already have an LTK for that
device, then we start the Pairing negotiation. But I fixed this, if I
need to write this email, then the code needed changing ;-) Thanks.

> 
> 	Gustavo

Cheers,
-- 
Vinicius
