Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Jan 2011 14:01:07 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Remove unused columns in PBAP queries
Message-ID: <20110107120107.GB31948@jh-x301>
References: <1294391018-3109-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1294391018-3109-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Fri, Jan 07, 2011, Radoslaw Jablonski wrote:
> Application for filling contact's data does not use
> "contact:" for attaching email, phones, and addresses
> without context. This fix removes columns for getting
> mentioned data from "contact:" context - they are no
> longer needed (all phone, email and addresses are now
> fetched from "affilation" structures).
> ---
>  plugins/phonebook-tracker.c |  184 ++++--------------------------------------
>  1 files changed, 18 insertions(+), 166 deletions(-)

This one has also been pushed upstream. Thanks.

Johan
