Return-Path: <mka@chromium.org>
Date: Fri, 25 May 2018 15:03:34 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
	hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 3/5] Bluetooth: hci_qca: Enable 3.2 Mbps operating
 speed.
Message-ID: <20180525220334.GB168650@google.com>
References: <20180524160051.29966-1-bgodavar@codeaurora.org>
 <20180524160051.29966-4-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180524160051.29966-4-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, May 24, 2018 at 09:30:49PM +0530, Balakrishna Godavarthi wrote:
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> 
> Changes in v6:
> 	* initial patch
> 	* enables Qualcomm chip to operate at 3.2Mbps.

The second point should be rather part of the commit message, but
since the summary basically states the same I guess it's fine to
omit it.

> 
> ---
>  drivers/bluetooth/hci_qca.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index f05382b5a65d..cb1034998040 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -872,6 +872,8 @@ static uint8_t qca_get_baudrate_value(int speed)
>  		return QCA_BAUDRATE_2000000;
>  	case 3000000:
>  		return QCA_BAUDRATE_3000000;
> +	case 3200000:
> +		return QCA_BAUDRATE_3200000;
>  	case 3500000:
>  		return QCA_BAUDRATE_3500000;
>  	default:
> @@ -886,7 +888,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>  	struct sk_buff *skb;
>  	u8 cmd[] = { 0x01, 0x48, 0xFC, 0x01, 0x00 };
>  
> -	if (baudrate > QCA_BAUDRATE_3000000)
> +	if (baudrate > QCA_BAUDRATE_3200000)
>  		return -EINVAL;
>  
>  	cmd[4] = baudrate;

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
