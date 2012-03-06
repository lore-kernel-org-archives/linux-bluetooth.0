Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331035658-10000-3-git-send-email-luiz.dentz@gmail.com>
References: <1331035658-10000-1-git-send-email-luiz.dentz@gmail.com>
	<1331035658-10000-3-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 6 Mar 2012 08:57:00 -0400
Message-ID: <CAJdJm_OmpNXq-hhqAQTXn-rvOk1eJhfQzuGdt2pQLRaa4+F1og@mail.gmail.com>
Subject: Re: [RFC BlueZ 3/3] core: Add Interfaces property to org.bluez.Device
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Mar 6, 2012 at 8:07 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This enables applications to be able to detect when an interface is
> enabled/disabled without depending on UUIDs.
> ---
>  doc/device-api.txt |    4 ++++
>  src/device.c       |   27 ++++++++++++++++++++++-----
>  2 files changed, 26 insertions(+), 5 deletions(-)

I thought it was possible to achieve this by using D-Bus listeners?
E.g. similar to g_dbus_add_service_watch()

What happens when the interface is unregistered with
g_dbus_unregister_interface() ?

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
