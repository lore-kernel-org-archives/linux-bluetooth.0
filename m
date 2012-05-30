Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Gustavo Padovan <gustavo@padovan.org>
Subject: Re: [PATCH 1/2] Bluetooth: Fix legacy pairing with some devices
Date: Wed, 30 May 2012 09:41:34 +0200
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1338198440-15077-1-git-send-email-szymon.janc@tieto.com> <20120529173703.GA18069@joana>
In-Reply-To: <20120529173703.GA18069@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID: <201205300941.34495.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> > Some devices e.g. SonyEricsson Xperia ray and arc S don't do SDP search
> > before pairing. No L2CAP is connected so default HCI_DISCONN_TIMEOUT
> > (2 seconds) timeout value is being used. This results in problems with
> > legacy pairing as remote user has only few seconds to enter PIN before
> > ACL is disconnected.
> > 
> > Increase disconnect timeout to HCI_PAIRING_TIMEOUT if SSP is disabled
> > and no linkey exists.
> 
> does this only happen with SSP disabled?

Yes, I've seen this only with SSP disabled.
After name request remote devices ask user to enter PIN and before user is
able to do so (4 sec only) link is disconnected (cause we didn't get pin
request event yet).

For SSP hci_conn_hold is called in hci_io_capa_request_evt so link is not
disconnected.

> 
> Also add the hcidump output to the commit message would be helpful.

hcidump for ssp disabled [1] and ssp enabled [2] below.

> > 
> > Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> > ---
> >  net/bluetooth/hci_event.c |    7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index ac86b65..98e8020 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -1762,7 +1762,12 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> >  		if (conn->type == ACL_LINK) {
> >  			conn->state = BT_CONFIG;
> >  			hci_conn_hold(conn);
> > -			conn->disc_timeout = HCI_DISCONN_TIMEOUT;
> > +
> > +			if (!hci_conn_ssp_enabled(conn) &&
> > +			    !hci_find_link_key(hdev, &ev->bdaddr))

I could add also checking if connection is incoming to narrow case a bit further...

> > +				conn->disc_timeout = HCI_PAIRING_TIMEOUT;
> > +			else
> > +				conn->disc_timeout = HCI_DISCONN_TIMEOUT;
> 
> You are also changing the timeout for a SDP search, for example, to
> HCI_PAIRING_TIMEOUT and this is not good. I think we need to be smarter here,
> we can't change the behaviour of things like SDP search here.

Maybe we could set timeout back to HCI_DICONN_TIMEOUT when l2cap is connected (or disconnected)?
That should cover SDP search case..


[1]
1338360473.214785 > HCI Event: Connect Request (0x04) plen 10
1338360473.214976 < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
1338360473.218782 > HCI Event: Command Status (0x0f) plen 4
1338360473.380780 > HCI Event: Role Change (0x12) plen 8
1338360473.392781 > HCI Event: Connect Complete (0x03) plen 11
1338360473.392806 < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
1338360473.393754 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
1338360473.395752 > HCI Event: Command Status (0x0f) plen 4
1338360473.410779 > HCI Event: Max Slots Change (0x1b) plen 3
1338360473.411749 > HCI Event: Command Status (0x0f) plen 4
1338360473.426778 > HCI Event: Read Remote Supported Features (0x0b) plen 11
1338360473.426797 < HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
1338360473.431755 > HCI Event: Command Status (0x0f) plen 4
1338360473.431774 < HCI Command: Remote Name Request (0x01|0x0019) plen 10
1338360473.435780 > HCI Event: Command Status (0x0f) plen 4
1338360473.438766 > HCI Event: Read Remote Extended Features (0x23) plen 13
1338360473.438788 < HCI Command: Remote Name Request (0x01|0x0019) plen 10
1338360473.462777 > HCI Event: Remote Name Req Complete (0x07) plen 255
1338360473.463764 > HCI Event: Command Status (0x0f) plen 4
1338360473.482777 > HCI Event: Remote Name Req Complete (0x07) plen 255
1338360477.448436 < HCI Command: Disconnect (0x01|0x0006) plen 3
1338360477.451710 > HCI Event: Command Status (0x0f) plen 4
1338360477.531708 > HCI Event: Disconn Complete (0x05) plen 4


[2]
1338360561.019888 > HCI Event: Connect Request (0x04) plen 10                                                                                                        
1338360561.020065 < HCI Command: Accept Connection Request (0x01|0x0009) plen 7                                                                                      
1338360561.023883 > HCI Event: Command Status (0x0f) plen 4
1338360561.185883 > HCI Event: Role Change (0x12) plen 8
1338360561.198881 > HCI Event: Connect Complete (0x03) plen 11
1338360561.198906 < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
1338360561.199856 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
1338360561.201855 > HCI Event: Command Status (0x0f) plen 4
1338360561.226883 > HCI Event: Max Slots Change (0x1b) plen 3
1338360561.227852 > HCI Event: Command Status (0x0f) plen 4
1338360561.232474 < HCI Command: Remote Name Request (0x01|0x0019) plen 10
1338360561.234855 > HCI Event: Read Remote Supported Features (0x0b) plen 11
1338360561.237852 > HCI Event: Command Status (0x0f) plen 4
1338360561.237866 < HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
1338360561.241851 > HCI Event: Command Status (0x0f) plen 4
1338360561.265852 > HCI Event: Remote Name Req Complete (0x07) plen 255
1338360561.266851 > HCI Event: Read Remote Extended Features (0x23) plen 13
1338360561.266869 < HCI Command: Remote Name Request (0x01|0x0019) plen 10
1338360561.269852 > HCI Event: Command Status (0x0f) plen 4
1338360561.296849 > HCI Event: Remote Name Req Complete (0x07) plen 255
1338360561.304851 > HCI Event: IO Capability Response (0x32) plen 9
1338360561.305850 > HCI Event: IO Capability Request (0x31) plen 6
1338360561.305972 < HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
1338360561.323850 > HCI Event: Command Complete (0x0e) plen 10
1338360562.861841 > HCI Event: User Confirmation Request (0x33) plen 10
1338360572.626696 < HCI Command: User Confirmation Request Reply (0x01|0x002c) plen 6
1338360572.662750 > HCI Event: Command Complete (0x0e) plen 10
1338360572.685766 > HCI Event: Simple Pairing Complete (0x36) plen 7
1338360572.727764 > HCI Event: Link Key Notification (0x18) plen 23
1338360572.782738 > HCI Event: Encrypt Change (0x08) plen 4
1338360572.786359 > ACL data: handle 43 flags 0x02 dlen 10


-- 
BR
Szymon
