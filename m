Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with MS mouse and keyboard
From: Marcel Holtmann <marcel@holtmann.org>
To: Gareth Reakes <gareth@apache.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20031122040102.E53230@minotaur.apache.org>
References: <20031105093947.J63252@minotaur.apache.org>
	 <1068072643.1284.106.camel@pegasus>
	 <20031105150230.T694@minotaur.apache.org>
	 <20031122040102.E53230@minotaur.apache.org>
Content-Type: text/plain
Message-Id: <1069532556.16350.82.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 22 Nov 2003 21:22:36 +0100

Hi Gareth,

> 	I thought I would give a quick update. M$ agreed within seconds
> that there was a problem with the keyboard and mouse and promptly sent a
> new one out! I have just recieved them and they do not work either :(
> Exactly the same problem.

please check that it works with the Windows XP Bluetooth stack.

> 	I thought that I would give it a try with Marcels bthid. In his
> previous mail he states that it relies on a modifcation to the USB HID
> kernel module. Where is this in CVS? Also, do I have to do anything else
> (like undo the things I did to make the original bthid work?) before this
> should work?

And here is the problem. This code is not available at the moment. I
have only one machine with a hacked USB HID driver and never found the
time to get this clean. You also have to install the new Bluetooth
library to make my bthid working, because the old SDP code can't get the
complete HID descriptor from the HID device.

Do anyone have interest in working on the HID kernel driver. My idea of
the interface for the bthid daemon is very easy. You will see it if you
look at the bthid source code. On request I can post some comments about
it.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
