Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Jul 2011 16:45:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/5] Fix pulling vCard for multiple ebooks
Message-ID: <20110714134554.GF2770@dell.ger.corp.intel.com>
References: <1310595010-1033-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310595010-1033-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Wed, Jul 13, 2011, Bartosz Szatkowski wrote:
> Problem occurred when there were multiple ebooks and the last one was
> empty. Reported vCard number was 0 and no data was transported.
> ---
>  plugins/phonebook-ebook.c |   15 ++++++++-------
>  1 files changed, 8 insertions(+), 7 deletions(-)

All five patches have been applied. Thanks.

Johan
