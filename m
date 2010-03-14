Return-Path: <cyrus@holtmann.org>
Subject: HCI_MAX_DEV is a bit too small.
From: Peter Dons Tychsen <donpedro@tdcadsl.dk>
Reply-To: donpedro@tdcadsl.dk
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain
Date: Mon, 15 Mar 2010 00:20:37 +0100
Message-Id: <1268608837.6400.26.camel@donpedro>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

HCI_MAX_DEV is set a bit low (16), causing hci_for_each_dev() to not
return all of the devices if you have more. This is not a disaster for
the library itself, as i can just copy hci_for_each_dev() and make a
version supporting more devices.

However, hcitool uses the library version of hci_for_each_dev(), so that
makes hcitool useless for a system with more devices. You could of
course fix this is hcitool, but changing HCI_MAX_DEV seem like the right
solution.

Can this be changed, or does it *need* to be 16?

If changed, it would be nice if it was raised to something like 256, to
keep the number in the power of 2. To be honest, i don't think this
should have been a constant at all, as the number of devices is
virtually endless. hci_for_each_dev() should probably have taken a MAX
parameter, but should not itself have set a limit. But to keep the API
intact, changing HCI_MAX_DEV could be a solution. 

Thanks,

/Pedro


