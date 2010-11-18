Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Nov 2010 18:48:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix queries for contact with only one affiliation
Message-ID: <20101118164802.GA2441@jh-x301>
References: <1290092503-10324-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290092503-10324-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Thu, Nov 18, 2010, Bartosz Szatkowski wrote:
> Previously some fields may be omitted for contacts with only one affiliation,
> when querying for call history.
> ---
>  plugins/phonebook-tracker.c |   83 ++++++++++++++++++++++++++++---------------
>  1 files changed, 54 insertions(+), 29 deletions(-)

Pushed upstream, but I had to fix the commit message width first. Please
keep it at max 72 characters so that it's properly viewable with git log
on a 80 column wide terminal.

Johan
