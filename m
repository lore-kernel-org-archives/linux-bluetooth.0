Return-Path: <cyrus@holtmann.org>
From: Michael Poole <mdpoole@troilus.org>
To: Bastien Nocera <hadess@hadess.net>,  Marcel Holtmann <marcel@holtmann.org>
Cc: Jiri Kosina <jkosina@suse.cz>,  "Gunn\, Brian" <bgunn@solekai.com>,  Ping <pinglinux@gmail.com>,  linux-kernel@vger.kernel.org,  BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 0/3] HID: make raw output callback more flexible
References: <alpine.LNX.2.00.1001291515560.356@pobox.suse.cz>
	<1264783166.29532.5302.camel@localhost.localdomain>
Date: Fri, 29 Jan 2010 19:46:39 -0500
In-Reply-To: <1264783166.29532.5302.camel@localhost.localdomain> (Bastien
	Nocera's message of "Fri, 29 Jan 2010 16:39:26 +0000")
Message-ID: <87iqakifm8.fsf@troilus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

Bastien Nocera writes:

> On Fri, 2010-01-29 at 15:20 +0100, Jiri Kosina wrote:
>> Hi,
>> 
>> this is a followup to the thread
>> 
>> 	"Implement Bluetooth Wacom tablet's mode change in the kernel"
>> 
>> First patch alters the raw output API so that it is able to actually 
>> distinguish between feature and output reports (and modifies low-level 
>> drivers accordingly), and the two followup patches make use of this for 
>> in-kernel mode setting of Sony and Wacom bluetooth devices.
>> 
>> Marcel, could you please review the Bluetooth part?

Count this as another vote for review, please -- I have a similar
patch[1] that I would prefer to drop.

[1]- http://www.spinics.net/lists/linux-input/msg06768.html

> Patches 1 and 2 work as expected (minus the hidp parsing issue[1]).
> Couldn't test patch 3 for the Sony Sixaxis right now.
>
> Cheers
>
> [1]: Comments on the patch at
> http://thread.gmane.org/gmane.linux.bluez.kernel/4279 would be
> appreciated

This patch does not work for me.  Before, the first time after each boot
that I tried to connect to an Apple Magic Mouse, it failed with -14
(EFAULT).  With this patch, it fails with -22 (EINVAL) instead.  The
-EFAULT *was* due to hidp_parse()'s copy_from_user().  I have not looked
yet to see where the -EINVAL is coming from -- would that help?  (Both
with and without your patch, the second attempt to connect works.)

Michael Poole
