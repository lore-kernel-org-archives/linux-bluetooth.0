Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Extremely slow printing?
From: Marcel Holtmann <marcel@holtmann.org>
To: Jon Valvatne <jon@valvatne.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1087440365.2624.75.camel@localhost.localdomain>
References: <1087431069.6361.26.camel@localhost.localdomain>
	 <1087432013.4309.43.camel@pegasus>
	 <1087438456.2624.64.camel@localhost.localdomain>
	 <1087440365.2624.75.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1087473569.23809.7.camel@localhost>
Mime-Version: 1.0
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
Date: Thu, 17 Jun 2004 13:59:30 +0200

Hi Jon,

> Oops... please disregard the last part of my previous message. It turns
> out, of course, that the data being sent to the printer is *much* larger
> than the original 250K of the postscript file. I haven't dealt much with
> non-postscript printers before, so this is all a bit new to me. The size
> of the raw data being sent to the printer is over 7 megabytes, which
> means a speed of 30 seconds over bluetooth just won't be possible.
> 
> And I suppose the difference between the Windows and Linux results could
> be explained by a difference in data size; maybe the Windows printer
> driver generates a smaller raw data file. I'll have to investigate this
> further.
> 
> So now my only question is: Is it expected/normal for the BlueZ CUPS
> backend to only manage about 400kbps when transferring data to the
> printer? Is there anything that can be done to speed this up?

actually this depends on the hardware in your printer. The max transfer
rate should be something about 700kbps, but this is not a must. Mostly
the reasons for this are differnt link manager implementations or an
UART that isn't running with full speed. Check your Bluetooth devices
with "hciconfig -a" and "hcitool info <printer-bdaddr>".

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
