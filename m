Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 0/3] HID: make raw output callback more flexible
From: Bastien Nocera <hadess@hadess.net>
To: Michael Poole <mdpoole@troilus.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Jiri Kosina <jkosina@suse.cz>,
        "Gunn, Brian" <bgunn@solekai.com>, Ping <pinglinux@gmail.com>,
        linux-kernel@vger.kernel.org,
        BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <87iqakifm8.fsf@troilus.org>
References: <alpine.LNX.2.00.1001291515560.356@pobox.suse.cz>
	 <1264783166.29532.5302.camel@localhost.localdomain>
	 <87iqakifm8.fsf@troilus.org>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Sat, 30 Jan 2010 14:11:03 +0000
Message-ID: <1264860663.29532.7887.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2010-01-29 at 19:46 -0500, Michael Poole wrote:
> > [1]: Comments on the patch at
> > http://thread.gmane.org/gmane.linux.bluez.kernel/4279 would be
> > appreciated
> 
> This patch does not work for me.  Before, the first time after each
> boot
> that I tried to connect to an Apple Magic Mouse, it failed with -14
> (EFAULT).  With this patch, it fails with -22 (EINVAL) instead.  The
> -EFAULT *was* due to hidp_parse()'s copy_from_user().  I have not
> looked
> yet to see where the -EINVAL is coming from -- would that help?  (Both
> with and without your patch, the second attempt to connect works.) 

I don't get -EFAULT anymore (it was failing to copy the rd_data from
user-space), but I do get -EINVALs now. I haven't investigated it
though. My guess is that the hid parser fails.

Could you compare the sizes of the data gathered in user-space?
