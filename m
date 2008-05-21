Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1211374622.5826.18.camel@bongo>
References: <1211374622.5826.18.camel@bongo>
Date: Wed, 21 May 2008 16:31:16 +0200
Message-Id: <1211380276.13248.61.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Support translations in bluez-utils
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

Hi Michael,

> I am attaching a patch and some files that all together allow gettext
> translations for bluez-utils.  I'd appreciate a review/commit.
> 
> The particular strings motivating this patch were the service names in
> hcid/dbus-service.c.  There may be other good candidates for
> translation, but I only marked those few strings.

actually this is going away in the near future. The logic to provide a
service friendly name will be done in bluez-gnome and the bluez-utils
will only export a service identifier.

In addition I also think that translation for system level functionality
is useless :)

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
