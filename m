Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oneukum@suse.de>
To: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: Tedd Ho-Jeong An <tedd.an@intel.com>,
	linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org,
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: Re: autosuspend issues with the Intel Bluetooth device [8087:07dc]
Date: Wed, 03 Jul 2013 14:29:28 +0200
Message-ID: <2178464.gnEadSyMSQ@linux-5eaq.site>
In-Reply-To: <87obajn8wv.fsf@nemi.mork.no>
References: <87obajn8wv.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 03 July 2013 14:08:00 Bjørn Mork wrote:
> But this just does not seem right? Any modern USB device is supposed to
> support autosuspend, right? I am using the firmware patch included in

What should be and what is may be different although it oughn't be.

> the latest public firmware repo:

Does the device respond to standard request, that is what does lsusb do?

	Regards
		Oliver

