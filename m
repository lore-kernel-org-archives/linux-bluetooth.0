Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Catalin Drula <Catalin.Drula@imag.fr>
To: <bluez-devel@lists.sourceforge.net>
Message-ID: <Pine.GSO.4.33.0410141441210.15261-100000@horus.imag.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-devel] (dtl1_cs) Problems with Socket CF card on HP Jornada
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
Date: Thu, 14 Oct 2004 14:41:34 +0200 (CEST)

Hi everyone,

I am trying to use a Socket CF card (revision F, model no "8510-00159 F")
with Linux (2.6.8.1-hh0 kernel) and Bluez on an HP Jornada 568 PDA for a
project for our lab.

It seems that I am running into the same problem that was described here:
http://sourceforge.net/mailarchive/message.php?msg_id=1427158

When I run:

root@jornada56x:~# hciconfig
hci0:   Type: PCCARD
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
        DOWN INIT RUNNING
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:1 errors:0

However:

root@jornada56x:~# hciconfig hci0 up
Can't init device hci0. Connection timed out(110)

And:

root@jornada56x:~# hcidump -x
HCIDump - HCI packet analyzer ver 1.10
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0

At boot time I get this:

Starting Bluetooth subsystem:Bluetooth: Core ver 2.6
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
 hcid sdpdCan't open HIDP control socket: Protocol not supported
 hiddCan't open RFCOMM control socket: Protocol not supported
 rfcomm.
Starting PCMCIA services: cardmgr[879]: watching 1 socket
done.
cardmgr[880]: socket 0: Socket Bluetooth Card
Bluetooth: Nokia control data = 07 00

Any ideas/help are most appreciated, thanks in advance,

Catalin






-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
