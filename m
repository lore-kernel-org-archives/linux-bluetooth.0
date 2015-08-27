Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 Aug 2015 13:27:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Norbert Holze <norbert.holze@web.de>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: btusb regression / 0a12:0001 CSR
Message-ID: <20150827102711.GA28958@t440s.lan>
References: <55C6F858.5080808@web.de>
 <BC6C2463-83DF-4825-95FC-A55A5B825B0A@holtmann.org>
 <55C7947A.6050605@web.de>
 <55DB58B7.5080101@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55DB58B7.5080101@web.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Norbert,

On Mon, Aug 24, 2015, Norbert Holze wrote:
> Is it possible to add a quirk or something else?

This was reported in the kernel.org bug tracker as well. Could you try
the patch proposal that I've attached there:

https://bugzilla.kernel.org/show_bug.cgi?id=103451

In the bug report it's just a single patch but I'll probably split it
into two for the final upstream submission.

Johan
