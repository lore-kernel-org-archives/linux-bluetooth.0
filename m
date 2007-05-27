Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1180268229.21432.63.camel@aeonflux.holtmann.net>
References: <20060222091231.GM19185@null.research.nokia.com>
	<1140607245.4519.7.camel@localhost>
	<20060222125425.GQ19185@null.research.nokia.com>
	<20060224110357.GT19185@null.research.nokia.com>
	<1141188501.29216.1.camel@localhost>
	<1180265456.3030.9.camel@cookie.hadess.net>
	<1180268229.21432.63.camel@aeonflux.holtmann.net>
Date: Sun, 27 May 2007 15:43:23 +0100
Message-Id: <1180277003.3030.18.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Soft lockup
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

Hey Marcel,

On Sun, 2007-05-27 at 14:17 +0200, Marcel Holtmann wrote:
> > Here's what I could capture from the i386 crash:
> > BUG warning at lib/kref.c:32/kref_get()
> 
> any chance you can test a 2.6.22-rc3 kernel. We fixed some potential
> problems in RFCOMM and Greg pushed some driver model changes that might
> make this go away. I really have no idea what triggers this at the
> moment. However I would like to see a simple reproducer.

Works with 2.6.22-rc3 (for a meaning of works, my code doesn't seem to
work, but that's a different matter).

To reproduce the problem:
- Install gnome-vfs2-obexftp (let me know if you want me to provide
binaries) from
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=231005
- Make sure you have bluez-utils 3.11 (for the serial service)
- On the console:
eval `dbus-launch --sh-syntax` # Launches a session D-Bus daemon
/usr/libexec/gnome-vfs-daemon # Launches the gnome-vfs daemon
gnomevfs-ls obex://[00:00:11:22:22:00]/ # Where 00:00:11:22:22:00 is the
bdaddr of a phone, or other device with ObexFTP support

I can reproduce the crash at will on 2 different machines. It might be
easier to create a minimal reproducer if you have a debug version of the
serial service.

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
