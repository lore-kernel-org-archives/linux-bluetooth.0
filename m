Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Jan 2012 10:23:14 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Keith Packard <keithp@keithp.com>
cc: linux-kernel@vger.kernel.org, <linux-usb@vger.kernel.org>,
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Regression: Revert "Bluetooth: use buffer priority to
 mark URB_ISO_ASAP flag"
In-Reply-To: <1327298281-2502-1-git-send-email-keithp@keithp.com>
Message-ID: <Pine.LNX.4.44L0.1201231019580.1372-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 22 Jan 2012, Keith Packard wrote:

> Ok, so this is a comedy of errors. The Bluetooth code is trying to use
> an iso-specific flag (URB_ISO_ASAP) on a bulk endpoint, which is
> invalid, but normally harmless. Unless the USB code is compiled for
> debugging, in which case it checks a bunch for incorrect usage and
> discards URBs which are wrong.
> 
> As far as I'm concerned, #ifdef DEBUG code should never ever change
> the behaviour of the code, and so I'd say the USB code is even more
> broken than the bluetooth code...

Well, if the DEBUG code never changed any behaviors at all, it would be 
pretty useless, wouldn't it?

In this case, the change in behavior involves printing out a kernel 
message announcing a bug.  Causing the submission to fail also helps 
draw people's attention to the bug.  Under the circumstances, I think 
this is understandable and not truly broken.

Alan Stern

