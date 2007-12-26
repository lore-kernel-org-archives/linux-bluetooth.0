Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <992527.97227.qm@web50206.mail.re2.yahoo.com>
References: <992527.97227.qm@web50206.mail.re2.yahoo.com>
Date: Wed, 26 Dec 2007 12:43:43 +0100
Message-Id: <1198669423.29208.19.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] check for inquiry
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

Hi Mina,

> is there a way to check if there is inquiry running by me or any other
> process? also is there a way to cancel a running inquiry through an
> API call (I ask for a method other than issuing the command "hcitool
> cmd 0x01 0x0002")
> 
> I am using APIs declared in hci_lib.h not DBus.

switch to use the D-Bus based API. It will make it a lot easier. The
hci_inquiry() call is blocking and can't handle Inquiry Result with RSSI
or Extended Inquiry Results.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
