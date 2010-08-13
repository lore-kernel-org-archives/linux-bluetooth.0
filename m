Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Aug 2010 08:15:27 -0400
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix unnecessary checking for empty phones list
Message-ID: <20100813121527.GA2819@jh-x301>
References: <1281681311-17074-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281681311-17074-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Fri, Aug 13, 2010, Radoslaw Jablonski wrote:
> Removed not needed anymore checking for empty list of phone numbers.
> ---
>  plugins/vcard.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)

This patch is now upstream. Thanks.

Johan
