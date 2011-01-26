Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Jan 2011 14:46:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] Remove unnecessary ordering from single vCard
 query
Message-ID: <20110126124648.GA11799@jh-x301>
References: <1296045187-28072-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296045187-28072-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Wed, Jan 26, 2011, Rafal Michalski wrote:
> Previously ordering for query called CONTACTS_QUERY_FROM_URI was applied.
> It is not needed since always only one vCard (with id specified)
> is fetched.
> ---
>  plugins/phonebook-tracker.c |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)

Pushed upstream. Thanks.

Johan
