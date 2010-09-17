Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Sep 2010 13:24:21 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org,
	marcel@holtmann.org
Subject: Re: [PATCH 1/3] bluetooth: Take a runtime pm reference on hid
	connections
Message-ID: <20100917122421.GA2072@srcf.ucam.org>
References: <1284659895-27984-1-git-send-email-mjg@redhat.com> <201009171039.54110.oneukum@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201009171039.54110.oneukum@suse.de>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Sep 17, 2010 at 10:39:54AM +0200, Oliver Neukum wrote:
> Am Donnerstag, 16. September 2010, 19:58:13 schrieb Matthew Garrett:
> > Bluetooth runtime PM interacts badly with input devices - the connection
> > will be dropped if the device becomes idle, resulting in noticable lag when
> > the user interacts with the input device again. Bump the pm runtime count
> > when the device is associated and release it when it's disassociated in
> > order to avoid this.
> 
> What is the effect on battery live of the external devices?

That's a reasonable question. I'll see what I can measure.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
