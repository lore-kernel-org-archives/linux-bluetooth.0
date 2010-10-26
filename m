Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Oct 2010 10:07:20 -0400
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Add separate queries for listing size in PBAP
Message-ID: <20101026140720.GA11212@jh-x301>
References: <1288081792-15296-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
 <1288081792-15296-2-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288081792-15296-2-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Tue, Oct 26, 2010, Radoslaw Jablonski wrote:
> Previosly to get phonebook-size or call history size, full phonebook
> query was used and a lot of unnecessary operations need to be done on
> that returned data.  Now separate query is used to get size of each
> listing so performance for "getPhonebookSize" operations improved a lot.
> ---
>  plugins/phonebook-tracker.c |  105 ++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 103 insertions(+), 2 deletions(-)

Both patches have been pushed upstream. Thanks.

Johan
