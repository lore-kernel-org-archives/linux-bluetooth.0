Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20030620171218.0db953a8@unixmail.qualcomm.com>
To: Philip Blundell <pb@nexus.co.uk>, bluez-devel@lists.sourceforge.net
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] patch for d-bus support in hcid
In-Reply-To: <1056040950.3518.18.camel@mill.nexus.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 20 Jun 2003 17:13:39 -0700

At 09:42 AM 6/19/2003, Philip Blundell wrote:
>This patch adds support to hcid for PIN requests using D-BUS.  (See
>http://www.freedesktop.org/software/dbus/ if you don't know what D-BUS
>is about.)
>
>The advantage of this is that the UI for PIN entry runs as the logged-in
>user, rather than root.  There's then no need for the helper application
>to try to guess the value for $DISPLAY or anything like that.
>
>To use this mechanism, you need to configure bluez-utils with
>--enable-dbus, and set pin-helper to "*dbus" in hcid.conf.
Cool. 
We should really start working on 3.x libs and utils. There are so 
many things and ideas that we want to put in.

Max



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
