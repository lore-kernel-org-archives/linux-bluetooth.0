Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem to connect hci as non-root
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4295EC2C.3070002@palmsource.com>
References: <4295E697.9060802@palmsource.com>
	 <1117120845.12036.41.camel@pegasus>  <4295EC2C.3070002@palmsource.com>
Content-Type: text/plain
Message-Id: <1117122236.12036.49.camel@pegasus>
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
Date: Thu, 26 May 2005 17:43:56 +0200

Hi Fred,

> OK, I thought about this but I don't know how to start the 
> authentication from an L2CAP socket.
> Is it possible ?
> Is it possible to acces to hci command from the L2CAP socket ?

you can get the ACL handle through getsockopt() and then open an HCI raw
socket and send the command. But I think the Authentication_Requested
command will also fail due to limited permissions.

For some time I thought to add the possibility to do authentication and
enable encryption through the socket interface or L2CAP and RFCOMM. At
the moment I haven't decided if I wanna do that with setsockopt() or
with ioctl(). Feel free to suggest something.

Do you think a pairing/bonding application is needed for Linux? If one
side requests the authentication we will handle it through PIN helper
and the rest is handled inside hcid. Deleting the link key is the only
job we might need an application for.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
