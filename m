Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2de46576041206085827162a8f@mail.gmail.com>
From: Manjunath Prabhu <manjunath.mp@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] HCI data packets
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
Date: Mon, 6 Dec 2004 22:28:46 +0530

Hi Marcel,

Does, opening a socket and then connect() at the
L2CAP......automatically establish an HCI connection first and then an
L2CAP connection on top of it??  This is what HCI dump shows..

Can I in someway just create an HCI connection first and then pump HCI data
packet with some known payload???How can i generate the test data
packets........... In a way, i just want  pump raw bits.....

Thanks,
Regards,
Manjunath


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
