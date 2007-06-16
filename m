Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200706151809.04115.fernando@bluexare.org>
References: <200706151809.04115.fernando@bluexare.org>
Date: Sat, 16 Jun 2007 09:29:47 +0200
Message-Id: <1181978987.6846.50.camel@aeonflux.inter-touch.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Problems with my own inquiry
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

Hi Fernando,

> I have an application that works with the bluetooth, scanning and sending 
> content with other devices..., and now, when I'm trying to make irt work in 
> other distribution, it fails.

the solution is to use the new D-Bus based API. It takes care of
everything that you want.

> This is a normal work, whit INQUIRY_RESULT and COMMAND_STATUS, but in the new 
> PC (a debian etch, buiilt by DebianLive) where I want to install the 
> application the output is like this:

The new hcid switches into the best inquiry mode and that means Inquiry
with RSSI (which is different event) for a Bluetooth 1.2 dongle or
later. You have to watch for that event, too. Or use the D-Bus API that
does that for you and already takes care of Extended Inquiry of the
Bluetooth 2.1 specification.

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
