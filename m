Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bthid question
From: Marcel Holtmann <marcel@holtmann.org>
To: Gareth Reakes <gareth@apache.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20031128011412.C61007@minotaur.apache.org>
References: <20031128011412.C61007@minotaur.apache.org>
Content-Type: text/plain
Message-Id: <1070025957.9036.153.camel@pegasus>
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
Date: Fri, 28 Nov 2003 14:25:57 +0100

Hi Gareth,

> 1)When __io_canceled is true, is this the same as (or at least a case of)
> when the above code is called (IE when the mouse goes to sleep)?
> 
> 2)Why is it in Marcels bthid code that the control and interrupt channels
> are shut down in different a order depending on if __io_canceled is true
> or not?

let me clear this a little bit up. When __io_canceled is true, we are
terminating the connection to the HID device. In general this is done by
sending SIGTERM to the process. When __io_canceld is false then the HID
device cuts the connection. For the Microsoft devices this is after 12
minutes.

While I was playing with the Microsoft devices I found that the order of
closing the connections differ on who terminates the connection. I think
that the problem is on the Linux side, but I couldn't found it. If it is
really the fault of BlueZ it must be something very odd that we have
overlooked all the time.

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
