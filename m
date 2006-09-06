Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44FE477D.9090307@xmission.com>
Date: Tue, 05 Sep 2006 21:58:53 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44EC8877.8050200@palmsource.com>
	<44F5A472.30003@xmission.com>	<44F7088F.6090606@palmsource.com>
	<44F9ABCF.1020706@xmission.com>
	<7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6E91@eumonex01.palmsource.com>
In-Reply-To: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6E91@eumonex01.palmsource.com>
Subject: Re: [Bluez-devel] RE :  Big patch to a2dpd
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

Frederic

fyi, I applied the "big patch" to cvs.

>> It only works if the bdaddr is specified in .asoundrc (the old way) as
>> well as in .a2dprc. Specifying it on the a2dpd command line does not
>> seem to help.
> Now that you tell it, as the .a2dprc is reread for address changes it will overwrite the value set by command line. You can use, enablerereadconfig=0. The .asoundrc is ignored.

I think this will lead to unexpected behavior. Normally the command line
 overrides the config file. Maybe we should ignore bdaddr changes in the
config file if the bdaddr was specified on the command line.

Have you looked into using dbus for communicating with the running
a2dpd? I think I read that ALP is going to use dbus for things like this.

>> Audio only came out the left speaker using my itech r35 black set. (My
>> other sets are up at work)
> I have a reversed stereo. It may be related. I haven't found where but it's one of the main problems. Try enablereversestereo=1 and see if audio comes from the right speaker. This would mean the failure came before compression and transmission.
> Also try playing with sound balance on xmms and look at alsamixer -D ctl.a2dpd to see if both internal channel values are the same.
> Does the standard a2dp plugin work well with that headset?
> I have a faulty headset that does that too. When I shoot it it goes ok :D

enablereversestereo=1 fixes audio so it comes out of both speakers. I've
made this the default in sample.a2dprc.

fyi, if interference makes the stream get behind, the rate of the stream
gets a little wacky for a while and the pitch wanders around for a few
seconds before settling down. fwiw, this is on a machine with intel i810
graphics which seems to "behave" better than nvidia with regard to
interrupt masking.

I was ecstatic to have avrcp "just work" when I used xmms to try things out.

fyi, the itech r35 has a combo play/pause button that seems to always
send "play" even when the music is already playing. Maybe we need to
pause if we get a play message during playback.

>> How do you switch on the fly to wired audio?
> Modify the .a2dprc file, write enablealsaredirect=1 instead of 0 and save. Yes, file ipc :D
> 
>> Could we contribute this stuff to a wiki? 
> Man is to my eyes the standard unix doc format. Even gnu info is nothing :D Why not a manpage stored in cvs, there are certainly php scripts that can render a man page in html.
> 
> The wiki is good for writing but having some docs in the project is better. The wiki needs to be watched over and there would be no way to automatically provide docs to a distro... The manpage can be installed with unbuntu packages.

I agree the manpage is essential but I'm going to break with tradition
for now and use the wiki for our in-progress stuff. It also motivates me
to get things down in some form of documentation when I don't have to
worry too much about coordination of other efforts.

I put a placeholder here:
http://wiki.linuxquestions.org/wiki/Bluetoooth-alsa
linuxquestions.org seems like an ok spot for this kind of thing.

I will put wiki snapshots in the project in some form when doing
releases or cvs tags.

Brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
