Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44D24BD3.4010404@xmission.com>
Date: Thu, 03 Aug 2006 13:17:39 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <002a01c6b5e5$5e6b0cd0$9d0cc70a@dlh.st.com>	<44D0350A.8090904@xmission.com>	<3837d8b10608020729i5bab5ea6vbc18b0ad502b11de@mail.gmail.com>	<44D17895.6050001@xmission.com>
	<3837d8b10608030747v551aa4a7t719aa57aa5ffc986@mail.gmail.com>
In-Reply-To: <3837d8b10608030747v551aa4a7t719aa57aa5ffc986@mail.gmail.com>
Subject: Re: [Bluez-devel] Bluetooth Headset Error
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

keith

> I took you suggestion and this corrected the problem.  Attached is a patch.

thanks for taking the time to see this was the right workaround. i
merged it.

> Now on to other problems.  I can play audio out of xmms, but it will
> only play the first track I play in XMMS,  Once I go to another track,
> the a2dp connection stays, but all I hear is silence.    I am using just
> a bunch of different sample audio files (not really a standardized
> collection like most people have), but I tested it with quite a few
> different combinations.  Here is the debug output

some headsets don't seem to like the quick close-reopen that results
from using xmms and others. gxine seems to be the worst in that it opens
the audio device three times in succession (closing between). the
typical headset is not amused and often won't respond until it's
powercycled.

a2dpd solves this problem... it isolates the headset from audio device
open/close ops and gives us more robust behavior for headset connections
to come and go without affecting the client.

> Just as a side note (maybe this deserves a new thread).   I'm been
> looking a lot through the archives, but I am still wondering what is the
> current state of progress in the bluetooth-alsa project?  What work
> still need to be done?   I have interest in furthering the project and
> more notably, my employer also has interest.   We are working on support
> for embedded arm platform and are looking for integration possible with
> gstreamer as most of our audio framework will use gstreamer. 

alsa is great for the desktop but elsewhere it's problematic. embedded
platforms shouldn't have to spend 1MB of ram and flash for a layer that
could be factored out. i'd like to see proper gstreamer plugins (i
started them from a template but didn't put them up yet). this is also a
win for headsets that have an mp3 decoder--using gstreamer the a2dp
source would just send the mp3 as-is and can save on batteries *and*
avoid the fidelity problems with reencoding.

this was in another thread. the only comment was that the name "wavez"
is already in use... i think that's ok for a small side project like
ours. this is where we should be headed.

- minimal update to btsco documents to bring in line
- make a btsco snapshot release .43
- use new wavez sourceforge project for alsa (both sco and a2dp)
plugins, for a2play test code and eventually gstreamer plugins
- create wavez as a cvs project (was tempted by svn but there's a
learning curve for everyone)
- leave out libsbc from the new project so we cleanly use the standalone
library
- eventually remove pieces from bluetooth-alsa's btsco project (alsa
plugins etc) to leave it mostly as it originally was, just the kernel
sco audio
- obviously refactor the documentation, simplifying btsco and updating wavez

brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
