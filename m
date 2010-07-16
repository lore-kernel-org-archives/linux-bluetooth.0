Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] bluetooth: retry reset for devices that fail
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <201007151423.23245.oneukum@suse.de>
References: <201007151423.23245.oneukum@suse.de>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 16 Jul 2010 09:10:36 -0700
Message-ID: <1279296636.6282.77.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> Some devices fail to reset properly at the first attempt to reset
> them under unknown circumstances. Failures can be identified by
> an invalid btaddr. Retry in those cases.

I am not sure about this. Can you provide some examples when this is
suppose to be happening. The empty BD_ADDR might not be a good indicator
for this.

Regards

Marcel


