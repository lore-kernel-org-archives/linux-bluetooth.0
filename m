Return-Path: <rene@soft.uni-linz.ac.at>
Message-ID: <3F954348.7090700@soft.uni-linz.ac.at>
Date: Tue, 21 Oct 2003 16:31:36 +0200
From: Rene Mayrhofer <rene@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Stress testing (Was: Re: command tx timeout and
 continuous inquiry.)
References: <3F86784F.9050608@soft.uni-linz.ac.at>	<1065778372.14923.336.camel@baroque.r				ococosoft.com>		<3F86A88E.4090106@soft.uni-linz.ac.at>	<1065790691.14513.	1	73.camel@pegasus>			<3F86AF96.7000904@soft.uni-linz.ac.at>	<1065791594.14514.179.camel@pegasus>		 <3F8FB6D9.8030000@soft.uni-linz.ac.at> <1066636708.902.5.camel@pegasus>		<3F950E33.3070303@soft.uni-linz.ac.at> <1066735933.1005.114.camel@pegasus>	 <3F9521E4.8010900@soft.uni-linz.ac.at> <1066738444.13788.124.camel@pegasus>
In-Reply-To: <1066738444.13788.124.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel

I've now done a bit of stress-testing and these are the results:

With the Epox adapter (HCI 16.4), I was able to go up to the theoretical 
maximum of 7 concurrent l2ping instances to different devices. All 7 
instances run and get their reply packets back. However, only 3 of them 
report "20 bytes from ...." while the other 4 report "0 bytes from 
....". I am not sure what causes this, but it might be the devices 
themselves. The Bluetooth stacks on the devices I used in this test are 
vastly different, ranging from Compaq Ipaq, FSC Pocket Loox, Sony Vaio 
with WinXP to other bluez boxes under x86 or Compaq Ipaq. There were 
even a few mobile phones in the pool....
And the background inquiry even returned some devices under this load, 
I'm now nearly where I want to go :)

Although this sounds very good, there are a few catches:
- Starting the l2ping instances was very tricky. The more were already 
running, the more difficult it got to start an additional one. For the 
last 2 instances, I had to try for about 25 times until it started 
correctly. Before that, it always returned "Can't connect.: Device or 
resource busy". Are there any internal kernel timeouts for freeing 
resources ? I have no idea why in the beginning it doesn't work but then 
suddenly it does. As soon as the l2ping starts, it seems reliable most 
of the time (some connection break but can be re-established, maybe it's 
just the radio link that's bad in these cases).
- Sometimes the same happens for the inquiry. In my "while true; hcitool 
scan --flush; done" loop, it sometimes also goes crazy with "Inquiry 
failed.: Device or resource busy" for about 30 seconds and then starts 
to work again.

How is an application supposed to deal with these phenomena ? Is there a 
maximum period during which a call is allowed to fail or is it random ? 
Although my application still can't create two L2 connections, this test 
shows that (with a current HCI firmware) it is in principle possible. I 
still have to find out why my code (which is mostly copied from l2ping) 
does not perform the same - I still think that it has to do with 
multi-threading somehow. But I am getting closer now.....

As a sidenote, bluez is rather unstable on my Sony Vaio PCG-SRX51P/A, 
which has a CSR chip with build ID 0x77 (which is reported as HCI 12.1). 
After a while of moderate load, the kernel log starts to get entries such as
kernel: hci_cmd_task: hci0 command tx timeout
kernel: Warning: null TTY for (d8:00) in tty_fasync
(I use rfcomm connections to a Siemens S55).
Reloading the bluez stack seems to reset everything so that it works 
again (until it breaks again....) - at least I don't have to reboot to 
get it back to work and can still claim that bluez is more mature than 
the Sony Bluespace stack :)
On my Debian system, this typically means
/etc/init.d/bluez-sdp stop
/etc/init.d/bluez-utils stop
/etc/init.d/hotplug restart
/etc/init.d/bluez-utils start
/etc/init.d/bluez-sdp start
Another sequence won't work, especially restarting the whole USB 
subsystem is necessary so that hci_usb gets reloaded.

PS: I can now confirm that Acer indeed has no updated firmware for their 
Bluetooth adapters BT-500 and does not plan to create one - our 
technician has talked to our Acer contact. Thus, I can not recommend 
this adapter for any more serious use under Linux.

best regards,
Rene

-- 
------------------------------------------------
Pervasive 2004:            www.pervasive2004.org
------------------------------------------------
