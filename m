Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Dec 2010 14:00:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: How to implement multiple instances of obexd service?
Message-ID: <20101213120003.GA12104@jh-x301>
References: <AANLkTin4xG5KUEpn6QaZA0V6y3cDvxpWhwRJhMrE_8QO@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTin4xG5KUEpn6QaZA0V6y3cDvxpWhwRJhMrE_8QO@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Mon, Dec 13, 2010, Slawomir Bochenski wrote:
> In order to fully implement Message Access Profile, support for more
> than one so-called instance is needed (MAP specification, chapter
> 3.1.8). According to specs, separate e-mail accounts on MSE should be
> represented by separate MAS instances. This requires one SDP record
> per instance and those differ by MASInstanceID and ServiceName.
> 
> As I understand this also implies that each and every instance needs
> its own separate RFCOMM channel?

Yep, I think that's implied, since othewise we can't detect which MAS
instance the client is trying to connect to (if I read the spec
correctly).

> What would be the preffered way to deal with this ugliness in obexd
> code?

Since we're primarly conserned with supporting only SMS for now, I think
it's too early to start adding complexity to the code due to this
feature. I.e. let's get working MAP with SMS support integrated upstream
and only after that start looking into these more advanced features.

> If separate channels are needed how to keep this in compliance
> with bluez doc/assigned-numbers.txt?

We'll need to reserve some channels for additional MAS instances.

> And what about assigned bitmask values for services in src/obex.h?

Do we need to change something there?

Johan
