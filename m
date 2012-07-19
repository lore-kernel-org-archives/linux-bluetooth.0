Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Jul 2012 09:44:01 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [RFC v1] Bluetooth: mgmt: Add device disconnect reason
Message-ID: <20120719064359.GA26057@aemeltch-MOBL1>
References: <1342679661-2444-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342679661-2444-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

just one nitpick

On Thu, Jul 19, 2012 at 08:34:21AM +0200, Mikel Astiz wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> MGMT_EV_DEVICE_DISCONNECTED will now expose the disconnection reason to
> userland, providing the following possible values:
> 
> 	0x00	Reason unspecified
> 	0x01	Connection timeout
> 
> Signed-off-by: Mikel Astiz <mikel.astiz@bmw-carit.de>
> ---
> This second proposal replaces the original HCI disconnect reason with a new enum type, to be used in the management socket. Currently just "Connection timeout" is being distinguished.
> 
> During the BlueZ meeting in Brazil it was proposed to add two more values to this enum: "Connection terminated by local host" and "Connection terminated by remote host". However, after some testing, it seems the result can be quite misleading. Therefore and given that there are no known use-cases that need this information (local vs remote disconnection), these two values have been dropped.
> 
> Useland patches to be used for testing will be submitted soon.
> 
>  include/net/bluetooth/hci.h      |    1 +
>  include/net/bluetooth/hci_core.h |    2 +-
>  include/net/bluetooth/mgmt.h     |    4 ++++
>  net/bluetooth/hci_event.c        |   12 ++++++++++--
>  net/bluetooth/mgmt.c             |    9 +++++----
>  5 files changed, 21 insertions(+), 7 deletions(-)

...
 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 41ff978..f53dbd2 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1909,9 +1909,17 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  		if (ev->status != 0)
>  			mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
>  					       conn->dst_type, ev->status);
> -		else
> +		else {

You need use braces also for "if"

Best regards 
Andrei Emeltchenko 

