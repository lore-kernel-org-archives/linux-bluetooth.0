Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <405638DD.2080000@handgranat.org>
From: Sunnan <sunnan@handgranat.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bthid on ppc
References: <20040307221349.GA1930@stag.mark-and-erika.com> <1078704798.15279.3.camel@pegasus> <20040308054000.GB1930@stag.mark-and-erika.com>
In-Reply-To: <20040308054000.GB1930@stag.mark-and-erika.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 16 Mar 2004 00:14:37 +0100

Ben Wilson wrote:
> Does this mean this is a known issue? The HID program from
> http://www.visi.com/~pmk/msbtkb-linux.html wouldn't even compile
> for me, I figured it may be the same type of issue.

Seeing this thread made me take up my old efforts to get my Apple
wireless mouse to work on my Debian-running iBook g4 (with built-in bt),
but it can't be the same type of issue since I did get Peter's bthid
mentioned above (same name, different program than in BlueZ cvs) to
compile (had to change some includes and so on) and work, it doesn't
crash but I could only use the mouse for a few seconds at a time, then
it would freeze for a few seconds, then work a few seconds, and so on
(and I mean full seconds, not figuratively speaking).
That was yesterday. Today I didn't even get that working, I managed to
move the cursor for just a short blink, maybe half a second or so.

That error could be in sdpd (that's what Peter's bthid's error messages
hint at, or so I interpret them) or in that bthid, or somewhere else, I
don't know.

So, anyway, it's not the same issue. BlueZ cvs bthid just dies silently
for me (even though the other tools, sdptool, hcitool etc works fine).

one love sunnan


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
