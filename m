Return-Path: <cyrus@holtmann.org>
Subject: Re: Apple Bluetooth devices: Battery level?
From: Bastien Nocera <hadess@hadess.net>
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-bluetooth@vger.kernel.org,
	linux-input <linux-input@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.0906101023460.7457@wotan.suse.de>
References: <1244384236.30768.5690.camel@cookie.hadess.net>
	 <alpine.LRH.2.00.0906081530330.31685@twin.jikos.cz>
	 <1244589738.5973.1954.camel@cookie.hadess.net>
	 <alpine.LNX.2.00.0906101023460.7457@wotan.suse.de>
Content-Type: text/plain
Date: Wed, 10 Jun 2009 15:25:43 +0100
Message-Id: <1244643943.2690.76.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2009-06-10 at 10:25 +0200, Jiri Kosina wrote:
> On Wed, 10 Jun 2009, Bastien Nocera wrote:
<snip>
> > - enabling CONFIG_HID_DEBUG requires rebuilding the kernel
> 
> CONFIG_HID_DEBUG has 'default y' for quite some time, but the defconfigs 
> haven't unfortunately been updated yet.
> 
> > - most distributions build hid into the kernel
> 
> hid.debug=2 on the kernel commandline option does the trick.

Or "echo 2 > /sys/modules/hid/parameters/debug" at run-time.

Seems CONFIG_HID_DEBUG is enabled by default in the builds I use as
well, so I'll quit complaining about that :)

Cheers

