Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Dec 2011 15:32:16 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 7/8] Bluetooth: Use SNIFF mode only for BREDR controller
Message-ID: <20111201133215.GE2216@aemeltch-MOBL1>
References: <1322743335-8671-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1322743335-8671-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1322745116.26198.33.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322745116.26198.33.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Dec 01, 2011 at 02:11:56PM +0100, Marcel Holtmann wrote:
> Hi Andrei,
> 
> >  net/bluetooth/hci_conn.c |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
> > 
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index b328ac6..beb280e 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -749,6 +749,9 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
> >  	if (test_bit(HCI_RAW, &hdev->flags))
> >  		return;
> >  
> > +	if (hdev->dev_type != HCI_BREDR)
> > +		return;
> > +
> >  	if (conn->mode != HCI_CM_SNIFF)
> >  		goto timer;
> >  
> > @@ -783,6 +786,9 @@ void hci_conn_enter_sniff_mode(struct hci_conn *conn)
> >  	if (conn->mode != HCI_CM_ACTIVE || !(conn->link_policy & HCI_LP_SNIFF))
> >  		return;
> >  
> > +	if (hdev->dev_type != HCI_BREDR)
> > +		return;
> > +
> >  	if (lmp_sniffsubr_capable(hdev) && lmp_sniffsubr_capable(conn)) {
> >  		struct hci_cp_sniff_subrate cp;
> >  		cp.handle             = cpu_to_le16(conn->handle);
> 
> I am really not sure that this is the best solution. It sounds like way
> to much overhead. Essentially I read this is being ignorant to what kind
> of controller we have and only last last minute we bother checking.

Do you think that the check shall be the first in
enter_[sniff|active]_mode commands or it shall be somewhere before those functions?

BTW: Can compiler do something for us if we use "unlikely" before those
checks?

Best regards 
Andrei Emeltchenko 
