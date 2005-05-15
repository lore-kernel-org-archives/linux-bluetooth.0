Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4287A9F0.7000400@marubeca.net>
From: Mark Watson <mark@marubeca.net>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Building btsco for Fedora 3
References: <42869C29.3040001@volantis.com> <4286E60F.1020505@xmission.com> <42876512.5040205@marubeca.net> <42879F86.8090902@xmission.com>
In-Reply-To: <42879F86.8090902@xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Sun, 15 May 2005 20:58:40 +0100

Brad Midgley wrote:

> try it without specifying the '1' (the channel should be autodetected)
>
> btw, does it say anywhere in our docs that you need to specify the 
> channel?

You're right, it doesn't. I was following various examples from Google.

Here's my attempt to connect, with tail -f /var/log/messages in the 
background:

> [bluetooth]# btsco 00:07:A4:07:52:3D
> May 15 20:51:02 localhost hcid[7935]: pin_code_request 
> (sba=00:20:E0:74:66:58, dba=00:07:A4:07:52:3D)
> Error: Failed to connect to SDP server: Function not implemented
> Assuming channel 2
>
> Can't connect RFCOMM channel: Resource temporarily unavailable

And here's the hcidump -X output

> [bluetooth]# hcidump -X
> HCIDump - HCI packet analyzer ver 1.11
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>   0000: 3d 52 07 a4 07 00 18 cc 02 00 00 00 00            =R...........
> > HCI Event: Command Status (0x0f) plen 4
>   0000: 00 01 05 04                                       ....
> > HCI Event: PIN Code Request (0x16) plen 6
>   0000: 3d 52 07 a4 07 00                                 =R....
> < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
>   0000: 3d 52 07 a4 07 00 2b 53 65 72 76 69 63 65 20 22   =R....+Service "
>   0010: 6f 72 67 2e 62 6c 75                              org.blu
> > HCI Event: Command Complete (0x0e) plen 10
>   0000: 01 0d 04 12 3d 52 07 a4 07 00                     ....=R....
> > HCI Event: Connect Complete (0x03) plen 11
>   0000: 22 29 00 3d 52 07 a4 07 00 01 00                  ").=R......
> < HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> > HCI Event: Command Complete (0x0e) plen 6
>   0000: 01 25 0c 00 60 00                                 .%..`.
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>   0000: 3d 52 07 a4 07 00 18 cc 02 00 00 00 00            =R...........
> > HCI Event: Command Status (0x0f) plen 4
>   0000: 00 01 05 04                                       ....
> > HCI Event: PIN Code Request (0x16) plen 6
>   0000: 3d 52 07 a4 07 00                                 =R....
> < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
>   0000: 3d 52 07 a4 07 00 2b 53 65 72 76 69 63 65 20 22   =R....+Service "
>   0010: 6f 72 67 2e 62 6c 75                              org.blu
> > HCI Event: Command Complete (0x0e) plen 10
>   0000: 01 0d 04 12 3d 52 07 a4 07 00                     ....=R....
> > HCI Event: Connect Complete (0x03) plen 11
>   0000: 22 2a 00 3d 52 07 a4 07 00 01 00                  "*.=R......

/etc/bluetooth/pin contains:

0000

I'm not confident the pin number is actually moving across ... bluepin 
never asks for input during the run

Mark





-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
