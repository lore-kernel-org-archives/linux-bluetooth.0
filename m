Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 May 2013 10:22:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org,
	vinicius.gomes@openbossa.org
Subject: Re: [PATCH] core: Don't update a known long name with a short name.
Message-ID: <20130508072229.GC9401@x220>
References: <1367897517-12309-1-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367897517-12309-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Mon, May 06, 2013, Alex Deymo wrote:
> update_found_devices() could attempt to update a device with new information
> containing only a short verstion of the name. If the struct eir_data passed
> has a short or NULL name, it will never update a previous name and will
> also trigger a "HCI Command: Remote Name Request" if the previous name was
> unknown.
> ---
>  src/adapter.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
