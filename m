Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] tools/hciattach: Add support for BCM line discipline
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1448366171-14264-1-git-send-email-john@metanate.com>
Date: Tue, 24 Nov 2015 13:21:05 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BECBB818-C6C6-4A55-A8ED-804820D0337E@holtmann.org>
References: <1448366171-14264-1-git-send-email-john@metanate.com>
To: John Keeping <john@metanate.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

> This is similar to the "bcm43xx" option but using the kernel driver has
> the advantage that the wakeup and shutdown pins on the device can be
> used.

what is wrong with just using btattach?

Regards

Marcel

