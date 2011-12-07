Return-Path: <cyrus@holtmann.org>
Date: Wed, 7 Dec 2011 13:23:29 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH hciemu] Process Read Local AMP Info in hciemu
Message-ID: <20111207112329.GA14827@x220>
References: <1321522151-7285-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321522151-7285-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Nov 17, 2011, Emeltchenko Andrei wrote:
> Add processing of Read Local AMP Info in hciemu, the values returned are
> used to emulate AMP HCI.
> ---
>  test/hciemu.c |   34 ++++++++++++++++++++++++++++++++++
>  1 files changed, 34 insertions(+), 0 deletions(-)

Thanks to recent changes from Marcel this patch doesn't apply anymore.

Johan
