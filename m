Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: dwillis@stx.rr.com
To: bluez-users@lists.sourceforge.net
Message-ID: <11163979.1079242503794.JavaMail.teamon@b112.teamon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] problems with pppd and x windows
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
Date: Sat, 13 Mar 2004 23:36:01 -0600 (CST)

i have a sony ericsson t610 phone from t-mobile (usa) and the 
internet works just fine, but only as long as i'm at the console.
when i use netscape, mozilla, konquerer, or anything else i soon loose 
the ability to transmit and receive any data, even though the 
connection is still there.  anyone have any clues?

facts about my system:

Linux version 2.4.20-highmem-ll-pe-mh14-xp (root@tiburon) (gcc version 
3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r1, propolice)) #2 Sat Feb 14 
14:25:30 CST 2004

XFree86 Version 4.3.0

d-link dbt-120 bluetooth usb dongle.

AMD Athlon(tm) XP 2400+

how i connect:
# modprobe hci_usb
# modprobe uhci
# hciconfig hci0 up
# hciconfig
# rfcomm bind 0 00:0A:D9:7B:1F:EA 1
# pppd call gprs2

pppd scripts:

/etc/ppp/peers/gprs2:
--
/dev/rfcomm0 57600
connect '/usr/sbin/chat -v -f /etc/ppp/peers/chat-gprs2'
noauth
defaultroute
debug
--

/etc/ppp/peers/chat-gprs2:
--
TIMEOUT         5
ECHO            ON
ABORT           '\nBUSY\r'
ABORT           '\nERROR\r'
ABORT           '\nNO ANSWER\r'
ABORT           '\nNO CARRIER\r'
ABORT           '\nNO DIALTONE\r'
ABORT           '\nRINGING\r\n\r\nRINGING\r'
#''              \rAT
#TIMEOUT         20
#OK              ATE1
#OK              'AT+cgdcont=1,"IP","internet2.voicestream.com"'
#OK              ATD*99***2#
#CONNECT

'' AT
TIMEOUT 240
OK ATE0
OK ATV1
OK AT+CGMI
OK AT+CIMI
#OK 'AT+CGDCONT=1,"IP","216.155.175.170"'
OK AT+CGQREQ=1,0,0,0,0,0
OK AT+CGQMIN=1,0,0,0,0,0
OK ATDT*99***2#
TIMEOUT 22
CONNECT ""
--

thanks.

-dave
-- 
(I*NT*p)    42.99803% - Major Geek    102 of 114:
computers let you take laziness to a whole new level. - mrak


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
