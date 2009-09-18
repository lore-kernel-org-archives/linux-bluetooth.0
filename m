Return-Path: <cyrus@holtmann.org>
Message-ID: <4AB353D8.70909@Atheros.com>
Date: Fri, 18 Sep 2009 15:03:12 +0530
From: Sasikiran Maddula <Madula.Sasikiran@Atheros.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: HFP - A2DP in BlueZ
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Sep 07, 2009, Jothikumar Mothilal wrote:

> > I was able to test HFP/A2DP independently.
> > Is BlueZ supports multi profiles?
> > For example, like A2DP with HFP - When you listen song, if you get a Skype call,
> > Stop audio streaming and attend the call and start streaming once the
> > call is disconnected.
>   

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


> > Is this feature available in BlueZ? If so from what version of BlueZ?
>   

In theory any 4.x version should be fine, but the newer the version the
higher the chances that it'll work well.


There was a discussion went with you and jothi probably 10 days back. I have some questions on that issue.

Your saying it works fine with the pavucontrol tool and pulseaudio. I am using pulseaudio 0.9.14 version. Whether it is sufficient to have the bluetooth profile switching. If I need to upgrade what version is the best suitable and suggest me on how to upgrade. Also whether pavucontrol is linked with the package for pulseaudio or it is separate. You mentioned that with the help of pavucontrol tool your able to do profile switching somewhat better. But I do not see any options in pavucontrol useful for bluetooth perspective. Could you guide me with more details.

Also you mentioned that the player I am using must be telephony aware directly or through some other component. Do you have any idea of any player which has that kind of facility.


Thanks,
Sasikiran.

