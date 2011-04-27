Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Apr 2011 16:23:41 -0700
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Remove grouping by phone number in call-history results
Message-ID: <20110427232341.GA26404@jh-x301>
References: <1303901520-6508-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1303901520-6508-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Wed, Apr 27, 2011, Radoslaw Jablonski wrote:
> Now call history entries are distinguished also by call
> date (previously only contact-id was compared, so calls with
> different date were grouped into one entry in pull results).
> This change is needed for headsets with PBAP support that are
> confused when number of "new missed calls" is different than
> number of returned entries by pull call-history response (by
> example Nokia BH-903 hangs when this happens).
> ---
>  plugins/phonebook-tracker.c |   30 +++++++++++++++++++++++++++---
>  1 files changed, 27 insertions(+), 3 deletions(-)

Pushed upstream. Thanks.

Johan
