Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1280130927-4137-2-git-send-email-santoscadenas@gmail.com>
References: <1280130927-4137-1-git-send-email-santoscadenas@gmail.com>
	<1280130927-4137-2-git-send-email-santoscadenas@gmail.com>
Date: Mon, 2 Aug 2010 17:39:18 +0300
Message-ID: <AANLkTin1khXOxvZTdazRYFbb3VZCf39YFYaZnwa3cbmN@mail.gmail.com>
Subject: Re: [PATCH] Notify to device drivers when the SDP records change
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jul 26, 2010 at 10:55 AM, Jose Antonio Santos Cadenas
<santoscadenas@gmail.com> wrote:
> When the remote SDP records that make a driver to be loaded change
> (added, remove, or updated) And the driver is not going to be
> removed, a notification is sent to the device driver. This
> notification is optional annnd does not fail  if the driver does
> not implemment it.

How this is supposed to work? If does seems to me that you guys are
planning to keep polling the services records to update the drivers
which IMO is not a good idea, DiscoverServices is not meant to update
the drivers either it is basically a replacement to sdptool to so
application can do it over dbus. Also if you take a closer look in the
plugins that use rfcomm channel, which can be changed at any point,
they basically fetch the record when attempting to connect, avdtp also
work in a similar way, we have to do the discover + get capabilities
every time we want to connect to a sink/source since there is no way
to keep this information updated locally.

In the other hand, this can be useful for LE which we can subscribe to
changes, but for sdp I don't see the point.

-- 
Luiz Augusto von Dentz
Computer Engineer
