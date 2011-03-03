Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Mar 2011 11:31:54 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikko Vinni <mmvinni@yahoo.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Justin P. Mattock" <justinmattock@gmail.com>,
	Ed Tomlinson <edt@aei.ca>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: Re: re "bluetooth disabled" and "[BUG] usb problems in .38-rc3+"
Message-ID: <20110303143154.GA2342@jh-x301>
References: <635561.59590.qm@web161820.mail.bf1.yahoo.com>
 <20110302140055.GA15047@jh-x301>
 <574436.88358.qm@web161820.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
In-Reply-To: <574436.88358.qm@web161820.mail.bf1.yahoo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mikko,

On Thu, Mar 03, 2011, Mikko Vinni wrote:
> > I can't reproduce this issue with any of my Bluetooth  adapters (I tested
> > with 6 different ones). Could you get us the hcidump of  what happens
> > when bluetoothd tries to switch on the adapter for the very  first time?
> > Probably you'll need to disable starting of bluetoothd when your  system
> > boots so that you have the chance to run hcidump first. Additionally,  if
> > possible, could you enable dynamic debug in your kernel and get the  logs
> > from hci_core.c and hci_event.c? Typically you'd enable this  with
> > something like:
> > 
> > echo 'file hci_event.c +p' >  /sys/kernel/debug/dynamic_debug/control
> > echo 'file hci_core.c +p' >  /sys/kernel/debug/dynamic_debug/control
> > 
> > Hopefully those logs will give  some better idea of what's going on since
> > the logs provided so far aren't  really helpful.
> > 
> 
> - Compiled the kernel (2.6.38-rc7 now) with dynamic debug
> - Commented out the lines to start bluetoothd from /lib/udev/rules.d/
> - Killed bluetoothd
> - rmmod'ed all bluetooth modules and then modprobe'd rfcomm (which pulls
> in all the others) (this resets the situation so that the bug appears -
> when unplugging and plugging the adapter in the working state it keeps
> on working)
> - enabled dynamic debug for hci_core.c, hci_event.c, and rfcomm/core.c
> - plugged in the bluetooth adapter
> - hcidump -w hcidump_ddebug (parsed version below)
> - bluetoothd -d
> - run hciconfig (without parameters) a couple of times
> - waited some minutes
> - run hciconfig -a (around 08:18:37 in the logs)
> - adapter led starts blinking (and e.g. blueman-applet sees it)
> - messages from syslog further below
> 
> Do these help?

They do indeed. However, the simplest short-term fix I can come up for
this is in user space and not the kernel.

> HCI sniffer - Bluetooth packet analyzer ver 2.0
> btsnoop version: 1 datalink type: 1002
> 2011-03-03 08:14:38.386728 < HCI Command: Reset (0x03|0x0003) plen 0
> 2011-03-03 08:14:38.386759 > HCI Event: Command Status (0x0f) plen 4
>     Unknown (0x00|0x0000) status 0x00 ncmd 1
> 2011-03-03 08:14:38.386810 < HCI Command: Read Local Supported Features 
> (0x04|0x0003) plen 0
> 2011-03-03 08:14:38.524768 > HCI Event: Command Complete (0x0e) plen 4
>     Reset (0x03|0x0003) ncmd 1
>     status 0x00

I'm not sure if this is correct. The command status for opcode 0 means
that we can start sending commands to the controller, however since
there's a pending reset command maybe we should be waiting for its
command complete event before sending the features command. Or should we
be sending the Reset command at all so early and instead wait for the
command status before sending it?

In any case what's happening is that there's never a command complete
for the local features. This is one of those commands that user space
tracks to determine that the adapter is initialized so if it never comes
the adapter remains uninitialized from a bluetoothd perspective. There
is supposed to be some work-around code in bluetoothd for this kind of
situations, but due to the patch you found in the kernel the code
doesn't get triggered since the "up" flag is not set when the situation
happens. The patch I've attached removed this check for the flag. Could
you try and see if it helps?

Meanwhile, it'd be nice to get some input from more knowledgeable
persons on whether the kernel is doing the right thing in not waiting
for the command status for opcode 0 before sending the HCI_Reset.

Johan

--BOKacYhQ+x31HxR3
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="devup.patch"

diff --git a/plugins/hciops.c b/plugins/hciops.c
index fd19ef4..c46465a 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -1569,9 +1569,6 @@ static void read_local_name_complete(int index, read_local_name_rp *rp)
 
 	DBG("Got name for hci%d", index);
 
-	if (!dev->up)
-		return;
-
 	/* Even though it shouldn't happen (assuming the kernel behaves
 	 * properly) it seems like we might miss the very first
 	 * initialization commands that the kernel sends. So check for

--BOKacYhQ+x31HxR3--
