Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CD162F8F-68B5-42BD-AC1B-76DC1E1B80AE@cd-jackson.com>
References: <CD162F8F-68B5-42BD-AC1B-76DC1E1B80AE@cd-jackson.com>
Date: Sun, 28 Feb 2016 20:53:38 +0000
Message-ID: <CAAu3APZc0zsrLoSchuOo4B4cx=rzhsXBVGm8O7gS9c9VptnofQ@mail.gmail.com>
Subject: Re: Receiving BLE advertisements over DBus
From: Barry Byford <31baz66@gmail.com>
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Chris,


On 27 February 2016 at 00:08, Chris Jackson <chris@cd-jackson.com> wrote:
> Is it possible to receive BLE advertisements over the DBus interface - if so, how?
>
> I suspect that the answer is that it’s not currently possible - is there any plans to add such support?  It seems that this is something that is becoming more necessary as the number of devices sending data in the discovery packet increases…
>
> Any information on this would be appreciated - if necessary I’d be happy to look at implementing something if the BlueZ architects can comment on a recommended approach.
>
> Thanks
> Chris--

Are you talking about getting the data from beacons that are doing
non-connectable advertising?
I'm sure Johan will correct me if I'm wrong but I think this is what
he has recently fixed.
I believe there have been a problem with this in 5.37 and before.
Although this should now be fixed by this commit:
http://git.kernel.org/cgit/bluetooth/bluez.git/commit/?id=43657d77037302268b6ef02724c66eda416cf3e7
The beacons in tools have also been corrected:
http://git.kernel.org/cgit/bluetooth/bluez.git/commit/?id=42d1c2f0ba790e8a2050d5fcf8b45e0c563776ef

Regards,
Barry
