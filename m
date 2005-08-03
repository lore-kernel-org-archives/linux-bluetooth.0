Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] DUN lookup on Samsung D500 raises SIGSEGV
In-Reply-To: <42F0C263.8070606@teleline.es>
Message-ID: <Pine.LNX.4.33.0508031910480.4458-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 3 Aug 2005 19:12:59 +0200 (CEST)


Hi,

without realy knowing the internals this looks to me like BlueZ does not
support 32 Bit UUIDS. It is a little bit unusual to use 32 Bit UUIDs but
legal. So BlueZ SDP Parser shall support them.

Ciao,

Peter

On Wed, 3 Aug 2005, Pedro Monjo Florit wrote:

> Hi folks:
>
> I am having problems with a Samsung SGH-D500 mobile phone. I do the
> following:
>
> pm@PM:~/Development/picdproto> sdptool search DUN
> Inquiring ...
> Searching for DUN on 00:12:47:63:FB:2A ...
> Service Name: Dial-up networking
> Service RecHandle: 0x10002
> Service Class ID List:
>       "Error: This is uuid32" (0x00001103)
> Protocol Descriptor List:
>       "Error: " (0x00000100)
>       "Error: " (0x00000003)
>         Channel: 4
> Segmentation fault
>
> I have attached the output of "hcidump -X".
>
> Using gdb, I have found that the offending instruction is in
> bluez-libs-2.xx/src/sdp.c. It is produced in the library function
> sdp_get_profile_descs(), in the line
>
> 	...
> 	sdp_data_t *pVnum = seq->val.dataseq->next;
> 	...
>
> It seems that the problem is that "seq->val.dataseq" points to an
> out-of-memory address (in my case, it was 0x1a), so trying to get the
> "next" field raises SIGSEGV.
>
> I do not quite understand all bluez structures (sdp_data_t and similar),
> so I do not know exactly what went wrong. My guess is that the SDP
> information sent by the mobile phone was corrupt or bogus and that the
> bluez SDP code did not handled it correctly.
>
> I hope that this information could help to fix this.
>
> Regards,
>
> Pedro Monjo
>
>
>
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
