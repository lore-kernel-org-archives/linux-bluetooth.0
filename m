Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bthid cvs question
From: Marcel Holtmann <marcel@holtmann.org>
To: Olivier Bornet <Olivier.Bornet@smartdata.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20031210080259.GF26896@smartdata.ch>
References: <Pine.LNX.4.44.0312091023470.6471-100000@speare5-1-11.nmt.edu>
	 <1071020597.10655.4.camel@pegasus>  <20031210080259.GF26896@smartdata.ch>
Content-Type: text/plain
Message-Id: <1071065922.10655.60.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 10 Dec 2003 15:18:42 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Olivier,

> > the code is in CVS under utils2/hid/ now.
> 
> And do you have some tips on how to use it. I have try without success.
> I will be happy to switch from bthid to the hid from BlueZ.

you need to install libs2 and I propose that you install it somewhere
else. For example with prefix /opt/bluetooth or so. After that you have
to tweak the Makefile.am files from utils2 to find the includes and the
library under that specific prefix. Compile it with the same prefix and
you get the bthid and hid2hci program. I will work on getting the config
part of libs2 and utils2 finished this weekend, so it will be easy to
install it with a different prefix and not breaking your current setup.

To use bthid you must make sure that uinput kernel module is loaded and
that you have /dev/input/uinput. Start "bthid -d" and you have the HID
server. Watch the syslog for connection events.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
