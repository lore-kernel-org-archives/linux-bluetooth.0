Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Christoph Brill <egore@gmx.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1193352738.6184.297.camel@violet>
References: <20071023130738.308690@gmx.net> <1193352738.6184.297.camel@violet>
Date: Fri, 26 Oct 2007 20:07:19 +0200
Message-Id: <1193422039.6117.3.camel@egore912.egore.lan>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] randomizer for passkey-agent
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

Hi

the use case is quite simple. Imagin a headless system that is doing
bonding via a deamon. The idea is to show a random passkey on a display
and enable the mobile user to authenitcate using this passkey. I know
that the passkey-agent is more a "proof of concept" version, but if it
would generate random keys and if there was a dbus interface to the last
generated key it would be pretty helpful. At least for me :-)

If you dislike the idea I will split of a bugfix patch of the original
one patch I sent that should be applied.


Am Freitag, den 26.10.2007, 00:52 +0200 schrieb Marcel Holtmann:
> Hi,
> 
> > I wanted a passkey-agent that does not always use the same passkey so it can run in daemon mode and provide passkeys. This is an attempt to implement this functionality.
> 
> you have to explain the use case for this one. The passkey-agent.c is
> only an example on how to write a passkey agent. The GNOME and KDE
> desktops provide their own ones that open input dialogs.
> 
> Regards
> 
> Marcel
> 
> 
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
