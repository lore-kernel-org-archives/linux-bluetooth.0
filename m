Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Aug 2010 08:19:15 -0400
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add support for FAX number in phonebook-tracker.c
Message-ID: <20100813121915.GB2819@jh-x301>
References: <1281697117-23072-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281697117-23072-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Fri, Aug 13, 2010, Radoslaw Jablonski wrote:
> Previously all fax numbers were treated as home phone numbers. Now
> fetching fax field as additional column in tracker query. Data from this
> column is filled as phone number with FAX type set. All pull queries are
> modified that way to suport fax number type.
> ---
>  plugins/phonebook-tracker.c |  129 +++++++++++++++++++++++++++++++++---------
>  1 files changed, 101 insertions(+), 28 deletions(-)

Thanks. This patch is now also upstream.

Johan
