Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] kernel/userspace communication interface
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0510180522l33037a86rbd0231a3ba1b7201@mail.gmail.com>
References: <e1effdeb0510180522l33037a86rbd0231a3ba1b7201@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1129657048.10721.48.camel@localhost.localdomain>
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
Date: Tue, 18 Oct 2005 19:37:28 +0200

Hi Claudio,

> You wrote in an old email that a new communication interface between 
> the kernel and the userspace has been developed. 
> 
> Could you give us more information about that? What is the status,
> how 
> it will work...
> 
> We are facing some problems related to blocking operations(eg: remote 
> name request and inquiry.) in the BlueZ D-Bus services.
> 
> The hcid D-Bus main loop can't be blocked and we wouldn't like open 
> another hci raw socket.

I still doesn't had time to finally implement the first rough steps into
this direction. Give some more time and I always to some thought about
what you need between kernel and userspace. The kernel for example is
already doing complete connection tracking and this means we don't need
to re-implement it in userspace.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
