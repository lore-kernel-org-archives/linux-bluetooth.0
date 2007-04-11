Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "'Sergey Smirnov'" <svs1957@gmail.com>
Date: Wed, 11 Apr 2007 13:10:02 +0530
Message-ID: <004601c77c0c$9d682b50$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <461C8F1E.5080800@gmail.com>
Cc: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] btsco: Operation not supported
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

> On PDA:
> hciconfig hci0 features
> hci0:   Type: PCCARD
>         BD Address: 00:E0:03:25:7C:36 ACL MTU: 340:4 SCO MTU: 64:8
>         Features: 0xbf 0x00 0x20 0x00 0x00 0x00 0x00 0x00
>                 <3-slot packets> <5-slot packets> 
> <encryption> <slot offset>
>                 <timing accuracy> <role switch> <sniff mode>
> On notebook:
> hciconfig hci0 features
> hci0:   Type: USB
>         BD Address: 00:09:DD:10:02:C2 ACL MTU: 192:8 SCO MTU: 64:8
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>                 <3-slot packets> <5-slot packets> 
> <encryption> <slot offset>
>                 <timing accuracy> <role switch> <hold mode> 
> <sniff mode>
>                 <park state> <RSSI> <channel quality> <SCO 
> link> <HV2 packets>
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> 
> <paging scheme>
>                 <power control> <transparent SCO>
> 
> There is no <SCO link> on PDA! Is it possible to change features?

Correct. Your PDA does not support SCO links. See my previous mail.
It is simply not possible to change the features of a bluetooth device.

Best Regards,

Mayank


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
