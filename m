Return-Path: <cyrus@holtmann.org>
Subject: Re: PATCH for input/fakehid.c to fix PS3 remote unpairing
From: Bastien Nocera <hadess@hadess.net>
To: "Ruslan N. Marchenko" <rufferson@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <a70b8cd30908190910p35910657m28fe09905717d60@mail.gmail.com>
References: <a70b8cd30908190910p35910657m28fe09905717d60@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 19 Aug 2009 17:16:18 +0100
Message-Id: <1250698578.11521.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2009-08-19 at 18:10 +0200, Ruslan N. Marchenko wrote:
> Hi,
> Here is the patch to correctly handle PS3 remote unpairing and manual
> turning off.

How do you test this?

<snip>

> I'm also thinking on implementing keymapping through input.conf
> configuration section. Will it be accepted or not worth trying?

You should handle this in the input user-space, or in X itself, rather
than in bluez.

Cheers

