Return-Path: <mka@chromium.org>
Date: Mon, 18 Jun 2018 12:59:38 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, robh@kernel.org,
	thierry.escande@linaro.org, linux-bluetooth@vger.kernel.org,
	rtatiya@codeaurora.org, hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 3/8] Bluetooth: btqca: Rename ROME related functions
 to Generic functions
Message-ID: <20180618195938.GS88063@google.com>
References: <20180616062718.29844-1-bgodavar@codeaurora.org>
 <20180616062718.29844-4-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180616062718.29844-4-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Jun 16, 2018 at 11:57:13AM +0530, Balakrishna Godavarthi wrote:
> Some of the QCA BTSoC ROME functions, are used for different versions
> or different make of BTSoC's. Instead of duplicating the same functions
> for new chip, updating names of the functions that are used for both
> chip's to keep this generic and would help in future when we would have
> new BT SoC.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> 
> Changes in v7:
> 	* updated the all the functions of ROME to generic.
> 
> Changes in v6:
> 	* initial patch
> 	* updated names of functions that are used for both the chips to 
> 	  keep this generic and would help in future when we would have 
> 	  new BT SoC.
> 
> ---

As per my comment on "[2/8] Bluetooth: btqca: Rename string ROME to
QCA in logs.", it would probably make sense to squash these two
patches.

> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 13d77fd873b6..d0ee96540636 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -37,7 +37,7 @@
>  #define EDL_TAG_ID_HCI			(17)
>  #define EDL_TAG_ID_DEEP_SLEEP		(27)
>  
> -enum qca_bardrate {
> +enum qca_baudrate {
>  	QCA_BAUDRATE_115200 	= 0,
>  	QCA_BAUDRATE_57600,
>  	QCA_BAUDRATE_38400,

This is a bit sneaky, it is not related with the change nor mentioned
in the commit message.

It is certainly a welcome change, but should be done in a separate
patch (not necessarily in this series).

The fact that only the enum declaration needs to be fixed indicates
that the enum isn't used for variables/paramters/return values of this
type. Also beyond the scope of this series, but using the enum type
instead of int types would be another possible future improvement.
