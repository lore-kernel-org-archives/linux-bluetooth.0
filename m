Return-Path: <cyrus@holtmann.org>
Date: Sun, 1 Nov 2015 15:38:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/4] Bluetooth: Make LE only events conditional on
 supported commands
Message-ID: <20151101133808.GA21304@t440s.P-661HNU-F1>
References: <1446367191-67668-3-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446367191-67668-3-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Nov 01, 2015, Marcel Holtmann wrote:
> For the LE only controllers, there are events that should not be enabled
> if the corresponding command is not supported.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

I've applied patches 1, 2 and 4 from this set, but could you add some
clarifications to this one:

> @@ -534,13 +534,20 @@ static void hci_setup_event_mask(struct hci_request *req)
>  	} else {
>  		/* Use a different default for LE-only devices */
>  		memset(events, 0, sizeof(events));
> -		events[0] |= 0x10; /* Disconnection Complete */
> -		events[1] |= 0x08; /* Read Remote Version Information Complete */
>  		events[1] |= 0x20; /* Command Complete */
>  		events[1] |= 0x40; /* Command Status */
>  		events[1] |= 0x80; /* Hardware Error */
> -		events[2] |= 0x04; /* Number of Completed Packets */
> -		events[3] |= 0x02; /* Data Buffer Overflow */
> +
> +		if (hdev->commands[0] & 0x20) {
> +			events[0] |= 0x10; /* Disconnection Complete */
> +			events[2] |= 0x04; /* Number of Completed Packets */
> +			events[3] |= 0x02; /* Data Buffer Overflow */
> +		}

Which exact command is "hdev->commands[0] & 0x20"? Could you add a code
comment here to make it clear.

> +		if (hdev->commands[2] & 0x80)
> +			events[1] |= 0x08; /* Read Remote Version Information
> +					    * Complete
> +					    */

I assume this one is HCI_Read_Remote_Version_Information, but might be
good to add a code comment for it too.

Johan
