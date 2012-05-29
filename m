Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 May 2012 14:37:03 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Fix legacy pairing with some devices
Message-ID: <20120529173703.GA18069@joana>
References: <1338198440-15077-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338198440-15077-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon.janc@tieto.com> [2012-05-28 11:47:19 +0200]:

> Some devices e.g. SonyEricsson Xperia ray and arc S don't do SDP search
> before pairing. No L2CAP is connected so default HCI_DISCONN_TIMEOUT
> (2 seconds) timeout value is being used. This results in problems with
> legacy pairing as remote user has only few seconds to enter PIN before
> ACL is disconnected.
> 
> Increase disconnect timeout to HCI_PAIRING_TIMEOUT if SSP is disabled
> and no linkey exists.

does this only happen with SSP disabled?

Also add the hcidump output to the commit message would be helpful.

> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/hci_event.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index ac86b65..98e8020 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1762,7 +1762,12 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  		if (conn->type == ACL_LINK) {
>  			conn->state = BT_CONFIG;
>  			hci_conn_hold(conn);
> -			conn->disc_timeout = HCI_DISCONN_TIMEOUT;
> +
> +			if (!hci_conn_ssp_enabled(conn) &&
> +			    !hci_find_link_key(hdev, &ev->bdaddr))
> +				conn->disc_timeout = HCI_PAIRING_TIMEOUT;
> +			else
> +				conn->disc_timeout = HCI_DISCONN_TIMEOUT;

You are also changing the timeout for a SDP search, for example, to
HCI_PAIRING_TIMEOUT and this is not good. I think we need to be smarter here,
we can't change the behaviour of things like SDP search here.

	Gustavo
