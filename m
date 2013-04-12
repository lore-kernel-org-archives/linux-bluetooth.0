Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	johan.hedberg@intel.com, don.fry@intel.com
Subject: Re: [PATCH] Bluetooth: Add support for Intel Bluetooth device [8087:07dc]
Date: Fri, 12 Apr 2013 10:33:47 -0700
Message-ID: <3003415.FJhpspW2hz@tedd-ubuntu>
In-Reply-To: <CAJdJm_NmHWTGcBCDt+wFtR-ARPqxi5bWR1fSQSdJHvEs2Vo61w@mail.gmail.com>
References: <3298128.mJ3qNWl1BF@tedd-ubuntu> <CAJdJm_NmHWTGcBCDt+wFtR-ARPqxi5bWR1fSQSdJHvEs2Vo61w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson.

Thanks for the comments.
I didn't know that I needed to run with "strict" option.

I will fix it and send new one.

Regards.

Tedd


On Friday, April 12, 2013 06:44:19 AM Anderson Lizardo wrote:
> Hi Tedd,
> 
> On Thu, Apr 11, 2013 at 7:31 PM, Tedd Ho-Jeong An <tedd.an@intel.com> wrote:
> > From: Tedd Ho-Jeong An <tedd.an@intel.com>
> >
> > This patch adds support for Intel Bluetooth device by adding
> > btusb_setup_intel() routine that update the device with ROM patch.
> 
> You might want to run "./scripts/checkpatch.pl --strict" on your
> patch, which will report various alignment issues. These issues were
> very criticized on the past, therefore you may want to fix them.
> 
> There is a line exceeding the 80-column limit as well, which should be
> easy to fix.
> 
> Best Regards,
> 

