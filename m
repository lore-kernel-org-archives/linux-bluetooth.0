Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46C6FE7D.90203@free.fr>
Date: Sat, 18 Aug 2007 16:13:17 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46BD85F4.1090400@free.fr>
	<1186855275.6698.10.camel@violet>	<1186999158.6262.10.camel@ubuntu.mpl.access-company.com>	<1186999538.6698.141.camel@violet>
	<46C07EAC.8060407@free.fr>	<1187024669.6698.214.camel@violet>	<1187027354.6262.59.camel@ubuntu.mpl.access-company.com>	<46C1A555.80404@free.fr>	<1187102836.3463.60.camel@ubuntu.mpl.access-company.com>	<46C57B93.7040905@free.fr>
	<1187348769.6698.373.camel@violet>
In-Reply-To: <1187348769.6698.373.camel@violet>
Subject: Re: [Bluez-devel] An	explanation	of	a2dpd	weird	behaviour	on	high
 resolution	timers enabled kernels
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

> just a small correction. I hate threads. However since ALSA already uses
> them, we can do, too. Otherwise you would never convince me to use
> threads.

I hate them too, however not at the point not to use them when they 
sound like the only reasonable solution :-)

> 
>>> In fact, the only application to care about is the sound server.
>> Could you be more specific on that ?
>> If you think of pulseaudio as the sound server, i'm afraid a native 
>> pulse plugin will have to be written for good bluetooth support anyway.
> 
> That is the plan in the end. Having a native PulseAudio plugin that
> connects over our IPC to the audio service.

Sounds like a good plan !

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
