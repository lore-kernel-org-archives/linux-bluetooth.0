Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sat, 14 Jul 2007 16:33:56 +0200
From: Filippo Giunchedi <filippo@esaurito.net>
To: bluez-devel@lists.sf.net
Message-ID: <20070714143356.GC25097@esaurito.net>
MIME-Version: 1.0
Cc: 433080-forwarded@bugs.debian.org
Subject: [Bluez-devel] [madduck@debian.org: [Pkg-bluetooth-maintainers]
	Bug#433080: pand:	erroneous log message, %d not substituted]
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

Hi,
my best guess about this is to use devname instead of netdev in pand/main.c

275             syslog(LOG_INFO, "New connection from %s %s",
276                                 str, netdev);

comments?

thanks,
filippo

----- Forwarded message from martin f krafft <madduck@debian.org> -----

Date: Sat, 14 Jul 2007 10:00:43 +0200
From: martin f krafft <madduck@debian.org>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Message-ID: <20070714080043.GA29829@lapse.madduck.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
Subject: [Pkg-bluetooth-maintainers] Bug#433080: pand: erroneous log message,
	%d not substituted
Reply-To: martin f krafft <madduck@debian.org>, 433080@bugs.debian.org
Sender: pkg-bluetooth-maintainers-bounces+filippo=esaurito.net@lists.alioth.debian.org

Package: bluez-utils
Version: 3.7-1
Severity: minor

Jun  2 11:47:50 piper pand[17876]: New connection from
00:19:63:98:9E:EC bnep%d

That %d should probably be interpolated.

-- System Information:
Debian Release: lenny/sid
  APT prefers unstable
  APT policy: (500, 'unstable'), (500, 'testing'), (1, 'experimental')
Architecture: i386 (i686)

Kernel: Linux 2.6.21-2-686 (SMP w/1 CPU core)
Locale: LANG=en_GB, LC_CTYPE=en_GB.UTF-8 (charmap=UTF-8)
Shell: /bin/sh linked to /bin/dash

Versions of packages bluez-utils depends on:
ii  dbus                         1.1.1-3     simple interprocess messaging syst
ii  libbluetooth2                3.12-1      Library to use the BlueZ Linux Blu
ii  libc6                        2.6-2       GNU C Library: Shared libraries
ii  libdbus-1-3                  1.1.1-3     simple interprocess messaging syst
ii  libusb-0.1-4                 2:0.1.12-7  userspace USB programming library
ii  lsb-base                     3.1-23.1    Linux Standard Base 3.1 init scrip
ii  makedev                      2.3.1-83    creates device files in /dev
ii  module-init-tools            3.3-pre11-4 tools for managing Linux kernel mo
ii  udev                         0.105-4     /dev/ and hotplug management daemo

Versions of packages bluez-utils recommends:
pn  bluez-passkey-gnome           <none>     (no description available)

-- no debconf information

-- 
 .''`.   martin f. krafft <madduck@debian.org>
: :'  :  proud Debian developer, author, administrator, and user
`. `'`   http://people.debian.org/~madduck - http://debiansystem.info
  `-  Debian - when you have better things to do than fixing systems



_______________________________________________
Pkg-bluetooth-maintainers mailing list
Pkg-bluetooth-maintainers@lists.alioth.debian.org
http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers

----- End forwarded message -----

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
