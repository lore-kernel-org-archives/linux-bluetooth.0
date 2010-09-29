Return-Path: <cyrus@holtmann.org>
From: Sander van Grieken <sander@outrightsolutions.nl>
To: linux-bluetooth@vger.kernel.org
Subject: Re: a2dp, myth, pulse
Date: Wed, 29 Sep 2010 17:08:00 +0200
References: <AANLkTingVh3OaAGQzsxWJQddqrPwgFssMeOq5Rp_DbS6@mail.gmail.com> <201009291337.40197.sander@outrightsolutions.nl> <AANLkTi=voJHxhTa4VXNnhUBm2v8ouX6cQNWgToip=wVi@mail.gmail.com>
In-Reply-To: <AANLkTi=voJHxhTa4VXNnhUBm2v8ouX6cQNWgToip=wVi@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201009291708.01026.sander@outrightsolutions.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 29 September 2010 17:01:06 Brad Midgley wrote:
> Sander,
> 
> >> Control is enabled by default in 4.60, is there anything I can check
> >> to see why I don't see any log messages about avrcp, no input device
> >> appear, nothing logged, etc?
> >
> > Currently there is support in bluez to act as a AVRCP target, and it will deliver 
these
> > events through the input layer. No new input device will appear, it will go through
> > /dev/uinput (which I think you can open for reading then)
> 
> Thanks for the tip. I didn't have /dev/uinput or /dev/input/uinput so
> I mknod'd it temporarily (mknod /dev/input/uinput c 10 233). Trying to
> get anything out of it while streaming gives me "No such device". 

I suppose this has to be enabled in the kernel, or loaded as a module, then udev will pick 
it up. On my Ubuntu 10.10 it is enabled in the kernel.

--
Sander
