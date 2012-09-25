Return-Path: <cyrus@holtmann.org>
Message-ID: <1348584182.27596.28.camel@frustration.ornl.gov>
Subject: Re: [PATCH v3] HID: Add support for Sony PS3 BD Remote Control
From: David Dillow <dave@thedillows.org>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org,
	David Herrmann <dh.herrmann@googlemail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bastien Nocera <hadess@hadess.net>,
	linux-input@vger.kernel.org, jkosina@suse.cz
Date: Tue, 25 Sep 2012 10:43:02 -0400
In-Reply-To: <1348583447-31820-1-git-send-email-ospite@studenti.unina.it>
References: <20120925132136.985de0b203fd342bce6dc77d@studenti.unina.it>
	 <1348583447-31820-1-git-send-email-ospite@studenti.unina.it>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2012-09-25 at 16:30 +0200, Antonio Ospite wrote:
> +static int ps3remote_mapping(struct hid_device *hdev, struct hid_input *hi,
> +			     struct hid_field *field, struct hid_usage *usage,
> +			     unsigned long **bit, int *max)
> +{
> +	unsigned int key = usage->hid & HID_USAGE;

The size check below should be moved into the switch statement, and
modified for each, as you could access beyond the joypad_buttons array
as-is. The usage page check can stay outside the switch.

> +	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_BUTTON ||
> +	    key >= ARRAY_SIZE(ps3remote_keymap_remote_buttons))
> +		return -1;
> +
> +	switch (usage->collection_index) {
> +	case 1:
> +		key = ps3remote_keymap_joypad_buttons[key];
> +		if (!key)
> +			return -1;
> +		break;
> +	case 2:
> +		key = ps3remote_keymap_remote_buttons[key];
> +		if (!key)
> +			return -1;
> +		break;
> +	default:
> +		return -1;
> +	}
> +
> +	hid_map_usage_clear(hi, usage, bit, max, EV_KEY, key);
> +	return 1;
> +}

