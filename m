Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4269FA9A.6000308@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] btsco on gumstix/infineon
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
Date: Sat, 23 Apr 2005 01:34:50 -0600

Hi

I have been making changes to our btsco daemon, build scripts, and my 
copy of the gumstix buildroot to cross-compile btsco for arm. I've got 
everything built on the gumstix. I have a couple of things to clean up 
in the build process, but with some manual tweaking it's good enough to 
run the daemon and establish the control connection to the headset. For 
some reason, examining the headset to discover the channel with sdp 
fails, so I have to specify the channel number:

# btsco -v 00:03:89:77:9A:E9 1
btsco v0.4a
Device is 0:0
Voice setting: 0x0060
RFCOMM channel 1 connected

When I try to send audio using madplay, I get:

speaker volume: 0 mic volume: 0
driver is in use
Can't connect SCO audio channel
: Device or resource busy

Does this mean bluez won't do sco on infineon?

My stereo set is still on backorder. Floating point is done in software 
on arm... as long as the cpu doesn't melt down, it should be able to do 
stereo encoding/transmission I think.

I had to switch lm from accept to accept,master but now gumstix won't 
connect to my bluetooth access point. argh... have to plug it in to my 
machine to reach it :)

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
