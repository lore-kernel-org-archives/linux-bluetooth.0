Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HID testing
From: Marcel Holtmann <marcel@holtmann.org>
To: Deepesh S Gujarathi <d_gujarathi@hotmail.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Law11-OE56C4Mkg3fDM00007728@hotmail.com>
References: <Law11-OE56C4Mkg3fDM00007728@hotmail.com>
Content-Type: text/plain
Message-Id: <1071150458.27256.16.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 11 Dec 2003 14:47:39 +0100

Hi Saturn,

> I have been playing around with the BlueZ stack for last couple of
> days and I would say that you guys have done an wonderful job. The
> stack appears to be fairly stable and rich with features and tools.
> However the most important feature is the socket interface provided
> which is missing in other stacks. Kudos to Max, Marcel at rest of the
> team.

you are welcome :)
 
> I am working on the developing HID profile (firmware) for a pointing
> device and utilising BlueZ as a host side testing tool.

What kind of Bluetooth chip do you use?

Please use "sdptest" from libs2/test CVS to show us the SDP record of
your HID device.

> 1. What could be the best way to test the HID device firmware from the
> host side using BlueZ ? I believe there are two alternatives, the
> bthid program by Peter and an alternate hid program by Marcel. I was
> not successful in getting the bthid working. My system is Mandrake 9.2
> with Linux 2.4.21-0.13mdk and I have installed BlueZ from rpms.
> Basically I want to test my HID firmware implementation for HID
> compliance.

You should make sure that you have the uinput driver compiled and
installed on your system. And you have to apply the patches from Edd
Dumbill and Olivier Bornet for the bthid from Peter. But this will not
solve the SDP problem of Peter's implementation.

My implementation is based on the new Bluetooth library (which is in
development state), but is working fine for HID devices from Logitech,
Microsoft and EPoX. Yesterday I posted a short installation help to the
mailing list.

Non of the implementations can guarantee HID compliance. The USB HID
parser will be of course much better for testing, but as stated in one
of my previous posts I have stopped working on an integration.

> 2. Is there a way to disconnect individual L2CAP connection from
> within user space program ? I saw a call  l2cap_sock_close in l2cap.c
> file, is there a way to call this function from a user program. I have
> already tried to use the close(socket) call but it closes down the ACL
> connection instead of closing the _individual_ L2CAP connection.
> do advise....

You can do it by simply call close(l2cap_sk) in your user application,
but depending on your firmware it will maybe close the other L2CAP
channel too and then the ACL link have to be closed. To be sure that you
have no L2CAP bugs in your kernel I propose that you start using 2.4.23.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
