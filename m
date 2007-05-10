Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4642BB47.6000609@idlum.be>
Date: Thu, 10 May 2007 08:27:19 +0200
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4642007E.5030803@idlum.be>
	<d89ddf300705091650w787619eap2ecd667b3c4ace33@mail.gmail.com>
In-Reply-To: <d89ddf300705091650w787619eap2ecd667b3c4ace33@mail.gmail.com>
Subject: Re: [Bluez-devel] How to completely reset a dongle from software?
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

Hello Brad,

>     Is there a way to perform a full reset of a USB dongle without
>     unplugging it, but having the very same effects than if it was
>     physically unplugged and plugged back again?
> 
> 
> if it is a csr chip, you can enable bccmd in bluez-utils and use it to 
> reset the chip. It might take two attempts to actually reset.

Very interesting. Unfortunately, the dongles I'm working with at the 
moment are all broadcom-based. Does the same tool/functionnality exist 
for this brand of devices?

Pierre-Yves

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
