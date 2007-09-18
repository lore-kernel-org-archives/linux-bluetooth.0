Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <6E672510D37D58428215BDFDF097DB46014692C9@EXGNT01.sasken.com>
References: <6E672510D37D58428215BDFDF097DB46014692C9@EXGNT01.sasken.com>
Date: Tue, 18 Sep 2007 06:58:19 +0200
Message-Id: <1190091499.5525.108.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] FW: Need some help - linux bluetooth driver
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Pintu,

> I need a help in compiling the linux 2.4.22 code (bluetooth part).
> Can you help me here.

the Linux 2.4 part of BlueZ is actually no longer officially supported
and so you can't expect any real help here.

However the 2.4.22 might be recent enough to get you going and it
contains the Bluetooth core.

> Here is my problem description
> ==========================
> I have a linux system which is running on Linux 2.4.22-ncgl-10.12.1.0
> kernel. It is a modified kernel. 
> Here the BLUETOOTH part is removed from the kernel. 
> (I didnt find - hci_core , hci_conn.o , and other required drivers and
> some of the export symbols are missing)
> (It report un resolved symbols - "hci_register_dev")

Since this looks like a vendor specific kernel that you have paid for,
it might be better to complain with that company and make them include
the Bluetooth sources again. I am serious here.

> I have the 2.4.22-ncgl-10.12.1.0 kernel source with me (on another
> system).
> Now, I dont want to build the whole kernel again. (This is not
> possible as it is in another system under separate path)
>  
> I wanted to compile only the Bluetooth related path (net/bluetooth/*)
> from this kernel source and put all related stuffs on my system.
> Is it possible??????? Please let me know the procedure. Please help me
> out.

So in theory it is possible to compile the kernel modules outside the
kernel source tree, but I don't remember the exact steps for a 2.4
system and quite frankly, I am not going to look that up.

The best way is to go for a 2.6.22 kernel or later. It might look
complicated in the beginning, but it is always worth the extra work. It
will give you a recent Bluetooth stack that is known to be qualifiable
and is up-to-date.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
