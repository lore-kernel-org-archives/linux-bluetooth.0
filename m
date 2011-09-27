Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 12:37:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Simplify counting new missed calls
Message-ID: <20110927093743.GF3952@dell>
References: <1314180743-10067-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314180743-10067-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

(This starts off my round of "applied to github" notifications for
obexd)

On Wed, Aug 24, 2011, Slawomir Bochenski wrote:
> This replaces parsing missed calls listing that was used to get the
> number of missed calls that have been unread with a simple SPARQL
> query.
> 
> Previous code was trying to deal with misbehaviour of commhistoryd but
> still was failing in some cases. commhistoryd is now fixed.
> ---
>  plugins/phonebook-tracker.c |  105 +++++++++----------------------------------
>  1 files changed, 22 insertions(+), 83 deletions(-)

Applied. Thanks.

Johan
