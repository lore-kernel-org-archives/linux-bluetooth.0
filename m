Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Jun 2012 23:27:36 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: AMP: Do not set name for AMP ctrl
Message-ID: <20120606152736.GA25191@x220.ccr.corp.intel.com>
References: <1338994856-31200-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120606152225.GA24903@x220.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120606152225.GA24903@x220.ccr.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jun 06, 2012, Johan Hedberg wrote:
> On Wed, Jun 06, 2012, Andrei Emeltchenko wrote:
> > AMP controllers do not understand this command
> > 
> > ...
> > < HCI Command: Write Local Name (0x03|0x0013) plen 248
> >    name ''
> > > HCI Event: Command Complete (0x0e) plen 4
> >    Write Local Name (0x03|0x0013) ncmd 1
> >    status 0x01
> >    Error: Unknown HCI Command
> > ...
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  net/bluetooth/mgmt.c |    3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 958f764..9afcc84 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -2135,6 +2135,9 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
> >  
> >  	BT_DBG("");
> >  
> > +	if (hdev->amp_type != HCI_BREDR)
> > +		return -ENOTSUPP;
> > +
> >  	hci_dev_lock(hdev);
> >  
> >  	memcpy(hdev->short_name, cp->short_name, sizeof(hdev->short_name));
> 
> This will essentially make write() fail on the mgmt socket which isn't
> necessarily the most intuitive behavior (one might think there's
> something wrong with the socket). What would probably make more sense is
> to send a proper cmd_status reply with MGMT_STATUS_NOT_SUPPORTED.

Actually, should we even be exposing AMP controllers to begin with
through mgmt? Maybe we shouldn't even tell user space about them through
mgmt?

Johan
