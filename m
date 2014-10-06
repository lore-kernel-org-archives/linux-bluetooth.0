Return-Path: <cyrus@holtmann.org>
Message-ID: <1412607050.1743.1.camel@linux-0dmf.site>
Subject: Re: btusb_intr_complete returns -EPIPE
From: Oliver Neukum <oneukum@suse.de>
To: Naveen Kumar Parna <pnaveenkos@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-usb@vger.kernel.org, acho@suse.com
In-Reply-To: <CAG0bkv+d9SxToWpk49s=C-w_aA4zbP_RvV_8kcgV254rsvHR0A@mail.gmail.com>
References: <CAG0bkvK4-gfeYXXsdNg4BKdjxmo1e5d8rKuABohtYNNBHKJwDA@mail.gmail.com>
	 <1412598268.1132.15.camel@linux-0dmf.site>
	 <CAG0bkv+nKt-TgONDLENNUncz9NScdJGcYR+J2Z6b=wg2grvqhg@mail.gmail.com>
	 <1412600108.28177.0.camel@linux-0dmf.site>
	 <CAG0bkvK=fumhJNzuSgx=HFHiVP08V+QH2wLajdffx+f5ugoQPQ@mail.gmail.com>
	 <1412602169.28177.2.camel@linux-0dmf.site>
	 <CAG0bkv+d9SxToWpk49s=C-w_aA4zbP_RvV_8kcgV254rsvHR0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 06 Oct 2014 16:50:50 +0200
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2014-10-06 at 20:08 +0530, Naveen Kumar Parna wrote:
> Thanks for the patch.
> 
> I tried and It crashed after the first occurrence of EPIPE.
> 
> Crash log is attached.

Could you post a full "lsusb -v"?

	Regards
		Oliver


