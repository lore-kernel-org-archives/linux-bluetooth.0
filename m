Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <d1f423d3050226200521a6d7a@mail.gmail.com>
From: Anderson Rodrigues <rodrigues.anderson@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] RFCOMM Device
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
Date: Sat, 26 Feb 2005 23:05:12 -0500

Hi Folks,

I am new with Bluez  and I trying to set up a rfcomm device but the
/dev/rfcomm0 is not being created or does not exist.

# rfcomm bind 0 aa:aa:aa:aa:aa 1 (works)
#rfcomm
rfcomm0: aa:aa:aa:aa:aa clean (is it right?)

but when i try to use pppd it does not work, it does not recognize the
/dev/rfcomm0

i will appreciate any help

cheers,

-- 
Anderson Clayton B. Rodrigues
Eng. de Software
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
