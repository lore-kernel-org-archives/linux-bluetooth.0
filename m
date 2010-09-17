Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oneukum@suse.de>
To: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 1/3] bluetooth: Take a runtime pm reference on hid connections
Date: Fri, 17 Sep 2010 10:39:54 +0200
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org,
	marcel@holtmann.org
References: <1284659895-27984-1-git-send-email-mjg@redhat.com>
In-Reply-To: <1284659895-27984-1-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201009171039.54110.oneukum@suse.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Donnerstag, 16. September 2010, 19:58:13 schrieb Matthew Garrett:
> Bluetooth runtime PM interacts badly with input devices - the connection
> will be dropped if the device becomes idle, resulting in noticable lag when
> the user interacts with the input device again. Bump the pm runtime count
> when the device is associated and release it when it's disassociated in
> order to avoid this.

What is the effect on battery live of the external devices?

	Regards
		Oliver
