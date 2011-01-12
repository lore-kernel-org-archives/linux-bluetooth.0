Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Jan 2011 17:46:46 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix crash after fetching single owner vCard
Message-ID: <20110112154646.GA3101@jh-x301>
References: <1294845338-15655-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1294845338-15655-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Wed, Jan 12, 2011, Rafal Michalski wrote:
> This patch makes that crash is avoided in case of fetching single owner
> vCard (0.vcf) from phonebook. Crash was caused because previous
> modifications of other queries wasn't included in query called
> CONTACTS_OTHER_QUERY_FROM_URI.
> ---
>  plugins/phonebook-tracker.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Thanks. The patch has been pushed upstream.

Johan
