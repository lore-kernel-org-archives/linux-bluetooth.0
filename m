Return-Path: <gareth@apache.org>
Date: Fri, 28 Nov 2003 07:06:44 -0800 (PST)
From: Gareth Reakes <gareth@apache.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bthid question
In-Reply-To: <1070031670.9036.166.camel@pegasus>
Message-ID: <20031128070531.F61007@minotaur.apache.org>
References: <20031128011412.C61007@minotaur.apache.org>  <1070025957.9036.153.camel@pegasus>
  <20031128060135.H61007@minotaur.apache.org> <1070031670.9036.166.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>


> If you exit the program without closing the L2CAP sockets, the OS will
> close it for you and this is the same as you close the sockets without
> sleeping between it. Closing the ACL link is the job of the kernel.

OK, this may be the problem then :) Thanks for that. I will try it when I
get home tonight and report back.

I appreciate all your time on this Marcel,

Gareth
