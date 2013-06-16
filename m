Return-Path: <cyrus@holtmann.org>
Date: Sun, 16 Jun 2013 18:30:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Subject: Re: [PATCH] lib: Fix two size constants
Message-ID: <20130616153037.GA6010@x220.P-661HNU-F1>
References: <1370985402-27535-1-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370985402-27535-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Tue, Jun 11, 2013, Alex Deymo wrote:
> Fixes the value of RESET_FAILED_CONTACT_COUNTER_RP_SIZE and
> RESET_FAILED_CONTACT_COUNTER_RP_SIZE macros to respect the
> associated struct.
> ---
>  lib/hci.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
