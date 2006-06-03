Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <5d12691e0606031048o148ad92bre33d6efe2b280560@mail.gmail.com>
References: <5d12691e0606021931hd95b058u38f464d30af8fd56@mail.gmail.com>
	<1149334394.19311.17.camel@localhost>
	<5d12691e0606031048o148ad92bre33d6efe2b280560@mail.gmail.com>
Date: Sat, 03 Jun 2006 21:14:33 +0200
Message-Id: <1149362073.1977.0.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluez udev rules for Slackware 10.2
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Aaron,

>  I'm sorry I wasn't more specific, I didn't realize that there were
> other devices then the rfcomm tty device node. This is actually the on
> I am after sense it is needed for my device to work with p3nfs. 
> 
> I have RFCOMM protocol support enabled in the kernel as a modules, and
> RFCOMM TTY support hard coded. I had to 'modprobe rfcomm' but the
> bluetooth module loaded automatically, both of which are listed in my
> 'lsmod'. How do I get udev to create the rfcomm device node? I
> searched for files containing "rfcomm" in the bluez build directory
> but didn't see anything relating to udev rules. Am I supposed to build
> this node myself or should udev be creating it automatically? 

you will see these device nodes if you bind or connect a RFCOMM TTY to a
remote device. See the rfcomm command for more details.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
