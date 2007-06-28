Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <22b6c3510706280736h6367a25eiac4918c0f80497a2@mail.gmail.com>
References: <22b6c3510706280736h6367a25eiac4918c0f80497a2@mail.gmail.com>
Date: Thu, 28 Jun 2007 16:56:25 +0200
Message-Id: <1183042585.9499.19.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] hcid defunct
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Ben,

> I've written a program which periodically invokes hcitool scan, and
> following that propagate out content via obex to the acquired
> bluetooth address. I've noticed something remarkably strange occuring
> throughout the process. The program which I'd written is invoked
> immediately after boot. I'd noticed when I "ps -e" my system, there
> are a couple of defunct hcid processes. These defunct hcid jobs are
> immediately visible right after boot and the amount of defunct hcid
> process will to continue grow until the entire bluetooth service is
> stuffed. Once the bluetooth srvice is stuffed, if I were to invoke
> either hcitool or sdptool...I would get a "connection timeout" reply.
> The only way to remedy the situation is to periodically restart the
> bluetooth service, once the service is restarted - all of the defunct
> hcid process will be cleared.
>  
> Btw I'm running Bluez-utils and bluez-libs 3.10.1 on both Fedora 6 and
> 7 (issue is replicatable on both system). I've multiple dongles, but
> only 1 dongle dedicated to scanning. Any idea, guys?

why don't you start trying bluez-utils-3.12 and see if the issue still
exists.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
