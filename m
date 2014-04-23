Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Apr 2014 14:37:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Allow discovery during advertising
Message-ID: <20140423113722.GA2967@t440s.lan>
References: <1397588651-13459-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1397588651-13459-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, Apr 15, 2014, Lukasz Rymanowski wrote:
> With this patch it is possible to start scan when device does
> advertising.
> 
> Most of chips do support such state combination, so there is no reason
> for blocking it here.
> If chip does not support this, kernel should get command status event
> with command disallowed status which should not make any problems.
> 
> Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
> ---
>  net/bluetooth/mgmt.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 54abbce..57cef73 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3474,13 +3474,6 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
>  			goto failed;
>  		}
>  
> -		if (test_bit(HCI_ADVERTISING, &hdev->dev_flags)) {
> -			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
> -					 MGMT_STATUS_REJECTED);
> -			mgmt_pending_remove(cmd);
> -			goto failed;
> -		}
> -
>  		/* If controller is scanning, it means the background scanning
>  		 * is running. Thus, we should temporarily stop it in order to
>  		 * set the discovery scanning parameters.

The general principle we've been following is that we don't send HCI
commands to the controller that we know will fail. In this case we do
track the supported states in hdev->le_states so you should be using
that to determine whether the command should fail or not.

You might need to add tracking of the advertising type though (similar
to how we track the own_addr_type for advertising) to know which state
combination to check.

Johan
