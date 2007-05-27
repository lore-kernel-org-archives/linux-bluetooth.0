Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: gilboad@gmail.com, BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1180273950.15368.42.camel@gilboa-work-dev.localdomain>
References: <1180273950.15368.42.camel@gilboa-work-dev.localdomain>
Date: Sun, 27 May 2007 18:36:36 +0200
Message-Id: <1180283796.21432.73.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Gilboa,

> I'm currently trying to get kdebluetooth reviewed into Fedora Core (and
> RHEL).
> As some of you may be aware, the current version of kdebluetooth has no
> support for recent (>= 3.9) bluez DBUS interface.
> As an interim solution I decided to write a small wrapper that can be
> used as a bridge between kdebluetooth's kbluepin and bluez-utils 3.9
> (running on the about to be released F7) - basing my work around
> bluez-utils' passkey-agent.
> While working on it I decided to further expand it - making it
> configurable and script-able which in turns, makes it entirely possible
> to create passkey dialog boxes in non-X modes (using 'dialog') or in
> low-end machines with minimal WM's (using 'zenity' in
> IceWM/Fluxbox/etc).
> 
> As it stands I got two options:
> A. Use this code as a stop-gate until qt-dbus + kdebluetooth is released
> (KDE 4?) maintaining this code as a Fedora-only blob.
> B. If its of any use to anyone (read, you), get it submitted into
> bluez-utils while maintaining it (and expending it - if so required)
> upstream.

take this up with the KDE Bluetooth guys since it the Bluetooth support
for KDE 3.x got basically abandoned. It is their job to actually fix it
and provide whatever they need to make Bluetooth working. I am not
really open for crazy hacks. The passkey-agent.c source code is mainly
an example on how to write a passkey agent and was used for initial
testing.

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
