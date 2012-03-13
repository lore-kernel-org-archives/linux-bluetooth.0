Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Mar 2012 10:16:54 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/4] Bluetooth: trivial: Remove sparse warnings
Message-ID: <20120313081652.GB15895@aemeltch-MOBL1>
References: <1331560774-10748-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1331560774-10748-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1331573777.14217.81.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331573777.14217.81.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Mar 12, 2012 at 10:36:17AM -0700, Marcel Holtmann wrote:
> Hi Andrei,
> 
> at least put the sparse warning in the commit message.
> 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  net/bluetooth/mgmt.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 06b5df3..5efca93 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -287,7 +287,7 @@ static int read_commands(struct sock *sk, struct hci_dev *hdev, void *data,
> >  	struct mgmt_rp_read_commands *rp;
> >  	u16 num_commands = ARRAY_SIZE(mgmt_commands);
> >  	u16 num_events = ARRAY_SIZE(mgmt_events);
> > -	u16 *opcode;
> > +	__le16 *opcode;
> >  	size_t rp_size;
> >  	int i, err;
> >  
> > @@ -2601,7 +2601,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
> >  	return 0;
> >  }
> >  
> > -struct mgmt_handler {
> > +static struct mgmt_handler {
> >  	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
> >  		     u16 data_len);
> >  	bool var_len;
> 
> And this should be static const.

Thanks for the review, I will resend this patch.

Best regards 
Andrei Emeltchenko 
