Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Nov 2010 18:11:04 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix status problem after pulling empty call history
Message-ID: <20101104181104.GA15469@jh-x301>
References: <1288871880-5857-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288871880-5857-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Thu, Nov 04, 2010, Rafal Michalski wrote:
> Problem with "OK" status after pulling phonebook for empty call history
> (cch) is fixed by this patch. Previously "OK" status was received even
> for empty (as it normally does for non-empty) call history and now
> "Not Found" status is received in case when there is no call event.
> ---
>  plugins/pbap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
