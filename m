Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with MS mouse and keyboard
From: Marcel Holtmann <marcel@holtmann.org>
To: Gareth Reakes <gareth@apache.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20031126134816.L25686@minotaur.apache.org>
References: <20031105093947.J63252@minotaur.apache.org>
	 <1068072643.1284.106.camel@pegasus>
	 <20031105150230.T694@minotaur.apache.org>
	 <20031122040102.E53230@minotaur.apache.org>
	 <1069532556.16350.82.camel@pegasus>
	 <20031122124825.T53230@minotaur.apache.org>
	 <20031126131925.M25686@minotaur.apache.org>
	 <1069882659.9032.54.camel@pegasus>
	 <20031126134816.L25686@minotaur.apache.org>
Content-Type: text/plain
Message-Id: <1069884332.9036.62.camel@pegasus>
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
Date: Wed, 26 Nov 2003 23:05:32 +0100

Hi Gareth,

> 	thanks for the response. Is there someway I can simulate this with
> hcitool (or some other tool)? If I hcitool cc to this what would you
> expect the behaveiour to be? The mouse will go to sleep in 12 mins, but if
> I move it and to a hcitool con after that should the device appear? Or
> would I have to connect again? I seem to recall that there was some way of
> showing the incoming input from the connection. If I did this without
> bthid, then would this establish if the problem was with bthid or bluez?

you can't use hcitool, because you have to establish the two HID L2CAP
connections for PSM 17 and 19.

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
