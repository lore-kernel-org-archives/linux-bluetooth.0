Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46C57B93.7040905@free.fr>
Date: Fri, 17 Aug 2007 12:42:27 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46BD85F4.1090400@free.fr>
	<1186855275.6698.10.camel@violet>	<1186999158.6262.10.camel@ubuntu.mpl.access-company.com>	<1186999538.6698.141.camel@violet>
	<46C07EAC.8060407@free.fr>	<1187024669.6698.214.camel@violet>	<1187027354.6262.59.camel@ubuntu.mpl.access-company.com>	<46C1A555.80404@free.fr>
	<1187102836.3463.60.camel@ubuntu.mpl.access-company.com>
In-Reply-To: <1187102836.3463.60.camel@ubuntu.mpl.access-company.com>
Subject: Re: [Bluez-devel] An explanation	of	a2dpd	weird	behaviour	on	high
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

Hi all, please find some comments below.

> Let's take an example : An application write 40 ms of music.
> If you internally buffer the data, then the application will consider it
>  written (not played yet).
> The application will then wait for the data to be played by repeatedly 
> asking the delay until is it 0. However, that application 
> will NOT call write(), preventing the plugin code to be executed.
> 
> I already hear you saying, let's put the code in getdelay() too. This is not possible
> because the application can also call getdelay() once and wait, or even not call
> getdelay() at all, because the number of music data is known...
> 
> However, using a thread can solve this issue.
> 
>> Ok, then we have to implement snd_pcm_get_delay() and offer the option 
>> to the application to sleep itself (or do other time consuming tasks 
>> such as video decoding). However when the application sends data too 
>> fast (such as a simple aplay) we *have* to do the sleeping ourselves to 
>> prevents cuts on the headset side :-)
> 
> Aplay is not sending the data too fast. aplay tries to fill the sound
> card buffer as 100% of sound playing application do.
> Buffer size being known, delay determine available space. When there is
> space, aplay writes data and that's all.
> 
> The current plugin delay implementation is the number of data written
> (not played) => delay is always 0 => buffer is always empty => aplay
> fills it => plugin have to wait in the write() call.
> 

Ok, this time i understood. I agree with you. Which means two things:
  * i basically screwed up the pcm plugin i did a while ago for headsetd 
:-(. I was wrongs about the sleeping stuff. I understood alsa dynamic 
behaviour the wrong way.
  * ALSA API has the builtin assomption that the data gets transmitted 
using a hardware ring buffer, which is not the bluetooth way of things 
when you send packets one after the other.

This means we have to workaround this by implementing a virtual buffer 
with a virtual hardware pointer.
While as Marcel, i'm not a big fan of threads, i'd tend to see them here 
as the less worse alternative we have :-) : so i'd say : let's go with 
threads !!

> I'm not sure we can assume an headset will buffer the received packets.

Well it does. However how much is left completely unspecified by the 
bluetooth specs. :-(

> In fact, the only application to care about is the sound server.

Could you be more specific on that ?
If you think of pulseaudio as the sound server, i'm afraid a native 
pulse plugin will have to be written for good bluetooth support anyway.

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
