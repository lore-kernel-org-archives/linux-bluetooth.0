Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] audio problems with a2play
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41A22C0B.4050008@xmission.com>
References: <41A22C0B.4050008@xmission.com>
Content-Type: text/plain
Message-Id: <1101148767.26578.9.camel@pegasus>
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
Date: Mon, 22 Nov 2004 19:39:27 +0100

Hi Brad,

> The iPhono stopped producing recognizable sound using a2play a few days 
> ago... but even the most successful transfers with a2play have been 
> mixed with static.

last time I tested it, it worked quite well.

> I'm convinced we need a media payload header. Page 23 of the A2DP spec 
> shows how the media payload header should look.
> 
> I tried changing a2play to send media_payload_header instead of 
> sbc_frame_header and I got "quiet" noise when I did that. I tried 
> various frame counts with no luck.
> 
> I need to get a better idea of what is going on...
> 
> * which frame exactly is a2play's calc_frame_length measuring? Is it the 
> same "sbc frame" that they're talking about in a2dp p.24?

It is the SBC frame length without the 4 byte SBC header.

> * how did you decide to put 2 0xff bytes in the CSRC section of the 
> media packet header? Why isn't this CSRC a multiple of 4 bytes like the 
> spec suggests on avdtp p. 46?
> 
> * what is the CSRC? (spec says "The CSRC list identifies the 
> contributing sources for the payload contained in this packet")

Actually I already tried to follow the AVDTP and A2DP specification, but
with no luck. My Aiptek headphone doesn't want to play nicely and I have
no clue how they got this thing qualified by the Bluetooth SIG.

>>From my testing I saw that my headphone only cares about the CC value of
the AVDTP media header. All other values are not used.

The 0xff 0xff in front of the SBC header are not part of the AVDTP media
header. It is already the media channel payload. This follows non of any
specification I know of. And I only know that values, because I sniffed
a connection between the sender device and the headphone with a protocol
analyzer.

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
