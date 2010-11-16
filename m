Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Nov 2010 13:35:49 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Using field names instead of numbers in PBAP
Message-ID: <20101116133549.GB10566@jh-x301>
References: <1289822497-5338-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289822497-5338-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Mon, Nov 15, 2010, Bartosz Szatkowski wrote:
> Previously addressing via field numbers and field names were mixed in PBAP
> query replies. Now there is defined name for each data base reply field.
> ---
>  plugins/phonebook-tracker.c |  104 +++++++++++++++++++++++++++++++-----------
>  1 files changed, 77 insertions(+), 27 deletions(-)

Pushed upstream. Thanks.

Johan
