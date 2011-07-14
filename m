Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: VISHWANATH KM <a21174@motorola.com>
Date: Thu, 14 Jul 2011 22:34:17 +0530
Message-ID: <CACbkbULaTeWVtcpFxhUMRMO-r+QuKU8NkX7o5nQBXHKApJbqgQ@mail.gmail.com>
Subject: Security level for Primary Services discovery during pairing
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

As per GAP spec section 10.1 Requirements, for both peripheral and
central security is optional,
in adapter.c create_paired_device_generic  we have
device_browse_primary with secure set to TRUE,
due to which we are connecting to other device with Security level
high, this is causing failure for those
peripherals where security is not supported hence those devices
doesn't respond to the pairing request initiated

device_browse_primary with secure to FALSE goes through, where
peripheral initiates Slave security request
and SMP just works completes as expected, since security is optional,
should the secure for device_browse_primary
be set to FALSE in create_paired_device_generic ? please let us know
your comments. thx

Regards
Vishwanath
