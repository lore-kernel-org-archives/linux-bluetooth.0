Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sun, 17 Jul 2011 11:23:13 -0400
Subject: Re: Unencrypted keyboard allows password visibility
Message-ID: <1310916193.17476.35.camel@THOR>
References: <1310842470.4874.35.camel@THOR>
	 <1310900320.21109.115.camel@aeonflux>
In-Reply-To: <1310900320.21109.115.camel@aeonflux>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> Hi Peter,
>=20
> > If a keyboard remote device does not initially require encryption durin=
g
> > initial ACL connection, then passwords (or other initial input) may be
> > transmitted unencrypted.
> >=20
> > The main problem is that the input server does not force link encryptio=
n
> > until *after* both the ctrl and intr l2cap channels are connected. This
> > will allow the remote device to begin transmitting unencrypted hid inpu=
t
> > reports -- which is often a password!
>=20
> are you sure keyboards transmit data if only one channel is connected.
> If I remember this correctly then they should not. Only when both
> channels are setup, the HID connection is complete. And only then
> encryption should be required.

Your understanding is correct here. The order is:
  1. Establish ctrl l2cap channel (PSM 17).
  2. Establish intr l2cap channel (PSM 19).
  3. HID input reports recv'd on intr channel.

The keyboard can begin delivering data as soon as it gets the l2cap
config response for the _intr_ channel.

The input server requests encryption (via btd_adapter_encrypt_link)
*after* the intr channel has been established. This allows the keyboard
to transmit unencrypted HID input reports while,
  1. Authentication is requested.
  2. The link key is exchanged.
  3. Encryption mode is set.

Most keyboards queue up all the input typed prior to link establishment
and then spit it out as soon as it can. So what happens is,
  1. User presses first key of password.
  2. Keyboard wakes up and initiates ACL connection.
  3. User keeps typing password - which keyboard internally queues.
  4. Keyboard establishes first ctrl, then intr l2cap channel.
  5. Input server requests authentication upon establishing intr channel
  6. Keyboard sends HID input reports very fast (dequeuing password).
  7. Link key is exchanged - keyboard still sending queued HID reports.
  8. Auth is completed - Set Connection Encryption sent.
  9. Only now is the link encrypted.=20

> > Inquiring minds can review hidp_add_connection() in input/device.c for
> > details.
> >=20
> > However, before I submit a patch, is the device class from the sdp/hid
> > record preferable to the l2cap socket device class (via btio)?
>=20
> Anyhow, in theory this is still all a race condition. It would be better
> to use our DEFER_ACCEPT support in the kernel and allow in between that
> phase to set the encryption requirement on that socket. And then have
> the kernel ensure a secured link before allowing any L2CAP packets
> coming in. Something similar to what is ensured with Security Modem 4
> for non-SDP channels.

Ok. I'll look into that. And I answered my own question regarding the
class_of_device preference: sdp record is preferable in case the device
is a composite.

Regards,
Peter
