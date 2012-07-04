Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Jul 2012 09:56:41 +0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/2] Bluetooth: Fix legacy pairing with some devices
Message-ID: <20120704075641.GB21012@joana>
References: <1338198440-15077-1-git-send-email-szymon.janc@tieto.com>
 <20120529173703.GA18069@joana>
 <201205300941.34495.szymon.janc@tieto.com>
 <20120629105653.GA17737@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120629105653.GA17737@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-06-29 13:56:53 +0300]:

> Hi Szymon & Gustavo,
> 
> On Wed, May 30, 2012, Szymon Janc wrote:
> > > > Some devices e.g. SonyEricsson Xperia ray and arc S don't do SDP search
> > > > before pairing. No L2CAP is connected so default HCI_DISCONN_TIMEOUT
> > > > (2 seconds) timeout value is being used. This results in problems with
> > > > legacy pairing as remote user has only few seconds to enter PIN before
> > > > ACL is disconnected.
> > > > 
> > > > Increase disconnect timeout to HCI_PAIRING_TIMEOUT if SSP is disabled
> > > > and no linkey exists.
> > > 
> > > does this only happen with SSP disabled?
> > 
> > Yes, I've seen this only with SSP disabled.
> > After name request remote devices ask user to enter PIN and before user is
> > able to do so (4 sec only) link is disconnected (cause we didn't get pin
> > request event yet).
> > 
> > For SSP hci_conn_hold is called in hci_io_capa_request_evt so link is not
> > disconnected.
> > 
> > > 
> > > Also add the hcidump output to the commit message would be helpful.
> > 
> > hcidump for ssp disabled [1] and ssp enabled [2] below.
> > 
> > > > 
> > > > Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> > > > ---
> > > >  net/bluetooth/hci_event.c |    7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > > index ac86b65..98e8020 100644
> > > > --- a/net/bluetooth/hci_event.c
> > > > +++ b/net/bluetooth/hci_event.c
> > > > @@ -1762,7 +1762,12 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> > > >  		if (conn->type == ACL_LINK) {
> > > >  			conn->state = BT_CONFIG;
> > > >  			hci_conn_hold(conn);
> > > > -			conn->disc_timeout = HCI_DISCONN_TIMEOUT;
> > > > +
> > > > +			if (!hci_conn_ssp_enabled(conn) &&
> > > > +			    !hci_find_link_key(hdev, &ev->bdaddr))
> > 
> > I could add also checking if connection is incoming to narrow case a bit further...
> > 
> > > > +				conn->disc_timeout = HCI_PAIRING_TIMEOUT;
> > > > +			else
> > > > +				conn->disc_timeout = HCI_DISCONN_TIMEOUT;
> > > 
> > > You are also changing the timeout for a SDP search, for example, to
> > > HCI_PAIRING_TIMEOUT and this is not good. I think we need to be smarter here,
> > > we can't change the behaviour of things like SDP search here.
> > 
> > Maybe we could set timeout back to HCI_DICONN_TIMEOUT when l2cap is
> > connected (or disconnected)?  That should cover SDP search case..
> 
> What happened to getting this patch upstream? To me it looks like a
> definitely needed fix. After adding the fix to restore a sensible value
> for disc_timeout after an L2CAP connect request either way and adding a
> better explanation to the commit message (that we only get the PIN
> request after user has entered one on the remote side, including a
> hcidump of this) I think this should go upstream. If this had been
> processed in a timely manner it could have made it to 3.5 but now it
> seems too late for that (as it's not strictly speaking a regression from
> 3.4).

Could you re-do this patch as Johan says so we can try push it to 3.5?

	Gustavo
