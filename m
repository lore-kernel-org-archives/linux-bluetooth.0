Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41727E71.3050800@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] question about hci_usb endpoint selection...
References: <416D23A6.3010904@dark-reality.de>	 <1097752849.4640.37.camel@notepaq>  <416EF4B0.6070802@dark-reality.de>	 <1097928414.4911.27.camel@pegasus>  <417149FD.6090700@dark-reality.de> <1098013275.4911.44.camel@pegasus>
In-Reply-To: <1098013275.4911.44.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 17 Oct 2004 16:15:13 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Marcel,

Marcel Holtmann wrote:
| Hi Lars,
|
| I am waiting for the final 2.6.9 release before I put out my next -mh
| patch. So it should be very soon. Otherwise check the Bitkeeper docs in
| the kernel source.

OK, I'll watch it. If I need to get into it before you released, I'll
use Bitkeeper.

|>OK, after digging for an USB API documentation I found:
|>
|>***
|>~ int usb_set_interface(struct usb_device *dev, int interface, int
|>alternate);
|>***
|>
|>The documentation/manpage says:
|>
|>***
|>Note that in the Linux USB subsystem, bandwidth associated with an
|>endpoint in a given alternate setting is not reserved until an URB is
|>submitted that needs that bandwidth. Some other operating systems
|>allocate bandwidth early, when a configuration is chosen.
|>
|>This call is synchronous, and may not be used in an interrupt context.
|>Also, drivers must not change altsettings while urbs are scheduled for
|>endpoints in that interface; all such urbs must first be completed
|>(perhaps forced by unlinking).
|>***
|>
|>Questions I'm unable to answer myself right now:
|>
|>1. are we in an interrupt context? (don't think so)
|
|
| You can check this with in_interrupt() and I think we are in interrupt
| context when notify() is called.

OK, I'll check. This is bad, because we can't use usb_set_interface
directly in the notify() function. Do you have an idea how we can solve
this? I still don't understand the structure of hci_usb well enough, but
I'm improving :)

We should be able to "mark" the change and do the switch somewhere else,
but...? This is kind of new stuff for me, but I'm eager to learn. Maybe
I should get this book about linux kernel programming...

|>2. how can we make sure that there are no pending urbs? maybe we have to
|>change the setting asynchronus in the transmit function or something? Or
|>should we unlink pending SCO URBs?
|
|
| I think you can't. We have to unlink them and resubmit them, but I don't
| know this for sure.

Looking at the docs, I think we have to unlink and resubmit them. Thing
is, if we can't call usb_set_interface from within notify() anyway,
maybe there's a nice workaround for both problems by doing it in the
tx/rx handlers or something?

|>3. can we safely assume that the endpoint ID's that are stored in
|>isoc_in_ep and isoc_out_ep are always the same for different alternate
|>settings?
|
| Check the HCI USB specification. I think it talks very clear how
| endpoint IDs must be numbered.

Will do so.

|>4. I think we *can* assume that alternate setting 1 matches for 0x0?40
|>voice modes, while alternate setting 2 matches for 0x0?60 voice modes,
|>as you (Marcel) wrote that it's defined in the BT-USB-HCI specs.
|
|
| Look at the specification. The number of SCO connection and the current
| voice setting defines the alternate setting.

Aaaah I see! Thanks for beeing patient with me :)

I won't have time until monday, but I'll jump into the doc's again I think.

I maybe writing me students final work (bacheloer) about proper
implementing alsa/bt/sco, so it's possible that I'll invest very much
time into this in the next few month. Nothing for sure though, yet.

CU,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBcn5wQWC6DTWkDAoRAr2SAJ0UIDX8ZGbHFxhvxxLkpr1J8KnS4QCgtzcY
TxGFJnkeen/0H88PzwMIVNc=
=R+Qk
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
