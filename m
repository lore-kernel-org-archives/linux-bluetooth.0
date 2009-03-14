Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Wacom Bluetooth mode-2 activation
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1237334085.15346.99.camel@cookie.hadess.net>
References: <1237334085.15346.99.camel@cookie.hadess.net>
Content-Type: text/plain
Date: Sat, 14 Mar 2009 07:09:48 +0100
Message-Id: <1237010988.24751.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> Patch is necessary to make the Wacom Bluetooth driver I posted to
> linux-input work as expected. I've tested this successfully with my
> tablet[1].

this maybe sound like a nit-pick, but please add an extra empty line
between the if-statement and the ioctl.

+               write(sk, buf, sizeof(buf));
+       }
        err = ioctl_connadd(req);

The original code had one and so should have the new one with this extra
quirk.

Also can we please check at least the return value of write().

+               write(sk, buf, sizeof(buf));

Check the return value and at minimum have an error message printed.

Regards

Marcel


