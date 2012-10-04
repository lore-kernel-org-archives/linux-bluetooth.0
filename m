Return-Path: <cyrus@holtmann.org>
Message-ID: <1349344331.27233.9.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: AMP: Register AMP only if High Speed enabled
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 04 Oct 2012 11:52:11 +0200
In-Reply-To: <1349339215-8422-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1349339215-8422-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Make sure that AMP controller is registered only if HS enables.
> Return EINVAL if High Speed is not enabled and dev_type is HCI_AMP.

I don't think this is a good idea. I like to keep the adapter registers,
but maybe have a hciconfig hciX up fail. Not the registration itself.

If you would fail the registration itself, then you have the problem
that you need to unplug and replug the hardware once you changed
enable_hs. And that might not always be possible.

Regards

Marcel


