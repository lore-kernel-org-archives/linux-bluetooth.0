Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <482AB4AD.50803@earthlink.net>
References: <482AB4AD.50803@earthlink.net>
Date: Thu, 15 May 2008 11:41:19 +0200
Message-Id: <1210844479.7025.35.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Anycom USB-250 unseen by hcitool
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Mumia,

> Hello. I recently bought an Anycom USB-250 Bluetooth
> adapter, and I'm trying to get it to work with my Palm
> Tungsten E2 so that I can get online on the E2.
> 
> However, I can't get it to work. When I run "hcitool scan",
> I get this error message: "Device is not available: No such
> device."

check with hciconfig -a and make sure that either the hci_usb or btusb
driver is loaded.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
