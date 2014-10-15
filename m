Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1413367888.7328.1.camel@linux-0dmf.site>
References: <Pine.LNX.4.44L0.1410091030580.1372-100000@iolanthe.rowland.org>
	<1413367888.7328.1.camel@linux-0dmf.site>
Date: Wed, 15 Oct 2014 18:39:31 +0530
Message-ID: <CAG0bkvJ8QrvdhCQjwOm79KMZWbE7S=keOfdTy7hyUCV-RmLegQ@mail.gmail.com>
Subject: Re: btusb_intr_complete returns -EPIPE
From: Naveen Kumar Parna <pnaveenkos@gmail.com>
To: Oliver Neukum <oneukum@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-usb@vger.kernel.org, acho@suse.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

EHCI controller on PCI card and hub("rate-matching" hub) also internal.

Is it possible to change the internal hub?



Thanks,
Naveen

On Wed, Oct 15, 2014 at 3:41 PM, Oliver Neukum <oneukum@suse.de> wrote:
> On Thu, 2014-10-09 at 10:31 -0400, Alan Stern wrote:
>> On Thu, 9 Oct 2014, Naveen Kumar Parna wrote:
>>
>> > Hi Oliver & Alan,
>> >
>> >
>> >
>> > Thanks for your inputs.
>> >
>> >
>> >
>> > I enabled the dynamic debugging for USB HC driver. Please correct me
>> > if I am wrong.
>>
>> Debugging the kernel (or doing anything else to the kernel, for that
>> matter) won't solve the problem if it is caused by a buggy hub.
>
> Indeed. Could you just try a different hub?
>
>         Regards
>                 Oliver
>
>
>
