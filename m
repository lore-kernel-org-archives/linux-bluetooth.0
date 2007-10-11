Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 11 Oct 2007 14:34:18 +0200
From: Radek (Fotopiper) <fotopiper@o2.pl>
To: bluez-devel@lists.sf.net
Message-ID: <20071011143418.65350112@darkstar.example.net>
Mime-Version: 1.0
Subject: [Bluez-devel] RFCOMM - serial line looped back.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,
I'm getting a "Serial line is looped back." from pppd when I try to connect to
the net threw my GSM phone.
pppd 2.4.4
kernel 2.6.22.8 (22.2 & 22.9 give the same results)
Bluez 3.20 (libs&utils)
Slacware 12

PPPD debug fallows "serial line looped back" and (at the end of mail) "LCP
terminated by peer (peer refused to authenticate)".

Any suggestions what I am doing wrong?

Best regards to all!

#>pppd debug gives (chat echo on):

abort on (NOCARRIER)
abort on (BUSY)
abort on (ERROR)
send (ATZ^M)
expect (OK)
ATZ
ATZ^M^M
OKOK
 -- got it

send (AT+CGDCONT=1,"IP","wpmobi.internet"^M)
expect (OK)

^M
AT+CGDCONT=1,"IP","wpmobi.internet"
AT+CGDCONT=1,"IP","wpmobi.internet"^M^M
OKOK
 -- got it

send (ATDT*99***1#^M)

Serial connection established.
using channel 2
Using interface ppp0
Connect: ppp0 <--> /dev/rfcomm0
sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x120103d1> <pcomp> <accomp>]
rcvd [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x120103d1> <pcomp> <accomp>]
sent [LCP ConfNak id=0x1 <magic 0x9e7e8225>]
rcvd [LCP ConfNak id=0x1 <magic 0x9e7e8225>]
sent [LCP ConfReq id=0x2 <asyncmap 0x0> <magic 0x2c46fff2> <pcomp> <accomp>]
rcvd [LCP ConfReq id=0x2 <asyncmap 0x0> <magic 0x2c46fff2> <pcomp> <accomp>]
sent [LCP ConfNak id=0x2 <magic 0xb829d231>]
rcvd [LCP ConfNak id=0x2 <magic 0xb829d231>]
sent [LCP ConfReq id=0x3 <asyncmap 0x0> <magic 0x7c164935> <pcomp> <accomp>]
rcvd [LCP ConfReq id=0x3 <asyncmap 0x0> <magic 0x7c164935> <pcomp> <accomp>]
sent [LCP ConfNak id=0x3 <magic 0xcf0565e3>]
rcvd [LCP ConfNak id=0x3 <magic 0xcf0565e3>]
sent [LCP ConfReq id=0x4 <asyncmap 0x0> <magic 0x38b7e52d> <pcomp> <accomp>]
rcvd [LCP ConfReq id=0x4 <asyncmap 0x0> <magic 0x38b7e52d> <pcomp> <accomp>]
sent [LCP ConfNak id=0x4 <magic 0xb25fcf05>]
rcvd [LCP ConfNak id=0x4 <magic 0xb25fcf05>]
sent [LCP ConfReq id=0x5 <asyncmap 0x0> <magic 0xdc05b7b8> <pcomp> <accomp>]
rcvd [LCP ConfReq id=0x5 <asyncmap 0x0> <magic 0xdc05b7b8> <pcomp> <accomp>]
sent [LCP ConfNak id=0x5 <magic 0x3b40f4a0>]
rcvd [LCP ConfNak id=0x5 <magic 0x3b40f4a0>]
sent [LCP ConfReq id=0x6 <asyncmap 0x0> <magic 0x42656947> <pcomp> <accomp>]
rcvd [LCP ConfReq id=0x6 <asyncmap 0x0> <magic 0x42656947> <pcomp> <accomp>]
sent [LCP ConfNak id=0x6 <magic 0xa25c92a7>]
rcvd [LCP ConfNak id=0x6 <magic 0xa25c92a7>]
sent [LCP ConfReq id=0x7 <asyncmap 0x0> <magic 0x12cb6808> <pcomp> <accomp>]
rcvd [LCP ConfReq id=0x7 <asyncmap 0x0> <magic 0x12cb6808> <pcomp> <accomp>]
sent [LCP ConfNak id=0x7 <magic 0xa67184e4>]
rcvd [LCP ConfNak id=0x7 <magic 0xa67184e4>]
sent [LCP ConfReq id=0x8 <asyncmap 0x0> <magic 0xee7e0c9c> <pcomp> <accomp>]
rcvd [LCP ConfReq id=0x8 <asyncmap 0x0> <magic 0xee7e0c9c> <pcomp> <accomp>]
sent [LCP ConfNak id=0x8 <magic 0xe7187c97>]
rcvd [LCP ConfNak id=0x8 <magic 0xe7187c97>]
sent [LCP ConfReq id=0x9 <asyncmap 0x0> <magic 0x5a6aff52> <pcomp> <accomp>]
rcvd [LCP ConfReq id=0x9 <asyncmap 0x0> <magic 0x5a6aff52> <pcomp> <accomp>]
sent [LCP ConfNak id=0x9 <magic 0x650dfa1>]
rcvd [LCP ConfNak id=0x9 <magic 0x650dfa1>]
sent [LCP ConfReq id=0xa <asyncmap 0x0> <magic 0xbd5dc8fa> <pcomp> <accomp>]
rcvd [LCP ConfReq id=0xa <asyncmap 0x0> <magic 0xbd5dc8fa> <pcomp> <accomp>]
sent [LCP ConfNak id=0xa <magic 0xd18be134>]
rcvd [LCP ConfNak id=0xa <magic 0xd18be134>]
Serial line is looped back.
sent [LCP TermReq id=0xb "Loopback detected"]
rcvd [LCP TermReq id=0xb "Loopback detected"]
sent [LCP TermAck id=0xb]
rcvd [LCP TermAck id=0xb]
Connection terminated.

#> peers-file:

lock
passive
noipdefault
asyncmap 0
modem
usepeerdns
defaultroute
noauth
/dev/rfcomm0
connect "/usr/sbin/chat -e -s -v -f /etc/ppp/chat/chat-PL.wpMobi.pl"

#> chat script:

ABORT NOCARRIER
ABORT BUSY
ABORT ERROR
'' ATZ
OK 'AT+CGDCONT=1,"IP","wpmobi.internet"'
OK ATDT*99***1#

#> sometimes pppd gives different resoults:

abort on (NOCARRIER)
abort on (BUSY)
abort on (ERROR)
send (ATZ^M)
expect (OK)
ATZ
ATZ^M^M
OKOK
 -- got it

send (AT+CGDCONT=1,"IP","wpmobi.internet"^M)
expect (OK)

^M
AT+CGDCONT=1,"IP","wpmobi.internet"
AT+CGDCONT=1,"IP","wpmobi.internet"^M^M
OKOK
 -- got it

send (ATDT*99***1#^M)

Serial connection established.
using channel 3
Using interface ppp0
Connect: ppp0 <--> /dev/rfcomm0
sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x2a92f843> <pcomp> <accomp>]
rcvd [LCP ConfReq id=0x1 <asyncmap 0xa0000> <auth pap>]
No auth is possible
sent [LCP ConfRej id=0x1 <auth pap>]
rcvd [LCP ConfRej id=0x1 <magic 0x2a92f843> <pcomp> <accomp>]
sent [LCP ConfReq id=0x2 <asyncmap 0x0>]
rcvd [LCP ConfReq id=0x2 <asyncmap 0xa0000>]
sent [LCP ConfAck id=0x2 <asyncmap 0xa0000>]
rcvd [LCP ConfAck id=0x2 <asyncmap 0x0>]
sent [CCP ConfReq id=0x1 <deflate 15> <deflate(old#) 15> <bsd v1 15>]
sent [IPCP ConfReq id=0x1 <compress VJ 0f 01> <addr 0.0.0.0> <ms-dns1 0.0.0.0> <
ms-dns3 0.0.0.0>]
rcvd [LCP TermReq id=0x3 "peer refused to authenticate"]
LCP terminated by peer (peer refused to authenticate)
sent [LCP TermAck id=0x3]
rcvd [LCP ProtRej id=0x4 80 fd 01 01 00 0f 1a 04 78 00 18 04 78 00 15 03 2f]
Connection terminated.
Modem hangup

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
