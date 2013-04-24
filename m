Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH] Bluetooth: Fix checks for LE support on LE-only controllers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1366797932-11507-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 24 Apr 2013 07:05:59 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FA2EA2E6-0A60-4175-8AE4-7219D0E21517@holtmann.org>
References: <1366797932-11507-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> LE-only controllers do not support extended features so any kind of host
> feature bit checks do not make sense for them. This patch fixes code
> used for both single-mode (LE-only) and dual-mode (BR/EDR/LE) to use the
> HCI_LE_ENABLED flag instead of the "Host LE supported" feature bit for
> LE support tests.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>

Acked-by: Marcel Holtmann <marcel@holtmann.org>

> ---
> This one slipped by with my earlier single-mode fixes. I've added a
> mgmt-tester case for it to prevent it from returning in the future.
> Since this is probably too late for a bluetooth-next pull for 3.10 I
> suppose it'll need to wait for the first bluetooth.git pull request
> instead.

I have to agree. Once 3.10 is out this should go in as a bug fix.

Regards

Marcel

