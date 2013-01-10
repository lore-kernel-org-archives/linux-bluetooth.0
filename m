Return-Path: <cyrus@holtmann.org>
Message-ID: <1357780978.1806.67.camel@aeonflux>
Subject: Re: [PATCH BlueZ 2/2] unit: Print D-Bus error message in verbose
 mode
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 09 Jan 2013 17:22:58 -0800
In-Reply-To: <1357779808-25513-2-git-send-email-anderson.lizardo@openbossa.org>
References: <1357779808-25513-1-git-send-email-anderson.lizardo@openbossa.org>
	 <1357779808-25513-2-git-send-email-anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> If g_dbus_setup_private() fails (e.g. a session bus is not available,
> and there is no X11 for dbus-launch to work), the tests are silently
> skipped.
> 
> With this commit, the D-Bus error message is also printed if verbose
> mode is enabled. The test is still skipped as before.
> ---
>  unit/test-gdbus-client.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

patch has been applied.

Regards

Marcel


