Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oneukum@suse.de>
To: Jesse Sung <jesse.sung@canonical.com>
Subject: Re: [PATCH] Bluetooth: set reset_resume handler
Date: Tue, 25 Oct 2011 10:40:13 +0200
Cc: linux-bluetooth@vger.kernel.org, 812132@bugs.launchpad.net
References: <4EA67552.1090703@canonical.com>
In-Reply-To: <4EA67552.1090703@canonical.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201110251040.14016.oneukum@suse.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am Dienstag, 25. Oktober 2011, 10:37:38 schrieb Jesse Sung:
> 
> On some machines, it seems that usb hubs do not get power while
> being suspended. We can get something like this in dmesg:
>      usb usb2: root hub lost power or was reset
> 
> When this is the case, .reset_resume is called instead of .resume.
> If .reset_resume is not set, bluetooth modules would stay in an unusable
> state because the resume function is not called.

Have you experimentally verified that? This state of affairs is years
old and should result in a virtual unplug/replug cycle. What are you
seeing?

	Regards
		Oliver
