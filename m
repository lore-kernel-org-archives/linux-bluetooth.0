Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1114345112.10706.64.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Comments about the Logitech/HP stereo headphones
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
Date: Sun, 24 Apr 2005 14:18:32 +0200

Hi Folks,

since the progress on the A2DP support stalled and because the problems
with the Logitech/HP headphones still exists, I thought that it is time
to buy one of these by myself. I now have the Aiptek, Bluewalker and the
HP headphones at home for testing. The first two are GCT based and the
last one is Zeevo based.

All GCT based headphones are working fine and they have the nice SBC
over RFCOMM support for testing. They are not picky about any timing
related transfers and they cache the SBC stream. To deal with the Zeevo
based headphones you can only talk AVDTP and you need to get the timing
right. Otherwise the sound is messed up.

So what I have done so far is that I extended the pcm_a2dp ALSA plugin
in the utils CVS repository with the ability to cache the connection.
This is needed, because players like xmms and bmp close the PCM every
time they change the track. If we close the AVDTP channel it results
into closing the ACL link and this is not what we want. The only problem
at the moment is that this plugin only supports SBC over RFCOMM and it
doesn't care about the timing. This means that if you change a track it
can take 1 or 2 seconds before the headphones reacts, because parts are
already cached. This is a problem (or feature) of the GCT based devices.

To fully support all A2DP headphones (including Logitech/HP) this plugin
needs a AVDTP implementation. I have a hacked one on my development
system and it works fine with the GCT headphones. The code is a little
bit messy, but in general it works. It is fully event driven and so it
deprecates the idea of the AVDTP library. It is a lot easier to do it
directly inside the plugin. I need to cleanup the code and submit it to
the CVS when there is a little bit more time.

I also got first results with the HP headphone by adding an usleep(2500)
for every SBC frame. It is also needed to pack as most SBC frames into
an AVDTP frame as possible. In my case this was up to eight. So this is
all about the timing. The perfect thing now would be if we can tell ALSA
to time everything for us. Problem is that I am not an audio expert and
also not an ALSA expert. Maybe the SBC encoder should return/store the
time the SBC frame is encoded for.

Comments? Ideas?

And btw for testing the pcm_a2dp plugin you need ALSA 1.0.9-rc2 and
an .asoundrc config file like this:

	pcm.bluewalker {
	        type a2dp
	        bdaddr "00:0B:0D:xx:xx:xx"
	}

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
