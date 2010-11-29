Return-Path: <cyrus@holtmann.org>
Date: Mon, 29 Nov 2010 16:13:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix problem with fetching 0.vcf vCard entry
Message-ID: <20101129141354.GA17807@jh-x301>
References: <1291038716-7244-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291038716-7244-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Mon, Nov 29, 2010, Rafal Michalski wrote:
> Previously after attempting to get single 0.vcf vCard entry from phonebook
> ("telecom/pb/0.vcf") "Not Found" status was received and this entry wasn't
> downloaded. Now "OK" status is received and valid 0.vcf vCard entry is
> downloaded.
> ---
>  plugins/phonebook-tracker.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
