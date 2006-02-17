Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS PATCH] BondingCreated && BondingFailed
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0602171007p5c34580ahe93f1023694b68e5@mail.gmail.com>
References: <e1effdeb0602171007p5c34580ahe93f1023694b68e5@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1140201999.4747.16.camel@aeonflux.holtmann.net>
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
Date: Fri, 17 Feb 2006 19:46:39 +0100

Hi Claudio,

> Here is another small patch...
> 
> According with the BlueZ D-Bus API the bonding result must be sent
> using the BondingCreated and BondingFailed signals.
> 
> In the current code, the bonding result the status is added in the
> signal argument.

do something like

signal = status ? DEV_SIG_BONDING_CREATED : DEV_SIG_BONDING_FAILED;

and then call it with dbus_message_new_signal(..., signal).

This end up in cleaner code and is easier to understand later.

> The next step is start the development of the missing bonding
> services: RemoveBonding, HasBonding and ListBonding.

The textfile library should have all stuff for it all ready. So it
should be really easy to add.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
