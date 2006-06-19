Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4496C0A6.3070601@palmsource.com>
Date: Mon, 19 Jun 2006 17:20:06 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <447C6278.1040707@palmsource.com>	<447C6598.6050107@xmission.com>	<447C69D4.9020504@palmsource.com>	<447C7330.9000303@xmission.com>	<44963723.4040807@xmission.com>
	<44965944.6090908@palmsource.com> <4496B96C.4060207@xmission.com>
In-Reply-To: <4496B96C.4060207@xmission.com>
Subject: Re: [Bluez-devel] A2DP Profile Certification
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi brad

>"sdptool add AVRTG" then avrecv that the play button did not cause the
>set to connect to avrecv. maybe it's really trying to start up a one of
>these plain a2dp connection (or maybe not doing anything :)
>  =

>
Yes, sdptool add A2SRC followed by hcidump shows an incoming connection!

I suppose the following log shows there is no L2CAP listening socket on =

PSM 25.

 > ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0040
< ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 2 status 0
      Connection refused - PSM not supported
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Remote Name Req Complete (0x07) plen 255
 > HCI Event: Disconn Complete (0x05) plen 4


Fr=E9d=E9ric.



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
