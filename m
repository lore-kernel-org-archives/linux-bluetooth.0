Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Jouni.Lohikoski@iki.fi" <jlohikos@cc.hut.fi>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] HID mouse doesnt reconnect after sleep if bemused-bemusedlinuxserver connection is open
Message-ID: <20041017165348.GA292044@kosh.hut.fi>
Reply-To: Jouni.Lohikoski@iki.fi
References: <20041017125132.GA274769@kosh.hut.fi> <1098018136.4911.87.camel@pegasus> <20041017133034.GC274769@kosh.hut.fi> <1098026676.4911.96.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1098026676.4911.96.camel@pegasus>
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
Date: Sun, 17 Oct 2004 19:53:48 +0300

On Sun, Oct 17, 2004 at 05:24:37PM +0200, Marcel Holtmann wrote:
> fine for me as long as you are aware of the side effects of using
> security mode 3.

Well, not all side effects I am aware of.
Couple of weeks ago I read few comments on bluez-users archives, but
maybe didn't quite get what is so bad in security mode 3, except as an
extra layer it brings additional complexity to the implementation and
debugging.

> Check with "hciconfig hci0 revision" (as root) your firmware version of

        HCI 14.3
        Chip version: BlueCore02 (ES2)
        Max key size: 56 bit
        SCO mapping:  HCI

> your dongle, but it is not a HCI 16.x one and so it does not support any
> kind of scatternet stuff and this is maybe the reason why it fails. Use
> "hcidump -x" to check for the real HCI error codes and look them up in
> the Bluetooth specification.
oI did this, but there was nothing to be seen. When Bemused connection
was active, ofcourse there was ACL data going between devices. When the
bemused connection was open but idle, hcidump didn't show anything. Then
I tried to reconnect the HID mouse by pressing mouse button 1. The mouse
woke up (red led started blinking on the bottom of the mouse). Running
hcidump didn't show anything, like hcid wasn't receiving or sending
anything. Doing something on the Bemused client then again showed data
sent and received.

So either bluetooth dongle or hcid desn't see connection requests when
one ACL connection which uses SP profile is open (and in sec.mode 3)

For bemused this is run in rc.local
sdptool add --channel=10 SP

But when HID connection is open and active, bemused connection can be
opened without problems. What I currently quite not understand, is why
other connection type is different that it blocks new connections, but
other one does not. Both uses AUTH+ENCRYPT+MASTER when checked with
hcitool con.


I did try the hciconfig -a and hcitool info <phone> when the mouse had
gone to sleep mode. There was no differences in the outputs, except the
packet counters were ofcourse increased.
But the mouse could not reconnect.

// jouni



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
