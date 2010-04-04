Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 4 Apr 2010 13:40:35 +0300
Message-ID: <k2h2c3916b71004040340t63dccd5bj11953c26d826d98f@mail.gmail.com>
Subject: Question about BlueZ's configure script
From: Daniel Abraham <daniel.shrugged@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In BlueZ's README, dev packages for ALSA, Gstreamer (+ plugins base),
and libsnd are not listed as required or even optional.

However, the configure script does look for them (although it doesn't
fail if they're missing).

So my question is: why does it look for them? How do they affect BlueZ
compilation/functionality?

Thanks
