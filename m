Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SCO && UART
From: Marcel Holtmann <marcel@holtmann.org>
To: James Ho <jamesh@insi.com.tw>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20040716T104017-134@post.gmane.org>
References: <loom.20040716T104017-134@post.gmane.org>
Content-Type: text/plain
Message-Id: <1089972663.4517.102.camel@pegasus>
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
Date: Fri, 16 Jul 2004 12:11:03 +0200

Hi James,

> Does anybody know HCI UART(H4 or BCSP) driver support SCO? 

the hci_uart driver has SCO support.
 
> I am currently working on applications about Handsfree, and bluebooth 
> module we use (CSR BlueCore2) can either wire through USB or UART 
> interface. Will there be any problem if we use UART interface? Which 
> driver and configuration should I use? thx. 

For UART everything depends on the baud rate of your UART and you must
make sure that the SCO packets are sent over the HCI and not over PCM.

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
