Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: =?iso-8859-1?q?J=FCrgen_Schindele?= <jschindele@arcor.de>
To: bluez-users@lists.sourceforge.net
References: <422DF27C.8080301@bjitodc.com>
In-Reply-To: <422DF27C.8080301@bjitodc.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200503090001.00828.jschindele@arcor.de>
Subject: [Bluez-users] Use of /etc/bluetooth/link-key Bug or Feature ??
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 9 Mar 2005 00:01:00 +0100

Hi All,
by an error i misconfigured a link with autentification.
so a entry in the file /etc/bluetooth/link-key was created.
Then M. Holtmann helped me out and told me how to configure it right.=20
But From there on when a connection was demanded a link key request=20
was always sent even it AUTH was switched off.

Is this a bug or a feature ??
 If this is a feature how can i delete a unique entry for one device
and not delete the whole file content because the content is not ascii ?

=2D-=20
Gru=DF J=FCrgen


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
