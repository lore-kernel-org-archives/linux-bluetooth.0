Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HIDP and HIDD ?
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Frey <mfrey@pepper.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <9361AF90-DB1B-11D8-8EF4-00039390D626@pepper.com>
References: <9361AF90-DB1B-11D8-8EF4-00039390D626@pepper.com>
Content-Type: text/plain
Message-Id: <1090419205.21683.107.camel@pegasus>
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
Date: Wed, 21 Jul 2004 16:13:25 +0200

Hi Michael,

> Is the purpose of HIDP and HIDD to replace bthid?  Should I be using 
> HIDP instead?  What advantages does HIDD along with HIDP provide me 
> over just using bthid?

the HIDP kernel module and the hidd daemon is the final way of how BlueZ
will support Bluetooth HID. The main advantage will be a lower latency
and you don't have to install anything from CVS.

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
