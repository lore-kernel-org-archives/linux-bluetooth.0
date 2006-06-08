Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <027101c68b0f$2dc2cfb0$0203a8c0@NBVICTOR>
References: <027101c68b0f$2dc2cfb0$0203a8c0@NBVICTOR>
Date: Thu, 08 Jun 2006 17:41:45 +0200
Message-Id: <1149781305.4219.38.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] DUN: samsung-E770 & LG-S5200 & more...
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

Hi Victor,

> I'm testing DUN with some LGs and Samsungs (mostly new models) and some 
> cases get very strange results. From the log below, PPP configuring the 
> connection:
> 
> sent [LCP ConfReq id=0x2 <asyncmap 0xa0000> <magic 0xd8a026bf>]
> < ACL data: handle 42 flags 0x02 dlen 45
>     L2CAP(d): cid 0x005b len 41 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 37 fcs 0x9a
>       0000: 7e ff 7d 23 c0 21 7d 21  7d 22 7d 20 7d 30 7d 22 
>  ~.}#.!}!}"} }0}" <-------------- PPP data is escaped with 0x7D
>       0010: 7d 26 7d 20 7d 2a 7d 20  7d 20 7d 25 7d 26 d8 
> a0  }&} }*} } }%}&..
>       0020: 26 bf f2 83 7e                                    &...~
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42
> > ACL data: handle 42 flags 0x02 dlen 10 
> > <-------------------------------here phone responds
>     L2CAP(d): cid 0x0040 len 6 [psm 3]
>       RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
>       0000: 7e                                                ~
> > ACL data: handle 42 flags 0x02 dlen 31
>     L2CAP(d): cid 0x0040 len 27 [psm 3]
>       RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 23 fcs 0x40
>       0000: ff 03 80 21 04 02 00 10  02 06 00 0a 00 00 05 06 
> ...!............  <--------------- PPP data not escaped?
>       0010: d8 a0 26 bf 8f e7 7e                              ..&...~
> 
> PPP sends configure request and phone replies, but for some reasong the data 
> in the replied frame is not escaped as should be according to standard.... 
> So it looks like PPP ignores the reply (cause it is invalid?) and sends the 
> next request... And so on till we termiate the link.

you can create a pppdump from hcidump and then feed it into pppdump or
Ethereal for further inspection. It also includes an experimental PPP
decoder, but that one is in an early stage.

> P.S. Looks like Windows handles these phones correctly
> P.P.S. Another strange thing with LGs, after trying a phone it with a 
> Windows PC (where it works fine), it starts to work also with the ARM box 
> running Bluez, if I reboot the phone it no longer works with ARM+Bluez till 
> I use it with Windows PC again. This is weird, will try to dig something up.

Can you compare the SDP records before Windows touches it and after. I
assume that Windows somehow enables the DUN profile.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
