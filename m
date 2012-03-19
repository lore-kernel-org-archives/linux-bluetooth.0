Return-Path: <cyrus@holtmann.org>
Message-ID: <1332178663.14217.211.camel@aeonflux>
Subject: Re: [PATCH] Add udev rule for Ralink WiFi+BT module w/ bccmd
From: Marcel Holtmann <marcel@holtmann.org>
To: Eric Miao <eric.miao@canonical.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 19 Mar 2012 10:37:43 -0700
In-Reply-To: <1332132103-23374-1-git-send-email-eric.miao@canonical.com>
References: <1332132103-23374-1-git-send-email-eric.miao@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eric,

> Some Ralink WiFi + CSR BT module needs bluetooth radio to be
> turned on explicitly with bccmd by the following command:
> 
>   bccmd psset -r 0x028c 0x0001
> 
> The HCI will be probed successfully, but due to the default
> OFF state of the radio, no scan or connection can be made.
> This patch adds the udev rule so that once the HCI is up,
> udev will invoke bccmd with warm reset to turn on the radio.
> 
> [1] https://bugs.launchpad.net/bugs/781556
> [2] https://bugs.meego.com/show_bug.cgi?id=3498
> [3] http://ubuntuforums.org/showthread.php?t=1776108
> [4] http://ubuntuforums.org/showthread.php?t=1703941

why are we doing this in userspace? The btusb.c driver has the option
for pre-execution HCI commands queue. Why not use that one.

Also why -r. Meaning why do we need a warmreset? And where is the magic
0x028c PS key coming from? Does anybody actually know what it is doing?

Regards

Marcel


