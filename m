Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 May 2011 13:42:48 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Rewrite of PBAP call history queries
Message-ID: <20110518204248.GA31478@dell.amr.corp.intel.com>
References: <1305723910-13168-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305723910-13168-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Wed, May 18, 2011, Slawomir Bochenski wrote:
> Graph patterns used in queries for PullPhonebook and PullvCardListing in
> case of call history are now rewritten to share the same code and be
> simpler - previously they were doing almost the same, but exact code
> differed. So in this patch repeating parts of queries were reduced to one
> place for easy management.
> 
> Also new queries fix the behaviour in situation when there is more than
> one contact matching a phone number from call history entry - in this
> case no contact data is returned instead of returning random contact as
> it was the case before.
> ---
>  plugins/phonebook-tracker.c |  600 ++++--------------------------------------
>  1 files changed, 58 insertions(+), 542 deletions(-)

Applied. Thanks.

Johan
