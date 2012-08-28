Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Aug 2012 10:40:10 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: mgmt: Fix enabling LE while powered off
Message-ID: <20120828074008.GA4602@aemeltch-MOBL1>
References: <1346078850-32704-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1346078850-32704-2-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346078850-32704-2-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Mon, Aug 27, 2012 at 04:47:30PM +0200, Andrzej Kaczmarek wrote:
> Set LE called when hdev is up but still has HCI_AUTO_OFF flag set will
> only change dev_flags and enable feature in host but won't enable feature
> in controller. As a resulit it's not possible to e.g. start LE only or
> interleaved discovery due to missing LE Supported flag in local features.
> 
> This patch ensures HCI Write LE Host Supported is sent when Set Powered is
> called to clear HCI_AUTO_OFF flag.
> 
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> ---
>  net/bluetooth/mgmt.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index ccc6716..f73441f 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2897,6 +2897,17 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
>  			hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE, 1, &ssp);
>  		}
>  
> +		if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
> +			struct hci_cp_write_le_host_supported cp;
> +
> +			memset(&cp, 0, sizeof(cp));

Why memset is needed here?

Best regards 
Andrei Emeltchenko 

> +			cp.le = 1;
> +			cp.simul = !!(hdev->features[6] & LMP_SIMUL_LE_BR);
> +
> +			hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED,
> +				     sizeof(cp), &cp);
> +		}
> +
>  		update_class(hdev);
>  		update_name(hdev, hdev->dev_name);
>  		update_eir(hdev);
> -- 
> 1.7.11.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
