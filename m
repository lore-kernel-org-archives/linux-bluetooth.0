Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Florian Echtler <echtler@fs.tum.de>
Cc: Olivier Bornet <Olivier.Bornet@smartdata.ch>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.NEB.4.58.0312202356540.10214@gaia.fachschaften.tu-muenchen.de>
References: <Pine.LNX.4.44.0312091023470.6471-100000@speare5-1-11.nmt.edu>
	 <1071020597.10655.4.camel@pegasus>  <20031210080259.GF26896@smartdata.ch>
	 <1071065922.10655.60.camel@pegasus>
	 <Pine.NEB.4.58.0312202356540.10214@gaia.fachschaften.tu-muenchen.de>
Content-Type: text/plain
Message-Id: <1071969925.2684.5.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [Bluez-users] bthid cvs question
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 21 Dec 2003 02:25:26 +0100

Hi Florian,

> Great work! Right now, I am typing this with my MS Bluetooth keyboard
> and I haven't noticed any glitches so far (connecting to the devices
> still is kind of a hassle, but I guess MS is to blame for that).

this is easy to solve. The problem is that if we don't have the device
in our inquiry cache we use a pscan_rep_mode with the value 0x01 for
connection setup, but Microsoft uses 0x02 by default. To solve the
glitches with the initial connection is to do an inquiry first.

> Just out of curiosity: whats the purpose of hid2hci? I confess that
> reading its sources didn't help my understanding..

If you have a dongle with a CSR HID proxy firmware, you need this
utility to switch it from HID to HCI mode.

> Final question: I patched the original bthid to allow me to control
> xmms via the extra mouse/keyboard buttons. Would anyone be interested
> if I ported this patch to the new bthid?

Send it to the list. Have you tried hotkeys? Last time I have tested it
it works fine for me.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
