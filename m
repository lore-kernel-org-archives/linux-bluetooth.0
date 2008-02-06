Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20080205125805.azdasqbjks4gwskk@wmlab.csie.ncu.edu.tw>
References: <20080205125805.azdasqbjks4gwskk@wmlab.csie.ncu.edu.tw>
Date: Wed, 06 Feb 2008 11:26:22 +0000
Message-Id: <1202297182.3491.19.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Where could I find the TODO list for BlueZ Gnome
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


On Tue, 2008-02-05 at 12:58 +0800, Ming-I Hsieh wrote:
> Hi, all
> 
> I am a sensior software engineer of a Bluetooth Chip company in  
> Taiwan, ISSC. In our business plain of this year, we will like to  
> support Linux platform. Of course, bluez had completed most important  
> functions for users. However, for an end-user, the key issue to use a  
> bluetooth device in Linux is GUI interface. Today, Bluetooth's GUI  
> interface for end user is not friendly enough. We think it would be a  
> key problem to block our business. Hence, we think the first step for  
> our project will help bluez to complete the GUI interface.
> 
> But with 2 weeks survey, I could not find out the TODO list in  
> bluez-gnome. I think the best way to complete the GUI interface is to  
> complete the TODO list in gnome-bluez, not write another software for  
> our company. Could anyone tell me where I could get a copy or  
> marcel/hadess could write a draft for us. Then, we could put our  
> resources in the right way.

There's the opened bugs at:
http://bugzilla.gnome.org/browse.cgi?product=bluez-gnome

This is bugs filed by users as well as my personal TODO list. Most of
those haven't been vouched by Marcel because he doesn't like Bugzilla
and/or bugmail ;)

My plan is to finish cleaning up the widgets, so that they're good
enough to be exported, and I can kill gnome-bluetooth.

I'm sure Marcel would be able to add some details to this.

> I think the first step is to complete the bluetooth-wizard since it's  
> important to add a device into bluez without console. Any plain for  
> this wizard?

This would be a good thing to work on, but I'm not sure what Marcel's
plans are for this yet.

Cheers


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
