Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1437319871-3004-1-git-send-email-dh79.pyun@samsung.com>
References: <1437319871-3004-1-git-send-email-dh79.pyun@samsung.com>
Date: Wed, 22 Jul 2015 15:50:19 +0300
Message-ID: <CABBYNZJ58=w_A6KULNO9n8VWCmnbyPOj2w1OAJbQRhWX5BexVA@mail.gmail.com>
Subject: Re: [PATCH BLUEZ 0/4] Modify Health profile signals for ObjectManager
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Dohyun Pyun <re20sfree@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	steve.jun@samsung.com, DoHyun Pyun <dh79.pyun@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dohyun,

On Sun, Jul 19, 2015 at 6:31 PM, Dohyun Pyun <re20sfree@gmail.com> wrote:
> From: DoHyun Pyun <dh79.pyun@samsung.com>
>
> Since BlueZ has ObjectManager interface, ChannelConnected and ChannelDeleted
> Signals of HealthDevice interface was not available. ObjectManager reports the
> HealthChannel D-Bus interface when g_dbus_emit_signal function is called,
> and generates "InterfaceAdded" signal. But ChannelConnected and ChannelDeleted
> Siganls was not generated. If health-api document contains these signals,
> application or service using Bluez Dbus API will get the unexpected result.
>
> If we just remove g_dbus_emit_signal for ChannelConnected and ChannelDeleted,
> InterfaceAdded signal will not sent. Because InterfaceAdded signal is pending
> before sending a dbus signal. These patches include new property in HealthChannel
> interfacem, and this PropertiesChanged signal can be used to replace the previous
> ChannelConnected and ChannelDeleted signals.

Seems like a good idea, but from the logs it looks like the channel
lifetime is tied with the connection in that case
InterfacesAdded/InterfacesRemoved can be used directly instead of
having another property or Im missing something?


-- 
Luiz Augusto von Dentz
