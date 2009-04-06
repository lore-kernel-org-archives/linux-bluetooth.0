Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Apr 2009 22:34:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Eiko Oltmanns <eiko.oltmanns@web.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: problem with reading from rfcomm socket
Message-ID: <20090406193443.GA969@jh-x301>
References: <49D511C2.5040304@web.de> <49DA5249.30008@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49DA5249.30008@web.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eiko,

On Mon, Apr 06, 2009, Eiko Oltmanns wrote:
> I think my code should be correct, isn't it? Is there maybe an option in the
> kernel config, that could cause such a behaviour of the socket?

Take a look at existing examples in the bluez source, e.g. tools/rctest.c.
You're missing a call to bind after the call to socket and before the call to
connect.

Joah
