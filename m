Return-Path: <Steven.Singer@csr.com>
Message-ID: <4189272C.4080306@csr.com>
Date: Wed, 03 Nov 2004 18:45:00 +0000
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Stephen Crane <steve.crane@rococosoft.com>,
   BlueZ Mailing List
    <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFCOMM service level security testing
References: <1099151759.16247.18.camel@pegasus>
    <1099433039.7125.13.camel@pegasus>
    <1099495689.3265.44.camel@baroque.rococosoft.com>
    <1099496238.6330.2.camel@notepaq>
    <1099497364.3261.64.camel@baroque.rococosoft.com>
    <41890BFF.8040501@csr.com> <1099504367.7125.131.camel@pegasus>
In-Reply-To: <1099504367.7125.131.camel@pegasus>
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> do you know any document that explicit requires it? Maybe SIM Access?

Not offhand, but I would have thought it was implicit in the security
model.

Not many systems have to worry about running profiles whilst
simultaneously allowing direct access to HCI.

Of course, even for systems that don't allow access to HCI, they still
have to worry about the other side disabling encryption.

> I heard rumors that encryption costs more CPU and so consumes more
> power. Is this still true with modern chips or can we ignore this?

I'd be surprised if this has ever been true to a significant level.

The encryption engine used in Bluetooth is quite lightweight if
implemented in hardware. I can't imagine that anyone has implemented it
in software (not least because the encryption stream used depends on the
time at which the packet is transmitted - retransmits use a different
obscuring stream).

Compared to the power the rest of the system is taking (most notably,
the radio), the encryption is negligible.

It's reasonable to work on a model that encryption is free. In which
case the question is, is there any reason encryption shouldn't be turned
on as early as possible (as soon as authentication completes)?

> This is a good point, but I think I will explicit have this fine gain
> control. However it is enough to set the *_ENCRYPT flag for example and
> the authentication will be triggered always first.

Strictly speaking, it's impossible to enable encryption at the baseband
level without first having authenticated (though only one side needs to
have initiated authentication).

There's a strong argument, however, for having just one combined flag
that requests both authentication and encryption. Fewer flags means
less complexity.

The problem with having separate flags is that someone might think "oh,
I don't care if anyone snoops on this data, I just want to make sure I
get requests only from trusted devices". In that case they might request
only authentication and not encryption. Unfortunately, this is not
enough to prevent session hijacking.

By having just one flag, you remove the possibility that anyone could
chose an inappropriate setting. They'll just have two options: secure
and insecure.

	- Steven



**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************
