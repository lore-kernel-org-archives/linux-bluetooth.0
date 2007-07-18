Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <469DCBD6.7040005@mojo-working.com>
References: <469DCBD6.7040005@mojo-working.com>
Date: Wed, 18 Jul 2007 10:18:55 +0200
Message-Id: <1184746735.6357.3.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] RFCOMM DISC dlci=0 missing after
	server	closesocket?
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

Hi Art,

> Our RFCOMM application conducts a brief session to validate the application on a 
> partner device, then terminates the session and gives the user an option to 
> reconnect to the partner application.  When the local application uses the 
> Microsoft stack or Toshiba stack on a WinXP, and the remote application uses 
> BlueZ, the user-driven connect fails if issued less than 60 secs before the 
> first session is disconnected.
> 
> This appears to be a flaw in the BlueZ implementation, but I am no expert on the 
> subject.  Is my analysis correct?  If it is, can someone suggest a workaround?
> 
> The RFCOMM specification from Bluetooth 1.1 says
> 
> << The device closing the last connection (DLC) on a particular session is 
> responsible for closing the multiplexer by closing the corresponding L2CAP channel.

the Linux kernel 2.6.22 should behave according to the specification.

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
