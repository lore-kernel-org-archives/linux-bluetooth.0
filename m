Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200407251403.50608.cijoml@volny.cz>
Subject: [Bluez-users] obexserver and t68i problem?
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
Date: Sun, 25 Jul 2004 14:03:50 +0200

Hi,

after a long time I needed send photos from my phone to bluez box.

sdpd
sdptool add --channel=10 OPUSH
obexserver

Mobile finds bluez box, try send, but writes connection problem:

here is output of hcidump

# hcidump -x
HCIDump - HCI packet analyzer ver 1.9
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  51 EC FC D9 0A 00 04 02 52 01
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  51 EC FC D9 0A 00 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04
> HCI Event: Connect Complete (0x03) plen 11
  1A 2F 00 51 EC FC D9 0A 00 01 00


Thanks

Michal


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
