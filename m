Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] can't establish a connection
From: Marcel Holtmann <marcel@holtmann.org>
To: ben4fun <ben_4_fun@freenet.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1091748784.6143.28.camel@localhost>
References: <1091742606.6143.17.camel@localhost>
	 <1091746301.20839.60.camel@pegasus>  <1091747064.6143.25.camel@localhost>
	 <1091748133.20839.63.camel@pegasus>  <1091748784.6143.28.camel@localhost>
Content-Type: text/plain
Message-Id: <1091749859.20839.65.camel@pegasus>
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
Date: Fri, 06 Aug 2004 01:50:59 +0200

Hi Ben,

> > show us the content of the /proc/bus/usb/devices file.
> 
> The file is absolutely empty, there is not a line.

activate the USB device filesystem in your kernel and mount it. Look at
the USB howto for more details.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
