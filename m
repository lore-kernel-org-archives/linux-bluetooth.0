Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <605264.10985.qm@web8411.mail.in.yahoo.com>
References: <605264.10985.qm@web8411.mail.in.yahoo.com>
Date: Wed, 06 Feb 2008 13:25:33 +0100
Message-Id: <1202300733.15090.222.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] system hangs playing audio on headset
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

Hi Pramod,

> I now use these command to stop and start hcid...its working fine...
> 
> [root@localhost Pramod]# /etc/init.d/bluetooth start
> Starting Bluetooth subsystem: hcid hid2hci.
> [root@localhost Pramod]# /etc/init.d/bluetooth stop
> Stopping Bluetooth subsystem: hcid..
> 
> But after running audio service same error come again and i am not
> able to connect to headset
> via rfcomm which was happening when I was using default set of BT
> utils in /usr/sbin & /usr/bin
> 
> why is it so????

because rfcomm is not the way to connect to headset. Read wiki.bluez.org
for instructions.

Regards

Marcel




-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
