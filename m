Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <d1f423d30503071045794c487e@mail.gmail.com>
From: Anderson Rodrigues <rodrigues.anderson@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] PAN Configurations
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
Date: Mon, 7 Mar 2005 14:45:27 -0400

Hi folks,

I am trying to create a PAN using PAND. Actually I am following the
"Personal Networking Area How-To" which can be found at Bluez.org.
Let explain what i am doing:

In both sides (GN and PANU)

# modprobe bnep
# hcid
# sdpd

on the GN side

# pand --listen --role GN

on the PANU side

# pand --connect <GN address>

after this command, I get the following messages using dmesg

parport0: FIFO is stuck
parport0: BUSY timeout (1) in compat_write_block_pio
FIFO write timed out
parport0: FIFO is stuck
parport0: BUSY timeout (1) in compat_write_block_pio
FIFO write timed out
parport0: FIFO is stuck
parport0: BUSY timeout (1) in compat_write_block_pio
FIFO write timed out
parport0: FIFO is stuck
parport0: BUSY timeout (1) in compat_write_block_pio
FIFO write timed out

and I can not find the bnep0 network interface.

am I doing something wrong? 

any help is very welcome

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
