Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Edd Dumbill <edd@usefulinc.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1100282119.7349.3.camel@pegasus>
References: <1100260673.8785.20.camel@saag>
	 <1100261630.12168.71.camel@pegasus>  <1100267525.8785.39.camel@saag>
	 <1100268649.8785.43.camel@saag>  <1100282119.7349.3.camel@pegasus>
Message-Id: <1100285554.8785.60.camel@saag>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Debian testing required: bcm203x firmware
Content-Type: text/plain
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 12 Nov 2004 18:52:34 +0000

On Fri, 2004-11-12 at 18:55 +0100, Marcel Holtmann wrote:
> Hi Edd,
> 
> > > > the firmware files are in the wrong place. You are using the old
> > > > directory. They must be under /lib/firmware/.
> > 
> > OK, I renamed it to bluez-firmware and changed the location back
> > to /lib/firmware.  bluez-utils-2.10-4 also updated to reference the
> > right firmware package name.
> 
> the bluez-bcm203x package cannot depend on the non-free bluez-firmware
> package, right?

Right, or all of bluez-utils would have to go in contrib. 

-- Edd




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
