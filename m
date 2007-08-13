Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Frederic Dalleau <frederic.dalleau@access-company.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1187024669.6698.214.camel@violet>
References: <46BD85F4.1090400@free.fr> <1186855275.6698.10.camel@violet>
	<1186999158.6262.10.camel@ubuntu.mpl.access-company.com>
	<1186999538.6698.141.camel@violet>  <46C07EAC.8060407@free.fr>
	<1187024669.6698.214.camel@violet>
Date: Mon, 13 Aug 2007 19:49:14 +0200
Message-Id: <1187027354.6262.59.camel@ubuntu.mpl.access-company.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] An explanation of
	a2dpd	weird	behaviour	on	high	resolution timers enabled kernels
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel, Fabien,

> > > We have to send the next SBC frame at the exact time slot.
> > > Otherwise the audio sounds too fast or frames are skipped. If you have
> > > any ideas on how we can improve pcm_bluetooth.c (yes, that handling is
> > > inside the ALSA plugin), I would like to know.
> > 
> > The way handset makers have solved the issue is to throttle the data 
> > sending, to avoid triggering moonlight specific headset behaviours.
> > What i would suggest is to do the same thing using usleep() calls inside 
> > the alsa plugin.
> 
> we have to calculate the actual time of an SBC frame and then transmit
> it and then sleep the rest of the time before sending the next frame.
> However to have at least a little bit buffer, we should encode something
> around 3 L2CAP packets ahead. Should be something like 9-12 SBC frames.

One sbc frame is very short (350 sbc frames / s). This will only be
possible if you have high resolution timers ;)

a2dpd used to accumulate as much sbc frames as possible in one L2CAP
packet based on mtu. This of course caused latency, but it allowed to
wait using a low resolution timer.

90% latency in a2dpd was due to the "mixer" implementation.

I'm thinking about having sbc encoding inside the plugin. I'm not
convinced, mostly for these reasons :

Even if enough data is buffered, you are not guaranteed that the
application will send data in time. Worse, if enough data is buffered,
the application can choose not to send more data. The application calls
snd_pcm_get_delay(), then sleeps for the remaining delay, then sends new
data. This is typically true at the end of a stream. The application
write what can be written, then wait until the stream underrun, without
writing anymore.

Using usleep in the alsaplugin has been an issue for some player
specially when video and sound must be decoded. Decoding video takes a
lot of time, and sleeping inside the loop is simply not possible.

> I can't see how the clock offset will help us here. It is only important
> for paging devices. All the other time, the device will re-sync their
> clocks as needed.

AFAIK clock drifting has not been an issue to me before. 

Frederic


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
