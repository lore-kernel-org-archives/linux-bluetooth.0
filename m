Return-Path: <cyrus@holtmann.org>
Message-ID: <1343682685.1803.67.camel@aeonflux>
Subject: Announcing standalone SBC library
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 30 Jul 2012 14:11:25 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everyone,

I like to announce the new standalone SBC library. It is an exact copy
of the previous internal SBC support within BlueZ.

	http://git.kernel.org/?p=bluetooth/sbc.git

In addition to this new tree, I also tagged and released version 1.0 of
the SBC library. It can be found at the usual location.

	http://www.kernel.org/pub/linux/bluetooth/

For BlueZ 5.0, the internal SBC support will be removed. And we are
making GStreamer integration and PulseAudio support depend on this new
library. So it is time to get this packaged and included into the
various distributions.

Regards

Marcel


