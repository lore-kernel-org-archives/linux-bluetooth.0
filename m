Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] HID device?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1125139965.13443.10.camel@localhost>
References: <1125139965.13443.10.camel@localhost>
Content-Type: text/plain
Message-Id: <1125308785.25073.14.camel@blade>
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
Date: Mon, 29 Aug 2005 11:46:25 +0200

Hi Jesper,

> I am trying to use my phone as a remote for my comp, using bt and hidd.
> And it's somewhat working. Not just exactly as I want.
> 
> As it is now the phone can act as a second mouse as well as a second
> keyboard (overriding core mouse/keyb)
> 
> The thing is that i would like the phone to only act on my second screen
> (where core mouse/keyb is not) This is possible through xorg.conf but
> the problem is i dont know how i am supposed to sepperate the phone and
> the core I/O. In other words how to define the phone-HID-device in
> xorg.conf?

for the mouse this should be possible if you can separate the mouse
devices, because sometimes they are enumerated in another order. For the
keyboard I have no idea. Ask the Xorg or the input subsystem guys.

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
