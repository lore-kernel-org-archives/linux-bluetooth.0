Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Tim Chick <chick@computergeek.freeserve.co.uk>
To: bluez-devel@lists.sourceforge.net
Date: Tue, 16 Jan 2007 08:17:38 +0000
References: <D8CE9CFA707C894180BAC8CDD154F8460AD538BE@msiexch01.marvell.com>
	<Pine.LNX.4.64.0701152257480.8201@cherokee.spacecom.si>
	<45AC4952.6060001@xmission.com>
In-Reply-To: <45AC4952.6060001@xmission.com>
MIME-Version: 1.0
Message-Id: <200701160817.38748.chick@computergeek.freeserve.co.uk>
Subject: Re: [Bluez-devel] a2dpd xmms and hbh-ds970
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

On Tuesday 16 January 2007 03:41, Brad Midgley wrote:
> Mitja
>
> > I recently got myslef a HBH-DS970 headset and yesterday I tryed it with
> > latest CVS version of plugz on FC6. It works great with VLC, but not wi=
th
> > xmms or a2play. With xmms it is really sped up, I tryed setting it to
> > lower frequency but it did not solve the issue, with a2play it is choppy
> > and just a little bit faster than it should be. I tryed it with Level 1
> > BC4-external and Anycom USB-250 with latest firmware and the resoults a=
re
> > the same, it should be some issue with headset. Do you perhaps have
> > any idea, where should I look, to fix it for xmms, as it is strange that
> > in VLC the sound of mp3s and movies is perfect? Oh and AVRCP in xmms
> > works.
>
> it sounds like a sample rate conversion issue. maybe xmms is expecting
> the plugin to handle a rate it can't really do. Fr=E9d=E9ric might have m=
ore
> ideas.
>
I use an .asoundrc file which looks like this:
pcm.a2dpd {
	type a2dpd
}

pcm.rs0 {
	type plug
	slave {
		pcm "a2dpd"
		rate 44100
		format S16_LE
		channels 2
	}
}

pcm.!default {
	type plug
	slave.pcm "rs0"
}

Then you can run apps with the aoss utility to get the to use the plugin if =

they don't support alsa enough, and the plugin will only get data at 44,100=
Hz

Tim


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
