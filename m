Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 11:42:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/7] Refactor get_eir_uuids() to get EIR data length
 parameter
Message-ID: <20101111094247.GD4132@jh-x301>
References: <1289411487-6113-1-git-send-email-anderson.lizardo@openbossa.org>
 <1289411487-6113-2-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289411487-6113-2-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 10, 2010, Anderson Lizardo wrote:
> get_eir_uuids() will be reused to parse LE advertising data as well, as
> they share the same format. But for Advertising, maximum data length is
> different (31 bytes vs. 240 bytes for EIR), and the radio is not
> required to send the non-significant (zero-filled) bytes.
> 
> adapter_emit_device_found() now also accepts a EIR data length
> parameter, so it can be reused for LE and can propagate the exact data
> length.
> ---
>  src/adapter.c |   17 ++++++++++-------
>  src/adapter.h |    2 +-
>  src/event.c   |    2 +-
>  3 files changed, 12 insertions(+), 9 deletions(-)

This patch seems fine, but it doesn't apply anymore since the first
patch of the set had issues and I didn't apply it.

Johan
