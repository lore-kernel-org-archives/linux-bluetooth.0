Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Nov 2010 13:37:43 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Split pull_contacts to smaller functions
Message-ID: <20101116133743.GC10566@jh-x301>
References: <1289822497-5338-1-git-send-email-bulislaw@linux.com>
 <1289822497-5338-2-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289822497-5338-2-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Mon, Nov 15, 2010, Bartosz Szatkowski wrote:
> Parts of pull_contact responsible for filling contact fields moved
> to new functions.
> ---
>  plugins/phonebook-tracker.c |  159 ++++++++++++++++++++++++------------------
>  1 files changed, 91 insertions(+), 68 deletions(-)

This one doesn't apply cleanly to current git. Could you please resend it?

Johan
