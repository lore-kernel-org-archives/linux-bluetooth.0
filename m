Return-Path: <justin-qt-dated-1065590530.6b5959@affinix.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] dtl1_cs suspend bug
Date: Tue, 23 Sep 2003 14:09:47 -0700
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
References: <200309220408.04569.justin-qt@affinix.com>
	<200309230508.07932.justin-qt@affinix.com> <1064319593.1619.10.camel@pegasus>
In-Reply-To: <1064319593.1619.10.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309231409.47300.justin-qt@affinix.com>
From: Justin Karneges <justin-qt@affinix.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Tuesday 23 September 2003 05:19 am, Marcel Holtmann wrote:
> don't expect too much, because I think this problem is not solveable
> with 2.4 and I am waiting for the final 2.6 with the changes in the
> PCMCIA subsystem before I ever start working on this again.

This is unfortunate, as it pretty much rules out this ever being fixed on t=
he=20
Zaurus.  Do you think this problem is really a bug in the PCMCIA subsystem?

=46rom my work the other day, it appears that the card is not properly bein=
g=20
reset.  In fact, you can break the driver by running 'cardctl reset'.  This=
=20
used to leave bluez in a funny state: hci0 still considered UP, but 'hcitoo=
l=20
scan' would hang or return odd results.

One thing I tried was unregistering / registering the hci dev in response t=
o a=20
pcmcia reset event.  This would clean things out on the bluez end, such tha=
t=20
'hcitool scan' would exit immediately saying there is no device.  This is=20
correct, as 'hciconfig' would report the device as DOWN.  Issuing 'hciconfi=
g=20
hci0 up' would timeout.  Interestingly, it seems bluez tries to bring the=20
card up automatically, which is kind of cool (when I 'hciconfig' shortly=20
after 'cardctl reset', I would see the state as "DOWN INIT RUNNING" or some=
=20
such, and then moments later just "DOWN").

So it seems what needs to be done is for the card to be reset completely.  =
I=20
don't know what kind of state 'cardctl reset' leaves the card in.  It looks=
=20
like it is a serial-based interface to the card, so even being off by one=20
byte could be a problem.  Perhaps the card still considers itself to be=20
active and in mid-use, and so reregistering the hci dev causes bluez and th=
e=20
card to become out of sync.  Unlike other hardware, such as memory cards, a=
=20
bluetooth card is pretty much unusable after a suspend, so I think a full=20
reset (of both bluez and the card itself) is in order.

To reset the card, I tried calling: dtl1_release, dtl1_config.  This didn't=
=20
appear to solve anything.  Then I tried putting that into the insertion eve=
nt=20
code, so it became "config, release, config".  This failed also, making the=
=20
driver unusable even upon card insert.  This seems to imply that your code =
is=20
not doing proper cleanup or resetting.  Shouldn't it be safe to call "confi=
g,=20
release, config, release, config, release, etc" any number of times?

=2DJustin
