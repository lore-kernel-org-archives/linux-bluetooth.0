Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Service registering but not visible
From: Marcel Holtmann <marcel@holtmann.org>
To: Daniel Stoddart <d.stoddart@cs.ucl.ac.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000201c46c5a$126175d0$13e9baac@oemcomputer>
References: <000d01c46b72$fb6af0f0$8425b9ac@oemcomputer>
	 <1090012501.9117.29.camel@pegasus>
	 <000701c46c08$958becd0$af2dbeac@oemcomputer>
	 <1090078779.4558.35.camel@pegasus>
	 <000201c46c5a$126175d0$13e9baac@oemcomputer>
Content-Type: text/plain
Message-Id: <1090141152.4558.52.camel@pegasus>
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
Date: Sun, 18 Jul 2004 10:59:12 +0200

Hi Daniel,

> It does look like there is something wrong with the sdpd daemon but it does
> seem to be running and the sdptool can find services on my nokia 6600.

these are two different things.

> root      1237  0.1  0.5  2308 1316 pts/1    S    00:37   0:00 -bash
> root      1252  0.0  0.2  1448  560 ?        S    00:37   0:00 hcid:
> processing
> root      1257  0.0  0.2  1428  536 ?        S    00:37   0:00
> /usr/sbin/sdpd
> root      1258  0.0  0.4  3016 1068 pts/1    R    00:37   0:00 ps aux

You have two hcid running, which is never good. Make sure that only one
hcid and one sdp are running.

> root@darkstar:~# sdptool search 0x1101
> Class 0x1101
> Inquiring ...
> Searching for 0x1101 on 00:0E:6D:11:E6:EB ...
> Service Name: Bluetooth Serial Port
> Service Description: Bluetooth Serial Port
> Service Provider: Symbian Ltd.
> Service RecHandle: 0x10002
> Service Class ID List:
>   "Serial Port" (0x1101)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 2
> Language Base Attr List:
>   code_ISO639: 0x656e
>   encoding:    0x6a
>   base_offset: 0x100

The sdptool don't need the sdpd to find the records on remote device. We
talk here about local SDP records.

> I hope this helps to decipher the problem.

No this was not helpful. Check /proc/bluetooth/l2cap and take a look at
the syslog for error messages from the sdpd. Do this more than once,
because I think there will be changes within the usage.

> Also, I'm not too sure what a PSM is - could you explain?

Maybe you read the Bluetooth specification or look it up in an Internet
search engine ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
