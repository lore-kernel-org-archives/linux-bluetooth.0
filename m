Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec05032915072ee95a9@mail.gmail.com>
From: Albert Huang <ashuang@gmail.com>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] does flush_to in l2cap setsockopt currently do anything?
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 29 Mar 2005 18:07:11 -0500

Hi all,

I was poking through the sources while trying to find an easy way to
set the ACL automatic flush timeout with an l2cap socket.

Does setsockopt(s, SOL_L2CAP, L2CAP_OPTIONS, ...) cause the underlying
ACL automatic flush timeout to change?  It doesn't look like flush_to
is being used in net/bluetooth/l2cap.c:setsockopt

Is there an easier way of doing it short of extracting the underlying
ACL connection handle and then sending an HCI
Write_Automatic_Flush_Timeout command packet to a separate HCI socket?

Regards,
Albert


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
