Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <47B5B3FA.1050107@wurmsdobler.org>
References: <47B5B3FA.1050107@wurmsdobler.org>
Date: Fri, 15 Feb 2008 19:51:59 +0100
Message-Id: <1203101519.7664.552.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Missing: big picture
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

Hi Peter,

> For the past few month help requests come up repeatedly on this list, 
> requests that are related to audio, headset, pass key - you name it. In 
> my opinion this is due to a missing overall understanding rather than to 
> unpredictable code behavior. At least for me, I miss an overall document 
> describing the architecture to a new user's eyes.
> 
> I recognise that all the developers do a great job implementing features 
> and advancing fast. They do a great job, but are far too deep in the 
> matter in order to understand the comprehension difficulties of a 
> newcomer. Certainly all reasons why there is no "big picture". The 
> sparse collection of Wikis does not help either. Of course, look at the 
> code is always an option, but it is time consuming.

and that is the point why developers should never write documentation,
because they always have a total different view point. I would prefer to
have some newbie starting some documentation and let the developers
assist him on question. People with no knowledge do the best manuals,
but they need guidance/help from the developers to distinguish right
from hacking and in some cases even actual bugs.

> Where is my problem? I see, on the one hand there is the well defined 
> stack model. On the other, there is a collection of demons in user space 
> and a bunch of kernel modules. But how does is hang together? What is 
> the designed start-up sequence?

I gave a lot of presentation at various conferences in the past and they
talk all about the stack design. The slides are all public.

> A bluetooth chip would be connected over different physical media such 
> as UART, USB and SDIO to a linux host. Is it correct to assume that the 
> respective kernel drivers will abstract the different physical transport 
> media into the HCI interface?

Yes.

> By some magic (to me) hciattach creates socket interfaces hciX. I have 
> added a service at start-up that does this, as in my case, the BC4-ROM 
> will be connected permanently to the mx27 host processor. Why is a 
> hciattach process required to maintain the hci0 interface? There is no 
> equivalent thing for ethernet, is there? Or would it be the job of hcid 
> anyway?

The hciattach is only needed in case of UART chips. USB and SDIO drivers
create the hciX interface directly. The hciattach case is needed since
you have to tell the kernel somehow to use an existing serial device
(like /dev/ttyS0) and use the Bluetooth H:4 (or BCSP etc.) protocol on
top of it. If you have USB or SDIO this step is not needed.

> What is exactly the role of hcid? Is it to create hciX interfaces, or 
> redirecting all communication coming in by the dbus to the proper hciX 
> interface?

The hciX interfaces are created by the Bluetooth subsystem inside the
kernel. Every driver registers a hci_dev device which becomes the next
hciX interface.

The hcid is the master daemon that handles additional device
initialization and pairing requests. This was its original task when
BlueZ 1.x and 2.x where released. With BlueZ 3.x we extended hcid to
expose a full D-Bus interface that allows you to control all device
settings.

> Assuming that hcid is involved in the creation of hciXes, does the sdpd 
> have to be started afterwards, or before?

No. The sdpd is a relic from old times. We don't use that anymore and
the main reason for it is technical. It had race conditions when
interacting with hcid. The full SDP server is now included in hcid. And
starting hcid with -s will enable it.

We only keep the sdpd binary around for reference. Actually with the
latest bluez-utils you would have to use --enable-sdpd to enable its
compilation. But again, it has been replaced with hcid. So don't use it
anymore.

> If passkey-agent and auth-agent are required but not supported, why is 
> their service simply not included into the bluez-utils, but is offered 
> by kde or gnome implementation, or even in QTopia? Because it involves 
> user invention?

A system process running as root should not hack around a user process
that owns the X session. The passkey and authentication agent concept is
an abstraction and allows us to have a way to tell hcid that a progress
that could display a dialog box and asked for PIN input is available
now. It is the clean daemon versus UI separation.

The GNOME and KDE desktops deliver agent implementation and it is easy
to write your own. This is what passkey-agent.c and auth-agent.c are
for. They give you a quick overview on how it has to be done.

The other advantage with abstracting the agents over D-Bus is that it
allows you to write agents in any programming language that has D-Bus
bindings. So a passkey agent in Python is about 20 lines of code or so.

> Assuming that, like in my case, a BT chip is connected permanently to 
> the mx27 host processor, what is supposed to happened in what order? Who 
> is involved and what configuration files are required?

Depends on the type of physical connection. The embedded world is always
a little bit more complex. Mostly these are UART or SDIO. So in the SDIO
case you start "hcid -s" and then make sure that you have agents that
suit your needs. You might have to write them by yourself.

In case of UART it is a little bit more trickier. In the simple way, you
also start "hcid -s" and then call hciattach with the right parameters
(don't ask me which they are, it depends on your board). However the
order of hcid and hciattach doesn't really matter.

There are some specific UART cases (for example the Nokia N8xx) in which
case they have their own kernel driver. Even if it is actually an UART.
If you have a kernel driver that drives your Bluetooth chip attached via
UART, you don't need the hciattach step. If the UART is exposed as
normal serial port, you do. As simple as that.

> In the case of a headset, what are the stages the entire bluetooth stack 
> is going through from the moment you set the headset into pairing mode? 
> What demons must be running, and how would the state diagram look like?

You need to enable the audio service. See /etc/bluetooth/audio.service
and change autostart. Then hcid will take care of actually starting the
audio service.

The configuration of your audio device via ALSA or GStreamer or directly
in case you use SCO over PCM is up to your UI application. Here you have
the same as for the agents, you might have to write your own one.

> Now in case of an audio stream being sent from an audio player, how are 
> the PCM sample routed to the BT headset (both with PCM data transfer 
> over SCO using a dedicated SSI connection between CPU and BT chip, or 
> piping the PCM data through HCI)?

In case of PCM, the daemons do nothing. It is up to you to hook up the
PCM interface of your Bluetooth chip with the sound system of your
embedded device.

In case of HCI, you can use ALSA or GStreamer and the plugins will make
sure the audio data goes to the SCO socket (for HFP/HSP) or L2CAP socket
(for A2DP).

> One thing I can say, once I understand all that with the help hopefully 
> of the list, I will write it up and make nice drawings. The downside 
> could, once they are finished they are obsolete.

Go ahead and use the wiki.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
