Return-Path: <cyrus@holtmann.org>
Message-Id: <C788EA15-8D46-4917-B97F-9F42F230C9FB@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY107-W467598E882F42FE079C35D8FA0@phx.gbl>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Mon, 31 Mar 2008 18:50:53 +0200
References: <BAY107-W467598E882F42FE079C35D8FA0@phx.gbl>
Subject: Re: [Bluez-devel] restart periodic inquiry
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

Hi Adolfo,

> I'm currently working with DBUS and GLIB. I have made a function  
> that calls StartPeriodicDiscovery(). Everything works fine but, at  
> certain point, I want to stop and restart it and here problems  
> arise: when I call StopPeriodicDiscovery() my program exits and I  
> can't call again StartPeriodicDiscovery. My program exits just after  
> the StopPeriodicInquiry() is performed, and I dont call the  
> g_main_loop_quit(loop) function. Is it a normal behaviour?
> For me it is necessary to restart the inquiry procedure in some  
> cases. Is there a way to restart the periodic discovery or should I  
> move to the normal inquiry procedure? With the standard inquiry  
> procedure I could call CancelInquiry and then I could start the  
> inquiry procedure again.

sounds like a bug to me. However if you close the D-Bus connection, it  
will stop the periodic inquiry for you. If the application dies that  
started it, hcid will actually stop it for you. Meaning your  
application has to be running to start periodic inquiry.

Regards

Marcel


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
