Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Message-ID: <20031106014519.GA31868@schnell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Peter Klausler <pmk@cray.com>
Subject: [Bluez-users] bthid updated
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 5 Nov 2003 19:45:19 -0600


I've updated my bthid daemon with some tweaks that
may or may not have been necessary to get the new
Apple Bluetooth keyboard to work, and a new "-p"
option that enables regular pinging after inactivity,
which appears to be the key to keeping the Microsoft
keyboard from going to sleep so hard that it needs
to be power-cycled.  Michal Semler suggested the
technique, and I wish that I had thought of it before
I broke the keyboard's battery compartment cover from
overuse.

The code is linked to http://klausler.com/msbtkb-linux.html,
a web page that badly needs revamping, I know.

I'm *very* happy with the new Apple keyboard, by the way.
It's affordable, solidly built, has an ON/OFF switch (!), and
is much more amenable to the Dvorak layout.  But I still prefer
the 5-button Microsoft mouse with its scroll wheel to Apple's
one-button Bluetooth mouse.

The Microsoft and Apple offerings remain the only Bluetooth
keyboards of commercial availability known to me.  Has anyone
seen another?

-- 
Peter Klausler, Sr. Principal Engineer, Cray Inc.           ',.PY FGCRL
pmk@cray.com, peter@klausler.com, http://klausler.com       AOEUI DHTNS
O/S kernel, compilers, simulation, and ISA design           ;QJKX BMWVZ


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
