Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Sep 2009 20:32:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"marcel@holtmann.org" <marcel@holtmann.org>
Subject: Re: HFP - A2DP in BlueZ
Message-ID: <20090907173244.GA25473@jh-x301>
References: <177499.67132.qm@web94915.mail.in2.yahoo.com> <215809.85886.qm@web94914.mail.in2.yahoo.com> <44EE5C37ADC36343B0625A05DD408C48506920BA83@CHEXMB-01.global.atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44EE5C37ADC36343B0625A05DD408C48506920BA83@CHEXMB-01.global.atheros.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jothi,

On Mon, Sep 07, 2009, Jothikumar Mothilal wrote:
> I was able to test HFP/A2DP independently.
> Is BlueZ supports multi profiles?
> For example, like A2DP with HFP - When you listen song, if you get a Skype call,
> Stop audio streaming and attend the call and start streaming once the
> call is disconnected.

Yes, we support it. The recommended way to connect both profiles is to
simply use the org.bluez.Audio.Connect() D-Bus method. You'll need to have
some integration with the actual telephony subsystem (e.g. skype in your
case) as well as some extra handling in the component that interfaces with
bluetoothd over the audio unix socket (pulseaudio/gstreamer/alsa/etc).
Your media player should probably also be telephony aware or at least
provide an interface to a component that is telephony aware so that the
playing can be paused for the duration of a call.

In Maemo 5 this all works quite well by using the bluez maemo telephony
driver and a special pulseaudio policy module which handles the stream
switching on the pulseaudio side. Even with upstream pulseaudio on my
Ubuntu laptop I can get the profile switching somewhat well working with
the help of the pavucontrol tool.

> Is this feature available in BlueZ? If so from what version of BlueZ?

In theory any 4.x version should be fine, but the newer the version the
higher the chances that it'll work well.

Johan
