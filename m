Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <432202D1.90102@gulik.org>
From: Gregory Gulik <greg@gulik.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Trouble with D-LINK adapter w/Treo 650 and FC4
References: <430D4681.80609@gulik.org> <1124996595.8019.58.camel@pegasus>	<430F2C70.5090601@gulik.org>  <4321F221.3030604@gulik.org> <1126299854.5269.3.camel@blade>
In-Reply-To: <1126299854.5269.3.camel@blade>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 09 Sep 2005 16:46:57 -0500


What is security mode 3 and how do I set it?

#  hciconfig -a
hci0:   Type: USB
         BD Address: 00:13:46:47:64:27 ACL MTU: 192:8 SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN AUTH ENCRYPT
         RX bytes:101 acl:0 sco:0 events:13 errors:0
         TX bytes:296 acl:0 sco:0 commands:12 errors:0
         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'GGULIK'
         Class: 0x120104
         Service Classes: Networking
         Device Class: Computer, Desktop workstation
         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP 
Subver: 0x20d
         Manufacturer: Cambridge Silicon Radio (10)



Marcel Holtmann wrote:
> 
> this can happen, because I am not always around. However the the D-Link
> is working fine. Do you set yourself into security mode 3? Show us the
> output of "hciconfig -a".

-- 
Greg Gulik                                 http://www.gulik.org/greg/
greg @ gulik.org



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
