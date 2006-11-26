Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <456937F3.7090107@xmission.com>
References: <456937F3.7090107@xmission.com>
Date: Sun, 26 Nov 2006 11:23:54 +0100
Message-Id: <1164536635.25914.18.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bccmd and usb/uart switching
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

Hi Brad,

> I am about to switch a bluegiga bluecore4 module from usb to uart/h4 so
> I can use it to work on audio stuff using a gumstix. I really can't
> afford to brick this thing and documentation is hard to come by... does
> it look like
> 
> bccmd psset 0x1f9 3
> bccmd psset 0x3cd 4
> 
> (to change HOST_INTERFACE & INITIAL_BOOTMODE respectively) is what I
> need so the module will respond on the uart at 115k with hw flow control?

I haven't done this for years and if, then only with Casira where I had
the SPI as fallback. I actually think the initial bood mode is wrong,
because this is for HID proxy and alike if I am not mistaken. You want
the UART settings for H4, but I can't remember what that was. I do
remember that they changed with the HCI 18.x firmware and got split off
into transport specific PS keys, but that's basically it.

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
