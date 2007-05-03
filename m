Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1178213140.2227.22.camel@hammer.suse.cz>
References: <1177946201.5443.59.camel@hammer.suse.cz>
	<200704302138.18170.dgollub@suse.de>
	<1178213140.2227.22.camel@hammer.suse.cz>
Date: Fri, 04 May 2007 00:32:17 +0100
Message-Id: <1178235137.3158.177.camel@cookie.hadess.net>
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

On Thu, 2007-05-03 at 19:25 +0200, Stanislav Brabec wrote:
> Daniel Gollub wrote:
> 
> > Not quite sure if this was intended or not ... attachted is the suggested 
> > change by Stanislav.
> 
> Here is an alternative patch. The same improvement but different GUI
> (see attached screenshots). I have changed second checkbox label.
> 
> Please decide what looks more intuitive and check-in.

This should optionally (ie. if HAL is available at compile and run-time)
use the new HAL API that allows to enable/disable builtin Bluetooth
devices completely (ie. not just not configured to accept anything, but
completely disabled, unplugged, and not consuming one bit of power).

The HAL API is pretty straight forward:
http://people.freedesktop.org/~david/hal-spec/hal-spec.html#device-properties-killswitch
and
http://people.freedesktop.org/~david/hal-spec/hal-spec.html#interface-device-killswitch

It's implemented for Sony and Dell laptops, with another opened RFE for
IBM laptops:
http://bugs.freedesktop.org/show_bug.cgi?id=10053

It should be dead-easy to implement for someone with access to an IBM
laptop (unlike me).

-- 
Bastien Nocera <hadess@hadess.net> 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
