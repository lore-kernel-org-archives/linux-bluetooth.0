Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY117-F8FCB480B6AED8A70E7014BFC40@phx.gbl>
References: <BAY117-F8FCB480B6AED8A70E7014BFC40@phx.gbl>
Date: Tue, 02 Jan 2007 05:01:35 +0100
Message-Id: <1167710495.30886.13.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] BLuez-Util
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

Hi Kelvin,

> i have been trying to install Bluez-Util to my ARM board to no avail as i
> could not get Dbus installed.
> May i know where can i download older versions of Bluez-Util that do not
> have dependencies on D-Bus?

the bluez-utils-2.x packages don't have a mandatory dependency on D-Bus.

> Is Bluez-Util necessary to get bluetooth working on embedded linux, such as 
> detecting any usb dongle and running pre-compiled bluetooth applications?

In general you don't need bluez-utils, but without it, you life will be
really hard to get Bluetooth going.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
