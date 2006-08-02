Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44D0350A.8090904@xmission.com>
Date: Tue, 01 Aug 2006 23:15:54 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <002a01c6b5e5$5e6b0cd0$9d0cc70a@dlh.st.com>
In-Reply-To: <002a01c6b5e5$5e6b0cd0$9d0cc70a@dlh.st.com>
Subject: Re: [Bluez-devel] Bluetooth Headset Error
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

Mayank

>      > ACL data: handle 44 flags 0x02 dlen 12
>         L2CAP(s): Connect req: psm 23 scid 0x0051 < ACL data: handle 44
>     flags 0x02 dlen 16
>         L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0051 result 2 status 0
>           Connection refused - PSM not supported   
>     There is a connection request from the headset on PSM 23 (0x17)
>     which is AVCTP.
>     So probably, the headset is trying to connect on AVRCP, which we reject.

good find here.

Keith, could you run
 sdptool add AVRTG
 ./avrecv
and see if the headset is sending avrcp messages?

Brad


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
