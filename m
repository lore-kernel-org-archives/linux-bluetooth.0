Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] WindowsCE and DUND
From: Marcel Holtmann <marcel@holtmann.org>
To: Ronny Bremer <rbremer@future-gate.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040122T124812Z_5232000B0001@future-gate.com>
References: <20040122T124812Z_5232000B0001@future-gate.com>
Content-Type: text/plain
Message-Id: <1074774284.19046.33.camel@pegasus>
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
Date: Thu, 22 Jan 2004 13:24:44 +0100

Hi Ronny,

> I am using RedHat Fedora Core 1 with the latest updates. I remember
> from earlier on, that in order to provide connectivity to a WindowsCE
> device I need to run
> dund --listen --msdun call synce-device
> 
> which will register with SDP automatically.
> 
> 2 questions
> 
> 1) I created a section in /etc/bluetooth/rfcommd.conf called rfcomm1,
> pointing to channel 1. If I then use
> dund --listen --msdun -P rfcomm1 call synce-device
> will it always listen on channel 1 so once configured devices are
> connecting to the right channel?

the config file rfcomm.conf has nothing to do with dund. Both are
different applications and also an outgoing connection to channel 1 and
an incoming connection to channel 1 results in two different DLCI's.

And the argument for -P is the only channel number.

> 2) In order to sync you need to create an ActiveSync session. This is
> searching for SP (serial port) service on the linux host, but dund
> registers LAN service only. Is there any option to have dund register
> both LAN and SP? Or am I mistaken? And why does calling
> sdptool add SP
> works afterwards, how does it route the request for the SP to dund?

Go ahead and modify the dund application to take another argument like
--spp, so it will add a serial port record instead of a LAN service. You
don't need both. If you had done this send me a patch.

SDP is like DNS only a lookup database. You can also do anything without
it, if you know where and how to connect.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
