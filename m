Return-Path: <cyrus@holtmann.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Bug 26182] btusb hangs after resetting USB device
Date: Wed, 23 Feb 2011 20:36:11 +0100
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
References: <bug-26182-10028@https.bugzilla.kernel.org/> <201102231604.p1NG4UEf006117@demeter1.kernel.org>
In-Reply-To: <201102231604.p1NG4UEf006117@demeter1.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201102232036.11270.rjw@sisk.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday, February 23, 2011, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=26182
> 
> 
> Alan Stern <stern@rowland.harvard.edu> changed:
> 
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>                  CC|                            |mjg59-kernel@srcf.ucam.org
> 
> 
> 
> 
> --- Comment #7 from Alan Stern <stern@rowland.harvard.edu>  2011-02-23 16:04:19 ---
> Matthew, it looks like your 556ea928f78a390fe16ae584e6433dff304d3014 commit
> (Bluetooth: Enable USB autosuspend by default on btusb) needs to be reverted,
> at least until somebody adds reset-resume support to the btusb driver.
> 
> Florian or Rafael, can one of you let the Bluetooth maintainers know about this
> bug?  There has been at least one other bug report for this same problem on
> LKML:
> 
>    http://marc.info/?l=linux-kernel&m=129845423017429&w=2

Sure, CCed.

Thanks,
Rafael
