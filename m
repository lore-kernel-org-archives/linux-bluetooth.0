Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45D138AF.3040708@xmission.com>
Date: Mon, 12 Feb 2007 21:03:59 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <9da483cb0702121756l3541cc58u690e518940035b11@mail.gmail.com>
In-Reply-To: <9da483cb0702121756l3541cc58u690e518940035b11@mail.gmail.com>
Subject: Re: [Bluez-devel] Successes and failures with btsco/bluez
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

Mike

> Finally, I decided to try the 'last known fallback that should work
> fine', btsco-0.5 from sf.net.
> I had read someone mention that audio would sometimes jitter because
> of the nvidia closed source video drivers, and as I am using that
> driver, i feared the worst. But, to my surprise, a2play was completely
> successful at sending uninterrupted sound to my headset for an entire
> 4 minute song!  I also edited a2play.c to edit the bitpool from 32
> (sounds craptacular) to 53 (sounds perfect with my input, no pops, no
> clicks no overamping nothing).

hmm. maybe you should also try the a2dp plugin from btsco-0.5. that was
before some pretty massive changes. We should have been tagging plugz
but I haven't known when to tag it.

> What do you think is happening with plugz / alsa plugins that cause
> the errors I have listed?
> Do you need any sort of logs from hcidump when the a2dpd2 plugin
> causes disconnects?

I'm not sure on hcidump logs, but one thing that causes similar problems
with my spider set is having my cellphone on. The spider is connected to
both the computer and the cellphone, so it wants to be the master
device. The computer also typically wants to be master and if you have a
smartphone it will too. The result is a big scatternet (possibly with
roles switching around) and extremely poor quality of delivery.

> Also, one thing I have noticed about my headset: The avrcp controls
> seem to be sent twice when I press the joystick buttons. Hitting the
> playpause button exactly 2 times produces:
> 
> A2DPD[218.721]: a2dpd_signal_command: avrcp_play
> A2DPD[218.827]: a2dpd_signal_command: avrcp_play
> A2DPD[219.215]: a2dpd_signal_command: avrcp_pause
> A2DPD[219.300]: a2dpd_signal_command: avrcp_pause
> 
> However, stopping the playback (ctrl-c on say, mplayer) only causes
> the headset to emit 1 avrcp_stop command.

it's possible we somehow have the outbound and inbound avrcp connections
going simultaneously. also, in early avrcp testing I remember seeing
doubled-up messages from some sets that were subtly different and I
thought I had added code to throw out the fake message.

brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
