Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Millinger <andreas.millinger@web.de>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1103817277.4597.2.camel@tuxlaptop.site>
Mime-Version: 1.0
Subject: [Bluez-users] Re: Re: Re: 3com bluetooth card
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
Date: Thu, 23 Dec 2004 16:54:37 +0100

Hello,

I used hciattach ttyS16 any (csr works also). The outpup of dump_cis is:

Socket 0:
  dev_info
    NULL 0ns, 512b
  manfid 0x0101, 0x0041
  funcid serial_port [post]
  serial_interface
    uart 16550 [space/mark/odd/even] [5/6/7/8] [1/1.5/2]
  vers_1 7.1, "3Com", "3CRWB6096B Bluetooth PC Card", "", ""
  config base 0x00f8 mask 0x000f last_index 0x02
  cftable_entry 0x01 [default]
    [rdybsy]
    Vcc Vnom 3300mV Iavg 70mA
    io 0x0000-0x000f [lines=4] [8bit] [range]
    irq mask 0xffff [level] [shared]
  cftable_entry 0x02 [default]
    [rdybsy]
    Vcc Vnom 5V Iavg 70mA
    io 0x0000-0x000f [lines=4] [8bit] [range]
    irq mask 0xffff [level] [shared]

Socket 1:
  no CIS present

Best regards
Andreas



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
