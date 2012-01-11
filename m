Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Jan 2012 16:45:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: jaganath.k@samsung.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/2] Fix incorrect transfer path id during request
 authorization
Message-ID: <20120111144510.GA31139@x220>
References: <1326292215-17824-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326292215-17824-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Wed, Jan 11, 2012, jaganath.k@samsung.com wrote:
> From: jaganath.k <jaganath.k@samsung.com>
> 
> Transfer is registered with id as cid, but authorize method
> is called with id as pointer to obex session structure
> ---
>  src/manager.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Both of these patches look fine to me, but you need to fix your git
author name. Once you've done that please resend the patches.

I also noticed that I've by mistake already applied another patch from
you in December with the same bogus author name, so you'll end up
getting your own entry in our infamous .mailmap file.

Johan
