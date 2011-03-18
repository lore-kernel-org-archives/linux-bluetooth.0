Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Mar 2011 11:24:51 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Set correct adapter state in cancel_resolve_name
Message-ID: <20110318092451.GB8640@jh-x301>
References: <1300368039-1376-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300368039-1376-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Thu, Mar 17, 2011, Radoslaw Jablonski wrote:
> Previously resetting STATE_RESOLVNAME for adapter was missing.
> This was causing problems with discovering devices when discovery
> was quickly turned off/on during resolving name.
> ---
>  src/adapter.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Pushed upstream. Thanks.

Johan
