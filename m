Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] vhci and RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: Papadopoulos Giannis <ipapadop@uth.gr>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1090829679.4104bd6fbc168@webmail.uth.gr>
References: <1090829679.4104bd6fbc168@webmail.uth.gr>
Content-Type: text/plain
Message-Id: <1090831085.31693.73.camel@pegasus>
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
Date: Mon, 26 Jul 2004 10:38:05 +0200

Hi Papadopoulos,

> I am trying to create an RFCOMM connection between 2 virtual adapters in my
> machine..
> 
> I' ve created the adapters and a connection between them...
> 
> Everything is OK, but I can't create an RFCOMM connection between them..
> 
> Terminal 1:
> mordor:/home/dop # hcitool dev
> Devices:
>         hci0    7F:00:00:01:00:0A
>         hci1    7F:00:00:01:00:0B
> mordor:/home/dop # hcitool -i 7F:00:00:01:00:0A cc 7F:00:00:01:00:0B
> mordor:/home/dop # rfcomm -i 7F:00:00:01:00:0A listen /dev/rfcomm0
> Waiting for connection on channel 1
> Can't open RFCOMM device: No such file or directory
> mordor:/home/dop #
> 
> Terminal2:
> dop@mordor:~> rfcomm -i 7F:00:00:01:00:0B connect /dev/rfcomm1 7F:00:00:01:00:0A
> Can't open RFCOMM device: No such file or directory
> 
> What am I doing wrong??

first, don't use "hcitool cc ...". This command is never needed and it
is only there for testing purpose. Who said that you should use it?

Your problem is that you didn't created the RFCOMM device nodes.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
