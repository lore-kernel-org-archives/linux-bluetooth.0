Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46447D58.2090300@telnet-ri.es>
References: <4642CD6D.4020904@telnet-ri.es>
	<1178789693.25565.73.camel@aeonflux.holtmann.net>
	<4642E9F3.9000501@telnet-ri.es>  <46447D58.2090300@telnet-ri.es>
Date: Fri, 11 May 2007 16:29:32 +0200
Message-Id: <1178893772.2820.20.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] LMX9830 driver
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

Hi David,

> We have realized that LMX9830 doesn't have HCI controller. The
> communicating with the chip is via an specific set of commands, and
> so, the HCI drivers and hciattach are not suitable for us.
> 
> We guess that we must develop our own driver that substitutes HCI
> driver, but we are not sure where we should start working. I would
> like to know if there's any effort done in this way in the BlueZ
> development.

National never sent me any development hardware and so no.

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
