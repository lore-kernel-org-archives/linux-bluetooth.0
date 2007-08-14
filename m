Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1187102836.3463.60.camel@ubuntu.mpl.access-company.com>
References: <46BD85F4.1090400@free.fr> <1186855275.6698.10.camel@violet>
	<1186999158.6262.10.camel@ubuntu.mpl.access-company.com>
	<1186999538.6698.141.camel@violet> <46C07EAC.8060407@free.fr>
	<1187024669.6698.214.camel@violet>
	<1187027354.6262.59.camel@ubuntu.mpl.access-company.com>
	<46C1A555.80404@free.fr>
	<1187102836.3463.60.camel@ubuntu.mpl.access-company.com>
Date: Tue, 14 Aug 2007 18:40:15 +0200
Message-Id: <1187109615.6698.283.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] An
	explanation	of	a2dpd	weird	behaviour	on	high	resolution
	timers enabled kernels
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

Hi Frederic,

> > > Even if enough data is buffered, you are not guaranteed that the
> > > application will send data in time. Worse, if enough data is buffered,
> > > the application can choose not to send more data. The application calls
> > > snd_pcm_get_delay(), then sleeps for the remaining delay, then sends new
> > > data. This is typically true at the end of a stream. The application
> > > write what can be written, then wait until the stream underrun, without
> > > writing anymore.
> > 
> > I'm not sure i understood your last paragraph : could you please 
> > expand/reformulate ?
> 
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

while I am against threads, for the plugin it is actually okay since
ALSA uses threads anyway. For the audio service, threads are not welcome
and hereby forbidden by me ;)

> > Or at first we can just say "go to hell" to those applications that do 
> > everything in the same thread and choose to solve the issue later :-)
> 
> In fact, the only application to care about is the sound server.

Actually the audio service is not doing any audio handling at all. It
only drivers AVDTP signaling and parameter negotiation. That's it. The
plugin is responsible for the whole media channel. This actually
includes the AVDTP header for that channel including the SBC header and
the actual SBC encoded data.

The audio service gives the plugin a file descriptor to use and then the
plugin takes care of everything until the audio service decides to
disconnect or the remote side terminates the connection. This includes
start, stop etc., but that are implementation details.

The I expect the following applications to work: aplay, xmms/beep,
totem, ekiga and skype.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
