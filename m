Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez and D-Link DBT-120
From: Marcel Holtmann <marcel@holtmann.org>
To: Max <spamhole@gmx.at>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040404194656.GA15485@venus>
References: <20040403190647.GA16596@venus>
	 <1081073362.2839.29.camel@pegasus> <20040404181317.GA962@venus>
	 <1081102784.5533.1.camel@pegasus> <20040404183332.GA1160@venus>
	 <1081105392.5533.4.camel@pegasus>  <20040404194656.GA15485@venus>
Content-Type: text/plain
Message-Id: <1081108683.5533.24.camel@pegasus>
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
Date: Sun, 04 Apr 2004 21:58:03 +0200

Hi Max,

> > and you still get this error? Maybe this is a problem with your VIA UHCI
> > host controller. Check the Linux USB mailing list for more details.
> 
> Yes, the problem is still the same with 2.6.5. What kind of things should
> I look/ask for on the Linux USB mailinglist? Are there known problems
> with VIA USB/Bluetooth?

this is some uhci_hcd and VIA related stuff I read about on the USB
mailing list, but I am no USB experts. Ask them for details.

> Is there a way to verify that the firmware upload with bluefw was
> successful?

The CSR chips don't need a firmware download.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
