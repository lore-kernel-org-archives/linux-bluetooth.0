Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas Gaufer <Andreas.Gaufer@blue-cell-networks.com>
To: Bluez Devel <bluez-devel@lists.sourceforge.net>
Message-Id: <20040609185348.65a9f382.Andreas.Gaufer@blue-cell-networks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-devel] HCI Event: Connect Complete with Status 09
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
Date: Wed, 9 Jun 2004 18:53:48 +0200

Hi,

I get into situations where the chip returnes a "Connect Complete" event 
with status MAX NUMBER OF CONNECTIONS (0X09) without having open handles.

The only way to get this Stick back to a usable state is removing power. 

There is no connection listed by "hcitool con".

Is there a (even csr specific) way of listing the acl handles that the chip 
thinks are open to drop them properly or a vendor specific hci command 
(besides "Reset(0x03|0x0003)") to get a "hard" reset?

Greetigs

Andy


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
