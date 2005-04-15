Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: DBT 120 dongle defaulting to HID mode
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <pan.2005.04.15.13.26.00.874309@wingnet.net>
References: <pan.2005.04.14.18.57.06.661056@wingnet.net>
	 <1113507101.8989.71.camel@pegasus>
	 <pan.2005.04.15.13.26.00.874309@wingnet.net>
Content-Type: text/plain
Message-Id: <1113572820.16433.26.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 15 Apr 2005 15:47:00 +0200

Hi Jesse,

> >> Ever since the firmware upgrade to BT 1.2, my DBT 120
> >> has been defaulting to HID mode. I only use HCI mode
> >> currently, so it freaked me out the first time this
> >> happened! I thought my dongle was dead! But then I
> >> remembered hid2hci.
> >> 
> >> Is there a way to change the default mode of this dongle
> >> back to HCI without downgrading the firmware?
> > 
> > yes, it is. You have to change the PS key for the boot mode.
> 
> OK. Has anyone written a program capable of changing arbitrary
> PS key settings yet? Or do I have to write my own?

there is the pskey program, but this will only work over UART with H:4
or BCSP transports. The BlueZ hciconfig code contains code to read PS
key values, but it can't store them. However I really think that we need
a graphical pstool for Linux like the CSR one for Windows.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
