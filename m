Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Quality issue with Bluetooth-SIG
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <059FABA9-CC68-4295-8391-C2EA7C202BC7@hella-gutmann.com>
Date: Wed, 12 Jul 2017 10:25:38 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <37500CB5-E231-4974-89F9-5E5F2859429B@holtmann.org>
References: <059FABA9-CC68-4295-8391-C2EA7C202BC7@hella-gutmann.com>
To: Heiko Abraham <heiko.abraham@hella-gutmann.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Heiko,

> if an new version of BlueZ is release, are any tests running on it?
> 
> Currently I see, that BlueZ 5.43, 5.45 or 4.101 with different versions of Linux Kernel (3.8, 3.12, 3.18) all failed with the Bluetooth-SIG test.
> I only look for Bluetooth Classic and RFCOMM. (Problems with eRTM, L2CAP_DISCONNECT)
> 
> My assumption is, that a lot of Mainline LTS kernels not pass the Bluetooth-SIG by default.
> Any suggestions for the best kernel/BlueZ combinations? An newer Kernel like 4.x sometimes not possible (OpenGL ES support).

bugs can always happen, but in general, BlueZ is run against PTS. Also SIG test vectors get updated based on errata.

Have you actually tried to follow the instructions I gave you last time? And have you tried them with a Linux 4.x recent kernel. And if you insist on using an old kernel, you might need to backport the patch that is required for qualification.

Regards

Marcel

