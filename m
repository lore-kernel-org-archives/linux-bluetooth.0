Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sat, 16 Jul 2011 14:54:30 -0400
Subject: Unencrypted keyboard allows password visibility
Message-ID: <1310842470.4874.35.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If a keyboard remote device does not initially require encryption during
initial ACL connection, then passwords (or other initial input) may be
transmitted unencrypted.

The main problem is that the input server does not force link encryption
until *after* both the ctrl and intr l2cap channels are connected. This
will allow the remote device to begin transmitting unencrypted hid input
reports -- which is often a password!

Inquiring minds can review hidp_add_connection() in input/device.c for
details.

However, before I submit a patch, is the device class from the sdp/hid
record preferable to the l2cap socket device class (via btio)?

Regards,
Peter
