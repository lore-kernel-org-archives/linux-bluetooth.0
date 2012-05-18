Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 May 2012 19:27:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 2/3 v2] AVRCP: Subscribe for VolumeChanged
 Notification
Message-ID: <20120518162726.GA8733@x220.P-661HNU-F1>
References: <1337357504-7900-1-git-send-email-luiz.dentz@gmail.com>
 <1337357504-7900-2-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337357504-7900-2-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

I think the following loop can be simplified a bit:

> +	for (l = session->handlers; l; l = l->next) {
> +		struct avctp_rsp_handler *handler = l->data;
> +
> +		if (handler->id == avctp->transaction) {

Avoid unnecessary indentation by using != and continue;

> +			gboolean ret = FALSE;
> +
> +			if (handler->func)
> +				ret = handler->func(session, avc->code,
> +						avc->subunit_type,
> +						operands, operand_count,
> +						handler->user_data);
> +
> +			if (ret)
> +				return;

Once you've reduced the indentation by the above trick you could even
just do:

	if (handler->func && handler->func(...))
		return;

Johan
