Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Hilzinger <mhilzinger@linuxnewmedia.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Thu, 9 Nov 2006 18:43:50 +0100
References: <200611091102.54282.marcel@hilzinger.hu>
	<20061109104245.GB7085@physik.fu-berlin.de>
In-Reply-To: <20061109104245.GB7085@physik.fu-berlin.de>
MIME-Version: 1.0
Message-Id: <200611091843.50711.mhilzinger@linuxnewmedia.de>
Subject: Re: [Bluez-devel] Quality of a2dp sound
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Am Donnerstag, 9. November 2006 11:42 schrieb Adrian Glaubitz:
> Hi Marcel !
>
> Marcel Hilzinger schrieb:
> > Hi,
> >
> > I made some tests with bluetooth stereo headsets and a2dpd.
> > I must confess, I'm impressed by the easy use of a2dpd! Thanks, it's ju=
st
> > great.
>
> Yes, the usage is very simple, indeed. Once I figured out how to use
> passkey-agent, the connection worked immediately ;).
>
> > But I'm not impressed by the audio quality. Its quite noisy and far away
> > from the quality of normal wireless headphones. Headset was a Jabra
> > BT620s. I tried with different dongles, but the dongle seems to make no
> > difference.
>
> My problem with the audio quality and a2dpd is, that the quality is set
> to telephone quality only (8kHz, Mono) though my headset can do up to
> 44,1kHz Stereo (SONY VGP-BRM1D) and a2dpd even displays 44,1kHz. When
> using a2play I can listen in 44,1kHz quality, so this is an issue with
> a2dpd for me (but a2play plays the MP3s with higher speed, so they sound
> high-pitched). Also the sound is chopped very often with a2dpd, so this is
> no use for me at the moment :(.
>
> > Questions:
> > is this a problem of the technology?
>
> I don't think so, this is rather due to the fact that btsco is still in
> Alpha status of development.
>
> > is it a problem of bluez?
>
> No, I'd rather blame btsco. (I tried different kernel versions, 2.6.17.9
> and 2.6.19-rc5 and the most recent bluez-utils version).
>
> > did I something wrong?
>
> Have you tried a2play instead ? Do this:
>
> - hcitool scan
> - passkey-agent <code> <address>
> - btsco -r -v <address>
> - mpg123 --au - file.mp3 | a2play <address>

Hey, thanks! I tried this once before, but it didn't work. So I gave up. Bu=
t =

now it works like a charm and yes, sound quality is better.

However, with this solution I can only play MP3 files. But most of my =

collection is in OGG-Vorbis. And how to skip to next/previous track?


> > did anybody compare the quality on Windows? I tried to compare with Mac.
> > But as Mac OS X cannot do a2dpd, it's even worse on Mac.
>
> I was not able to use my headset in Windows, Windows doesn't give me any
> options for choosing the headset as an audio output-device, though I can
> to the headset successfully. On 2 Macintosh Mini (Intel and PPC) with OS
> 10.4 I was able to connect to the headset without any problems, and I cou=
ld
> choose my headset for all the sound-output so I was able to listen to
> iTunes via the headset. The only drawback on the Mac is, that the
> quality is limited to 8000Hz, 16 Bit mono (and the Audio Utility won't
> let me choose any better quality, though the headset supports this).
Mac does not support a2dp, that's why the quality is bad.


-- =

Mit freundlichen Gr=FC=DFen,
Marcel Hilzinger

Linux New Media AG
S=FCskindstr. 4
D-81929 M=FCnchen
Tel: +49 (89) 99 34 11 0
Fax: +49 (89) 99 34 11 99

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
