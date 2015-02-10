Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <54D9D9B1.30800@endlessm.com>
References: <54D4D012.4050108@endlessm.com>
	<54D9D9B1.30800@endlessm.com>
Date: Tue, 10 Feb 2015 14:05:00 +0200
Message-ID: <CABBYNZ+QQdL1t-m32R6kuWvKSdnyXVAgyWmiXY5UvFh=1kAMpg@mail.gmail.com>
Subject: Re: No SCO packets while trying to use a Bluetooth headset
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mario Sanchez Prada <mario@endlessm.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Larry.Finger@lwfinger.net
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mario,

On Tue, Feb 10, 2015 at 12:13 PM, Mario Sanchez Prada
<mario@endlessm.com> wrote:
> Hi again,
>
> Just a quick heads up about the problem mentioned a few days ago (see [1]) to let you know that I've recently (yesterday) tried the latest kernel 3.19 and that did not make any difference either. I've tested this by applying Daniel's patch to add support for the RTL8723BE bluetooth device (see [2]) on top of the v3.19 tag from the kernel git repository, and I also used the latest release of BlueZ and PulseAudio, so the problem seems to be still relevant even with the latest code.
>
> At this point it's not clear to me what the problem could be, so I'd really appreciate any comment that might help fix or improve this situation. Larry Finger, I'm adding you to Cc as I understand you are the go-to person for these drivers, in case you could drop some light on this problem (e.g. perhaps you've seen something similar before?).

I think your controller is not properly setup for SCO over HCI
routing, probably Windows does that so while the controller is still
powered it will work but as soon as you power it down it will loose
these settings. I guess you will need to find what commands these are,
from the logs it seems the Windows driver is doing something that
wireshark cannot decode, perhaps it is not really HCI as it claims to
be.

> Thank you all,
> Mario
>
> [1] http://article.gmane.org/gmane.linux.bluez.kernel/58759
> [2] http://article.gmane.org/gmane.linux.bluez.kernel/58810
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
