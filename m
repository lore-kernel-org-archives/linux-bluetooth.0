Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: bluez-devel <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] How can I set CSR module as PCM master?
In-Reply-To: <20050726083000.1153.qmail@web15704.mail.cnb.yahoo.com>
Message-ID: <Pine.LNX.4.33.0507261224230.7555-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
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
Date: Tue, 26 Jul 2005 12:26:03 +0200 (CEST)


Hi,

you have to set PSKEY PCM_CONFIG32. It is described in the CSR data
sheets.

Ciao,

Peter

On Tue, 26 Jul 2005, [gb2312] =C4=FE =C4=FE wrote:

> Hi,
> I want to transmit voice data through CSR modules so
> that I can talk with others using speaker and
> microphone.And I connecte a C145483 Codec throught PCM
> interface .But unfortunately,CSR module doesn't send
> the PCM clock and sync,so the Codec doesn't work.And
> now, I know that when the CSR module is set as a PCM
> master it will send the PCM clock. However ,I don't
> know how to do that. I can change the PCM mapping
> using pskey just like this:
> $ pskey -i hci0 mapsco 0
> $ hciconfig hci0 revision
> hci0:   Type: UART
>         BD Address: 4A:49:4E:00:15:2F ACL MTU: 384:4
> SCO                          MTU: 64:8
>         Build 705
>         Chip version: BlueCore02-External
>         Max key size: 56 bit
>         SCO mapping:  HCI
> So, what can I do?
>
> Thanks in advance!
>
> gadfly
>
>
>
> __________________________________________________
> =B8=CF=BF=EC=D7=A2=B2=E1=D1=C5=BB=A2=B3=AC=B4=F3=C8=DD=C1=BF=C3=E2=B7=D1=
=D3=CA=CF=E4?
> http://cn.mail.yahoo.com
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dcl=
ick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

|	Peter Wippich 			Voice: +49 30 46776411		|
|	G&W Instruments GmbH		fax:   +49 30 46776419		|
|	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
|	D-13355 Berlin  / Germany					|




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
