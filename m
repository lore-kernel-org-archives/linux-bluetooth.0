Return-Path: <gareth@apache.org>
Date: Fri, 28 Nov 2003 14:38:41 -0800 (PST)
From: Gareth Reakes <gareth@apache.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bthid question
In-Reply-To: <1070057994.9033.209.camel@pegasus>
Message-ID: <20031128143645.Y44245@minotaur.apache.org>
References: <20031128011412.C61007@minotaur.apache.org>  <1070025957.9036.153.camel@pegasus>
  <20031128060135.H61007@minotaur.apache.org>  <1070031670.9036.166.camel@pegasus>
  <20031128070531.F61007@minotaur.apache.org>  <20031128125922.O44245@minotaur.apache.org>
 <1070057994.9033.209.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

Hey Marcel,

> I am thinking of having only one bthid running and using an event loop
> to multiplex all the file descriptors. We can also try to use uinput and
> have our own HID parser in userspace. What do you think?

Sounds good to me. I will happily put some time in. I am going to read the
Bluetooth spec over the weekend. Any other reading materials you suggest
that I should read before we attempt this?

Cheers,

Gareth
