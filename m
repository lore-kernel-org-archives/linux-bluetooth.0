Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41B7113A.9030701@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: snd-bt-sco problem
References: <20041206225609.GA1177@zeus.galaxy.org.uk> <cp3mkk$m7t$1@sea.gmane.org> <20041208103449.GC2258@zeus.galaxy.org.uk>
In-Reply-To: <20041208103449.GC2258@zeus.galaxy.org.uk>
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
Date: Wed, 08 Dec 2004 15:35:38 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Chris Boyle wrote:
| On Tue, Dec 07, 2004 at 08:37:56AM +0100, Sebastian Roth wrote:

| As mentioned in reply to Brad Midgley, this established a successful
| connection (pressing the volume buttons affected alsamixer), but I
| still couldn't actually get any audio to flow in either direction,
| despite continuous SCO data packets seen with hcidump, although only in
| one direction.

I just wanted to point out that the volume control messages are sent
over the HCI channel, while audio data is send over the SCO channel.
It's likely that if there's a problem with the SCO data transfer, the
volume buttons will still work.

With my headset, I can hear the volume increasing because the noise gets
loader.

You could also try the "loopback" mode; just don't use any audio
software, but activate the loopback i.e. in alsamixer by unmuting and
then press the headset button to connect.

Audio should than be routed back to the headset so you can "hear
yourself". Makes it easier to determine whether there's a bluez/sco
problem or something with your audio setup :)

good luck,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBtxE6QWC6DTWkDAoRAqVIAKC+2cyao0HoZPqBoK1rbwO6JbIHWwCgtEBN
lLLFf5eU+dU34SiO3lwc17g=
=G1e+
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
