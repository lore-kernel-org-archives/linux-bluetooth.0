Return-Path: <trexx@pobox.com>
Subject: Re: [Bluez-users] Logitech Bluetooth  Mx900+keyboard support.
From: Terence Rudkin <trexx@pobox.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Olivier Bornet <Olivier.Bornet@puck.ch>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1075307541.26729.18.camel@pegasus>
References: <1074457244.3254.17.camel@localhost.localdomain>
	 <1074458664.6070.73.camel@pegasus>
	 <1074480891.2817.10.camel@localhost.localdomain>
	 <1074514935.6070.80.camel@pegasus>
	 <1074568150.7831.5.camel@localhost.localdomain>
	 <20040120081245.GA1871@smartdata.ch>  <1074597908.7088.5.camel@pegasus>
	 <1075234547.3064.13.camel@localhost.localdomain>
	 <1075276833.12766.56.camel@pegasus>
	 <1075306699.1793.38.camel@localhost.localdomain>
	 <1075307541.26729.18.camel@pegasus>
Content-Type: text/plain
Message-Id: <1075346991.1793.65.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Wed, 28 Jan 2004 20:29:51 -0700
List-ID: <bluez-users.lists.sourceforge.net>

Marcel,  et al,

The keyboard and mouse now work!  The last issue on getting them to work
was I needed to umount/mount the /proc/bus/usb file system. 

Actually just umount and reinsert the USB devices.  I restarted hcid and
bthid after umount'ing and before the insert.  Getting the right modules
in /etc/modules should be all that is needed. 

I'll get the steps needed I used put together as an addendum the the
MX900 page referenced eariler


Now to get the Tungsten T3 talking (passcode not exchanging) , but that
a different thread. 

Thanks again, Marcel, for all the help!! 
 
TR
