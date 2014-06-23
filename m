Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Jun 2014 14:38:27 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix using address of array instead of size
Message-ID: <20140623113827.GC24897@t440s>
References: <20140623075529.GA29804@t440s>
 <1403522375-30438-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403522375-30438-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Jun 23, 2014, Andrei Emeltchenko wrote:
> Address of array is always not NULL.
> ---
>  src/device.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied. Thanks.

Johan
