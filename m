Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Nov 2013 14:15:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v4 1/5] android/hid: Fix set seport ipc cmd preparation
Message-ID: <20131108121531.GA1371@x220.p-661hnu-f1>
References: <1383912531-1306-1-git-send-email-ravikumar.veeramally@linux.intel.com>
 <1383912531-1306-2-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383912531-1306-2-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Fri, Nov 08, 2013, Ravi kumar Veeramally wrote:
> -	memcpy(cmd.data, report, cmd.len);
> +	memset(cmd, 0, sizeof(buf));

How about memset(buf, 0, sizeof(buf)) to make this perfectly clear. Btw,
why is the memset needed? I don't think the original code had it. Seems
like this is an independent bug fix?

> +	cmd->len = strlen(report);
> +	memcpy(cmd->data, report, cmd->len);
>  
>  	switch (report_type) {
>  	case BTHH_INPUT_REPORT:
> -		cmd.type = HAL_HIDHOST_INPUT_REPORT;
> +		cmd->type = HAL_HIDHOST_INPUT_REPORT;
>  		break;
>  	case BTHH_OUTPUT_REPORT:
> -		cmd.type = HAL_HIDHOST_OUTPUT_REPORT;
> +		cmd->type = HAL_HIDHOST_OUTPUT_REPORT;
>  		break;
>  	case BTHH_FEATURE_REPORT:
> -		cmd.type = HAL_HIDHOST_FEATURE_REPORT;
> +		cmd->type = HAL_HIDHOST_FEATURE_REPORT;
>  		break;
>  	default:
>  		return BT_STATUS_PARM_INVALID;
>  	}
>  
>  	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SET_REPORT,
> -				sizeof(cmd), &cmd, 0, NULL, NULL);
> +					sizeof(buf), buf, 0, NULL, NULL);

This last call looks broken to me. Shouldn't you instead of sizeof(buf)
be sending sizeof(*cmd) + cmd->len?

Johan
