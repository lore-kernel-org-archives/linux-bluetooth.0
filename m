Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] dinovo problem ... hid2hci
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200511282246.02411.mgorbach@yahoo.com>
References: <200511282246.02411.mgorbach@yahoo.com>
Content-Type: text/plain
Message-Id: <1133238503.27800.1.camel@blade>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 29 Nov 2005 05:28:23 +0100

Hi Michael,

> I more or less have my dinovo keyboard working under bluez and gentoo.
> There are two problems I wanted to ask about:
> 1. The dongle doesnt reset to HID mode when system is shut off ... so I have 
> no ability to use the keyboard in grub! I need to write a script to reset it 
> to hid mode when the system is shut off. How can i do this? The hid2hci 
> program supposedly provides an option to switch back to hid mode ... but it 
> doesn't work. I get the error "No devices in hid mode found" (obviously!).

we don't know the magic sequence to switch it back into HID mode.

> 2. The functions keys on my dinovo dont work (fn keys). The mouse is stuck in 
> f-lock mode where the function keys are special keys ... but I want them to 
> just work as f1 ... f12. What do i need to get the f-lock key working?

What do the function keys have to do with the mouse. About what diNovo
generation are we talking.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
