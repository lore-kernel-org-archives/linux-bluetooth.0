Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] patch for d-bus support in hcid
From: David Woodhouse <dwmw2@redhat.com>
To: Philip Blundell <pb@nexus.co.uk>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1056040950.3518.18.camel@mill.nexus.co.uk>
References: <1056040950.3518.18.camel@mill.nexus.co.uk>
Content-Type: text/plain
Message-Id: <1056446930.29264.403.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
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
Date: Tue, 24 Jun 2003 10:28:51 +0100

On Thu, 2003-06-19 at 17:42, Philip Blundell wrote:
> This patch adds support to hcid for PIN requests using D-BUS.  (See
> http://www.freedesktop.org/software/dbus/ if you don't know what D-BUS
> is about.)
> 
> The advantage of this is that the UI for PIN entry runs as the logged-in
> user, rather than root.  There's then no need for the helper application
> to try to guess the value for $DISPLAY or anything like that.
> 
> To use this mechanism, you need to configure bluez-utils with
> --enable-dbus, and set pin-helper to "*dbus" in hcid.conf.

Thanks for doing this. There are now packages in Red Hat Rawhide with
this enabled.... volunteers to provide the GNOME and KDE GUI side for
this welcomed...

-- 
dwmw2


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
