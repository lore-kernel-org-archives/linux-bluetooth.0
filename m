Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS-PATCH] list registered paths
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0510140530l6055351ak7505758983378586@mail.gmail.com>
References: <e1effdeb0510140530l6055351ak7505758983378586@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1129293738.5057.61.camel@localhost.localdomain>
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
Date: Fri, 14 Oct 2005 14:42:17 +0200

Hi Claudio,

> The attached patch implements the service for list the registered
> paths under the path /org/bluez/Manager.
> 
> The message request signature can be:
> 1. ListPaths() - list all paths under /org/bluez/Manager
> 2. ListPaths(String), The string is the relative path. eg: "hci0",
> "default" - list all paths provided by one adapter

do we really need this?

> Other minor changes:
> - removed some logs
> - added verification for dbus_connection_list_registered function. It
> can return FALSE if there is no memory 
>   to allocate the child entries

Don't send combined patches. If you have cleanups then send them as a
separate patch.

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
