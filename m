Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 Sep 2010 19:55:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Removing role field from ORG tag
Message-ID: <20100910165507.GA10395@jh-x301>
References: <1284127974-8230-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284127974-8230-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Fri, Sep 10, 2010, Rafal Michalski wrote:
> Previously role field was under ORG tag. Now it's single field under
> ROLE tag.
> ---
>  plugins/phonebook-tracker.c |    2 +-
>  plugins/vcard.c             |   12 ++++++------
>  plugins/vcard.h             |    2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)

The patch has been pushed upstream. Thanks.

Johan
