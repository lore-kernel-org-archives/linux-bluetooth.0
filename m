Return-Path: <cyrus@holtmann.org>
Date: Sun, 24 May 2015 16:58:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] monitor: Improbe decoding of ATT Read by Group
 Type Respose
Message-ID: <20150524135841.GA10688@t440s>
References: <1432473311-16657-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432473311-16657-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sun, May 24, 2015, Luiz Augusto von Dentz wrote:
> +static void print_group_list(const char *label, uint8_t length,
> +					const void *data, uint16_t size)
> +{
> +	uint8_t count;
> +
> +	if (length == 0)
> +		return;
> +
> +	count = size / length;
> +
> +	print_field("%s: %u entr%s", label, count, count == 1 ? "y" : "ies");
> +
> +	while (size >= length) {
> +		print_handle_range("Handle range", data);
> +		print_uuid("UUID", data + 4, length - 4);
> +
> +		data += length;
> +		size -= length;
> +	}
> +
> +	packet_hexdump(data, size);
> +}

Looks good, but to avoid btmon crashes (e.g. when analyzing codenomicon
logs) might be good to add check for 'length >= 6' and jump to
packet_hexdump if you get something smaller than that.

Johan
