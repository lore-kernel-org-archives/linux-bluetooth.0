Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 16 Sep 2007 22:40:50 -0700 (PDT)
From: Johan Brannlund <johan_brn@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <790151.13379.qm@web50209.mail.re2.yahoo.com>
Subject: [Bluez-users] SCO headset with bluez audio service
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi. I have a Motorola H300 headset that works reasonably well with
headsetd (including using it with Twinkle, a SIP softphone). I've now
attempted to get it running with the bluez audio service - I'm using
bluez-utils 3.18 in Ubuntu Gutsy.

Playing sounds using "mplayer -ao alsa:device=bluetooth file.mp3" works
well with the bluez method, but when I start Twinkle, I don't get any
sound and Twinkle pops up a dialog saying "Unable to access speaker.
Unable to access microphone." When Twinkle starts, the audio
service spits out these messages:

audio[16573]: Accepted new client connection on unix socket (fd=8)
audio[16573]: Package PKT_TYPE_CFG_REQ:0
audio[16573]: State changed /org/bluez/audio/device0: DISCONNECTED -> 
CONNECTING
audio[16573]: /org/bluez/audio/device0: Connecting to 00:0B:2E:7E:22:37
 channel 2
audio[16573]: State changed /org/bluez/audio/device0: CONNECTING -> 
CONNECTED
audio[16573]: /org/bluez/audio/device0: Connected to 00:0B:2E:7E:22:37
audio[16573]: State changed /org/bluez/audio/device0: CONNECTED -> 
STREAM_STARTING
audio[16573]: SCO socket opened for headset /org/bluez/audio/device0
audio[16573]: SCO fd=10
audio[16573]: fd=10, fd_opt=1, pkt_len=48, sample_size=2, rate=8000
audio[16573]: 30 bytes sent
audio[16573]: 22 bytes sent
audio[16573]: State changed /org/bluez/audio/device0: STREAM_STARTING
 -> STREAMING
audio[16573]: Accepted new client connection on unix socket (fd=11)
audio[16573]: Unix client disconnected (fd=8)
audio[16573]: State changed /org/bluez/audio/device0: STREAMING -> 
DISCONNECTED
audio[16573]: Package PKT_TYPE_CFG_REQ:0
audio[16573]: State changed /org/bluez/audio/device0: DISCONNECTED -> 
CONNECTING
audio[16573]: get_handles_reply: Unable to get handle array from reply
audio[16573]: State changed /org/bluez/audio/device0: CONNECTING -> 
DISCONNECTED
audio[16573]: Unix client disconnected (fd=11)
audio[16573]: Accepted new client connection on unix socket (fd=8)
audio[16573]: Package PKT_TYPE_CFG_REQ:0
audio[16573]: State changed /org/bluez/audio/device0: DISCONNECTED -> 
CONNECTING
audio[16573]: get_handles_reply: Unable to get handle array from reply
audio[16573]: State changed /org/bluez/audio/device0: CONNECTING -> 
DISCONNECTED
audio[16573]: Unix client disconnected (fd=8)

Does anyone know what the problem could be? Could it have something to
do with trying to use the same alsa device for both input and output?

Thanks in advance,

Johan



       
____________________________________________________________________________________
Be a better Globetrotter. Get better travel answers from someone who knows. Yahoo! Answers - Check it out.
http://answers.yahoo.com/dir/?link=list&sid=396545469

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
