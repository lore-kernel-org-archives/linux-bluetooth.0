Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20041223141028.61563.qmail@web11602.mail.yahoo.com>
From: "Bhaskar S. Manda" <bhaskar_manda@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: Anybody using Socket CF Bluetooth version F on Zaurus
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
Date: Thu, 23 Dec 2004 06:10:28 -0800 (PST)

>From /etc/pcmcia/bluetooth.conf:

device "dtl1_cs"
  class "bluetooth" module "dtl1_cs"
<...>
card "Socket Bluetooth Card"
  version "Socket", "CF+ Personal Network Card"
  bind "dtl1_cs"


# dump_cis
Socket 0:
  dev_info
   NULL 0ns, 512b
  vers_1_7.0, "Socket", "CF+ Personal Network Card"
  manfid 0x0104, 0x009f
  funcid unknown [post]
  config base 0x01f6 mask 0x0011 last_index 0x24
  cftable_entry 0x04 [default]
    Vcc Vnom 3300mV Vmin 3140mV Vmax 3470mV Istatic 25mA
      Iavg 55mA Ipeak 120mA
    io 0x0000-0x001f [lines=5] [8bit] [range]
    irq mask 0xffff [level]
  cftable_entry 0x24
    Vcc Vnom 5V Vmin 4500mV Vmax 5500mV Istatic 25mA
      Iavg 55mA Ipeak 120mA


Thanks!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
