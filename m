Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Apr 2015 14:56:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [V4.1] Regression: Bluetooth mouse not working.
Message-ID: <20150417115613.GA9308@t440s.lan>
References: <CADDKRnBzf+dPqzHxXBWynwssc4su-7LVDCteZCNJJXJEuVca0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CADDKRnBzf+dPqzHxXBWynwssc4su-7LVDCteZCNJJXJEuVca0w@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jörg,

(unnecessary people and lists dropped from CC)

On Fri, Apr 17, 2015, Jörg Otte wrote:
> The BT mouse is "death" in v4.1.

Could you be a bit more specific what you mean by v4.1, considering that
it's not yet released (we don't even have a 4.1-rc1 yet).

> The BT mouse has been working in 4.0 and previous kernels, so this
> is a regression.
> 
> BT adapter is an intel 8087:07da. The mouse is an MS Notebook Mouse 500.

There was an initialization issue with 8087:07da that was already fixed,
and the fix should be going to the 4.1 kernel. Could it be that you're
simply missing this commit in your tree? It is this one:

commit 407550fe2ccfca3fa0ac4bcdb0a412adeabf84ba
Author: Marcel Holtmann <marcel@holtmann.org>
Date:   Sun Feb 22 15:41:18 2015 -0800

    Bluetooth: btusb: Fix issue with CSR based Intel Wireless controllers

Johan
