Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1367829810-8262-9-git-send-email-mikel.astiz.oss@gmail.com>
References: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1367829810-8262-9-git-send-email-mikel.astiz.oss@gmail.com>
Date: Mon, 6 May 2013 13:00:42 +0300
Message-ID: <CABBYNZLiB6tO8748w=Qr16Or2FJQ6jh0Q1oa4NKDU1DhDK+NQg@mail.gmail.com>
Subject: Re: [RFC BlueZ v0 08/13] dbus: Add state property to org.bluez.Service1
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, May 6, 2013 at 11:43 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> +static gboolean service_get_state(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data)
> +{
> +       struct btd_service *service = data;
> +       const char *str;
> +
> +       str = state2dbus(service->state);
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &str);

The code about would break if state2dbus returns NULL for
BTD_SERVICE_STATE_UNAVAILABLE, perhaps if service is unavailable it
should not have an object path representing it?
