Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Sep 2010 10:02:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix problem with phonebook size
Message-ID: <20100906070201.GA11700@jh-x301>
References: <1283509311-3965-1-git-send-email-lucas.pawlik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283509311-3965-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Fri, Sep 03, 2010, Lukasz Pawlik wrote:
> This patch fix problem with phonebook size during phonebook
> pull request. Now obexd "combine" the raw results from tracker DB
> to match with that what phonebook pull returns.
> ---
>  plugins/phonebook-tracker.c |   13 ++++++-------
>  1 files changed, 6 insertions(+), 7 deletions(-)

Thanks. The patch is now upstream.

Johan
