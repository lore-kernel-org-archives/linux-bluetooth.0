Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] a2play and Toshiba SR-1 Bluetooth Headset
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Cc: Henryk =?ISO-8859-1?Q?Pl=F6tz?= <henryk@ploetzli.ch>
In-Reply-To: <20041126041158.GF27879@snoopy.src.ricoh.co.jp>
References: <20041125091124.GA19805@snoopy.src.ricoh.co.jp>
	 <20041125112509.75347786.henryk@ploetzli.ch>
	 <20041125105615.GA19821@snoopy.src.ricoh.co.jp>
	 <1101440449.6465.64.camel@pegasus>
	 <20041126041158.GF27879@snoopy.src.ricoh.co.jp>
Content-Type: text/plain
Message-Id: <1101443356.6465.81.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 26 Nov 2004 05:29:16 +0100

Hi Alain,

> > You can try to hack the a2play.c to use SEID 3 instead of 1 and see what
> > the audio sink on SEID 3 offers you. Run the hcidump 1.15.
> 
> The SEID 1 is pretty weird in fact ... at least doesn't offer things that
> can be decoded by hcidump (sorry guys .. just no time now to read AV specs 
> in details).

you meant SEID 3, right? Please do the same for SEID 4. We can't do
anything useful with audio source, but it is nice to know what it is.

> > ACL data: handle 0x0028 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0041 len 8 [psm 25]
>       AVDTP(s): Discover rsp: transaction 0
>         ACP SEID 1 - Audio Sink
>         ACP SEID 3 - Audio Sink
>         ACP SEID 4 - Audio Source
> < ACL data: handle 0x0028 flags 0x02 dlen 7
>     L2CAP(d): cid 0x0040 len 3 [psm 25]
>       AVDTP(s): Capabilities cmd: transaction 1
>         ACP SEID 3
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 0x0028 flags 0x02 dlen 19
>     L2CAP(d): cid 0x0041 len 15 [psm 25]
>       AVDTP(s): Capabilities rsp: transaction 1
>         Media Transport
>         Media Codec - non-A2DP
>           04 00 01 00 01 00 FC

So they use their own codec here. It is fine, but doesn't help us and
even the specification wouldn't tell us anymore. Actually I expect to
see a MP3 codec.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
