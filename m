Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41AE59AC.5000505@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco2
References: <200412010839.06669.mailsp@sebastian-eichner.de>	 <200412010943.33419.mail@sebastian-eichner.de>	 <1101894192.18840.44.camel@pegasus>	 <200412011224.29191.mail@sebastian-eichner.de>  <41ADAC67.10706@suche.org>	 <1101901302.18840.72.camel@pegasus>  <41ADB1C2.8070805@suche.org> <1101902920.18840.79.camel@pegasus> <41ADD32D.2060502@suche.org> <41AE065F.9040601@xmission.com> <41AE281E.3050908@suche.org> <41AE3871.1000608@xmission.com> <41AE3CC7.4070804@suche.org>
In-Reply-To: <41AE3CC7.4070804@suche.org>
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
Date: Thu, 02 Dec 2004 00:54:20 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bluetooth wrote:
| Brad Midgley wrote:
|
|> We can continue to maintain a daemon that does not support these
|> features and works well for embeded systems. What applications will
|> you use the headset with and how will they start/stop/detect connections?
|
|
| Currently kphone sjphone, kphone vor example try to open the dsp device
| on inbound or outbond connection if we can signal btsco that dsp is open
| this would be sufficent or not ?

There are several reasons why a Headset can be "connected" to the DSP
(that is, open the SCO channel).

We discussed those earlier (I think on the old mailing list - is there
an archive?), and it pretty much boiles down to:

1. user presses button on the headset. Headset sends some RFCOMM stuff
to the server, and that one should open the SCO channel
2. the server opens the SCO channel

to indicate a ring on the headset there's also an RFCOMM signal that
should, following the BT specs, used to signalize the user "incoming
call" so that the user can connect the headphone and take the call by
pressing the button.

In fact I think a phone software must be able to use some "general"
interface to connect to the btsco daemon to signal "incoming call" and
recieve a "take call". That's what I'd expect of a real good phone
application supporting a headset - it should work excatly like my phone
connected to the headset.

But of course, there are many ways a headset could be used, so I think
we also need an "auto connect" mode that opens the sco connection when
the dsp is opened - like you described. Like the "auto-pickup" function
of a cellphone when in car mode or headset connected...

So the user must be able to select what his headset should do:

a) idle until user presses connect button, than connect
b) connect when audio interface is opened

(b) has some problems because there's a connection delay, and some
programs might open/close devices often, so maybe we need a disconnect
timeout (when device is disconnected, keep SCO running in case it
immediatly re-connects)

Just my thoughts...

|> the kernel needs changes in bluez.
|>
|> Marcel explained it once: "To get more than one SCO channel working
|> the hci_usb driver must be fixed to dynamicaly change the alternate
|> settting."
|>
|> again, I don't know SCO well enough to understand this, but it sounds
|> fundamental.
|>
|> the btsco in the kernel also needs to be changed to allow for multiple
|> simultaneous audio streams.
|
|
| Hm sounds bad :-(

Well it depends. What sounded more badly was his note about "the whole
hci_usb is a mess and should be rewritten".

The problem with hci_usb and sco is that you need to select the correct
"alternate setting" depending on the bitrate that is needed for *all*
sco channels together. So i.e. three 16 bit sco connections lead to the
48bit endpoint (just gussing, but it's something alike).

So the endpoint depends on the number of channels and of course on the
bitrate (there are several codecs that only use 8bit).

How the endpoint could be set is sorted out in a "rough style", but
there are several issues when it comes to interupts and not-yet-send
data in the USB urb's that I don't know how to fix right now. We have a
notify that tells the hci_usb about new made connections, and a counter
for sco connections. But are unable to simply change the alternate
settings as long as there are unsent USB packages, and we are unsure
where to safely switch the setting.

I'd have to dig deeply into it and I don't have the time right now. I
hope I'll have some more soon, but... *sigh*

Please don't focus only on your use case for btsco but remember that
there are very different topics that have to be addressed here. If you
are looking at embedded devices and trying to reduce dependencies than
we should think about one full-featured *and* one light-weight program
to solve our problems the best way for different platforms and needs.
And have a look what the BT specs say about how the headsets should
operate (audio connection stuff)

regards,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBrlmrQWC6DTWkDAoRAmL3AJ9+GYhlERvP1kejG2RN01qePkcmMwCgrqz+
mK8aBQ/E3oW8uoZhJNSzQhI=
=dweH
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
