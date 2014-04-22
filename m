Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Apr 2014 14:34:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v0] gatt: Fix not replying for write requests
Message-ID: <20140422113430.GA10626@t440s.lan>
References: <1397744385-29209-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1397744385-29209-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Apr 17, 2014, Claudio Takahasi wrote:
> Attributes should not be unregistered dynamically unless the service
> implementation calls UnregisterService() or leave the system bus.
> Implementations may accidentally (or maliciously) unregister a GATT
> object (characteristic or descriptor) belonging to a service hierarchy.
> gdbus automatically tracks InterfacesRemoved() signal, and destroys the
> GDBusProxy associated with the removed interfaces. Subsequent calls of
> g_dbus_proxy_set_property_array() returns FALSE, and it needs to be
> handled properly since the GDBusProxy result callback will not be called.
> ---
>  src/gatt-dbus.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
