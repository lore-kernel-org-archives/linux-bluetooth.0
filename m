Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCI Event: Connect Complete with Status 09
From: Marcel Holtmann <marcel@holtmann.org>
To: Andreas Gaufer <andreas.gaufer@blue-cell-networks.com>
Cc: Steven Singer <steven.singer@csr.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040609212529.6901de52.Andreas.Gaufer@blue-cell-networks.com>
References: <20040609185348.65a9f382.Andreas.Gaufer@blue-cell-networks.com>
	 <40C74EDD.6060903@csr.com>
	 <20040609212529.6901de52.Andreas.Gaufer@blue-cell-networks.com>
Content-Type: text/plain
Message-Id: <1086862843.1607.33.camel@pegasus>
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
Date: Thu, 10 Jun 2004 12:20:43 +0200

Hi Andreas,

> Yes, indeed thats close to what im doing. Not within one secoud but very 
> frequently.

do you enabled CONFIG_BT_HCIUSB_SCO? If yes, disable it and try again.
Our way of consuming USB bandwith with ISOC URB's wasn't liked by some
of the BlueCore02 firmwares.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
