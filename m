Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A22C0B.4050008@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] audio problems with a2play
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
Date: Mon, 22 Nov 2004 11:12:27 -0700

Guys

The iPhono stopped producing recognizable sound using a2play a few days 
ago... but even the most successful transfers with a2play have been 
mixed with static.

I'm convinced we need a media payload header. Page 23 of the A2DP spec 
shows how the media payload header should look.

I tried changing a2play to send media_payload_header instead of 
sbc_frame_header and I got "quiet" noise when I did that. I tried 
various frame counts with no luck.

I need to get a better idea of what is going on...

* which frame exactly is a2play's calc_frame_length measuring? Is it the 
same "sbc frame" that they're talking about in a2dp p.24?

* how did you decide to put 2 0xff bytes in the CSRC section of the 
media packet header? Why isn't this CSRC a multiple of 4 bytes like the 
spec suggests on avdtp p. 46?

* what is the CSRC? (spec says "The CSRC list identifies the 
contributing sources for the payload contained in this packet")

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
