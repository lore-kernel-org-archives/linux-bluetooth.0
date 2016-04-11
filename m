Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 11 Apr 2016 22:06:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2] core/device: Fix breakage of Bluetooth pairing
Message-ID: <20160411190614.GA4001@t440s.P-661HNU-F1>
References: <1460390582-16548-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460390582-16548-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Apr 11, 2016, Luiz Augusto von Dentz wrote:
> +static void convert_info(struct btd_device *device, GKeyFile *key_file)
> +{
> +	char **uuids;
> +
> +	/* Load device profile list from legacy property */
> +	uuids = g_key_file_get_string_list(key_file, "General", "SDPServices",
> +								NULL, NULL);
> +	if (uuids) {
> +		char **uuid;
> +
> +		for (uuid = uuids; *uuid; uuid++)
> +			device_add_uuid(device, *uuid);
> +
> +		/* Remove SDPServices so it is not loaded again */
> +		g_key_file_remove_key(key_file, "General", "SDPServices", NULL);

Note that this doesn't modify the file but just the GKeyFile object. For
places where we need to write back out the contents to the file we
usually use g_key_file_to_data + g_file_set_contents, but I didn't see
any such calls in this call path.

Johan
