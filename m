Return-Path: <cyrus@holtmann.org>
Message-ID: <1356893571.19248.84.camel@aeonflux>
Subject: Re: [PATCH BlueZ 06/11] gdbus: Introduce
 G_DBUS_FLAG_ENABLE_DEPRECATED
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 30 Dec 2012 10:52:51 -0800
In-Reply-To: <1356699069-5469-7-git-send-email-luiz.dentz@gmail.com>
References: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
	 <1356699069-5469-7-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This flag can be set using g_dbus_set_flags to enable deprecated
> interfaces, default is unset.
> ---
>  gdbus/gdbus.h  |  3 ++-
>  gdbus/object.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 1 deletion(-)

I decided against this patch. At least for now. The whole point of the
interface versioning is to support two API versions. So having an option
to manually enable them makes no sense. We can revisit this once we
reach that point, but otherwise I leave this out for now.

Regards

Marcel


