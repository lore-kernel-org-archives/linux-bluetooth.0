Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100721101934.GA12188@jh-x301>
References: <4C46324D.5070800@aircable.net>
	<20100721101934.GA12188@jh-x301>
Date: Wed, 21 Jul 2010 16:26:53 +0300
Message-ID: <AANLkTikcy_R0SOhL52AD372_DTA3c2pUVEY85lh3ZEj3@mail.gmail.com>
Subject: Re: [PATCH][RFC] Fix SDP resolving segfault
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Manuel Naranjo <manuel@aircable.net>,
	BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jul 21, 2010 at 1:19 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> I don't really understand the need for these changes, but admitedly the
> function does have issues since it first checks for !ctxt->session and
> then later for ctxt->session even though at that point it's already
> guaranteed that ctxt->session is not NULL.

Yep, I suspect it is something else too, there doesn't seems to be a
call to bt_cancel_discovery in the last trace sent to the list, but
the check for ctxt->session there seems buggy, we should always remove
the context doesn't matter if it is connected or not.

@Manuel: Does valgrind give you a nice bracktrace when it bluetoothd segfaults?

Normally I use something like this:

> sudo valgrind --trace-children=yes ./bluetoothd -dn

-- 
Luiz Augusto von Dentz
Computer Engineer
