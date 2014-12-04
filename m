Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Dec 2014 11:13:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] shared/crypto: Fix resource leak
Message-ID: <20141204091350.GA761@t440s.lan>
References: <1417683055-24584-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417683055-24584-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Dec 04, 2014, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Fix leaking fd on exit
> ---
>  src/shared/crypto.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied. Thanks.

Johan
