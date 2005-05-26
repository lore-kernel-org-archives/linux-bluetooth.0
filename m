Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem to connect hci as non-root
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4295FDE5.1080404@palmsource.com>
References: <4295E697.9060802@palmsource.com>
	 <1117120845.12036.41.camel@pegasus>  <4295EC2C.3070002@palmsource.com>
	 <1117122236.12036.49.camel@pegasus>  <4295FDE5.1080404@palmsource.com>
Content-Type: text/plain
Message-Id: <1117126920.12036.53.camel@pegasus>
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
Date: Thu, 26 May 2005 19:02:00 +0200

Hi Fred,

> I agree with you that Linux should not need a pairing/bonding 
> application. But we got one and want to keep it when porting our 
> applications to Linux.

you know that this will only work if the other side implements a simple
trust policy. If you move to service based policies this makes no longer
real sense. The only advantage will be that the link key is exchanged.

> I do not know differences between setsockopt() and ioctl() enough to 
> give you an advice, sorry.

If anyone have an opinion on this, please let me know. I am totally
undecided at the moment.

> Is there any way to force the authentication (encryption) for a L2CAP 
> socket (at creation time for example) ?

We support if for the incoming connection on L2CAP and RFCOMM level, but
nobody added support for outgoing connection. If you set the LM_AUTH
flag for outgoing connections it will be ignored. Maybe it is worth to
implement it.

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
