Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300804302008h651289d5q82eaf8f054c697a8@mail.gmail.com>
Date: Wed, 30 Apr 2008 21:08:18 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <4818E1B3.6000900@powercraft.nl>
MIME-Version: 1.0
References: <48171A58.8060200@powercraft.nl> <4817DAE3.6050406@gmail.com>
	<d89ddf300804291959m6589b95fse31e8227c37c8f1f@mail.gmail.com>
	<4818E1B3.6000900@powercraft.nl>
Subject: Re: [Bluez-users] step by step - how to get your bluetooth stereo
	headset fully working with the bluez software stack under linux
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

 Jelle

>  I got some kind of bandwidth issue with bluez. When I use my bluetooth
>  headset and mouse at the same time, the audio gets interrupted. Both
>  devices are master connections, if the headset is connected as slave,
>  the connection is totally unusable, every other bluetooth event will
>  make the audio stop in this case.
>  - So how can we fix the bandwidth priority/distribution system with bluez?

since the computer's adapter is master on all the connections, it
shouldn't be a bandwidth/scatternet issue.

Someone found a background process was starting up bt scans regularly
that tanked a2dp streams but it doesn't sound like that is happening
to you.

I did notice quite a while ago that the nvidia driver would interrupt
a2dp while scrolling or moving windows. It must work some evil like
disabling interrupts for long periods. But that would happen even with
a wired mouse.

Do you have anything special with low-latency or other kernel process
scheduler options?

>  When I play audio from a dvd, there is a little glitch in some of the
>  audio frequency's, I think there is an issue with the sbc codec it
>  appears only in some audio frequency circumstances.
>  - Can we create a freq spectrum sweep to test the sdc codec on some
>  glitches?

I suspect some less conservative encoder settings would help here, but
if you have an audio clip you can share, I'd be able to hear for
myself.

>  When playing audio, it gets buffered, and when you hit the pause key the
>  media should stop directly. The buffer is also a source for some major
>  audio video synchronization issues that I have encountered. hitting
>  pause and play resets the buffer, but it keeps getting out of sync after
>  some time.

the delay when using the gstreamer plugin should be more consistent and shorter.

that's good to hear it basically works in windows... early a2dp
hardware had an inherent delay problem.

>  I can't get two audio streams to mix and play at the same time on one
>  bluetooth device.
>  - Can we get support for multiple audio streams mixing together for the
>  same bluetooth device?

that will be one of the benefits of a native pulse plugin when it's
written. the old school way to do this is dmix, but it will result in
more confusion and delay.

it might be possible to coax pulse to use the gstreamer plugins. this
setup would give you mixing and more stability. I would only try this
with native pulse clients.

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
