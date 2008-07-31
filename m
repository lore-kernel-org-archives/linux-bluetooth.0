Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
Date: Thu, 31 Jul 2008 17:21:33 +0200
Cc: linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <200807311452.24166.oliver@neukum.org> <94E72E02-9C26-4FB4-8E0E-414B08E43F6A@holtmann.org>
In-Reply-To: <94E72E02-9C26-4FB4-8E0E-414B08E43F6A@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807311721.34299.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Donnerstag 31 Juli 2008 16:03:13 schrieb Marcel Holtmann:
> yeah, I was afraid of that switching the alternate settings is not as =A0
> easy as the spec. might think. Personally I think it is a broken =A0
> specification anyway. So the best assumption is that we have one SCO =A0
> connection and that is either 8-bit or 16-bit. So we do the switching =A0
> when we get the notify() callback for a changed voice setting.

That's problematic because in the notify() callback you cannot sleep,
can you? In addition, a device is legally allowed to take a lot of time
to switch altsettings.

	Regards
		Oliver
