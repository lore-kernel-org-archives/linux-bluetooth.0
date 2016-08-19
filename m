Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Proposed Patch Bluez v5] btmon: Print connection latency correctly
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <155e0135-7d14-259d-322b-a582afb979c9@atomos.com>
Date: Fri, 19 Aug 2016 10:49:29 +0200
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Message-Id: <35A91F39-E5C2-47F2-81D5-398797B31C1C@holtmann.org>
References: <155e0135-7d14-259d-322b-a582afb979c9@atomos.com>
To: Leigh Fiddes <leigh.fiddes@atomos.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Leigh,

> I submit the following small patch for consideration.
> Leigh
> ---
> 
> In at least two places the Connection Latency field was being displayed by btmon in units of 1.25mS,
> which is incorrect. Print in decimal instead of hex as it is a number.

then print the connection latency with a correct unit and the hex value in parentheses. This way is not acceptable. If we need a print_field_msec helper, then introduce that and use it throughout.

Regards

Marcel

