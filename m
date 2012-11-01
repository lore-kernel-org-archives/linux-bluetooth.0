Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Nov 2012 10:55:06 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 12/12] Bluetooth: Process Create Chan Request
Message-ID: <20121101085500.GA17693@aemeltch-MOBL1>
References: <1350493622.26318.114.camel@aeonflux>
 <1351691197-8394-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1351691197-8394-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1351700642.1828.13.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351700642.1828.13.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 31, 2012 at 09:24:02AM -0700, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Add processing L2CAP Create Chan Request. When channel is created
> > save associated high speed link hs_hcon.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  net/bluetooth/l2cap_core.c |   63 ++++++++++++++++++++++++++++++--------------
> >  1 file changed, 43 insertions(+), 20 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index bdffc4c..783ffae 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -4237,7 +4237,9 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
> >  				    u16 cmd_len, void *data)
> >  {
> >  	struct l2cap_create_chan_req *req = data;
> > +	struct l2cap_create_chan_rsp rsp;
> >  	struct l2cap_chan *chan;
> > +	struct hci_dev *hdev = NULL;
> 
> why is this one set to NULL. Can we avoid that please.

Sorry, forgot to clean this up from the previous patch. With the new patch
we do not need to set this NULL.

Best regards 
Andrei Emeltchenko 
