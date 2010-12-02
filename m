Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Dec 2010 18:22:36 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Optimize tracker queries for PBAP
Message-ID: <20101202162236.GA1291@jh-x301>
References: <1291305728-3463-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291305728-3463-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Thu, Dec 02, 2010, Radoslaw Jablonski wrote:
> Now data from tracker is fetched without redundand fields. Also
> determining which type has phone, address and email (work or home) is
> done in backend code - no tracker sub-query is used for that case. Now
> queries are about 6 times faster for any amount of data( call history
> queries, which were heavy loaded with OPTIONAL sub-queries are even 10
> times faster than before)
> ---
>  plugins/phonebook-tracker.c |  514 ++++++++++++++-----------------------------
>  1 files changed, 166 insertions(+), 348 deletions(-)

Pushed upstream. Thanks.

Johan
