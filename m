Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Mar 2011 11:00:55 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikko Vinni <mmvinni@yahoo.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Justin P. Mattock" <justinmattock@gmail.com>,
	Ed Tomlinson <edt@aei.ca>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: Re: re "bluetooth disabled" and "[BUG] usb problems in .38-rc3+"
Message-ID: <20110302140055.GA15047@jh-x301>
References: <635561.59590.qm@web161820.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <635561.59590.qm@web161820.mail.bf1.yahoo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Feb 28, 2011, Mikko Vinni wrote:
> Just wondering what is the status of "bluetooth disabled with current 
> 2.6.38-rc4"
> from Justin (http://www.spinics.net/lists/linux-bluetooth/msg10745.html) and
> "[BUG] usb problems in .38-rc3+"" (http://marc.info/?t=129693396800003&r=1&w=2)
> from Ed? (apologies for not being able to reply to those threads)
> 
> The first one because I think I see the same problem and the second one because
> for me also "hciconfig -a" makes the bluetooth adapter work. Maybe they have
> a common cause.

I can't reproduce this issue with any of my Bluetooth adapters (I tested
with 6 different ones). Could you get us the hcidump of what happens
when bluetoothd tries to switch on the adapter for the very first time?
Probably you'll need to disable starting of bluetoothd when your system
boots so that you have the chance to run hcidump first. Additionally, if
possible, could you enable dynamic debug in your kernel and get the logs
from hci_core.c and hci_event.c? Typically you'd enable this with
something like:

echo 'file hci_event.c +p' > /sys/kernel/debug/dynamic_debug/control
echo 'file hci_core.c +p' > /sys/kernel/debug/dynamic_debug/control

Hopefully those logs will give some better idea of what's going on since
the logs provided so far aren't really helpful.

Johan
