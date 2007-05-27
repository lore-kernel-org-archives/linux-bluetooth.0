Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Gilboa Davara <gilboad@gmail.com>
To: bluez-devel@lists.sourceforge.net
Date: Sun, 27 May 2007 16:52:30 +0300
Message-Id: <1180273950.15368.42.camel@gilboa-work-dev.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] Suggesting bluez_pinhelper
Reply-To: gilboad@gmail.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hello all,

I'm currently trying to get kdebluetooth reviewed into Fedora Core (and
RHEL).
As some of you may be aware, the current version of kdebluetooth has no
support for recent (>= 3.9) bluez DBUS interface.
As an interim solution I decided to write a small wrapper that can be
used as a bridge between kdebluetooth's kbluepin and bluez-utils 3.9
(running on the about to be released F7) - basing my work around
bluez-utils' passkey-agent.
While working on it I decided to further expand it - making it
configurable and script-able which in turns, makes it entirely possible
to create passkey dialog boxes in non-X modes (using 'dialog') or in
low-end machines with minimal WM's (using 'zenity' in
IceWM/Fluxbox/etc).

As it stands I got two options:
A. Use this code as a stop-gate until qt-dbus + kdebluetooth is released
(KDE 4?) maintaining this code as a Fedora-only blob.
B. If its of any use to anyone (read, you), get it submitted into
bluez-utils while maintaining it (and expending it - if so required)
upstream.

Comments?
Is it any use for you?

http://gilboadavara.thecodergeek.com/bluez_pinhelper-0.1.tgz

P.S. this code was tested against i386/x86_64 Fedora Rawhide installs
running bluez-libs 3.9. I've yet to port it to 3.11.

- Gilboa



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
