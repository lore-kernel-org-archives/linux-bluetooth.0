Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] MTU and MRU for Bluetooth
Message-ID: <20040505211012.GA11210@gmx.net>
References: <opr7hpnaqeqdj9uv@mail.gmx.de> <1083692600.4666.57.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1083692600.4666.57.camel@pegasus>
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
Date: Wed, 5 May 2004 23:10:12 +0200

On  0, Marcel Holtmann <marcel@holtmann.org> wrote:
>> some suggestions for suitable values for MTU / MRU when using pppd and PAP?
> 
> are these values not related to the upper protocols like TCP/IP? The
> underlaying RFCOMM protocol is a stream, so you don't have a MTU.

I think, he wants a MTU size that doesn't lead to fragmentation on the
carrying transport medium. I think this doesn't make much sense due to
the "short" packets of bluetooth, and the fact that L2CAP packets can be
up to 2^16 bytes large.

nicholas


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
