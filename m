Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Nov 2010 14:00:35 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix fetching contact photo file name
Message-ID: <20101122130035.GA29249@jh-x301>
References: <1289828017-13412-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289828017-13412-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Nov 15, 2010, Bartosz Szatkowski wrote:
> Previously photo id was fetched. File name may be further converted to
> binary data (actual image) if such behavior would be desired in the future.
> ---
>  plugins/phonebook-tracker.c |   60 ++++++++++++++++++++++++++++++++++++++----
>  1 files changed, 54 insertions(+), 6 deletions(-)

Sorry about the delay with this one (I simply missed it). The patch has
now been pushed upstream.

Johan
