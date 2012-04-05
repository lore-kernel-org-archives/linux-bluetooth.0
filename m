Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Apr 2012 13:28:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ 2/4] btio: Add address type in bt_io_connect
Message-ID: <20120405102805.GE32212@x220>
References: <1333570571-29650-1-git-send-email-claudio.takahasi@openbossa.org>
 <1333570571-29650-2-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333570571-29650-2-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Apr 04, 2012, Claudio Takahasi wrote:
> @@ -714,6 +717,9 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
>  		case BT_IO_OPT_DEST_BDADDR:
>  			bacpy(&opts->dst, va_arg(args, const bdaddr_t *));
>  			break;
> +		case BT_IO_OPT_DEST_TYPE:
> +			opts->dst_type = va_arg(args, int);
> +			break;
>  		case BT_IO_OPT_DEFER_TIMEOUT:
>  			opts->defer = va_arg(args, int);
>  			break;

I'd prefer that you also add a line to the "Set defaults" section of
this function to initialize opts->dst_type (I know the default is
implicitly 0 but it's good to have it there for clarity). Also, are you
planning to add BT_IO_* defines/enum for the types or what value is the
new BtIO API expecting to receive (this should probably be documented
and you do need to know the answer to the question before adding the
initialization line I requested).

Johan
