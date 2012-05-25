Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 May 2012 14:44:46 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Define HCI AMP cmd struct
Message-ID: <20120525114445.GG3089@aemeltch-MOBL1>
References: <1337944440-9361-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337944440-9361-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337945351.15105.92.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337945351.15105.92.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, May 25, 2012 at 01:29:11PM +0200, Marcel Holtmann wrote:
> > +#define HCI_OP_DISC_PHY_LINK		0x0437
> > +struct hci_cp_disc_phy_link {
> 
> we should use disconn or disconnect for this.

OK

> > +#define HCI_OP_READ_LOCAL_AMP_ASSOC	0x140a
> > +struct hci_cp_read_local_amp_assoc {
> > +	__u8     handle;
> > +	__le16   len_so_far;
> > +	__le16   max_len;
> > +} __packed;
> > +
> 
> No empty line here if the belong together.

OK 

> > +#define HCI_EV_LOG_LINK_COMPLETE	0x45
> > +struct hci_ev_log_link_complete {
> 
> Do you wanna go with log instead of logical. I would use logical to not
> get confused here.

OK

> 
> > +	__u8     status;
> > +	__le16   log_handle;
> 
> Just use handle here.

Ok, so I rename log_handle to handle and leave phy_handles as is.

Best regards 
Andrei Emeltchenko 
