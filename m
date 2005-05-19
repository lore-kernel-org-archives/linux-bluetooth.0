Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Creating more than one instance of BlueZ
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050519120627.77301.qmail@web8303.mail.in.yahoo.com>
References: <20050519120627.77301.qmail@web8303.mail.in.yahoo.com>
Content-Type: text/plain
Message-Id: <1116508000.24921.19.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 19 May 2005 15:06:40 +0200

Hi Mayank,

> I am still looking for a reply...

it seems that I missed your post. Sorry for that, but this can happen
some time.

> This is very necessary since this is the deterrent
> that I am facing during development process.
> 
> Cause I now do not have access to a test PC.

BlueZ connections are always established with a source (local) and with
a destination (peer) address. So you can create connection between two
local device, but you must make sure that the source address is the
address of the other dongle. The only think where this not really works
is BNEP, because the kernel will route the TCP/IP traffic over the
loopback interface.

The instances question is non-sense, because there is always only one
instance of BlueZ running (like one TCP/IP, USB, SCSI, Firewire etc.),
but this instance is capable of handling more than one local device.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
