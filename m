Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41C2F2DB.5010204@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] passive inquiry
References: <20041217141809.62713.qmail@web40605.mail.yahoo.com>
    <200412171534.03946.bluez-user@schaettgen.de>
In-Reply-To: <200412171534.03946.bluez-user@schaettgen.de>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 17 Dec 2004 14:53:15 +0000

Fred Schaettgen wrote:
> On Friday 17 December 2004 15:18, Paolino paperino wrote:
>> Hi,
>> i want to know if it is possible to make a "passive
>> inquiry", i explain better, a device A do an inquiry
>> no find their neighbours, it is possible for a device
>> B (in the reachability field) to know that was
>> inquiried by device A? The applican can receive an
>> event each time the device is inquiried?
> 
> No, that is not possible in general. 
> The bluetooth chip responds to the inquiry without generating any HCI events. 
> You can see SDP requests, since those are handled by the Bluetooth stack, but 
> that won't help you much I guess. Maybe there are vendor-specific commands to 
> make that possible, but I don't know about any.

No, even vendor specific commands don't help. In the inquiry procedure
at the baseband no identity information flows from the inquirer to the
scanner. The only thing the scanner can tell is that somebody has
inquired.

As an analogy, inquiry works like this. The inquirer sends out a
message which means "Can anybody who can hear me identify themselves"
and gets responses like "I heard you, I'm 0x123456789abc and I'm a
headset". Hence, the inquirer knows the identity of the devices that
have responded but the scanners gets nothing from the inquirer.

Future changes to the inquiry spec might allow extra information to
be passed from the scanner to the inquirer, but not from the inquirer
to the scanner.

If the scanner responds to the inquirer and then the inquirer follows
it up with a remote name request or an HCI level connection then at that
point the inquirer reveals its address. In the former case, the
information is available at the baseband, but is not passed up to the
host. In the latter case, the host is informed of the address of the
device that has connected.

However, completely passive identification, as you describe, is not
possible.

	- Steven



**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
