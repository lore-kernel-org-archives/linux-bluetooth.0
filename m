Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas Gaufer <Andreas.Gaufer@blue-cell-networks.com>
To: bluez-devel@lists.sourceforge.net
Message-Id: <20040518154926.4522519c.Andreas.Gaufer@blue-cell-networks.com>
In-Reply-To: <E1BQ0K1-0000wa-00@intern.SerNet.DE>
References: <1084868892.5833.45.camel@pegasus>
	<E1BQ0K1-0000wa-00@intern.SerNet.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-devel] Nokia 6230 info
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
Date: Tue, 18 May 2004 15:49:26 +0200

On Tue, 18 May 2004 10:51:37 +0200 (CEST)
Lutz Pressler <Lutz.Pressler@SerNet.DE> wrote (on BlueZ-Users):
> > please run "hcitool info <bdaddr-6230>" for me, so I can put this phone
> > on my list.
> >
> Requesting information ...
>         BD Address:  00:E0:03:39:C9:AB
>         Device Name: Nokia 6230 LP
>         LMP Version: 1.1 (0x1) LMP Subversion: 0x380
>         Manufacturer: Cambridge Silicon Radio (10)
>         Features: 0xbf 0xee 0x00 0x09
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
>                 <timing accuracy> <role switch> <sniff mode> <RSSI>
>                 <channel quality> <SCO link> <HV3 packets> <u-law log>
>                 <A-law log>
> 

Hi Marcel,

just looked into the data from our field tests. We saw something that had the 
Device Name "Nokia 6230 Ir" and it had a diffrent feature list. Just thought 
this might be intresting for you :

1080041406|dn|Nokia 6230 iR
1080041406|fea|0xbf 0xee 0x0f 0x00
1080041406|lmpsv|0x380
1080041406|lmpv|1.1 (0x1)
1080041406|mf|NokiaDanmarkAS

Since the Mac-Adress was 00:02:EE:x:x:x this was maby a prototype of that 
phone. We spotted it in March in Hannover ;)

Greetings

Andy


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
