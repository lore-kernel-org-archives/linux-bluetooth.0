Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech Bluetooth  Mx900+keyboard support.
From: Marcel Holtmann <marcel@holtmann.org>
To: Terence Rudkin <trexx@pobox.com>
Cc: Olivier Bornet <Olivier.Bornet@puck.ch>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1075326261.1793.49.camel@localhost.localdomain>
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
	 <1075315567.1793.44.camel@localhost.localdomain>
	 <1075317417.26729.37.camel@pegasus>
	 <1075326261.1793.49.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1075354762.26729.51.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 29 Jan 2004 06:39:22 +0100

Hi Terence,

> Patch works fine.  But if neither path exist then it will silently
> fail.  while not having /dev/usb should not be an issue, but ya never
> know.  Presetting err to -1 resolves this. 

I included this fix an committed it to the CVS. Everything should now
work fine. Thanks.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
