Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Marcin Michalak" <marcin@telscom.ch>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <418775F2.13601.5B50785@localhost>
Content-type: text/plain; charset=US-ASCII
Reply-To: marcin@telscom.ch
Subject: [Bluez-devel] Problem with Billionton PCMCIA card
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 02 Nov 2004 11:56:34 +0100

Hello,
 I'm trying to make Billionton PCMCIA card work on Linux. It seems it 
is similar to other cards, like ZOOM CF, which should work...
CIS_dump shows:
-------------------
Socket 0:
  dev_info
    NULL 0ns, 512b
  manfid 0x0279, 0x950b
  funcid serial_port [post]
  serial_interface
    uart 16550 [space/mark/odd/even] [5/6/7/8] [1/1.5/2]
  vers_1 7.1, "PCMCIA", "Bluetooth Card", "", ""
  config base 0x00f8 mask 0x000f last_index 0x04
  cftable_entry 0x01 [default]
    [rdybsy]
    Vcc Vnom 3300mV
    io 0x03f8-0x0407 [lines=8] [8bit] [range]
    irq mask 0xffff [level] [shared]
  cftable_entry 0x02
    io 0x0000-0x7fff [lines=15] [8bit]
--------------------
I copied btuart.conf to /etc/pcmcia/ and the module is loading, but 
there's some problem:
btuart_config: No usable port range found
btuart_cs: RequestIO: No more items
 Any ideas how it could be solved? I tried hciattach on the serial 
port, but with bcsp it hangs the whole system;-)
 Hope this will work,
  Marcin
----------------------------------------------------------
Marcin Michalak		Research Engineer
Mobile: +41 79 330 83 51	Telscom AG		



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
