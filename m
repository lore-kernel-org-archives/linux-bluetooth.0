Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bthid question
From: Marcel Holtmann <marcel@holtmann.org>
To: Gareth Reakes <gareth@apache.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20031128125922.O44245@minotaur.apache.org>
References: <20031128011412.C61007@minotaur.apache.org>
	 <1070025957.9036.153.camel@pegasus>
	 <20031128060135.H61007@minotaur.apache.org>
	 <1070031670.9036.166.camel@pegasus>
	 <20031128070531.F61007@minotaur.apache.org>
	 <20031128125922.O44245@minotaur.apache.org>
Content-Type: text/plain
Message-Id: <1070057994.9033.209.camel@pegasus>
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
Date: Fri, 28 Nov 2003 23:19:55 +0100

Hi Gareth,

> Does anyone have any idea what to try next (I will start work on the USB
> HID kernel modification when I have some time soon but would love to get
> them working first)?

I am thinking of having only one bthid running and using an event loop
to multiplex all the file descriptors. We can also try to use uinput and
have our own HID parser in userspace. What do you think?

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
