Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
Date: Wed, 22 Sep 2004 12:52:26 -0700
Message-ID: <004d01c4a0dd$b09a3810$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1095881636.6223.117.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

> I understand what you mean and it should be impossible to 
> have an socket
> on the accept_q with state BT_CLOSED. May you wanna remove the extra
> code in ...accept_dequeue() and only leave a warning message 
> there when
> you do your tests. However this extra code should not harm and I don't
> see an easy solution for getting the module reference 
> decrementing right
> when we have to do it in ...accept_dequeue() for all socket types.

I think I'll leave the code as is, unless you're considering removing the
code in accept_dequeue(). If there's a problem, we'll see the use count go
up.

Thanks for working on this...  Looks like you spent some late nights on it.

-Daryl.
