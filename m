Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Igor Luiz Oliveira de Souza <igorluiz@magiclink.com.br>
Reply-To: igorluiz@magiclink.com.br
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1077831499.7219.34.camel@emerald>
Mime-Version: 1.0
Subject: [Bluez-users] Problem with pppd through bluetooth
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
Date: Thu, 26 Feb 2004 21:38:19 +0000

Hello all,

I'm experimenting a problem trying to connect internet via GRPS through
bluetooth using my Nokia 3650 and a Linux Box with a usb-dongle
bluetooth BT3030, via pppd.

The connection between the mobile and the PC via bluetooth is working
fine. I can transfer data in the two ways: PC->mobile , mobile->PC,
using the bluez driver.
So, now when I try to access the internet via GPRS a got this message
when I call "pppd"

root@emerald:~# rfcomm 1 xx:xx:xx:xx:xx:xx 9
Connected /dev/ttyU1 to xx:xx:xx:xx:xx:xx on channel 9
rfcomm_send_data: DLCI 18 not connected
rfcomm_send_data: DLCI 18 not connected
rfcomm_send_data: DLCI 18 not connected
rfcomm_send_data: DLCI 18 not connected

My pppd scripts are:

in /etc/ppp/chat-gprs
-----------------------------------
TIMEOUT         5
ECHO            ON
ABORT           '\nBUSY\r'
ABORT           '\nERROR\r'
ABORT           '\nNO ANSWER\r'
ABORT           '\nNO CARRIER\r'
ABORT           '\nNO DIALTONE\r'
ABORT           '\nRINGING\r\n\r\nRINGING\r'
''              \rAT
TIMEOUT         12
OK              ATE1
OK              'AT+cgdcont=1,"IP","tim"'
OK              ATD*99***1#
-----------------------------------


and in /etc/ppp/peers/gprs
-----------------------------------
/dev/modem 57600
connect '/usr/sbin/chat -v -f /etc/ppp/chat-gprs'
noauth
defaultroute
debug
-----------------------------------

I have a symbolic link from /dev/ttyU1 to /dev/modem

And when I call: "pppd call gprs"
I got that message "rfcomm_send_data: DLCI 18 not connected"

Does anyone can help me with this?
Sorry about the long message...

TIA,
-- 
Igor Luiz Oliveira de Souza
Magiclink Solucoes Internet
Analista de TI - 88657412
Salvador / BA   -  Brasil



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
