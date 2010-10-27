Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Oct 2010 09:49:10 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?utf-8?B?UmFmYcWC?= Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Optimize call history queries
Message-ID: <20101027134910.GA27339@jh-x301>
References: <AANLkTikwCntXxSzqc1VpA1L27UChsHK=GLmhcHXb8coX@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTikwCntXxSzqc1VpA1L27UChsHK=GLmhcHXb8coX@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Wed, Oct 27, 2010, Rafał Michalski wrote:
> This patch optimizes call history queries - now there is no redundant
> results of invoking them.
> ---
>  plugins/phonebook-tracker.c |   74 ++++++++++++++++++++----------------------
>  1 files changed, 35 insertions(+), 39 deletions(-)

Pushed upstream. Thanks. Btw, if possible please send the patches in the
message body instead of an attachment (use e.g. git send-email for
this).  This would make your patch submissions more consistent with the
rest and ease my work (by not having to always check if I should pipe
the main message or the attachment to git am).

Johan
