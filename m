Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Jun 2013 13:05:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	kernel list <linux-kernel@vger.kernel.org>, marcel@holtmann.org,
	gustavo@padovan.org, linux-bluetooth@vger.kernel.org
Subject: Re: 3.10-rc: bluetooth disappeared on thinkpad x60 (regression)
Message-ID: <20130610100519.GA9816@x220.ger.corp.intel.com>
References: <20130610092907.GA5487@amd.pavel.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130610092907.GA5487@amd.pavel.ucw.cz>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavel,

On Mon, Jun 10, 2013, Pavel Machek wrote:
> root@amd:~# hciconfig hci0 up
> Can't init device hci0: Operation not supported (95)
> root@amd:~# hcitool inq
> Inquiring ...
> Inquiry failed.: No such device
> root@amd:~# 

Could you take logs of the HCI traffic that happens when you try this.
You can use the btmon tool from BlueZ for it. Based on a quick look at
the code it seems like this particular error could only come if one of
the HCI commands used for device initialization fails.

The Bluetooth HCI init sequence is constructed using only commands that
should be expected to work assuming the hardware follows the
specification, but occasionally we do encounter Bluetooth hardware that
is broken in one way or another and needs a work around to the sequence.
E.g. recently we added a couple of extra commands to read some new
parameters from the hardware, commands that are mandatory for hardware
beyond a specific version (something we check for), but could be that
the chip on the X60 doesn't support these.

Anyway, once we see what exactly is failing in the HCI logs we can make
an adjustment to the conditions that the failing commands depend on,
which in the worst case will be a device specific quirk based on the USB
id of your hardware.

Johan
