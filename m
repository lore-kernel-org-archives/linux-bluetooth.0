Return-Path: <cyrus@holtmann.org>
Subject: Re: HCI_MAX_DEV is a bit too small.
From: Marcel Holtmann <marcel@holtmann.org>
To: donpedro@tdcadsl.dk
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1268608837.6400.26.camel@donpedro>
References: <1268608837.6400.26.camel@donpedro>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 14 Mar 2010 16:34:19 -0700
Message-ID: <1268609659.3897.56.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pedro,

> HCI_MAX_DEV is set a bit low (16), causing hci_for_each_dev() to not
> return all of the devices if you have more. This is not a disaster for
> the library itself, as i can just copy hci_for_each_dev() and make a
> version supporting more devices.
> 
> However, hcitool uses the library version of hci_for_each_dev(), so that
> makes hcitool useless for a system with more devices. You could of
> course fix this is hcitool, but changing HCI_MAX_DEV seem like the right
> solution.
> 
> Can this be changed, or does it *need* to be 16?
> 
> If changed, it would be nice if it was raised to something like 256, to
> keep the number in the power of 2. To be honest, i don't think this
> should have been a constant at all, as the number of devices is
> virtually endless. hci_for_each_dev() should probably have taken a MAX
> parameter, but should not itself have set a limit. But to keep the API
> intact, changing HCI_MAX_DEV could be a solution. 

you are seriously considering the case of more than 16 Bluetooth devices
are real normal use cases. We are talking about 1 device vs. 2 and can
not even find an agreement for the UI cases there.

Anyhow, I agree with you that the number of devices should not have been
limited within the library. That was a bug we inherited from the initial
library design. However I am against just raising the number. We did
raise it once from 4 to 16 a long time ago. It is a serious memory issue
in the long running apps like bluetoothd.

So I could be convinced to add new functions to read/write the limit
from within an application itself. So that it can be changed without
re-compiling the library. Feel free to propose a patch.

Regards

Marcel


