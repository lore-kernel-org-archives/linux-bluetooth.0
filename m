Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: O Plameras <oscarp@acay.com.au>
Message-ID: <cje512$kj5$1@sea.gmane.org>
References: <E1CA5Ze-0006Iu-R6@paris.servershost.net>	 <cjad82$qji$1@sea.gmane.org> <1096371695.4950.2.camel@notepaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <1096371695.4950.2.camel@notepaq>
Subject: [Bluez-users] Re: pand freezes upon disconnect
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
Date: Wed, 01 Sep 2004 09:06:49 +1000

Marcel Holtmann wrote:
> Hi,
> 
> 
>>I have a similar problem but my clients are Linux FC2. When I close
>>my connection from Linux clients the server has to be rebooted as it
>>freezes. I also tried shutdown the the following in sequence and the
>>server also freezes.
>>
>>ifconfig bnep0 down
>>ifconfig bnep1 down
>>brctl delif br0 bnep0
>>brctl delif bro bnep1
>>hciconfig hci0 down ................
>>
>>My server is Fedora Core 2 with kernel-2.6.8.1-mm4. It is
>>also a bridge-router-firewall (firewall = www.shorewall.net).
>>I also tried patching my server with patch-2.6.8-mh2 with the
>>same results. Can anyone help ?
>>
>>[root@compaq src]#hci0:   Type: USB
>>         BD Address: 00:10:60:A7:DD:45 ACL MTU: 192:8  SCO MTU: 64:8
>>         UP RUNNING PSCAN ISCAN
>>         RX bytes:1484873 acl:44063 sco:0 events:26226 errors:0
>>         TX bytes:5589996 acl:32995 sco:0 commands:29 errors:0
>>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>>         Link policy: RSWITCH HOLD SNIFF PARK
>>         Link mode: ACCEPT MASTER
>>         Name: 'compaq.noy.com.au'
>>         Class: 0x000100
>>         Service Classes: Unspecified
>>         Device Class: Computer, Uncategorized
>>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP 
>>Subver: 0x20d
>>         Manufacturer: Cambridge Silicon Radio (10)
>>
>>[root@compaq src]#brctl show
>>bridge name     bridge id               STP enabled     interfaces
>>br0             8000.00105a67f2a1       yes             eth0
>>                                                         eth1
>>                                                         bnep0
>>                                                         bnep1
>>[root@compaq src]#
>>
>>My clients are Fedora Core 2 with kernel-2.6.8.1-mm4
>>
>>I have:
>>bluez-sdp-1.5-1
>>bluez-pan-1.1-1
>>bluez-firmware-1.0
>>bluez-hcidump-1.12
>>bluez-hciemu-1.0
>>bluez-libs-2.10
>>bluez-pin-0.24
>>bluez-utils-2.10
>>
>>in my server and clients.
> 
> 
> there is no need to have bluez-sdp and bluez-pan installed. Remove them
> and only use latest bluez-libs and bluez-utils.
> 

I have re-installed bluez. The setup works well as
before until a client bluetooth is downed or is temporarily
out of range. The server, then freezes with the console
going blank.

I tried using Bluetooth on Windows/XP Professional with the
same results.

Is there an older version of bluez that does not do this ?


Thanks.



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
