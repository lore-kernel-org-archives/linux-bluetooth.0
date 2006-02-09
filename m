Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <fd87b6160602081708k1c5d03ddk5a58b4050d636401@mail.gmail.com>
From: John McCabe-Dansted <gmatht@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: [PATCH] hci_usb: implement suspend/resume
In-Reply-To: <1137602323.4543.29.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1137540084.4543.15.camel@localhost>
	 <1137589998.27515.8.camel@localhost>
	 <1137602323.4543.29.camel@localhost>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 9 Feb 2006 14:08:40 +1300

On 1/19/06, Johannes Berg <johannes@sipsolutions.net> wrote:
> The attached patch implements suspend/resume for the hci_usb bluetooth
> driver by simply killing all outstanding urbs on suspend, and re-issuing
> them on resume.
>
> This allows me to actually use the internal bluetooth "dongle" in my
> powerbook after suspend-to-ram without taking down all userland programs
> (sdpd, ...) and the hci device and reloading the module.

Anybody have success using this patch with suspend2?

I get:

Feb  9 13:48:32 localhost kernel: [17193418.644000] uhci_hcd
0000:00:1f.2: USB bus 1 deregistered
Feb  9 13:48:32 localhost kernel: [17193418.660000] ACPI: PCI
interrupt for device 0000:00:1f.2 disabled
Feb  9 13:48:39 localhost kernel: [17193425.268000] Suspend2 2.2:
Initiating a software suspend cycle.
Feb  9 13:48:46 localhost kernel: [17193427.272000] userspace ui:
Failed to contact userspace process.
Feb  9 13:48:46 localhost kernel: [17193427.272000] Freezing processes
Feb  9 13:48:47 localhost kernel: [17193432.404000] Stopping tasks failed.
Feb  9 13:48:47 localhost kernel: [17193432.404000] Tasks that refused
to be refrigerated and haven't since exited:
Feb  9 13:48:47 localhost kernel: [17193432.404000]  - snd-bt-scod
(#2206) signalled and todo list empty.
Feb  9 13:48:47 localhost kernel: [17193432.428000] Suspend2 debugging info=
:
Feb  9 13:48:47 localhost kernel: [17193432.428000] - SUSPEND core   : 2.2
Feb  9 13:48:47 localhost kernel: [17193432.428000] - Kernel Version :
2.6.15.1-p4-s2-ll
Feb  9 13:48:47 localhost kernel: [17193432.428000] - Compiler vers. : 4.0
Feb  9 13:48:47 localhost kernel: [17193432.428000] - Attempt number : 2
Feb  9 13:48:47 localhost kernel: [17193432.428000] - Parameters     :
17 32 0 1 525 0
Feb  9 13:48:47 localhost kernel: [17193432.428000] - Overall expected
compression percentage: 50.
Feb  9 13:48:47 localhost kernel: [17193432.428000] - Compressor lzf enable=
d.
Feb  9 13:48:47 localhost kernel: [17193432.428000] - Swapwriter active.
Feb  9 13:48:47 localhost kernel: [17193432.428000]   Swap available
for image: 307241 pages.
Feb  9 13:48:47 localhost kernel: [17193432.428000] - Filewriter inactive.
Feb  9 13:48:47 localhost kernel: [17193432.428000] - No I/O speed
stats available.
Feb  9 13:48:47 localhost kernel: [17193433.656000] USB Universal Host
Controller Interface driver v2.3
Feb  9 13:48:47 localhost kernel: [17193433.668000] ACPI: PCI
Interrupt 0000:00:1f.2[D] -> GSI 19 (level, low) -> IRQ 16
Feb  9 13:48:47 localhost kernel: [17193433.672000] PCI: Setting
latency timer of device 0000:00:1f.2 to 64

--
John C. McCabe-Dansted
Master's Student
94709339 (In Perth)


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
