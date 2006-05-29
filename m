Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <70DCB28C5BB04A4BBB1C8512589BAC65D4E773@MAIL006.mail.lan>
References: <70DCB28C5BB04A4BBB1C8512589BAC65D4E773@MAIL006.mail.lan>
Date: Mon, 29 May 2006 19:36:52 +0200
Message-Id: <1148924212.31689.95.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Strange behaviour
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Chris,

> > please send the code as attachment. It seems your mailer 
> > messed up the whitespaces.
> 
> Attached. Sorry about that.
> 
> > How do I run the test case 
> > and what should I look for?
> 
> On one node, I run it with "./rfcommloop -c 1 -M 1024". It reports the
> bluetooth address of the device it's using. On the other node, use the
> same command line but append the reported bluetooth address.

it doesn't actually work (and yes, a dongle is attached):

# ./rfcommloop -c 1 -M 1024
[Status] Random seed = 1148924068
_RfGetPrimaryBDA [757]: No bluetooth modules (19)
_RfGetPrimaryBDA [757]: No bluetooth modules (19)
_RfListen [816]: _RfGetPrimaryBDA () failed (19)
_RfGetPrimaryBDA [757]: No bluetooth modules (19)
main [1117]: _RfListen () failed (19)

Are you sure this is the latest code?

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
