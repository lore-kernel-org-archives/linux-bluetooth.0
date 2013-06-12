Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH] lib: Fix two size constants
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1370985402-27535-1-git-send-email-deymo@chromium.org>
Date: Wed, 12 Jun 2013 09:50:41 +0200
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Message-Id: <AF7724A5-FE64-493E-99C8-335AAD9C95E7@holtmann.org>
References: <1370985402-27535-1-git-send-email-deymo@chromium.org>
To: Alex Deymo <deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> Fixes the value of RESET_FAILED_CONTACT_COUNTER_RP_SIZE and
> RESET_FAILED_CONTACT_COUNTER_RP_SIZE macros to respect the
> associated struct.
> ---
> 
> Hi! I was playing with the libbluetooth and found these two constants
> wrongly defined. I actually checked with the Core spec that the structs
> are fine... but I still have a very very naive question:
> 
> Why don't you use sizeof(some_struct) and be happy???

the original kernel code this is based on is from 2001 and we have not bothered to change it. I think there also were some gcc version that had problems with sizeof(struct xxx) when we needed packed structs. Take it as some legacy that has not changed in the last 12 years.

Regards

Marcel

