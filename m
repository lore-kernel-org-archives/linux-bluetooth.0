Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402151519.55271.pavouk@pavouk.org>
Subject: [Bluez-users] Bluetooth CF card i-Tec
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
Date: Sun, 15 Feb 2004 15:19:55 +0100

Hello,

I was testing other new Bluetooth CF card i-Tec.
I was discovering, that this card is exactly same like Billionton card.

This is dump_cis of i-Tec card:
---------------------------------------------------------------
  dev_info
    no_info
  vers_1 7.1, "Compact Flash", "Bluetooth Card", "", ""
  manfid 0x022d, 0x2000
  funcid serial_port
  serial_interface
    uart 16550 [space/mark/odd/even] [5/6/7/8] [1/1.5/2]
  config base 0x00f8 mask 0x000f last_index 0x03
  cftable_entry 0x01 [default]
    [rdybsy] [audio] [pwrdown]
    Vcc Vnom 3300mV Vmin 3V Vmax 3600mV Iavg 300mA
    Ipeak 300mA Idown 10mA
    io 0x02f8-0x02ff [lines=3] [8bit] [range]
    irq mask 0x86bc [level] [pulse] [shared]
  cftable_entry 0x02
    io 0x03e8-0x03ef [lines=3] [8bit] [range]
  cftable_entry 0x03
    io 0x02e8-0x02ef [lines=3] [8bit] [range]
------------------------------------------------------------------


This card is very cheap in our country and it is distributed in Czech 
republic, Slovakia and Poland.
Link to informations in czech language:
http://www.i-tec.cz/bt_cf.htm

Link to Billionton card:
http://www.billionton.com/website/product/doc/CFBT02.htm

I have one other speculation. I look at web of Ambicom, and their card
BT2000-CF has new design. Old card was like Pretec BT2000E,
but this new card looks like Billionton :-(
http://www.ambicom.com/products/air2net/bt2000cf.html

Have somebody working this i-Tec (Billionton) card?

Best regards,

Pavel Ruzicka



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
