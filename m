Return-Path: <cyrus@holtmann.org>
Message-Id: <49F9E0BA020000BF00029098@mailgw2.hevs.ch>
Date: Thu, 30 Apr 2009 17:32:42 +0200
From: "Marc Pignat" <Marc.Pignat@hevs.ch>
To: <marcel@holtmann.org>,<jkosina@suse.cz>
Cc: <ext-roger.quadros@nokia.com>,<linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.30-rc4 hid bluetooth not working
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

>>> Marcel Holtmann <marcel@holtmann.org> 04/30/09 5:03 PM >>>
>Hi Jiri,

>> > My bluetooth keyboard is not working any more in rc4, but was working =
in=20
>> > rc3.
>> > Here is the dmesg output, triggered by the first key press on the=20
>> > keyboard, fortunately, this is 100% reproductible (once per boot).
>>=20
>> Does reverting f3784d834c7 fix the problem?

>we have seen a similar report where reverting f3784d834c7 didn't fix it.
It seems to fix it for me...

>And I don't see anything wrong with that patch. Did something important
>got changed in the work queue code that I am missing?

Is this a good idea to flush the current queue? (add_con and del_con call =
flush_workqueue(bluetooth),
but add_con and del_con are run by this queue).

Best regards

Marc
