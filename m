Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Feb 2011 11:21:39 -0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7 v3] Add return value to query tracker
Message-ID: <20110215142139.GA18921@jh-x301>
References: <1297675191-8046-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297675191-8046-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Mon, Feb 14, 2011, Radoslaw Jablonski wrote:
> Previously errors were returned via parameter err - it was needed
> because some time ago query_tracker was returning newly allocated
> structure. Now returning error through return value has more
> sense.
> ---
>  plugins/phonebook-tracker.c |   37 ++++++++++++++++++-------------------
>  1 files changed, 18 insertions(+), 19 deletions(-)

All seven patches have been pushed upstream. Thanks.

Johan
