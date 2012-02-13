Return-Path: <cyrus@holtmann.org>
Message-ID: <4F39138A.5000709@monom.org>
Date: Mon, 13 Feb 2012 14:43:38 +0100
From: Daniel Wagner <wagi@monom.org>
MIME-Version: 1.0
To: bubba junk <junkbubba2@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth Headset Connection Issue Linux v3.0
References: <CAMk70DBANeAndgm-nV=9Cgt2tvz=dRmd8WdpnJkNTe=a2LDugA@mail.gmail.com> <4EF30EE3.6050602@monom.org> <CAMk70DAh0gaydUbj-ryqeo350+64j=vn-_-yGUk_wo=fYSuXYw@mail.gmail.com> <4F13E0CD.50704@monom.org> <CAMk70DAo9no5aHJ7LaqYvQEE1-MO-4mGZbiMb7r1mUpiaA1N_Q@mail.gmail.com> <4F3237D8.3060700@monom.org> <CAMk70DCotYGECxFSmQvozXQE4TOwkB1ENaBTsVXoe1nM2UwV1g@mail.gmail.com>
In-Reply-To: <CAMk70DCotYGECxFSmQvozXQE4TOwkB1ENaBTsVXoe1nM2UwV1g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi bubba,

On 10.02.2012 17:12, bubba junk wrote:
> I then tried rebooting the laptop. I noticed that after rebooting the laptop,
> I was not able to reconnect the headset. I thought that maybe the sspmode had
> been re-enabled. I checked and it looked like it was re-enabled after reboot.
> I again ran the terminal command to disable it, this time without
> un-pair/re-pair and the headset was able to again connect. Is there a way to
> permanently disable the sspmode or disable it automatically after reboot until
> the bug has been patched?

I don't know if there is such a switch for permanent disabling simple
pairing.

> It seems like such a simple issue, but from a users perspective, the issue can
> have a devastating impact on the perception of the system. Users take for
> granted simple things like being able to connect a BT device and to have the
> ability to reconnect it the next time it is needed. For me, this has been an
> ongoing frustration since I upgraded to Ubuntu 11.10 from 11.04 back in
> October, almost 3 months ago. Until your email, I had spent hours reading
> different forums and posts trying to find out what was causing the issue. It
> was extremely frustrating to know that something that used to work, no longer
> did work.

I agree and I completely understand your situation. IIRC, at the last
Bluetooth meeting in Prague one conclusion was to coordinate the testing
a bit better on the upstream version of BlueZ. Such problems should be
soon something from the past.

> I'm glad to hear that a more permanent fix is in the works to correct the
> issue. Would you suggest that I create a bug report in the Ubuntu Launchpad
> forum and link to this thread so that at least this fix can be incorporated
> into my current distribution release? I've never created a bug report, so I'm
> not sure of the correct protocol.

There is already such a report. Would you mind to add some information
to the bug tracker with the results from here?

https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/839157

> You seem to be referring to a longer term fix as well. How would I go about
> monitoring the status of the longer term fix?

I wont work on it therefore, it is depending on the person who is going
to fix it :) Unfortunately, I only know the nick from the IRC (sjanc^)
who said s/he is going to fix it properly.

cheers,
daniel
