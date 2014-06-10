Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix SSP acceptor just-works confirmation without MITM
Date: Tue, 10 Jun 2014 10:22:29 +0200
Message-ID: <3801331.FNIQ7jQ6EV@uw000953>
In-Reply-To: <1402311494-28906-1-git-send-email-johan.hedberg@gmail.com>
References: <1402311494-28906-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Monday 09 of June 2014 13:58:14 johan.hedberg@gmail.com wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> From the Bluetooth Core Specification 4.1 page 1958:
> 
> "if both devices have set the Authentication_Requirements parameter to
> one of the MITM Protection Not Required options, authentication stage 1
> shall function as if both devices set their IO capabilities to
> DisplayOnly (e.g., Numeric comparison with automatic confirmation on
> both devices)"
> 
> So far our implementation has done user confirmation for all just-works
> cases regardless of the MITM requirements, however following the
> specification to the word means that we should not be doing confirmation
> when neither side has the MITM flag set.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_event.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index df7895e8fcc8..67a9cf4143ae 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3622,8 +3622,11 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
>  
>  		/* If we're not the initiators request authorization to
>  		 * proceed from user space (mgmt_user_confirm with
> -		 * confirm_hint set to 1). */
> -		if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags)) {
> +		 * confirm_hint set to 1). The exception is if neither
> +		 * side had MITM in which case we do auto-accept.
> +		 */
> +		if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) &&
> +		    (loc_mitm || rem_mitm)) {
>  			BT_DBG("Confirming auto-accept as acceptor");
>  			confirm_hint = 1;
>  			goto confirm;
> 

I've tested this on top of Nexus4 kernel + backports-20140516 with Android
CTS "Insecure Server" test and this works OK (no user confirmation on incoming
pairing).

Tested-by: Szymon Janc <szymon.janc@tieto.com>

-- 
Best regards, 
Szymon Janc
