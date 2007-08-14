Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46C1A555.80404@free.fr>
Date: Tue, 14 Aug 2007 14:51:33 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46BD85F4.1090400@free.fr>
	<1186855275.6698.10.camel@violet>	<1186999158.6262.10.camel@ubuntu.mpl.access-company.com>	<1186999538.6698.141.camel@violet>
	<46C07EAC.8060407@free.fr>	<1187024669.6698.214.camel@violet>
	<1187027354.6262.59.camel@ubuntu.mpl.access-company.com>
In-Reply-To: <1187027354.6262.59.camel@ubuntu.mpl.access-company.com>
Subject: Re: [Bluez-devel] An explanation of	a2dpd	weird	behaviour	on	high
 resolution timers enabled kernels
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

Hi all,

Please find some comments.

> Marcel, Fabien,
> 
>>>> We have to send the next SBC frame at the exact time slot.
>>>> Otherwise the audio sounds too fast or frames are skipped. If you have
>>>> any ideas on how we can improve pcm_bluetooth.c (yes, that handling is
>>>> inside the ALSA plugin), I would like to know.
>>> The way handset makers have solved the issue is to throttle the data 
>>> sending, to avoid triggering moonlight specific headset behaviours.
>>> What i would suggest is to do the same thing using usleep() calls inside 
>>> the alsa plugin.
>> we have to calculate the actual time of an SBC frame and then transmit
>> it and then sleep the rest of the time before sending the next frame.
>> However to have at least a little bit buffer, we should encode something
>> around 3 L2CAP packets ahead. Should be something like 9-12 SBC frames.
> 
> One sbc frame is very short (350 sbc frames / s). This will only be
> possible if you have high resolution timers ;)
> 
> a2dpd used to accumulate as much sbc frames as possible in one L2CAP
> packet based on mtu. This of course caused latency, but it allowed to
> wait using a low resolution timer.
> 
> 90% latency in a2dpd was due to the "mixer" implementation.
> 
> I'm thinking about having sbc encoding inside the plugin. I'm not
> convinced, mostly for these reasons :
> 
> Even if enough data is buffered, you are not guaranteed that the
> application will send data in time. Worse, if enough data is buffered,
> the application can choose not to send more data. The application calls
> snd_pcm_get_delay(), then sleeps for the remaining delay, then sends new
> data. This is typically true at the end of a stream. The application
> write what can be written, then wait until the stream underrun, without
> writing anymore.

I'm not sure i understood your last paragraph : could you please 
expand/reformulate ?

> 
> Using usleep in the alsaplugin has been an issue for some player
> specially when video and sound must be decoded. Decoding video takes a
> lot of time, and sleeping inside the loop is simply not possible.

Ok, then we have to implement snd_pcm_get_delay() and offer the option 
to the application to sleep itself (or do other time consuming tasks 
such as video decoding). However when the application sends data too 
fast (such as a simple aplay) we *have* to do the sleeping ourselves to 
prevents cuts on the headset side :-)
This means we have to implement some kind of "virtual buffer" and sleep 
only after this buffer is full, and not after each packet is sent.
Or at first we can just say "go to hell" to those applications that do 
everything in the same thread and choose to solve the issue later :-)

However i don't see how it is related to the fact encoding is done (or 
not done) in the plugin itself...)

> AFAIK clock drifting has not been an issue to me before. 

Well, it is a physical fact. People at my company have been spending 
weeks, if not months implementing all those 
streaming/clocking/throttling things for their a2dp implementation, so 
that it would work with most of the a2dp headsets on the market today 
:-(. An the issues we've seen here they've already solved :-)
The fact you haven't encountered it before can be explained by the fact 
that:
  * you haven't been paying attention to it :250 ppm is ~ 15 
milliseconds per minute: if you're licky enough you just haven't 
discovered yet. ;-)
  * you used headsets that compensate for clock drifting by dynamically 
adjusting their playing speed to the rate at which data arrive. However 
not all do. My brand new Sony Ericsson just drops the sample or inserts 
audio cuts for instance :-(

In fact in a previous mail i said i got perfect sound quality with the 
bluetooth audio service (which means no audio cuts whatsoever), while 
only good sound quality with a2dpd : i from time to time get some cuts. 
:-( It may or may not be related to those issues : i don't know.

Cheers,

Fabien



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
