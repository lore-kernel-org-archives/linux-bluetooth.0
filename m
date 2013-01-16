Return-Path: <cyrus@holtmann.org>
From: "Kling, Andreas" <Andreas.Kling@peiker.de>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 16 Jan 2013 12:12:29 +0100
Subject: bluez: atomic operations
Message-ID: <sig.07284aae85.B3F251FD87EC894A88C2221EEEBDF54807096F7F3D@Exchange>
References: <B3F251FD87EC894A88C2221EEEBDF54807096F7F3B@Exchange>
In-Reply-To: <B3F251FD87EC894A88C2221EEEBDF54807096F7F3B@Exchange>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

using gcc atomic buildins breaks support for older gcc/platforms.

src/bluetoothd-adapter.o: In function `btd_adapter_unref':
adapter.c:(.text+0x63f8): undefined reference to `__sync_sub_and_fetch_4'

I suggest to use glib g_atomic_* group of functions.
They fall back to traditional locking if buildins are not available.

kind regrads

andy
