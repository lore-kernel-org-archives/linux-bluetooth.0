Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] No module named gtk
From: Marcel Holtmann <marcel@holtmann.org>
To: Kiran Rama <ramak@ctech.ac.za>
Cc: bluez-users@lists.sf.net
In-Reply-To: <s0cd9c72.077@cal01.ctech.ac.za>
References: <s0cd9c72.077@cal01.ctech.ac.za>
Content-Type: text/plain
Message-Id: <1087228791.13792.12.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 14 Jun 2004 17:59:51 +0200

Hi Kiran,

> How do I fix this error?
> Where do I get the module gtk?
> 
> linux:/ # bluepin
> Traceback (most recent call last):
>   File "/bin/bluepin", line 34, in ?
>     from gtk import *
> ImportError: No module named gtk

you must install the python-gtk support.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
