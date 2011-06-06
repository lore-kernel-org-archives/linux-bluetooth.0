Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTincgvG1WftEUjXWBDEhpP=sTFTkCA@mail.gmail.com>
References: <BANLkTik1Onu+9EWdi+ZzP5tZD0-f+UgyZQ@mail.gmail.com>
	<BANLkTincgvG1WftEUjXWBDEhpP=sTFTkCA@mail.gmail.com>
Date: Mon, 6 Jun 2011 15:17:35 +0300
Message-ID: <BANLkTimXSE_wc8rR7onv1RfNdmH54j9SYw@mail.gmail.com>
Subject: Re: Build bluez without dbus
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jacques Dirac <jacquesdirac@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jacques,

On Mon, Jun 6, 2011 at 1:46 PM, Jacques Dirac <jacquesdirac@gmail.com> wrote:
> Hi,
>
> Is there some configure parameter, patch or tutorial to build bluez
> without dbus? Or with dbus, but without glib?

The answer is no, those are very common dependencies on any
system/distribution that why we use them in the core daemon and they
fit pretty well in our design.

> I want to use bluez v4.94 on an embedded system (x86, without GUI)
> just to scan for nearby bluetooth devices (inquiry).

If you just care about inquiry then you don't need the core
daemon/bluetoothd, just do a hcitool scan.

> Hope this is possible.
>
>
> Best regards.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Luiz Augusto von Dentz
Computer Engineer
