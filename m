Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Jan 2013 10:13:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: mail@timomueller.eu
Cc: linux-bluetooth@vger.kernel.org,
	Timo Mueller <timo.mueller@bmw-carit.de>
Subject: Re: [RFC] Bluetooth: Fix missing MITM protection when being
 responding LM
Message-ID: <20130122081320.GA27138@x220>
References: <1358789748-318-1-git-send-email-mail@timomueller.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358789748-318-1-git-send-email-mail@timomueller.eu>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Timo,

On Mon, Jan 21, 2013, mail@timomueller.eu wrote:
> A MITM protected SSP associaton model can be used for pairing if both
> local and remote IO capabilities are set to something other than
> NoInputNoOutput.
> 
> With these IO capabilities a MITM protected SSP association model is
> used if we are initiating the pairing process (initiating LM).
> 
> When responding to a pairing request - remote device is the initiating
> LM - the pairing should also be proteced against MITM attacks.
> 
> Signed-off-by: Timo Mueller <timo.mueller@bmw-carit.de>
> ---
> When we were testing the iPhone 5 we noticed that the association
> model changes depending on which side initiates the pairing. For
> example if we paired from the phone "Just Works" was used while if the
> phone was the responding LM a "Numeric Comparison" was used instead.
> 
> We'd like to enforce MITM protection in our cars whenever possible.
> That is why we want to set the MITM protection even when being the
> responding LM. The patch proposes this policy as the default approach.
> 
> Expected SSP accociation model:
> |-------------------------------------------|
> |  Device          |  SSP assocation model  |
> |===========================================|
> |  KeyboardDisplay |  Numeric Comparison    |
> | ------------------------------------------|
> |  NoInputNoOutput |  Just Works            |
> | ------------------------------------------|
> |  KeyboardOnly    |  Passkey Entry         |
> |-------------------------------------------|
> 
> Tested Devices:
>   KeyboardDisplay:
>     iPhone 4 (iOS4), iPhone 5 (iOS6), Nokia N9, HTC One S,
>     Samsung Galaxy (CM 10.1), Nexus 4, Nokia 6313 Classic,
>     BlueZ 5 - Simple Agent
> 
>   NoInputNoOutput:
>     BlueZ 5 - Simple Agent
> 
>   KeyboardOnly:
>     Logitech Keyboard Case, BlueZ 5 - Simple Agent
> 
> I've also tested this patch with the following kernels:
>   3.8-rc4
>   3.4
> 
> Best regards,
> 	 Timo
> 
>  net/bluetooth/hci_conn.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 25bfce0..806583b 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -357,11 +357,15 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
>  	conn->type  = type;
>  	conn->mode  = HCI_CM_ACTIVE;
>  	conn->state = BT_OPEN;
> -	conn->auth_type = HCI_AT_GENERAL_BONDING;
>  	conn->io_capability = hdev->io_capability;
>  	conn->remote_auth = 0xff;
>  	conn->key_type = 0xff;
>  
> +	if (hdev->io_capability == 0x03)
> +		conn->auth_type = HCI_AT_GENERAL_BONDING;
> +	else
> +		conn->auth_type = HCI_AT_GENERAL_BONDING_MITM;
> +
>  	set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
>  	conn->disc_timeout = HCI_DISCONN_TIMEOUT;

The question that could equally be asked is why does iOS *not* set the
MITM flag when initiating pairing to a remote device. If it did this
issue would not exist.

Since the over all sequence of the IO capability negotiation with iOS devices
when we're on the acceptor side might be a bit unclear to people by just
reading your commit message and patch I'll provide here a HCI trace of it:

 > HCI Event: IO Capability Response (0x32) plen 9
         Address: 04:F7:E4:xx:xx:xx (OUI 04-F7-E4)
         IO capability: DisplayYesNo (0x01)
         OOB data: Authentication data not present (0x00)
         Authentication: General Bonding - MITM not required (0x04)
 > HCI Event: IO Capability Request (0x31) plen 6
         Address: 04:F7:E4:xx:xx:xx (OUI 04-F7-E4)
 < HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
         Address: 04:F7:E4:xx:xx:xx (OUI 04-F7-E4)
         IO capability: DisplayYesNo (0x01)
         OOB data: Authentication data not present (0x00)
         Authentication: General Bonding - MITM not required (0x04)

Basically the BlueZ side has so far given the remote initiator the
choice whether to do just-works or not. However, I do agree that it's
good to strive for a best-possible security in the pairing (within the
limits of the available IO capabilities) so setting the MITM flag on our
side should be fine.

The one thing that I'd still consider improving is to make the setting
of the MITM flag also dependent on the remote IO capability and not just
the local one, since we do know the remote one before we need to give
our own value when we are on the acceptor side of the pairing. Thoughts?

Johan
