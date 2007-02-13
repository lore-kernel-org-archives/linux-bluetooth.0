Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <9da483cb0702130227i2bf3c015jacfa68577b36fe1a@mail.gmail.com>
Date: Tue, 13 Feb 2007 03:27:06 -0700
From: "Mike Hodson" <mystica@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <CE5216C10C83944D9FD37B65CD33F3970CF471@mplex01.mpl.access-company.com>
MIME-Version: 1.0
References: <9da483cb0702121756l3541cc58u690e518940035b11@mail.gmail.com>
	<CE5216C10C83944D9FD37B65CD33F3970CF471@mplex01.mpl.access-company.com>
Subject: Re: [Bluez-devel] RE : Successes and failures with btsco/bluez
	respectively
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

On 2/13/07, Frederic Dalleau <Frederic.Dalleau@access-company.com> wrote:
> Hi, thank you for reports.

You're welcome. :) I'm glad to help, as I just literally 2 days ago
decided I wanted to try and make this work, as I am on vacation from
work for 1wk with nothing else to do.

> When did you do all that? Latest submit was last friday.
Yesterday, monday, 13feb.

> > i ofcourse tried xmms.
> Which version? Can you try 1.2.10?
Specifically 1.2.10-cvs, as of about 2 months ago from their cvs servers.
This does work perfectly well with btsco-0.5's a2dpd-daemon/a2dpd pcm.
I can try the release tarball if you'd like.

> > After a while, i decided to try mplayer, vlc, and even audacious.
> Which version? Can you try 1.0rc1?
I tried the version that gentoo portage decided to install, which
apparently is 1.0rc1 with a few tweaks. Im unsure which tweaks, but i
know SVN does not properly work the last I tried about a week ago,
else i would have used that.
mplayer always outputs sound, video is a different question.

With the newest a2dpd, this mplayer always outputs, either plugin, but
video is another story. Audio works fine, video lags sloooowly.   VLC
worked fine either way, ofcourse, newer plugz skips a lot, but
btsco-0.5 has been playing a tivoed episode of CSI for the last 10
mins without a problem, just the ~200ms audio lag or so that I'm
unsure how to correct for in VLC.


> > Then i read that there was a newer plugin, a2dpd2.
> Should be broken I will remove it.
Noted.

> > btsco-0.5 from sf.net.
> Should work well, but would be better fix plugz a2dpd.
Yes, this release works good for audio sending.

>
> > What do you think is happening with plugz / alsa plugins that cause
> > the errors I have listed?
> Bad luck!
I always seem to get this! especially when I want something to work
really badly :)

> > Also, one thing I have noticed about my headset: The avrcp controls
> > seem to be sent twice when I press the joystick buttons. Hitting the
> Press and release.
I'm unsure of this, as I have tried holding the button for a few
seconds, and even the first slight press gives 2 commands. This
however, is ONLY for the shared play/pause, as the buttons for
forward/back are indeed press and release triggered.
>
> > However, stopping the playback (ctrl-c on say, mplayer) only causes
> > the headset to emit 1 avrcp_stop command.
> The headset should not send command if you stop from the computer. is it avrcp_stop or AVDTP_STOP?
Let me make sure... ctrl-c on mplayer / kill -9 vlc (them and their
ctrl-c catching...blah)

A2DPD[487.288]: a2dpd_signal_state: Disconnected
A2DPD[488.255]: a2dpd_signal_command: avrcp_stop


> set your plugin as this :
> pcm.a2dpd {
> type a2dpd
> debug 1
> }
> Then give us full player log, and a2dpd log. Use plugz latest cvs.

Well, I was in the process of doing this, and now, neither version of
a2dpd wish to connect with my headset at all. It just sits at
'connecting' ... nomatter what im trying. vlc/mplayer/xmms, new/old,
a2play/pcm.a2dpd, it is refusing to connect anymore... I even rebooted
to no avail.. did i somehow wear out my headset?!?

DEBUG: a2dp_new: 00:14:CF:03:37:DC, 44100
DEBUG: detect_a2dp: Found A2DP Sink
DEBUG: connect_stream: Found A2DP Sink at the destination (psm_cmd=25)
DEBUG: do_connect: (errno=111:Connection refused)Can't connect to
DC:37:03:CF:14:00 on psm 25.
DEBUG: connect_stream: cannot open psm_cmd = 25
DEBUG: a2dp_new: Can't connect
DEBUG: a2dp_free
This is from btsco-0.5 a2play ...

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
