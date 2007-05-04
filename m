Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1178235137.3158.177.camel@cookie.hadess.net>
References: <1177946201.5443.59.camel@hammer.suse.cz>
	<200704302138.18170.dgollub@suse.de>
	<1178213140.2227.22.camel@hammer.suse.cz>
	<1178235137.3158.177.camel@cookie.hadess.net>
Date: Fri, 04 May 2007 08:45:52 +0200
Message-Id: <1178261152.25425.32.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bluez-gnome: No GUI way to switch from "off" mode
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

> > > Not quite sure if this was intended or not ... attachted is the suggested 
> > > change by Stanislav.
> > 
> > Here is an alternative patch. The same improvement but different GUI
> > (see attached screenshots). I have changed second checkbox label.
> > 
> > Please decide what looks more intuitive and check-in.
> 
> This should optionally (ie. if HAL is available at compile and run-time)
> use the new HAL API that allows to enable/disable builtin Bluetooth
> devices completely (ie. not just not configured to accept anything, but
> completely disabled, unplugged, and not consuming one bit of power).
> 
> The HAL API is pretty straight forward:
> http://people.freedesktop.org/~david/hal-spec/hal-spec.html#device-properties-killswitch
> and
> http://people.freedesktop.org/~david/hal-spec/hal-spec.html#interface-device-killswitch
> 
> It's implemented for Sony and Dell laptops, with another opened RFE for
> IBM laptops:
> http://bugs.freedesktop.org/show_bug.cgi?id=10053
> 
> It should be dead-easy to implement for someone with access to an IBM
> laptop (unlike me).

the off operation doesn't make any real sense for desktop system. It is
mainly there for embedded systems without HAL or where the kernel driver
has to put the device into deep-sleep mode.

An integration with HAL's killswitch is the correct way.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
