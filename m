Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <451D057A.1070507@sentivision.com>
References: <451D057A.1070507@sentivision.com>
Date: Fri, 29 Sep 2006 13:43:29 +0200
Message-Id: <1159530209.6131.22.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] hcitool: bug in printing names of class of device
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Artur,

> In our company we've designed BT remote controller device. We set class 
> of device to 0x5cc (Major class: Peripheral, Minor class: Combo 
> keyboard/pointing device + Remote control). On Windows it is recognized 
> correct (icon and description), but on Linux (bluez-utils 3.4) "hcitool 
> scan --class --flush" prints "Device class:   Invalid (0x005cc)".
> 
> I've found that only devices with major class < 5 are recognized 
> correctly. This is because is bug in hcitool.c in function cmd_scan():
> 
>  if ((cls[1] & 0x1f) > sizeof(*major_classes))
>                                 ^^^^^^^^^^^^^^^^^^
> this is always sizeof(char**) and on 32bit machine is 4!
> It should be:
>                               sizeof(major_classes) / sizeof(char*),

thanks for looking into this. This is has been fixed in the CVS now.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
