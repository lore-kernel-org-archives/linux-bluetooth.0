Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Florian Echtler <echtler@fs.tum.de>
Cc: Olivier Bornet <Olivier.Bornet@smartdata.ch>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.NEB.4.58.0312211145020.12898@neptun.fachschaften.tu-muenchen.de>
References: <Pine.LNX.4.44.0312091023470.6471-100000@speare5-1-11.nmt.edu>
	 <1071020597.10655.4.camel@pegasus>  <20031210080259.GF26896@smartdata.ch>
	 <1071065922.10655.60.camel@pegasus>
	 <Pine.NEB.4.58.0312202356540.10214@gaia.fachschaften.tu-muenchen.de>
	 <1071969925.2684.5.camel@pegasus>
	 <Pine.NEB.4.58.0312211145020.12898@neptun.fachschaften.tu-muenchen.de>
Content-Type: text/plain
Message-Id: <1072007784.2684.45.camel@pegasus>
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
Date: Sun, 21 Dec 2003 12:56:24 +0100

Hi Florian,

> Do you mean by "hcitool inq <mouseaddr>"? Still doesn't work..
> I can't even l2ping the bloody rodent, it's either "Host is down"
> or "Function not implemented" (WTF?). Is there a tried-and-true command
> sequence to get a freshly powered up mouse connected?

you only have to connect to a Bluetooth mouse once. In all subsequent
cases the mouse will connect to you. For the first connection you press
the connect button under the mouse. Run "hcitool inq" and connect to the
mouse. This is working every time.

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
