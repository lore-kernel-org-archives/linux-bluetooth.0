Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Aug 2010 07:13:28 -0400
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Use enum from vcard.h for phone types
Message-ID: <20100812111328.GA19296@jh-x301>
References: <1281599353-27811-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281599353-27811-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Thu, Aug 12, 2010, Radoslaw Jablonski wrote:
> Removed redundant declarations for phone types. Now using values from
> phonebook_number_type declared in vcard.h.
> ---
>  plugins/phonebook-tracker.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)

The patch has been applied and pushed upstream. Thanks.

Johan
