Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Till Harbaum <harbaum@beecon.de>
To: Talbi <amine@baracoda.com>
Subject: Re: [Bluez-devel] BlueZ Disconnects
References: <410E51C9.1020401@celar.fr> <1091521684.12594.137.camel@imladris.demon.co.uk> <200408031214.36250.amine@baracoda.com>
In-Reply-To: <200408031214.36250.amine@baracoda.com>
Cc: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200408031222.31152.harbaum@beecon.de>
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
Date: Tue, 3 Aug 2004 12:22:31 +0200

On Tuesday 03 August 2004 12:14, Talbi wrote:
> there is a way using BlueZ to detect a disconnection between my dongle and
> a Bluetooth device.
Sure, it works exaclty like it does with e.g. a lost tcp connection. If you 
are using the select, you e.g. get a read event. But the actual read() call  
returns with 0 bytes read. You then know, that your l2cap connection is gone.

This should work similar with rfcomm.

Till

-- 
Dr.-Ing. Till Harbaum                       Tel.:  +49 721 4998963
BeeCon GmbH                                 Fax:   +49 721 4998962
Haid-und-Neu Strasse 7, 76131 Karlsruhe     Mobil: +49 179 9087904
harbaum@beecon.de                           http://www.beecon.de



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
