Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Jul 2014 11:31:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Murat Kilivan <Murat.Kilivan@csr.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Bluetooth Low Energy service crash report - when trying read a
 HID feature report
Message-ID: <20140724083116.GB9891@t440s.lan>
References: <45F17F5803927D43967AFEED068E781E0879A30E@CAMEUREXM02.EUROPE.ROOT.PRI>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45F17F5803927D43967AFEED068E781E0879A30E@CAMEUREXM02.EUROPE.ROOT.PRI>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Murat,

On Wed, Jul 23, 2014, Murat Kilivan wrote:
> I have successfully connected to a BLE HID (peripheral) device and /dev/hidraw1 file is created. I am able to read raw data successfully from hidraw1. However, when I try to read a feature report from this device, the Bluetooth service crashes. The bluetooth service log and my source code are below.
> 
> Enviroments:
> ------------
> Linux Mint-17 KDE
> Kernel 3.13.0-24-generic
> BlueZ 5.21
> 
> Output of Bluetooth service:
> ----------------------------
> # bluetooth -d -n
> ...
> ...
> bluetoothd[2610]: profiles/input/hog.c:forward_report() Sending report type 3 to device 0x000C handle 0x1C
> (bluetoothd:2610): GLib-ERROR **: /build/buildd/glib2.0-2.40.0/./glib/gmem.c:103: failed to allocate 4294967295 bytes

4294967295 is the same as (uint32_t) -1 so seems like there might be a
missing error check somewhere. Could you please try to get the full
bluetoothd backtrace by running it through gdb or valgrind? If possible
do this with the latest git version.

Johan
