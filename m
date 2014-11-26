Return-Path: <cyrus@holtmann.org>
Message-ID: <1416996623.3171.7.camel@linux-0dmf.site>
Subject: Re: bluetooth related firmware loader spew on resume.
From: Oliver Neukum <oneukum@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Dave Jones <davej@redhat.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>, pgynther@google.com,
 linux-bluetooth@vger.kernel.org
Date: Wed, 26 Nov 2014 11:10:23 +0100
In-Reply-To: <s5h7fyijqc9.wl-tiwai@suse.de>
References: <20141111181228.GA27815@redhat.com>
	 <s5hsih7xmgg.wl-tiwai@suse.de>
	 <D19A9DA1-3706-4351-B2E9-25D5ABA662E7@holtmann.org>
	 <s5h7fyijqc9.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2014-11-26 at 09:52 +0100, Takashi Iwai wrote:
> At Wed, 26 Nov 2014 14:15:27 +0900,

> In order to paper over this, we may also remember the failing firmware
> and avoid loading it.  This might be an easer way than the endless
> fight against UMH race...

Hi,

the full fix would be to implement reset_resume() for btusb.
It seems to me that setup() should be split in two methods,
one to request the firmware from user space and the second
to transfer it to the device. reset_resume() would just need
to repeat the second operation.

	Regards
		Oliver
