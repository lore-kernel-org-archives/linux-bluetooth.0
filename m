Return-Path: <cyrus@holtmann.org>
Subject: Re: Release Note for BlueZ versions
From: Marcel Holtmann <marcel@holtmann.org>
To: pavan_savoy@indiatimes.com
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <643074291.26281228924530061.JavaMail.root@mbv7.indiatimes.com>
References: <643074291.26281228924530061.JavaMail.root@mbv7.indiatimes.com>
Content-Type: text/plain
Date: Fri, 12 Dec 2008 02:44:27 +0100
Message-Id: <1229046267.22285.22.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

> How do I know what BlueZ versions refer to what Bluetooth specification & confrom to which version ?
> I am particularly interested about BlueZ 3.36.
> 
> It shows me a error "Can't read simple pairing mode" on a v2.1 hardware.

make sure you use hcidump -X -V to capture what is going on there. Maybe
your hardware doesn't support Simple Pairing. It is possible to built
2.1 devices without Simple Pairing support.

Also you should switch to 4.22 or something more recent.

Regards

Marcel


