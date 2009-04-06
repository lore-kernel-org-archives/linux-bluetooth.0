Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Apr 2009 22:39:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Eiko Oltmanns <eiko.oltmanns@web.de>,
	linux-bluetooth@vger.kernel.org
Subject: Re: problem with reading from rfcomm socket
Message-ID: <20090406193946.GA1108@jh-x301>
References: <49D511C2.5040304@web.de> <49DA5249.30008@web.de> <20090406193443.GA969@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090406193443.GA969@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Apr 06, 2009, Johan Hedberg wrote:
> Take a look at existing examples in the bluez source, e.g. tools/rctest.c.
> You're missing a call to bind after the call to socket and before the call to
> connect.
> 
> Joah

And despite my signature my name is actually Johan. Guess I should go get some
sleep :P

Johan
