Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: John McCorquodale <random-spam@viz.cacr.caltech.edu>
To: John McCorquodale <random-spam@viz.cacr.caltech.edu>
Cc: bluez-devel@lists.sourceforge.net
Message-ID: <20050125040526.GA2080@viz.cacr.caltech.edu>
References: <20050125015049.GA1520@viz.cacr.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050125015049.GA1520@viz.cacr.caltech.edu>
Subject: [Bluez-devel] Re: btsco/headset problems
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 24 Jan 2005 20:05:26 -0800

> stracing btsco shows that no data ever comes in on the BT file descriptor;
> the poll just sits in its little one-second loop never rx'ing anything from
> anybody, even when I bang on the headset button like an undersexed chihuahua
> on speed.

I done figured it out, Martha.  Turns out there were two problems:

  1. The Debian bluez-utils package comes with this great little pin helper
     that's a Python script and pops up a little window with PyGtk to ask
     for the headset's PIN.  But it seems MyGtk had evolved and the little
     script hadn't and it got stuck or bombed or something.  The thread of
     control was hanging in that pin handler and thus btsco was unable to
     print out "recieve AT+CKPD=200" and go forward.  Switching my pin
     helper to "#!/bin/sh \n echo PIN:0000" suddenly caused btsco to act
     like it's supposed to and quiet static to eminate from an full-loud
     headset.  But aplay/arecord still hung forever.

  2. Switching away from the Socket CF G card to the D-Link DBT-120 USB
     fob solved the aplay/arecord problem and now I have a fully working
     ALSA headset!

  3. (aside) I also switched up to 2.6.10-mh2 in the process here and
     from Debian's 2.10 libs/utils to the current 2.14 libs/utils.  I
     don't know if that made any difference; I suspect not.

Since I answered the hard question and the list didn't have to, I have an
easy one for you guys:

What is a CF card BT adapter that has _no_ protruding antenna, like the Socket
CF, that _works_?  I really want my Zaurus to talk to my headset and the little
antenna doodah will break off in my pocket, and Zaurus has no USB host.

Thanks, y'all,

-mcq


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
