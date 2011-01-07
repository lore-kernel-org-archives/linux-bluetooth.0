Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Jan 2011 14:00:31 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix for handling emails in pull call history queries
Message-ID: <20110107120031.GA31948@jh-x301>
References: <1294388397-1642-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1294388397-1642-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Fri, Jan 07, 2011, Radoslaw Jablonski wrote:
> Previously only emails of one type at a time were listed
> in call history for given contact. With this fix every
> email for contact will be displayed in pull call history
> result.
> ---
>  plugins/phonebook-tracker.c |   99 ++++++++++++++++++++++++++++++-------------
>  1 files changed, 69 insertions(+), 30 deletions(-)

The patch has been pushed upstream. Thanks.

Johan
