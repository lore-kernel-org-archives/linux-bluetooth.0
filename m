Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SDP & RFCOMM SYNC
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5000105b05010705172040f6c3@mail.gmail.com>
References: <5000105b0501070138cd4b4a8@mail.gmail.com>
	 <1105102531.4299.97.camel@pegasus>
	 <5000105b05010705172040f6c3@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1105108041.4299.100.camel@pegasus>
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
Date: Fri, 07 Jan 2005 15:27:21 +0100

Hi Amit,

> can u explain how it is possible? 
> 
> Because only one  l2cap connection is possible over a ACL connection
> (between 2 devices).

who said so? There can only be one ACL connection between two devices,
but there is no limit for L2CAP connections. You can even have multiple
connections on the same PSM.

> According to SDP specification, SDP seesion first issue a SDP connect,
> send SDP query, wait for response and then send SDP disconnect.
>  
>  if we start a SDP session, What will happen with the l2cap
> connection, over which 1( or more ) rfcomm session is running?
> 
> Should l2cap implementation provide a support for this or SDP should
> check for that?
> 
> if so how to implement this at the l2cap level? 

Read the specification and look at the source code. As I said, this
simply works.

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
