Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Service level security for RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: Stephen Crane <steve.crane@rococosoft.com>
Cc: Bhatt Abhi-ABHATT <ABHISHEK.BHATT@motorola.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1099062653.28599.47.camel@baroque.rococosoft.com>
References: 
	 <5987A7CB1694D811A04D0002B32C289601BF3BFE@il93exb05.corp.mot.com>
	 <1099061231.10164.62.camel@pegasus>
	 <1099062653.28599.47.camel@baroque.rococosoft.com>
Content-Type: text/plain
Message-Id: <1099068050.10164.69.camel@pegasus>
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
Date: Fri, 29 Oct 2004 18:40:50 +0200

Hi Steve,

> > So the question still stands. Should we already force authentication
> > when the peer sends PN CMD?
> 
> Actually p412 in the SPEC (v1.1) says:
> 
> "On the responding side, if authentication procedures are triggered from
> RFCOMM, this must only be done when receiving a SABM frame, not when
> receiving configuration commands preparing an unopened DLC (Erratum
> 1052)."

this is a clear statement. Thanks for pointing this out.

However this also leads to a security problem, because I can scan the
RFCOMM ports of a remote device without forcing the security mechanism.
I only have to do the PN exchange and then disconnect. What should a
remote device do when a PN CMD comes in for a channel without a service
behind it?

> > You must convince me that this is really needed and a good idea. For
> > what kind of application do you wanna use it?
> 
> It's for the same reason as stated above: you don't want the connection
> to succeed unless the security requirements can be met. If you have a
> client in security mode 2 and a server in security mode 1, you want the
> server to see an incoming connection _only_ if authentication/encryption
> have been successfully performed. You _don't_ want the server to see an
> incoming connection which is immediately closed.

Sorry, I don't get the point. Why should a client care about security
mode 2, when it want to connect to a server in security mode 1. Actually
the server must know what services to protect and not the client. If you
have such server running, then this is a wrong designed server from my
point of view.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
