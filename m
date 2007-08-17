Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46C583BF.9080705@free.fr>
References: <46BD85F4.1090400@free.fr> <1186855275.6698.10.camel@violet>
	<1186999158.6262.10.camel@ubuntu.mpl.access-company.com>
	<1186999538.6698.141.camel@violet> <46C07EAC.8060407@free.fr>
	<1187024669.6698.214.camel@violet> <46C1A54A.9080103@free.fr>
	<1187109870.6698.287.camel@violet>  <46C583BF.9080705@free.fr>
Date: Fri, 17 Aug 2007 13:32:04 +0200
Message-Id: <1187350324.6698.382.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] An explanation
	of	a2dpd	weird	behaviour	on	high	resolution timers enabled kernels
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

Hi Fabien,

> > I might be simply never hear the difference, 
> 
> Well, you will, however not always, this will be dependant upon the 
> bluetooth devices used, so that might work for you but fail for someone 
> else if those clock drifting issues are not handled properly.
> 
> but anyway, we can actually
> > do this. However the implementation is tricky. The plugin should not
> > send HCI commands at all. Actually no daemon (except hcid) should send
> > any HCI commands at any time. 
> 
> Woops, didn't know about that :-(
> 
> Are there any hard constraints behing this limitation or is it just a 
> good software architecturing rule that prevents us from doing it ?

currently it is not a hard requirement, but I am going to change that at
some point in the (far) future. The kernel is responsible for HCI. Our
interface actually is pretty sane since even commands from user space
are honored by the kernel and the flow control will be applied. However
in some corner cases (like hcitool cc for example) the kernel takes full
control and applies its rules. And the kernel is always right.

The other point is that only the kernel has enough knowledge to actually
trigger certain actions. All user space application have only a limited
view of HCI and thus it is a bad idea to mess around with it.

> > I can make the kernel to as for the clock
> > offset in a certain interval. 
> Just for my own comprehension : could you expose here how do you intend 
> to implement this ?

No idea, yet. Adding the scheduling of this command is really simple. A
problem is actually to get the result of it into the audio service. The
kernel knows it and hcid can easily get it, but that doesn't help us.

> > This costs too since it has to go over the
> > same HCI link that the audio data goes. 
> Agreed :-)
> > So at which rate do you need
> > this information?
> 
> Let's say we are unlucky and we got the master clock and the main CPU 
> clock to drift each of 250 ppm in opposite directions. That leaves use 
> with a 30 ms per minute drift.
> 
> I'd say a clock resynch every 20-30 seconds should be enough, and would 
> limit the drift at any time below 15 mseconds, which should be 
> compensated byt the headset side buffering.
> 
> So let's say i need this information every ~20 seconds.

Every 20 seconds is no problem. A kernel patch for that is rather simple
actually.

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
