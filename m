Return-Path: <cyrus@holtmann.org>
Subject: Re: Unencrypted keyboard allows password visibility
From: Marcel Holtmann <marcel@holtmann.org>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sun, 17 Jul 2011 12:58:39 +0200
In-Reply-To: <1310842470.4874.35.camel@THOR>
References: <1310842470.4874.35.camel@THOR>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1310900320.21109.115.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

> If a keyboard remote device does not initially require encryption during
> initial ACL connection, then passwords (or other initial input) may be
> transmitted unencrypted.
> 
> The main problem is that the input server does not force link encryption
> until *after* both the ctrl and intr l2cap channels are connected. This
> will allow the remote device to begin transmitting unencrypted hid input
> reports -- which is often a password!

are you sure keyboards transmit data if only one channel is connected.
If I remember this correctly then they should not. Only when both
channels are setup, the HID connection is complete. And only then
encryption should be required.

> Inquiring minds can review hidp_add_connection() in input/device.c for
> details.
> 
> However, before I submit a patch, is the device class from the sdp/hid
> record preferable to the l2cap socket device class (via btio)?

Anyhow, in theory this is still all a race condition. It would be better
to use our DEFER_ACCEPT support in the kernel and allow in between that
phase to set the encryption requirement on that socket. And then have
the kernel ensure a secured link before allowing any L2CAP packets
coming in. Something similar to what is ensured with Security Modem 4
for non-SDP channels.

Regards

Marcel


