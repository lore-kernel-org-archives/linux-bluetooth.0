Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nosve" <nosve@libero.it>
To: <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] BT3030...
Message-ID: <AGELIJDLJNOPFNMOHHIFOECICAAA.nosve@libero.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Wed, 21 Jan 2004 13:55:31 +0100

I've the same device,
it works smoothly with the latest kernel, post 2.6.0
if you compile it with the device support for the tecom,
and if you copy the firmware files from /etc/bluetooth/firmware

in /usr/lib/hotplug/fimware

I've also inhibited the old bluefw hotplug agent, which is obsoleted by
the new driver support.

For more infos, look at:

 http://article.gmane.org/gmane.linux.bluez.user/1802

bye


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
