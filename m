Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: milosz danielewski <master@apnet.pl>
Date: Mon, 5 Mar 2007 19:14:47 +0000 (UTC)
Message-ID: <loom.20070305T200231-670@post.gmane.org>
References: <45EAAB70.60302@apnet.pl>
	<1173029470.5752.6.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel]
	=?utf-8?q?sdp=5Fuuid32=5Fto=5Fuuid128=2C_lack_of_de?=
	=?utf-8?q?claration?=
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

Marcel Holtmann <marcel <at> holtmann.org> writes:

> 
> Hi Milosz,
> 
> > Why there are no sdp_uuid32_to_uuid128 declaration in sdp_lib.h
> > (bluez-libs-devel 3.7.1)? It would be useful, but in such situation I
> > cannot use it...
> 
> I think that is simply because nobody needed them before. Feel free to
> implement them and send a patch.

 As far, as I can see it's already implemented, just not exposed in header file.

> However UUID32 is the most unused UUID
> type. In general you should either use UUID16 for well known profile and
> service identifiers or UUID128 for your own identifiers.

 I've started to implement jsr82. When I create java object representing UUID
it's most convenient to pass 16 byte array from native C to Java. So, when I
iterate over service attributes, have to properly convert SDP_UUID32 to uuid128.
That's why I need to use sdp_uuid32_to_uuid128 (which is already implemented and
working). Only problem is ugly warning "implicit declaration".

milosz danielewski


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
