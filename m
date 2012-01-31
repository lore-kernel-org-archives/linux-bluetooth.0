Return-Path: <cyrus@holtmann.org>
Message-ID: <1327971027.1955.203.camel@aeonflux>
Subject: Re: [PATCH 6/8] Bluetooth: Add support for removing LTK's when
 pairing is removed
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 30 Jan 2012 16:50:27 -0800
In-Reply-To: <20120130233316.GD17656@samus>
References: <1327962558-25720-1-git-send-email-vinicius.gomes@openbossa.org>
	 <1327962558-25720-7-git-send-email-vinicius.gomes@openbossa.org>
	 <1327963746.1955.198.camel@aeonflux> <20120130233316.GD17656@samus>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> > > Instead of having a separated command for removing SMP keys, we use the
> > > Remove Keys command to remove *all* keys.
> > > 
> > > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> > > ---
> > >  include/net/bluetooth/hci_core.h |    1 +
> > >  net/bluetooth/mgmt.c             |    6 ++++++
> > >  2 files changed, 7 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > > index 9e415dc..b61de08 100644
> > > --- a/include/net/bluetooth/hci_core.h
> > > +++ b/include/net/bluetooth/hci_core.h
> > > @@ -665,6 +665,7 @@ int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
> > >  int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
> > >  struct smp_ltk *hci_find_ltk_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
> > >  								u8 addr_type);
> > > +int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr);
> > 
> > why do we have this export now? So why was this previously public?
> 
> A previous patch ("[PATCH 3/8] Bluetooth: Add new structures for handling SMP Long Term
> Keys") adds this function but doesn't export it then. Going to fix it.
> 
> Just to be clear, it is public because it is going to use it on mgmt.c.

that is what I assumed, but it was kinda funky. Please clean this up and
feel free to keep the ack.

Regards

Marcel


