Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SDP & RFCOMM SYNC
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5000105b0501070138cd4b4a8@mail.gmail.com>
References: <5000105b0501070138cd4b4a8@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1105102531.4299.97.camel@pegasus>
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
Date: Fri, 07 Jan 2005 13:55:31 +0100

Hi Amit,

> I am working over SDP layer & i want to suport multiple profile over rfcomm.
> 
> I want to know how I can implement the following situation.
> 
> Already there is one rfcomm (ACL) connection with the remote device by
> a profile .Other profile wants to make sdp session with the same
> device.How can we send query request over the l2cap chanel?
> 
> If so, wat will happen after if sdp sends a disconnect request after query?

this simply works. The kernel is able to handle multiple L2CAP and
RFCOMM connections without any problems.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
