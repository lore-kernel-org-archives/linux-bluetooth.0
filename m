Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] New to the headset club :)
From: Marcel Holtmann <marcel@holtmann.org>
To: Nils Faerber <nils@kernelconcepts.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1065537273.29878.613.camel@idoru.kc.de>
References: <1065537273.29878.613.camel@idoru.kc.de>
Content-Type: text/plain
Message-Id: <1065539062.5470.79.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 07 Oct 2003 17:04:16 +0200

Hi Nils,

> and the headset beeps a single time.
> After that nothing obvious happens anymore.
> What does the AT command mean? It seems to come from the headset, right?
> Would hstest need to respond at least with OK?

forgot something :(

You must make sure that your local device routes the SCO traffic of the
HCI interface. If your local device is CSR based, the CVS version of
hciconfig can show you this.

	# hciconfig hci0 revision
	hci0:   Type: USB 
	        BD Address: 00:50:xx:xx:xx:xx ACL MTU: 192:8  SCO MTU: 64:8
	        HCI 16.1.1
	        Chip version: BlueCore02
	        Max key size: 128 bit
	        SCO mapping:  HCI

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
