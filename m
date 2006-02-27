Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Big rename for the D-Bus API
Message-ID: <20060227073835.GA16640@localhost.localdomain>
References: <1141022379.823.2.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1141022379.823.2.camel@localhost>
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
Date: Mon, 27 Feb 2006 09:38:35 +0200

Hi Marcel,

On Mon, Feb 27, 2006, Marcel Holtmann wrote:
> I just came to the conclusion that using org.bluez.Device for the local
> attached Bluetooth dongles etc. is not a good name. I would prefer to
> use org.bluez.Adapter and start renaming everything before the next
> release. Any comments?

I'm fine with that. The current naming is because of the "let's imitate
hald interface" decision. However, if you change "Device" to "Adapter",
then I think that the methods and signals in the Manager path should
also change to using Adapter instead of Device (currently we have
ListDevices, DefaultDevice, DeviceAdded and DeviceRemoved).

Johan



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
