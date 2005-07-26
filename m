Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: John Gruenenfelder <johng@as.arizona.edu>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Can't get btsco to connect to Plantronics M2500 headset
Message-ID: <20050726225514.GA26245@as.arizona.edu>
References: <20050726042812.GA16828@as.arizona.edu> <42E5CA58.4030408@xmission.com> <20050726062958.GA17805@as.arizona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050726062958.GA17805@as.arizona.edu>
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
Date: Tue, 26 Jul 2005 15:55:14 -0700

On Mon, Jul 25, 2005 at 11:29:58PM -0700, John Gruenenfelder wrote:
>On Mon, Jul 25, 2005 at 11:30:00PM -0600, Brad Midgley wrote:
>>
>>I've looked at your messages and I can't think of many other things. Do 
>>you have other bluetooth devices you can try? Can you easily try it with 
>>a 32-bit kernel/userland?
>
>I do have an old laptop that I can test with.  I will try this tomorrow.  I
>don't actually intend to use the headset on my 64bit machine, but as it is my
>desktop, it's what I use for testing.  So if it works with a 32bit machine,
>that will be just fine.

Okay, I tried to use the headset on my laptop.  Unfortunately, the result was
the same.

I did find that when I first turned on the headset with the bluetooth dongle
plugged into the laptop, I saw the "pin_request" events in the hcidump
output.  After reading up on what the link key is and how it is generated, it
now seems to me that this is just fine.

If I understand correctly, the first time a device is connected to a bluetooth
host, they will negotiate the link key.  This usually involves transmitting
the PIN and generating the encryption key.  After that, this procedure no
longer needs to be done.  This would explain why I never saw those messages
again on my other machine.  The link setup had already been performed.

So... if the link status is fine, and the device is properly paired... what
could be wrong?  If it weren't for the fact that I breifly had it functioning,
I would strongly suspect that the headset is broken.

Is such a breakage possible, where the radio/link is working, but everything
past that doesn't function?

I don't know anybody else with anything bluetooth (even a phone), so it's hard
for me to test this.  My only other option right now is the tiny iota of
information I can get out of Windows.  In XP, the pairing succeeds, but when I
check the headset "Properties" and check the "Services" tab, it pauses for a
second, but lists nothing.  If anybody here has any idea what, if anything,
should be listed in that tab, please let me know.  Otherwise I'll try to
contact Plantronics support and see what they say.


-- 
--John Gruenenfelder    Research Assistant, Steward Observatory, U of Arizona
                        johng@as.arizona.edu
Try Weasel Reader for PalmOS  --  http://gutenpalm.sf.net
"This is the most fun I've had without being drenched in the blood
of my enemies!"
        --Sam of Sam & Max


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
