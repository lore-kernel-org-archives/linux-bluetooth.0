Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] AVDTP socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <418E6FBF.3090409@xmission.com>
References: <418DB442.2050801@uen.org> <1099830449.6896.14.camel@pegasus>
	 <418E4E9C.8070100@xmission.com> <1099846462.6896.26.camel@pegasus>
	 <418E6FBF.3090409@xmission.com>
Content-Type: text/plain
Message-Id: <1099863224.6896.57.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 07 Nov 2004 22:33:44 +0100

Hi Brad,

> > I looked a little bit into ALSA and actually what we really need is the
> > support in the ALSA library for understanding SBC. So the kernel don't
> > has to worry about it.
> 
> good, so it's an alsa project. :)
> 
> in the perfect world, you should be able to hand an mp3 over to a 
> userspace library that only transcodes into SBC if the headset does not 
> advertise its own mp3 codec. same with aac. avoiding the transcode would 
> be good for reducing latency and preserving batteries on a portable 
> player. it may be academic if none of the headsets implement optional 
> codecs.

it is not really an ALSA project, but from my understanding it is the
best way to go. We must extend the ALSA kernel part to allow a PCM with
the type SBC and then expect from the library to do the rest for us.

And yes, if there are headphones with MP3 or any other codec in their
endpoint list, then we should use a native one. Actually as far as I got
through the ALSA code we simply set what we support and then the rest is
done automatically by the library.

> > In general yes, but the AVDTP is crap. It needs at least two L2CAP
> > channels on PSM 25.
> 
> it may be ugly, but it's all we've got, eh?

This was not what I meant. You must open the signal channel first and
then open the media channel. This is the basic mode.

> > I saw that too and actually I don't know what is it good for. Maybe you
> > wanna try to connect it to a TTY and then copy the SBC files into it.
> 
> I copied a few of the sbc streams. They resulted in a whole lot of 
> static on the headset. I think we need to tell the headset we're using 
> avdtp and get that media packet header in there.

Don't ask me. I don't know what this RFCOMM channel is for.

> I don't know where to start with the avdtp protocol handling. Can you 
> give me a pointer?

I think you should start with a simple test implementation in user space
that fulfils your purpose. I haven't understand the AVDTP enough to move
any part of it into the kernel at the moment.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
