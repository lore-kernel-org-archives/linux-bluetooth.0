Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification testing.
Message-ID: <000701c4d898$525f9180$1a01010a@baked>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0008_01C4D855.443C5180"
In-Reply-To: <1101972944.15615.78.camel@pegasus>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 2 Dec 2004 09:56:59 -0800

This is a multi-part message in MIME format.

------=_NextPart_000_0008_01C4D855.443C5180
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Marcel,

> > An hcidump is attached. Though I don't think you'll learn 
> much from it.
> 
> actually I learned that hcidump can't deal with the hint bit 
> and that it
> don't understand the QoS option. Both is fixed in CVS and 
> looks now like
> this:

Good stuff.

> > L2CAP(s): Config req: dcid 0x0040 flags 0x0001 clen 4
>   [MTU 672] 
> < L2CAP(s): Config rsp: scid 0x0040 flags 0x0001 result 0 clen 0
> > L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 28
>   [FlushTO 65535] [QoS 0x01 (Best effort)] 
> < L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> 
> We send two empty resposonses, but from my current 
> understanding this is
> fine. All of the options have set the hint bit (indicated by 
> []). Maybe
> I am missing something, but the specification says:
> 
> 	option is a hint; if the option is not recognized then
> 	skip the option and continue processing
> 
> So our responses are valid, because we answer both requests.

As far as I can tell it's fine too. I'm waiting for more information from
the test house. Will let you know what I find out.

> For you it is the best to go with the hack, because I don't 
> think that I
> will backport such a change to the 2.4 kernel series.

Ok.

> However do you also have a hcidump from that test for me?

Attached.

-Daryl.

------=_NextPart_000_0008_01C4D855.443C5180
Content-Type: application/octet-stream;
	name="cos_cfd_bv_12"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="cos_cfd_bv_12"

DQABACiMq0H4JwwABAQKERERERERAAAAAQsAAAAojKtBWioMAAEJBAcREREREREBBwABACiMq0GS
QAwABA8EAAEJBA4AAQAojKtBF6gMAAQDCwAqABEREREREQEACAAAACiMq0EOqQwAAQ0IBCoAAQAK
AAEAKIyrQRasDAAEIAcREREREREBCQABACiMq0HPvgwABA4GAQ0IACoACAAAACiMq0H6yAwAAQ8E
BCoAGMwHAAEAKIyrQRTcDAAEDwQAAQ8ECAABACiMq0F23QwABB0FACoAGMwGAAEAKIyrQXqNDQAE
GwMqAAURAAEAKYyrQeotAAACKiAMAAgAAQACAQQAAQBAABUAAAApjKtBIC8AAAIqIBAADAABAAMB
CABAAEAAAAAAAAgAAQApjKtBPpQAAAQTBQEqAAEAFAABACmMq0F8lQIAAiogDwALAAEABAIHAEAA
AAB/AQATAAAAKYyrQX+WAgACKiAOAAoAAQAFAgYAQAAAAAAAEQAAACmMq0HKlgIAAiogDAAIAAEA
BAEEAEAAAAAIAAEAKYyrQWH8AgAEEwUBKgABAAgAAQApjKtB7wADAAQTBQEqAAEABwABACmMq0FY
nwcABAUEACoAExoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGho=

------=_NextPart_000_0008_01C4D855.443C5180--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
