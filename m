Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hid2hci and Logitech Hub
From: Marcel Holtmann <marcel@holtmann.org>
To: Alexander Holler <holler@ahsoftware.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <8430000.1072356496@[192.168.207.2]>
References: <8430000.1072356496@[192.168.207.2]>
Content-Type: text/plain
Message-Id: <1072363056.2876.75.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 25 Dec 2003 15:37:36 +0100

Hi Alexander,

> I've just tried hid2hic with my Logitech Hub.

the hid2hci don't work for the Logitech Hub. It is for the HID proxy
dongle from EPoX.

> Then I've tried some of the control transfers I've logged using SnoopyPro 
> and Windows XP. None of them are working. I allways receive -1 (Device or 
> resource busy).
> 
> What makes me wonder is that in the windows logs, the transfers are allways 
> of type 21 (out, class, interface), but hid2hci normally uses type 40 (out, 
> vendor, device).

Logitech uses some specific HID reports to switch the device from HID to
HCI mode. They use the report ID 16 for that and we also must send the
same reports through hiddev interface of the USB HID driver, but by now
I haven't figured out how to do it the right way.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
