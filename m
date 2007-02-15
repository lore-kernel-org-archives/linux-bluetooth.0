Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <5b9417770702150030x4e84f59flfbac26257b600ef1@mail.gmail.com>
Date: Thu, 15 Feb 2007 02:30:26 -0600
From: "John H." <mistamaila@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45D33129.7040906@xmission.com>
MIME-Version: 1.0
References: <5b9417770702132316t2594eedfie00e3d930ef82efe@mail.gmail.com>
	<45D33129.7040906@xmission.com>
Subject: Re: [Bluez-devel] can you use bluetooth alsa to let bt device use
	computer speakers as output?
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

I am confused, I Can't use plugz and have to use btsco???

I don't even see these binaries after installing btsco, like a2play

Legacy Stereo (A2DP) Testing
Only developers should need to use this testing code. The A2DP plugin
work is mature enough to use directly.

A2DP provides a way to send stereo high-quality audio to some of the
newer headsets. On all the headsets I've seen so far, this is one-way
audio, so if you were expecting to get something like a gaming headset
(talking to other players, getting stereo sound back from the game),
you should wait for the next generation of headsets to get 2-way A2DP.

This code is found only in the "btsco" package.

To test stereo audio without installing the alsa plugin, you can run:

	mpg123 --au - file.mp3 | ./a2play 00:0D:3C:30:32:AD

Where you replace file.mp3 with a good mp3 file and bdaddr with the
address of your headset. You can send live audio from line-in etc
using a command like:

	./a2play -s -d -r 44100 00:0D:3C:30:32:AD /dev/dsp

Don't be surprised to get a delay. It's probably under 500ms but not
much under that.

The A2DP sink code receives a stream from another device. Run it with:

        hciconfig hci0 class 0x200404
	sdptool add A2SNK
	./a2recv

It will try to bind to the bluetooth adapter and send audio out to /dev/dsp.

On 2/14/07, Brad Midgley <bmidgley@xmission.com> wrote:
> John
>
> > My moto Q can use a bluetooth headset for stereo music listening.  Can
> > I tell bluez to allow my speakers to act as such a headset?  If so,
> > how?
>
> open http://bluetooth-alsa.sourceforge.net/build.html (see the legacy
> drivers section and "the a2dp sink code" specifically)
>
> brad
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
