Return-Path: <gareth@apache.org>
Date: Fri, 28 Nov 2003 06:07:09 -0800 (PST)
From: Gareth Reakes <gareth@apache.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bthid question
In-Reply-To: <1070025957.9036.153.camel@pegasus>
Message-ID: <20031128060135.H61007@minotaur.apache.org>
References: <20031128011412.C61007@minotaur.apache.org> <1070025957.9036.153.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

> let me clear this a little bit up. When __io_canceled is true, we are
> terminating the connection to the HID device. In general this is done by
> sending SIGTERM to the process. When __io_canceld is false then the HID
> device cuts the connection. For the Microsoft devices this is after 12
> minutes.


Thanks for the clarification. I have 1 more question. Is the ACL link
supposed to be terminated with the close of the control/interupt channels?
I'm sorry if this is obvious, but I do not yet understand exactly what
this ACL link is in relation to the sockets we have open. If this is the
case (and I am reading Peter's code correctly) then would you think that
my problem may be that when the HID terminiates the connection, we do not
close the sockets and therefore the ACL link?

Cheers,


Gaerth
