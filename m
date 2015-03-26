Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: CSR Radio Becomes Unresponsive
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALdogvEPfgXMB78dp0NjuSicGoGHOET1icdurmpSXpn4MphtrQ@mail.gmail.com>
Date: Thu, 26 Mar 2015 14:18:19 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <44928B0C-51EA-4C56-B3CE-9CA396F44ABF@holtmann.org>
References: <CALdogvEPfgXMB78dp0NjuSicGoGHOET1icdurmpSXpn4MphtrQ@mail.gmail.com>
To: daron anderson <daronanderson7@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daron,

> I am experiencing a Bluetooth radio failure on a CSR Bluetooth module
> using kernel 3.10 and Bluez 5.29.  The radio I am using is a Bluegiga
> WT21 USB radio which is hardwired to an internal USB bus inside an
> Intermec CV61 mobile computer.  The failure results in the Bluetooth
> radio being unresponsive after a reboot until the unit is powered down
> and powered up again.  I have worked out a concise test case that
> causes the failure to appear with details below.  There appears to be
> other scenarios where the radio failure occurs, but this is the
> simplest repeatable test case I have found.
> 
> 
> 
> lsusb reports:
> 
> Bus 005 Device 002: ID 0a12:0002 Cambridge Silicon Radio, Ltd
> Frontline Test Equipment Bluetooth Device

these are CSR sniffer devices. I have no idea how you can use them for normal operation. Only a really few early of these are allowed for normal operation. All other ones get pushed into raw mode and do not work as Bluetooth devices.

What does /sys/kernel/debug/usb/devices actually say about your dongle? You can also check "bccmd buildname" to see what CSR build this really is.

Regards

Marcel

