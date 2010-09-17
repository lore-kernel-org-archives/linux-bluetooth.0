Return-Path: <cyrus@holtmann.org>
From: Will Woods <wwoods@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, kernel@lists.fedoraproject.org
Subject: bluetooth: add support for btusb devices in recent MacBook Pros
Date: Fri, 17 Sep 2010 17:09:19 -0400
Message-Id: <1284757761-11994-1-git-send-email-wwoods@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

These two patches add support for the USB bluetooth controllers found
in recent MacBook Pro systems. In both cases the device class is
ff (vend.) rather than the usual e0. The iMac11,1 has the same 
problem and is handled with an explicit USB_DEVICE() entry, so 
these two devices are handled the same way.

(Apologies for sending the patches again - I forgot the Signed-off-by:
lines the first time.)

-w
