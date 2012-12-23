Return-Path: <cyrus@holtmann.org>
Message-ID: <1356278946.29264.24.camel@aeonflux>
Subject: Re: [PATCH BlueZ 3/6] gdbus: Introduce GDBusInterfaceFlags
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 23 Dec 2012 08:09:06 -0800
In-Reply-To: <1356276298-13795-3-git-send-email-luiz.dentz@gmail.com>
References: <1356276298-13795-1-git-send-email-luiz.dentz@gmail.com>
	 <1356276298-13795-3-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> The flags should be passed in g_dbus_register_interface_with_flags,
> currently there only one flag which is G_DBUS_INTERFACE_FLAG_EXPERIMENTAL
> which works similarly to G_DBUS_METHOD_FLAG_EXPERIMENTAL but for the
> whole interface.
> ---
>  gdbus/gdbus.h  | 13 +++++++++++++
>  gdbus/object.c | 20 ++++++++++++++++++++
>  2 files changed, 33 insertions(+)

can we not just check if the interface contains any non experimental
method, signals and properties and base that decision around that?

I am not really in favor of introducing a version with flags.

Regards

Marcel


