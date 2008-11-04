Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 Nov 2008 15:35:10 -0500 (EST)
From: "George F. Nemeyer" <tigerwolf@tigerden.com>
To: Johan Hedberg <johan.hedberg@nokia.com>
cc: linux-bluetooth@vger.kernel.org
Subject: compiling text only
In-Reply-To: <20081104123342.GA20202@localhost>
Message-ID: <Pine.LNX.4.53.0811041503400.14051@tiger.tigerden.com>
References: <49104706.2010200@kleiderschrank51.de> <20081104123342.GA20202@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A couple of us have reported issues with compiling on systems with older
Glib packages.  There's likely quite a few others having the problem, but
who haven't bothered to join this list to report.

At least on the production systems I'm dealing with, an upgrade to Glib
isn't really possible.  I looked into it, but it leads to dependency hell,
and would cause unnecessary bloat for systems which rely only on an
absolute bare minimum of Gnome.  They're XFCE-based to keep operation
simple and fast.

At least for our application, we don't need *any* graphical interface for
bluetooth.  The setups could be just as easily done from shell scripts.
Indeed, since these systems are *NOT* configured by end users, having a
graphical user interface is not only superfluous, but is something we'd
rather avoid. (They're in a kiosk-type environment so quite locked down.)

Is it possible to have a more backward-compatible (and therefore more
widely applicable) compile, or is the needed bit from newer Glib really
critical?  Even a less capable result would be vastly better than a dead
end.

If the Gnome parts can't be built at all without the newest Glib, is it
possible to add a configure option that would allow the basic bluetooth
interface libs and utilities to be built without Gnome altogether so they
could be used in a command line environment?

Regards,

George Nemeyer
