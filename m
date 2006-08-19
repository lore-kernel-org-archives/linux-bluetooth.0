Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <20060819094153.56998.qmail@web54001.mail.yahoo.com>
Date: Sat, 19 Aug 2006 02:41:53 -0700 (PDT)
From: Auer Michael <netmicha@yahoo.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] SCO Command Disallowed
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

I wanted to use the PC as an handsfree. Everything is
working all right so far. Rfcomm connection is
established, settings are exchanged via AT commands
-the mobile phone accepts the HF profile
(Icon,Connection OK), I can also receive the pressed
key messages from the phone. An SCO link was also
established successfull. But the phone cannot
transmitt SCO (audio) data, because the connection
request is canceld with an "Command Disallowed".

The hstest test programm is working perfectly with an
connected headset (play and record) so the BT adapter
is capable of sending,transmitting SCO data.

Any hints what's wrong.

PS: I've been reading almost every post on this list,
but cannot find anything about this :)


Thanks in advance.



Output of hcidump -X -V:

> ACL data: handle 42 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 0]
      0000: 19 ef 1e 00 0d 0a 2b 43  49 45 56 3a 20 31
30 2c  ......+CIEV: 10,
      0010: 32 0d 0a 55                               
       2..U
> ACL data: handle 42 flags 0x02 dlen 23
    L2CAP(d): cid 0x0040 len 19 [psm 0]
      0000: 19 ef 1c 00 0d 0a 2b 43  4b 45 56 3a 20 5b
2c 30  ......+CKEV: [,0
      0010: 0d 0a 55                                  
       ..U
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 2a 00 01                                      
   *..
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:12:EE:6D:FB:B6 class 0x520204 type SCO
< HCI Command: Accept Connection Request (0x01|0x0009)
plen 7
    bdaddr 00:12:EE:6D:FB:B6 role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status
0x0c ncmd 1
    Error: Command Disallowed








__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
