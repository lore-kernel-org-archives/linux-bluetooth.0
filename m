Return-Path: <cyrus@holtmann.org>
Message-Id: <DF35A68F-4B41-448D-9C12-BB4FACED2D57@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1204819758.2640.123.camel@cookie.hadess.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Fri, 7 Mar 2008 19:36:13 +0100
References: <1204819758.2640.123.camel@cookie.hadess.net>
Subject: Re: [Bluez-devel] Device type filter ideas
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

Hi Bastien,

> As can be seen after yesterday's commit, the device type filter in the
> selection widget is starting to get a bit long.
>
> How about putting the work of adding new filters onto applications
> instead?

I like to have something that GTK+ does with the File Dialog filters.  
That would be the right approach.

> I can think that sendto would add filters for Phones, Printers, and
> computers, as those are the most likely type of devices that could  
> have
> obex available.

We need a way to filter on service classes instead of major/minor  
classes. Also we need  some support for Extended Inquiry cases where  
we would get a list of UUIDs for free during inquiry.

Before we extend the filters, we need to make the Device Selection  
widget more generic. For example configureable title and be able to  
hide the filters part. Take a lot at the current code for the wizard.  
It looks ugly and is wrong in that context. Also in case of the wizard  
we don't wanna show bonded and trusted devices at all. We already know  
about them and wanna setup only new ones.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
