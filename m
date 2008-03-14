Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: prahal@yahoo.com,
	BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1205436966.22400.4.camel@cyclope.server.maison>
References: <1205436966.22400.4.camel@cyclope.server.maison>
Date: Fri, 14 Mar 2008 01:07:06 +0100
Message-Id: <1205453226.12951.12.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] shows error in logs if the
	special	directories are not	defined and close the server if
	failure to start obex	server
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

Hi Alban,

> This patch is made out of my attempt to start obex-data-server from
> debian without xdg-user-dirs . It does not work as the glib special
> directories are nto defined but worst than that :
> - it did not tell in the log anything went wrong, 
> - it did not close the server when it failed to start it and
> sharing_enabled and received_enabled where not in sync with the server
> state anymore because of that. applet was trying to create the server
> while it was already running leading to socket already in use errors
> after two attempts. 
> This fixes those issues.

patch has been applied. Thanks.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
