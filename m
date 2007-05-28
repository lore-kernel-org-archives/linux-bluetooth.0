Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Daniel Gollub <dgollub@suse.de>
To: bluez-devel@lists.sourceforge.net
Date: Tue, 29 May 2007 00:21:17 +0200
References: <1180273950.15368.42.camel@gilboa-work-dev.localdomain>
	<200705281848.09618.dgollub@suse.de>
	<200705290711.56349.denis.kenzior@trolltech.com>
In-Reply-To: <200705290711.56349.denis.kenzior@trolltech.com>
MIME-Version: 1.0
Message-Id: <200705290021.18684.dgollub@suse.de>
Subject: Re: [Bluez-devel] Suggesting bluez_pinhelper
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Monday 28 May 2007 23:11:56 Denis KENZIOR wrote:
> What are your plans with kdebluetooth? =A0Are you going to make KDE3 based
> releases or wait until KDE4? =A0I'm asking since Qtopia Bluetooth is Qt4
> based and uses Qt DBUS bindings internally to communicate with BlueZ.

kdebluetooth for KDE3 consits of a libkbluetooth which got ported to BlueZ =

DBUS interface in the kdebluetooth-dbus-integration work branch:
http://websvn.kde.org/branches/work/kdebluetooth-dbus-integration/libkbluet=
ooth/

KDE4 will still take some time, so there is need to have something working =
in =

KDE3 in meantime. I would use the Qtopia Bluetooth API for a new Bluetooth =

Solid backend in KDE4. Which would replace:
http://websvn.kde.org/trunk/KDE/kdebase/runtime/solid/bluez

best regards,
Daniel

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
