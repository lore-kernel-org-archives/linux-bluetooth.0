Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] dund never activates pppd
From: Marcel Holtmann <marcel@holtmann.org>
To: Klaus Holst <klaus@encephalon.dk>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040224215400.GA3875@encephalon.dk>
References: <20040223213658.GA1453@encephalon.dk>
	 <1077573810.2791.161.camel@pegasus> <20040224085351.GA3782@encephalon.dk>
	 <1077624875.2880.44.camel@pegasus>  <20040224215400.GA3875@encephalon.dk>
Content-Type: text/plain
Message-Id: <1077659986.2919.46.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 24 Feb 2004 22:59:46 +0100

Hi Klaus,

> I manually assigned the ip-number for my PDA and That fixed the problem - Thanks for the help.
> However a new problem has appeared :-). The connection is quite slow (maybe 1kb/s) and after at 
> most a couple of minutes the connection is dropped and I am unable to detect hci0 from the 
> server:
> 
> # hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:03:C9:2E:6C:F6 ACL MTU: 377:10  SCO MTU: 16:0
>         UP RUNNING PSCAN ISCAN AUTH ENCRYPT 
>         RX bytes:10342 acl:118 sco:0 events:92 errors:0
>         TX bytes:33903 acl:148 sco:0 commands:19 errors:0
>         Features: 0xff 0xfd 0x05 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: HOLD SNIFF PARK 
>         Link mode: ACCEPT MASTER 
> Can't read local name on hci0. Connection timed out(110)

show us "hciconfig -a" after you plugged in the dongle.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
