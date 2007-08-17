Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Frederic Dalleau <frederic.dalleau@access-company.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46C57B93.7040905@free.fr>
References: <46BD85F4.1090400@free.fr> <1186855275.6698.10.camel@violet>
	<1186999158.6262.10.camel@ubuntu.mpl.access-company.com>
	<1186999538.6698.141.camel@violet> <46C07EAC.8060407@free.fr>
	<1187024669.6698.214.camel@violet>
	<1187027354.6262.59.camel@ubuntu.mpl.access-company.com>
	<46C1A555.80404@free.fr>
	<1187102836.3463.60.camel@ubuntu.mpl.access-company.com>
	<46C57B93.7040905@free.fr>
Date: Fri, 17 Aug 2007 15:41:06 +0200
Message-Id: <1187358066.6257.21.camel@ubuntu.mpl.access-company.com>
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


> * ALSA API has the builtin assomption that the data gets transmitted 
> using a hardware ring buffer, which is not the bluetooth way of things 
> when you send packets one after the other.

Right, this is quite simple to emulate by doing this I got the best
experience with all players in a2dpd.

> This means we have to workaround this by implementing a virtual buffer 
> with a virtual hardware pointer.

A buffer, with a hardware pointer... data not sent yet must be stored.

> > I'm not sure we can assume an headset will buffer the received packets.
> 
> Well it does. However how much is left completely unspecified by the 
> bluetooth specs. :-(

Keep in mind that buffering induce latency. A2DP itself is not so
latent, my old iphono works great on windows , even for gaming... It
does not buffer data and requires precise timing.

The "all in plugin" architecture is designed to reduce data copy and
latency. If buffering starts to occur on headset side, then it seems to
me that all the benefit of this architecture are ruined.

> > In fact, the only application to care about is the sound server.
> 
> Could you be more specific on that ?

I don't think of a server in particular, it's difficult to choose one
yet...

It is time for me to leave.

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
