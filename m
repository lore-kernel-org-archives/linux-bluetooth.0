Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100806060611o58e38551g45955f7a52cb1430@mail.gmail.com>
Date: Fri, 6 Jun 2008 10:11:27 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20080604200738.GA27091@tango.0pointer.de>
MIME-Version: 1.0
References: <20080604200738.GA27091@tango.0pointer.de>
Subject: [Bluez-devel] Fwd: Summary of the PulseAudio/Bluetooth discussions
	at the BlueZ meeting in Helsinki
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

---------- Forwarded message ----------
From: Lennart Poettering <lennart@poettering.net>
Date: Wed, Jun 4, 2008 at 5:07 PM
Subject: Summary of the PulseAudio/Bluetooth discussions at the BlueZ
meeting in Helsinki
To: luiz.dentz@gmail.com, joao.vita@gmail.com, bnocera@redhat.com,
PulseAudio Discussion List <pulseaudio-discuss@mail.0pointer.de>


Heya!

(Luiz, please forward this to the bluez ML!)

So, here's my summary of the grand plan to get PA and BT working well
together. This is basically the result of the audio discussions during
the BlueZ Meeting we had in Helsinki that ended today. Especially for
you, Jo=E3o-Paulo, this might be very interesting!

There should be two new PA modules, module-bluetooth-discover and
module-bluetooth-device. The former will use D-Bus to connect to the
BlueZ system services and whenever a new BT audio devices appears load
one m-bt-device instance for it. (as a side node: in contrast to linux
kernel modules, PA modules can be loaded more than once at the same
time).

The latter, m-bt-device, then connects to the BlueZ audio service via one
BlueZ specific well known unix socket, configures a connection to the
BT device, gets a BT socket fd passed in via the unix socket and then
hands this over to its RT thread. The code for this would actually be
very similar to module-esd-sink which we ship already. m-esd-s is a
sink for PA that hands data to an existing EsounD server. It's basic
structure is very similar: we first configure the ESD connection from
the main thread via exchanging a few simple packets and then hand the
actual communication socket to the RT thread for the actual work. The
big difference in logic is mostly that the BT module needs to encode
the audio data to SBC/SCO first, while the ESD module just spits raw
PCM to the TCP stream. And then, the timing needs to be implemented
differently.

Neither ESD nor A2DP/SCO provide any reasonable timing
source. However, the TCP socket used by ESD provides flow control
which we misuse for timing estimation. Unfortunately A2DP/SCO doesn't
even provide that, so we need to roll our own timing all the time --
with the exception that for the SCO case we can probably deduce the
remote clock from the time we get the recording packets flowing
in. Since for A2DP we mostly lack recording support we don't have that
clock and we have no other option than just using the raw local clock.
The BT socket uses DGRAM/SEQPACKET as socket type, This should
actually make things much easier than for the m-e-s case, since packet
deserilization is much easier.

Since we only have a single socket for both recording and playback
m-bt-device should register both a sink and a source at the same time
and run it from the same RT thread. This is similar to what module-oss
does, but different from e.g. the alsa modules which run the sink and
the source from seperate threads.

The seperation of m-bt-discover and m-bt-device is very similar to the
seperation between module-hal and module-alsa-{sink,source} or
module-zeroconf-discover and module-tunnel.

To improve the timing estimation, the BlueZ team will add support for
and SIOCOUTQ/SIOCINQ on the BT audio socket. This should tell us how
many bytes are buffered locally. Of course, we still would have no
idea how many bytes are buffered on the receivng side, but it would
help us at least a bit to make our timing more reliable. Also, they
want to add a new sockopt which would allow us to query the BT clock
of the BT device. We can probably assume that the audio clock of the
BT device is dependant or identical to the BT clock. This would allow
us to make sure we stay in sync with the device as much as possible,
even tough we still would have no idea about the actual latency.

The first step to implement is certainly m-bt-device without any fancy
timing. The next step would be m-bt-discover and finally, the fancier
timing estimation should be implemented. And finally the native volume
support should be implemented.

m-bt-device would probably not use D-Bus itself at all. Only
m-bt-discover would.

Eventually the btaudio unix socket should also be used to pass the key
events from the bt head set. I'd need to add a simple subsystem to
pass them on to the application then. Those keypresses would then be
passed to the application inline via the audio API. On one hand I see
that it would be good send the key events inline to make clear to
which audio device they belong. OTOH I have a bad feeling about this
because I don't want to add yet another key event subsystem, in
addtion to XIE, the linux input stuff and even HAL. We need to think
about this a bit more. (It is interesting to note, that having the
sound server forward "pause" and "resume" request to applications is
on the todo list anyway, to allow policy modules to request music
playback stopping on imcoming phone calls and suchlike. So doing the
full "audio key" set of keypresses would be a simple extension of
that.)

Marcel, Johan, Luiz, Marc-Andr=E9, Claudio, did I miss anything?

Lennart

--
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4



-- =

Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
