Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] a2dp on iTech works
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4255ADED.3080200@xmission.com>
References: <4255A15E.3010007@xmission.com>
	 <1112908613.26175.0.camel@pegasus>  <4255ADED.3080200@xmission.com>
Content-Type: text/plain
Message-Id: <1112911835.26175.2.camel@pegasus>
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
Date: Fri, 08 Apr 2005 00:10:34 +0200

Hi Brad,

> here's the info
> 
>          BD Address:  00:0D:3C:30:04:0F
>          Device Name: i.Tech stereo headset
>          LMP Version: 1.2 (0x2) LMP Subversion: 0x703
>          Manufacturer: Cambridge Silicon Radio (10)
>          Features: 0xff 0xff 0x8f 0xf8
> 
>                  <3-slot packets>
>                  <5-slot packets>
>                  <encryption>
>                  <slot offset>
>                  <timing accuracy>
>                  <role switch>
>                  <hold mode>
>                  <sniff mode>
>                  <park state>
>                  <RSSI>
>                  <channel quality>
>                  <SCO link>
>                  <HV2 packets>
>                  <HV3 packets>
>                  <u-law log>
>                  <A-law log>
>                  <CVSD>
>                  <paging scheme>
>                  <power control>
>                  <transparent SCO>
>                  <broadcast encrypt>
>                  <enhanced iscan>
>                  <interlaced iscan>
>                  <interlaced pscan>
>                  <inquiry with RSSI>
>                  <extended SCO>
>                  <AFH cap. slave>
>                  <AFH class. slave>
>                  <AFH cap. master>
>                  <AFH class. master>
>                  <extended features>

this looks weird and normally means that the bluez-libs and bluez-utils
are not matching. However this is the first CSR based headphone I've
seen so far.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
