Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] About new hardware testing
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1ffb4b0705022008331572db81@mail.gmail.com>
References: <1ffb4b070502200751191953c@mail.gmail.com>
	 <Pine.LNX.4.33.0502201659100.26897-100000@redbean.intranet.gw-instruments.de>
	 <1ffb4b0705022008331572db81@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1109026689.7626.17.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 21 Feb 2005 23:58:09 +0100

Hi Mike,

> > I remember we initialy had a problem to get the right default pass for
> > hcid.conf when cross compiling.
>     I will try this
> > Does "hciconfig hci0 up" work ??
>     Because i do not get any info from hciconfig. I can not "up" the device.
> > 
> > I use
> > hciattach /dev/ttyS1 -s 115200 csr 921600 flow
> > to attach the bluetooth device (CSR with HCI connected to an ARM).
> 
>    My script is like that hciattach /dev/ttyS1 -s 921600 csr 921600
> flow. But it works on my development board, so i don't think it is the
> problem.

I think you should add a lot of printf to the hciattach to see where it
fails. If the hci0 device is not created (hciconfig shows nothing) then
the line discipline of ttyS1 is never changed to HCI.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
