Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bt_inquiry
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?S=E9rgio?= Alcides Fernandes <sergiofernandes@clix.pt>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200404072157.02734.sergiofernandes@clix.pt>
References: <200404072157.02734.sergiofernandes@clix.pt>
Content-Type: text/plain
Message-Id: <1081417720.2970.2.camel@pegasus>
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
Date: Thu, 08 Apr 2004 11:48:40 +0200

Hi Sergio,

> When i try to compile utils2 from cvs i get the following error :
> 
> checking bluetooth/bluetooth.h usability... yes
> checking bluetooth/bluetooth.h presence... yes
> checking for bluetooth/bluetooth.h... yes
> checking for bt_inquiry in -lbluetooth... no
> configure: error: Bluetooth library not found
> 
> 
> i installed/compiled libs2 (from cvs) in /opt/bluetooth and 
> added /opt/bluetooth/lib to my /etc/ld.so.conf....

you must run configure with --with-bluetooth=/opt/bluetooth

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
