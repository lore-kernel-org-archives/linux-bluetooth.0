Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Feb 2011 12:00:32 -0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add increasing query OFFSET in phonebook_pull_read
Message-ID: <20110216150032.GA21777@jh-x301>
References: <1297848855-29991-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297848855-29991-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Wed, Feb 16, 2011, Radoslaw Jablonski wrote:
> It is needed to properly move starting index in tracker
> for next invocations of phonebook_pull_read - without that
> pull result for bigger queries (over one part of data) will
> be wrong (it will include duplicate vcard entries).
> ---
>  plugins/phonebook-tracker.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)

Pushed upstream. Thanks.

Johan
