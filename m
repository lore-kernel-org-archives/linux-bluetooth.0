Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Cinaed Simson <cinaed.simson@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: bluetooth faq
Message-ID: <14979653-a357-02f1-25f3-a86231a608d2@GMail.COM>
Date: Wed, 25 Jul 2018 21:07:46 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The FAQ on the Wiki appears to indicate that you need to build the
source is a kernel version > 2.6.

However, the build fails on Jessie running kernel version 3.16.51-3
because of no ell.

Not big deal.

I was able to download it and build it but the ell web page suggests I
need the latest kernel version - 4.17 for things to work.

I haven't actually installed ell to see if that was only requirement for
the build which wasn't mentioned in the README.

So am I wasting my time the release from

  https://git.kernel.org/pub/scm/bluetooth/bluez.git

? I don't mind installing additional packages from source provided it
fixes the known problems with bluetooth.

I am currently using 5.49 from

   https://github.com/Vudentz/BlueZ.git

It doesn't require ell to build.

The following URL

   https://www.theregister.co.uk/2018/07/24/bluetooth_cryptography_bug/

which is what got me started looking for information and possible fixes.

Any help would be greatly appreciated.

-- Cinaed
