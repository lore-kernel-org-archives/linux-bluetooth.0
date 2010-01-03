Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4B40CC74.1060508@gmail.com>
References: <4B40CC74.1060508@gmail.com>
From: roel kluin <roel.kluin@gmail.com>
Date: Sun, 3 Jan 2010 18:44:57 +0100
Message-ID: <25e057c01001030944h5c9c84e1i4712ee48d7cead67@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Wrong variable tested
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Jan 3, 2010 at 5:57 PM, Roel Kluin <roel.kluin@gmail.com> wrote:
> The return of the function sdio_readb() was not tested.

Please ignore, as Joe Perches pointed out it's wrong.

Roel
