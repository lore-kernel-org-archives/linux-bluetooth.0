Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Andrew Kohlsmith <akohlsmith-bluez@benshaw.com>
To: bluez-users@lists.sourceforge.net
Date: Thu, 10 May 2007 07:19:36 -0400
References: <4641DA61.8040709@tao-group.com>
	<1178780976.25565.6.camel@aeonflux.holtmann.net>
	<1178784111.10803.27.camel@localhost.localdomain>
In-Reply-To: <1178784111.10803.27.camel@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <200705100719.36399.akohlsmith-bluez@benshaw.com>
Subject: Re: [Bluez-users] API documentation?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Thursday 10 May 2007 4:01 am, Erwin Authried wrote:
> Until now, it seems that nobody has ported d-bus to uClinux. Doing that
> isn't trivial, because there are several uses of fork() that isn't
> available in uClinux. In openwrt, there isn't any mention of d-bus at

Actually, I built dbus-libs and most of dbus-utils under m68knommu without too 
much trouble; Now I did have some manual hacking to do, and there were a few 
tools which did not build, but I did get hciattach, hciconfig, hcitool and 
hcid built.  I could have sworn I had the sdp and pan utils too, but my build 
environment is a bit of a mess these days.

> all. Most probably, the footprint is too large for memory-restricted
> systems. Because of that and the fact there are very few (if any)
> projects for embedded systems that use d-bus it's hardly worth the
> effort to port it. Bluez has worked quite well for embedded systems with
> older versions, but since it ignores the demands of embedded systems
> it's probably better to use a different bluetooth stack.

This would be my response as well.  Marcel has purposely made it difficult to 
locate older versions of BlueZ in the (IMO) misguided attempt to force 
everyone to test and use the new stuff.  I can see WHY he's chosen to use 
d-bus, but yes; it's seems to be unsuitable for light embedded systems and 
you're probably better off with another stack.  There aren't many uses for a 
message bus in small embedded systems.

-A.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
