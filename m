Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Microsoft Optical Desktop for Bluetooth - Help!
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <43245D2E.4070009@gmail.com>
References: <4324344D.1030401@gmail.com> <1126447038.31313.11.camel@blade>
	 <43245D2E.4070009@gmail.com>
Content-Type: text/plain
Message-Id: <1126563738.5518.5.camel@localhost.localdomain>
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
Date: Tue, 13 Sep 2005 00:22:18 +0200

Hi,

> Thanks for your fast reply and I'm feeling sorry for asking the same 
> question again, but a search in the mailing list archive wasn't very 
> helpful. A HID proxy dongle is a dongle which saves all the required 
> info so that my device (keyboard, mouse) could be used during booting as 
> a USB device, right? If so, after installing the keyboard device in 
> Windows, my keyboard works during booting (I can go into the BIOS menu, 
> choose an OS with the boot loader etc.) even after I shut down my PC.
> 
> So, I suppose, the Microsoft USB dongle supports HID proxy. After all, 
> your list (http://www.holtmann.org/linux/bluetooth/features.html) 
> indicates that the bluetooth chip Microsoft uses could be either CSR or 
> Broadcom. If I'm right, my next question is how to write the link key to 
> the bluetooth chip.
> 
> Although I've searched through the mailing list, I couldn't find any 
> explanatory note about it. The only thing I found was something about 
> tranferring the link key between Windows and Linux, but I suppose this 
> has to do with the operating systems only (and in both of them I use the 
> same pin number) and not with the firmware itself.

check with "hciconfig hci0 version" what chip is used and for storing
the link key the putkey of hciconfig could be used.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
