Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Feb 2014 11:19:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Petri Gynther <pgynther@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3] hog: Use HoG device name as uHID input device name
Message-ID: <20140213091902.GA2754@x220.p-661hnu-f1>
References: <20140130035506.2A034100F4B@puck.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140130035506.2A034100F4B@puck.mtv.corp.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Wed, Jan 29, 2014, Petri Gynther wrote:
> If HoG BLE device name is known, use it when creating uHID input device.
> Pass adapter and device addresses to uHID as well.

Could you perhaps elaborate a bit what exactly the "uniq" and "phys"
members are in the request (possibly with a reference to the uHID
documentation). That would make it easier to verify that the content
you're adding to them makes sense.

> +	if (device_name_known(hogdev->device)) {
> +		device_get_name(hogdev->device, (char *) ev.u.create.name,
> +				sizeof(ev.u.create.name) - 1);
> +	} else {
> +		strcpy((char *) ev.u.create.name, "bluez-hog-device");
> +	}

We don't use { } for single line branches, so you can drop these here.

> +	ba2str(btd_adapter_get_address(device_get_adapter(hogdev->device)),
> +		(char *) ev.u.create.phys);

This is getting a bit messy with the nested function calls. I'd add
separate adapter variable here to make this a bit more readable.

Also note our coding style wrt split lines: indent the continuation
lines as much as you can (with tabs) as long as it's under 80 chars.

Also, it might be good to split this up into two patches since you've
essentially got two independent improvements here. One is making sure
the name member contains something more useful and the other is adding
some content to the uniq and phys members.

Johan
