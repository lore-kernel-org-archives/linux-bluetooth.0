Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bthid question
From: Marcel Holtmann <marcel@holtmann.org>
To: Gareth Reakes <gareth@apache.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20031128060135.H61007@minotaur.apache.org>
References: <20031128011412.C61007@minotaur.apache.org>
	 <1070025957.9036.153.camel@pegasus>
	 <20031128060135.H61007@minotaur.apache.org>
Content-Type: text/plain
Message-Id: <1070031670.9036.166.camel@pegasus>
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
Date: Fri, 28 Nov 2003 16:01:10 +0100

Hi Gareth,

> Thanks for the clarification. I have 1 more question. Is the ACL link
> supposed to be terminated with the close of the control/interupt channels?
> I'm sorry if this is obvious, but I do not yet understand exactly what
> this ACL link is in relation to the sockets we have open. If this is the
> case (and I am reading Peter's code correctly) then would you think that
> my problem may be that when the HID terminiates the connection, we do not
> close the sockets and therefore the ACL link?

this is Bluetooth specific, so you should read the specification. The
underlaying data link is always ACL and there is also only one ACL link
between two devices. The L2CAP or RFCOMM connections share always the
same ACL link.

If you exit the program without closing the L2CAP sockets, the OS will
close it for you and this is the same as you close the sockets without
sleeping between it. Closing the ACL link is the job of the kernel.

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
