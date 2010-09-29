Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201009291337.40197.sander@outrightsolutions.nl>
References: <AANLkTingVh3OaAGQzsxWJQddqrPwgFssMeOq5Rp_DbS6@mail.gmail.com>
	<AANLkTim27JkfgsumEwd3jK+n1DzYvTYWJGCLGreuw7y3@mail.gmail.com>
	<201009291337.40197.sander@outrightsolutions.nl>
Date: Wed, 29 Sep 2010 09:01:06 -0600
Message-ID: <AANLkTi=voJHxhTa4VXNnhUBm2v8ouX6cQNWgToip=wVi@mail.gmail.com>
Subject: Re: a2dp, myth, pulse
From: Brad Midgley <bmidgley@gmail.com>
To: Sander van Grieken <sander@outrightsolutions.nl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sander,

>> Control is enabled by default in 4.60, is there anything I can check
>> to see why I don't see any log messages about avrcp, no input device
>> appear, nothing logged, etc?
>
> Currently there is support in bluez to act as a AVRCP target, and it will deliver these
> events through the input layer. No new input device will appear, it will go through
> /dev/uinput (which I think you can open for reading then)

Thanks for the tip. I didn't have /dev/uinput or /dev/input/uinput so
I mknod'd it temporarily (mknod /dev/input/uinput c 10 233). Trying to
get anything out of it while streaming gives me "No such device". Is
there somewhere else I can look to debug what bluez is doing to see if
it's trying to handle avrcp events? Is there any d-bus api for
examining them? hcidump shows avrcp messages going across, I just
don't know what bluetoothd is doing with them.

thanks all
-- 
Brad Midgley
