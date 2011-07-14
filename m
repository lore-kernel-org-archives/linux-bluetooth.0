Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Jul 2011 16:43:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/2] Revert handling CALL-DATETIME in PullvCardEntry
Message-ID: <20110714134320.GE2770@dell.ger.corp.intel.com>
References: <1310566804-26748-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310566804-26748-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Wed, Jul 13, 2011, Bartosz Szatkowski wrote:
> This reverts commit 02d8dea9490b8852b837e143a09891817a4965f9.
> The constraints for pulling single vCard are to loose and causes other
> numbers to be merged into same vCard. Also there is more elegant way of
> applying the new changes.
> ---
>  plugins/phonebook-tracker.c |   30 +++++++-----------------------
>  1 files changed, 7 insertions(+), 23 deletions(-)

Both patches have been applied. Thanks.

Johan
