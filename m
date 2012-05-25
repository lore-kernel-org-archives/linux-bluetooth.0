Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1337940693-3417-4-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337940693-3417-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1337940693-3417-4-git-send-email-mikel.astiz.oss@gmail.com>
Date: Fri, 25 May 2012 12:15:17 +0200
Message-ID: <CANT-zCWphPtG7_ZSPYiXOmc-EAtTQKg8SRrOYdoqe-UDBDhB6Q@mail.gmail.com>
Subject: Re: [PATCH obexd v1 03/16] client: Add progress property to transfer
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

On Fri, May 25, 2012 at 12:11 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> The number of transferred bytes is exposed in D-Bus using a specific
> property for this purpose.
>
> Internally, the value of this property does not necessarily match the
> internal progress counter. In order to avoid D-Bus overhead, the
> property will be updated at least every N bytes, where N is fixed and
> hardcoded (TRANSFER_PROGRESS_PERIOD).
> ---
>  client/transfer.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 49 insertions(+), 2 deletions(-)
>

I just realized the commit message needs to be updated here. I will
include the change in the next version after your reviews.

Cheers,
Mikel
