Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Sep 2010 19:06:08 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Anderson Briglia <anderson.briglia@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Implement LE Set Advertise Enable cmd
Message-ID: <20100908220608.GO16973@vigoh>
References: <1282591815-26934-1-git-send-email-anderson.briglia@openbossa.org>
 <20100908214359.GM16973@vigoh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100908214359.GM16973@vigoh>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Gustavo F. Padovan <padovan@profusion.mobi> [2010-09-08 18:43:59 -0300]:

> Hi Anderson,
> 
> * Anderson Briglia <anderson.briglia@openbossa.org> [2010-08-23 15:30:14 -0400]:
> 
> > This patch implements LE Set Advertise Enable command for dual mode and
> > Low Energy hci controllers. It also adds new HCI flags in order to
> > indicate the Advertising state for userland applications and kernel
> > itself.
> > 
> > Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
> > ---
> >  include/net/bluetooth/hci.h |    6 ++++++
> >  net/bluetooth/hci_event.c   |   27 +++++++++++++++++++++++++++
> >  2 files changed, 33 insertions(+), 0 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index bcbdd6d..cae1816 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -76,6 +76,7 @@ enum {
> >  	HCI_INQUIRY,
> >  
> >  	HCI_RAW,
> 
> Skip a line here and then add the new LE commands
> 
> > +	HCI_LE_ADV,
> >  };
> >  
> >  /* HCI ioctl defines */
> > @@ -593,6 +594,11 @@ struct hci_rp_read_bd_addr {
> >  	bdaddr_t bdaddr;
> >  } __packed;
> >  
> > +/* --- HCI LE Commands --- */
> > +#define HCI_OP_LE_SET_ADVERTISE_ENABLE	0x200a
> > +	#define ADVERTISE_ENABLED	0x01
> > +	#define ADVERTISE_DISABLED	0x00

And make these LE_ADVERTISE...

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
