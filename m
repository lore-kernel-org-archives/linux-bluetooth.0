Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Jun 2012 12:40:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon@janc.net.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] mgmtops: Fix adding UUID when EBUSY error is returned
Message-ID: <20120611094011.GA16742@x220.ger.corp.intel.com>
References: <1339357852-6326-1-git-send-email-szymon@janc.net.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339357852-6326-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Sun, Jun 10, 2012, Szymon Janc wrote:
> +static void mgmt_add_uuid_resend(int sk, uint16_t index)
> +{
> +	struct controller_info *info;
> +	struct pending_uuid *pending;
> +
> +	DBG("index %d", index);
> +
> +	info = &controllers[index];
> +
> +	pending = info->pending_uuids->data;
> +
> +	send_uuid(index, &pending->uuid, pending->svc_hint);
> +}
> +
>  static void mgmt_cmd_status(int sk, uint16_t index, void *buf, size_t len)
>  {
>  	struct mgmt_ev_cmd_status *ev = buf;
> @@ -1460,6 +1479,10 @@ static void mgmt_cmd_status(int sk, uint16_t index, void *buf, size_t len)
>  	case MGMT_OP_READ_LOCAL_OOB_DATA:
>  		read_local_oob_data_failed(sk, index);
>  		break;
> +	case MGMT_OP_ADD_UUID:
> +		if (ev->status == MGMT_STATUS_BUSY)
> +			mgmt_add_uuid_resend(sk, index);
> +		break;
>  	}
>  }

It's there a risk that this ends up in an infinite loop if the kernel is
in some state where it always keeps sending STATUS_BUSY? Would it make
sense to add a counter for retries and give up after 5 or 10 attempts?
Would it also make sense to add a small delay before resending the
command?

Johan
