Return-Path: <cyrus@holtmann.org>
Message-Id: <BDDF9433-7A32-4CAB-B9C8-2A67635C8578@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1203878261.2754.140.camel@cookie.hadess.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Mon, 25 Feb 2008 03:08:51 +0100
References: <1203878261.2754.140.camel@cookie.hadess.net>
Subject: Re: [Bluez-devel] Option for more-"gnomey" settings
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

> As you know, I have a problem with a few settings in bluez-gnome not
> matching up with the philosophy/target for GNOME.
>
> Right now it's:
> - "Use HAL" settings, and associated device selection

you know that the class of device selection will disappear when  
enabling the HAL setting. I did that a few releases ago.

> - Sharing properties, which conflict with gnome-user-share (where we
> want to have most of the sharing preferences for GNOME, including
> sharing the screen using vino, etc.)

You can easily add an option to gnome-user-share for setting the GConf  
value that bluez-gnome is using. The whole incoming connection/accept  
thing should be handled inside bluetooth-applet.

And as I mentioned the gnome-user-share dependency chain of the  
distros is crazy. As long as it drags Apache + WebDAV into my desktop,  
I am against it.

> Would you accept a patch to add a --enable-gnome to configure to hide
> those settings away when bluez-gnome is compiled for use in the GNOME
> desktop? Or would you prefer a run-time option?

I prefer if you use the GConf values that bluez-gnome uses and move  
all Bluetooth related interaction into bluetooth-applet instead of  
hacking it into some other applications and bloat the dependencies.

If you really wanna shrink the settings of bluetooth-properties, we  
can do that at runtime with a GConf setting. I have no problem with  
that. I am against compile time options.

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
