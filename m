Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] braindead adapters (sco)
From: Marcel Holtmann <marcel@holtmann.org>
To: Brad Midgley <bmidgley@xmission.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41090B25.6090806@xmission.com>
References: <41090B25.6090806@xmission.com>
Content-Type: text/plain
Message-Id: <1091112872.12651.50.camel@pegasus>
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
Date: Thu, 29 Jul 2004 16:54:32 +0200

Hi Brad,

> I've been trying to get snd-bt-sco to work. I'm told that one possible 
> reason it's not working is if the bluetooth dongle is routing incoming 
> SCO data to PCM rather than HCI. I'm using the internal bluetooth (usb) 
> on a Toshiba Portege m200. How can I tell if it's doing sco properly?

check with "hciconfig hci0 revision" as root.

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
