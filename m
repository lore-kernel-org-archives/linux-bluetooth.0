Return-Path: <gareth@apache.org>
Date: Wed, 5 Nov 2003 15:06:03 -0800 (PST)
From: Gareth Reakes <gareth@apache.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with MS mouse and keyboard
In-Reply-To: <1068072643.1284.106.camel@pegasus>
Message-ID: <20031105150230.T694@minotaur.apache.org>
References: <20031105093947.J63252@minotaur.apache.org> <1068072643.1284.106.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

> it looks like you lost the ACL link, but the mouse didn't know about
> that and keeps sending you reports on that channel.
>
> Do you get this working under Windows XP. If not, they are broken.

I will fish out the drivers and find someone with XP to test them. I will
hopefully do this next week and will give a shout back about success then.
However, I assume that the 100% CPU usage is not a good thing? I will
happily build this stuff up in debug mode and try and start it under gdb
to get a backtrace if this will be helpful for bluez development. Tell me
if there is anything I can do.

Thanks for your help,

Gareth
