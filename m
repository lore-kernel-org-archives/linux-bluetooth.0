Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Various questions
From: Marcel Holtmann <marcel@holtmann.org>
To: Christoph Torens <christoph@torens.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <opr5jsgqtl7p7ahu@debian>
References: <opr5jsgqtl7p7ahu@debian>
Content-Type: text/plain
Message-Id: <1080506632.2281.150.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 28 Mar 2004 22:43:52 +0200

Hi Christoph,

> I'd like to buy an additional Bluetooth Dongle,
> because my Zeevo Chip Dongles don't work properly and I stressed my friend  
> to long now by borrowing his CSR Dongle.
> So which chipsets exist at all, and is CSR the "all-time-best-solution"  
> for linux?
> And last but not least, how can I buy a Dongle with the desired chipset?  
> You normaly just see the manufacturers as Acer for example, not the  
> chipset, don't you? Is it absolutely unimportant at all, if its Acer,  
> Belkin, D-Link or what ever?

the problem is the community support with chips from Zeevo and Broadcom
for example. We already know that their chips not behave very well under
some circumstances. On the other side we have CSR and if you ask me I
would always decide to use one of their chips, because their chips are
known to work very well and their community support is very good. They
really support Linux and try to help people that have problems. But
there are more companies than Zeevo, Broadcom and CSR. For example I
also use devices from AVM and ST Microelectronics and some others.

Actually my current policy is to tell everyone to try a CSR dongle first
if you see hardware problems like TX timeouts. Some companies should do
their homework or pay people to do it for them.

For finding out what kind of chip is inside the dongles you can use this
webpage

	http://www.holtmann.org/linux/bluetooth/features.html

> Now, I just read Marcel's last mail Re: [Bluez-users] PANU and "ACL tx  
> timeout"
> He says one should try to update the firmware. Thats a faszinating idea,  
> because I didn't manage to solve my Bluetooth problems yet. I wonder if a  
> firmware update would help me, too. I didn't know this is possible at all.  
> But after a short time on google I think its not possible with my Dongles.  
> Or are there updates vor the Acer 510 Dongles?

Some dongles load the firmware every time they are plugged in (Broadcom
and AVM for example) and other have stored the firmware in flash. And
updating a firmware in flash is another topic. Search the mailing list
archive for more details.

> The funny thing is, with time I get more and more different error messages  
> regarding bluetooth.
> My last error was when trying to connect via pand: "Connection failed.  
> Permission Denied 13"
> So I guess I make some failure, but I can't find it.

This is no hardware problem. This part of the software stack on the
local or the remote device.

> By the way: can I pair two PC's with Linux? Could this be an idea of my  
> failure?

Yes, you can. It works, but you should understand what pairing really is
and what the different security modes mean.

> Another interessting thing is, that i can connect my viper (PC104) using  
> dund to Win2000. But the ppp0 device on the viper doesn't get configuered  
> automatically (I thougt this should happen? routing seems to get set  
> automatically, though) And I can't ping in any direction. The ppp  
> conection produces output every 3 seconds and while doing a ping, hcidump  
> produces output parallel to the ppp messages every 3 seconds.

This is a PPP problem.

> Dund says it is a ppp over rfcomm connection. Connecting to Windows the  
> "Lan Access service" answers.

Read the profile specification and understand what LAN Access using PPP
means.

> Doing a rfcomm connection by hand, the "serial port" answers.
> But there also exists a "dial up service"
> So I'm a bit confused about what connects to what and why.

Again, read the specification. There is no "real" difference between
DUN, LAN or serial profiles.

> sdptool knows LAN DUN PAN. Is it unimportant which service it is, that a  
> dund connects to?
> Can it connect to dund AND lan? is this the same?

In general yes, but it depends on your remote device.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
