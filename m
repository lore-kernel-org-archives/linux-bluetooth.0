Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Heiko Abraham <heiko.abraham@hella-gutmann.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Quality issue with Bluetooth-SIG
Date: Wed, 12 Jul 2017 08:07:45 +0000
Message-ID: <059FABA9-CC68-4295-8391-C2EA7C202BC7@hella-gutmann.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

if an new version of BlueZ is release, are any tests running on it?

Currently I see, that BlueZ 5.43, 5.45 or 4.101 with different versions of Linux Kernel (3.8, 3.12, 3.18) all failed with the Bluetooth-SIG test.
I only look for Bluetooth Classic and RFCOMM. (Problems with eRTM, L2CAP_DISCONNECT)

My assumption is, that a lot of Mainline LTS kernels not pass the Bluetooth-SIG by default.
Any suggestions for the best kernel/BlueZ combinations? An newer Kernel like 4.x sometimes not possible (OpenGL ES support).


Regards,
Heiko Abraham

--

________________________________

--
Hella Gutmann Solutions GmbH * Unternehmensform: Gesellschaft mit beschraenkter Haftung *
Firmensitz: 79241 Ihringen * Eingetragen im Handelsregister: AG Freiburg i.Br., HRB 290194 * Geschaeftsfuehrer: Andreas Habeck * USt-IdNr.: DE142208666
