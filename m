Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Device Busy during "hcitool info" or "sdptool
	search"
From: Marcel Holtmann <marcel@holtmann.org>
To: ag@new-media-artists.de
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <FJENILNPNAGPJMMDOKDCAEJJDJAA.ag@new-media-artists.de>
References: <FJENILNPNAGPJMMDOKDCAEJJDJAA.ag@new-media-artists.de>
Content-Type: text/plain
Message-Id: <1071683672.27570.71.camel@pegasus>
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
Date: Wed, 17 Dec 2003 18:54:32 +0100

Hi Andreas,

> I appreciate your great work and dedication to the bluetooth technologie.
> The blueZ Stack is the most stable BT-Software i ever used on a PC-Style
> Hardware and im verry happy that it is avaiable. I hope i can contribute at
> some point, but i think i need to keep on learning to be able to. Heres what
> i found out for now.
> 
> I have noticed that
> 
> "hcitool inq" returnes "Device or resource busy" every time if a
> "hcitool info <mac>" || "sdptool search --bdaddr <mac> <someservice>" is
> running on the same hciX device.
> 
> Is this normal or should this be considered a problem?

this depends on your Bluetooth chip and the firmware on this chip. In
general all CSR chips with HCI 16.x firmware should be able to run an
inquiry while maintaining an ACL link. So your modules should not have a
problem here, but you can run a hcidump and look for the error code that
is returned by the inquiry command.

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
