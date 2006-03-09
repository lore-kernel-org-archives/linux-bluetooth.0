Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Multiple connections between USB dongles
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <94e407f00603090536g6e039055tad50e96bf5be8ea9@mail.gmail.com>
References: <94e407f00603090536g6e039055tad50e96bf5be8ea9@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1141917840.4605.36.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 09 Mar 2006 16:23:59 +0100

Hi Arpit,

> I'm using Broadcom based dongles.
> 
> I'm using hcitool cc <BD-ADDR> to connect to other bluetooth dongles.
> The problem is, at a time I can have only 2 connections. To connect to
> a third dongle I have to kill one of the 2 earlier connections. Any
> idea why this is happening?

run "hcidump -X -V" and look for the actual error message.

Regards

Marcel





-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
