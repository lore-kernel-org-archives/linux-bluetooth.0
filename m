Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Max M." <bluez-ml@maxim.comm2000.it>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0502241626280.12963-100000@blomma.comm2000.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] tx submit failed urb c4c6b014 type 3 err -19
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
Date: Thu, 24 Feb 2005 17:09:07 +0100 (MET)

Hi.

I'm prototyping an application that should eventually become a
Voip/Bluethooth gateway.

Among the various problems I'm facing (i.e. occasional bizzare errors on
SCO connections, or inability to open more than one SCO link through the
same BT dongle), the currently most serious one is the following.

After a while my program is running (repeatedly dialing a phone number,
opening and closing the audio link), the following error shows up

 kernel: __tx_submit: hci0 tx submit failed urb c4c6b014 type 3 err -19

followed, a few seconds later, by an "Unable to handle kernel NULL
pointer..." message, which does not get logged.

Of course, I'm not asking what the cause is. I just need some suggestions
as to how to further investigate the problem and provide a more useful
report.

My system is Debian with kernel package 2.6.10-1-686.

Thanks,

Maxim




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
