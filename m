Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Trouble compiling bluez-hcidump-1.18
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <423021C200007A66@resmta01.ono.com>
References: <423021C200007A66@resmta01.ono.com>
Content-Type: text/plain
Message-Id: <1111618010.1916.19.camel@pegasus>
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
Date: Wed, 23 Mar 2005 23:46:50 +0100

Hi,

> Untar, ./configure and then make and I get this:
> 
> make  all-recursive
> make[1]: Entering directory `/root/bluez-hcidump-1.18'
> Making all in parser
> make[2]: Entering directory `/root/bluez-hcidump-1.18/parser'
> gcc -DHAVE_CONFIG_H -I. -I. -I..     -Wall -O2 -c `test -f 'parser.c' ||
> echo './'`parser.c
> gcc -DHAVE_CONFIG_H -I. -I. -I..     -Wall -O2 -c `test -f 'hci.c' || echo
> './'`hci.c
> hci.c: In function `command_dump':
> hci.c:707: error: `OCF_CHANGE_CONN_LINK_KEY' undeclared (first use in this
> function)
> hci.c:707: error: (Each undeclared identifier is reported only once
> hci.c:707: error: for each function it appears in.)
> hci.c: In function `cmd_complete_dump':
> hci.c:966: error: `OCF_SET_AFH_CLASSIFICATION' undeclared (first use in this
> function)
> hci.c:998: error: `OCF_READ_LINK_QUALITY' undeclared (first use in this function)
> hci.c:1001: error: `OCF_READ_CLOCK' undeclared (first use in this function)
> hci.c: In function `event_dump':
> hci.c:1376: error: `EVT_CHANGE_CONN_LINK_KEY_COMPLETE' undeclared (first
> use in this function)
> hci.c: In function `hci_dump':
> hci.c:1505: error: `HCI_VENDOR_PKT' undeclared (first use in this function)
> make[2]: *** [hci.o] Error 1
> make[2]: Leaving directory `/root/bluez-hcidump-1.18/parser'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/root/bluez-hcidump-1.18'
> make: *** [all] Error 2
> 
> I have no idea where the problem is... Any suggestions?

make sure that bluez-libs-2.15 is installed. This is clearly stated in
the ChangeLog file as an requirement.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
