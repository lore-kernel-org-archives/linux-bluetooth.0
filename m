Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: bluetooth related firmware loader spew on resume.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <s5hioi2xmf9.wl-tiwai@suse.de>
Date: Wed, 26 Nov 2014 23:08:22 +0900
Cc: Oliver Neukum <oneukum@suse.de>, Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	pgynther@google.com, linux-bluetooth@vger.kernel.org
Message-Id: <2B9F7EBC-753E-4486-9A5A-32031ADD22E7@holtmann.org>
References: <20141111181228.GA27815@redhat.com> <s5hsih7xmgg.wl-tiwai@suse.de> <D19A9DA1-3706-4351-B2E9-25D5ABA662E7@holtmann.org> <s5h7fyijqc9.wl-tiwai@suse.de> <1416996623.3171.7.camel@linux-0dmf.site> <s5hlhmyxng0.wl-tiwai@suse.de> <1416998616.3171.13.camel@linux-0dmf.site> <s5hioi2xmf9.wl-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Takashi,

>>>> On Wed, 2014-11-26 at 09:52 +0100, Takashi Iwai wrote:
>>>>> At Wed, 26 Nov 2014 14:15:27 +0900,
>>>> 
>>>>> In order to paper over this, we may also remember the failing firmware
>>>>> and avoid loading it.  This might be an easer way than the endless
>>>>> fight against UMH race...
>>>> 
>>>> Hi,
>>>> 
>>>> the full fix would be to implement reset_resume() for btusb.
>>>> It seems to me that setup() should be split in two methods,
>>>> one to request the firmware from user space and the second
>>>> to transfer it to the device. reset_resume() would just need
>>>> to repeat the second operation.
>>> 
>>> I'm not against it, but one slight drawback is that you'll have to
>>> remember the firmware content to transfer by the driver itself in this
>>> scenario.   In the firmware loader framework, the content is re-read
>>> at resume so that the largish content isn't kept unnecessarily during
>>> the whole operation. 
>> 
>> That isn't a drawback but an advantage. Firmware for devices that
>> do power management needs to be in RAM. The right time to free it
>> is in disconnect(). But why does that mean that the driver has to
>> manage the firmware? Can't the firmware layer do it?
> 
> The f/w loader remembers the f/w names of the successful loads, and
> retries to load them automatically at the suspend time.  But it
> doesn't remember/cache the failed loads.  So, when the driver retires
> request_firmware() for a non-existing file in the resume path, it
> actually reaches to the f/w loading part again unexpectedly.

I think this should be indeed fixed. The firmware loader needs to remember the information. Since sometimes the firmware is optional. No point in re-loading it. And realistically, if the firmware was not present before suspend, it will not magically appear during resume.

Regards

Marcel

