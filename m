Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Aug 2010 11:03:24 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix problem with multiple emails in vcard
Message-ID: <20100819080323.GA6125@jh-x301>
References: <1282200587-5475-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282200587-5475-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Thu, Aug 19, 2010, Radoslaw Jablonski wrote:
> Previously only one email appeared in generated vcard, even if contact
> had defined multiple email addresses in contact data.
> Changed vcard struct and phonebook-tracker pull_contacts func to support
> multiple emails.
> ---
>  plugins/phonebook-tracker.c |   99 +++++++++++++++++++++++++++++-------------
>  plugins/vcard.c             |   12 ++++-
>  plugins/vcard.h             |    2 +-
>  3 files changed, 78 insertions(+), 35 deletions(-)

Thanks. The patch is now upstream.

Johan
