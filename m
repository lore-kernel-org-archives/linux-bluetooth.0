Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Edd Dumbill <edd@usefulinc.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1091123717.12651.107.camel@pegasus>
References: <1091123717.12651.107.camel@pegasus>
Message-Id: <1091981521.6281.39.camel@saag>
Mime-Version: 1.0
Content-Type: text/plain
Subject: [Bluez-users] Re: [BlueZ-Announce] Release of bluez-libs-2.9 and bluez-utils-2.9
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 08 Aug 2004 17:12:01 +0100

On Thu, 2004-07-29 at 19:55 +0200, Marcel Holtmann wrote:
> Hi Folks,
> 
> I released a new stable version of the Bluetooth library and also the
> utilities. The library contains only small updates, but the utilities
> got some major enhancements in the HID area. The EPoX keyboards and
> their new HID presenters should now work correct in report protocol
> mode.

I just ploaded these to Debian unstable; they should be available in the
archive later today.  I also updated the vastly out of date bluez-
hcidump.

> With this version the bluez-bluefw is deprecated by the bluez-firmware
> package. The Broadcom firmware loading utility for 2.4 kernels is now
> also part of the bluez-utils package and was renamed to bcm203x.

I have not yet enabled this in the Debian package as it will mean a new
package, which would have delayed the upload of 2.9.  When I do enable
it, it will be in a package called bluez-bcm203x.  Sometime in the next
two weeks I hope.

-- Edd




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
