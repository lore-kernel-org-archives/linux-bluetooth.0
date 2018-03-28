Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: David Frey <dpfrey@gmail.com>
Date: Wed, 28 Mar 2018 11:02:11 -0700
Message-ID: <CAAvkfd_baAUHfnO9JX3h2rc4BYQBzjBeWqf2tiGBMJQMG2yseA@mail.gmail.com>
Subject: Support adapter without HCI
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Is it possible to support a bluetooth adapter in the Linux kernel in
the case where the adapter doesn't present a HCI interface?  The
adapter in question was originally envisioned as a standalone host,
but I am interested in using it as an adapter (over SPI) controlled by
another CPU running Linux.  The BLE implementation on the target is a
closed source binary that provides GAP and GATT APIs.  Details of the
APIs are here: http://labs.mediatek.com/api/mt7697/group___bluetooth.html

If it *is* possible to support adapters which don't offer an HCI
interface, then I'm hoping that someone can point me at an example or
an interface definition so I can get an idea of what is required.

Thanks,
David
