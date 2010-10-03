Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1286118002-2354-1-git-send-email-sbalashanmugam@atheros.com>
References: <1286118002-2354-1-git-send-email-sbalashanmugam@atheros.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Mon, 4 Oct 2010 09:13:27 +1100
Message-ID: <AANLkTinpE-3Ku9=WFyOO8XYUWkxj3oVvgi3QTt491jZq@mail.gmail.com>
Subject: Re: [PATCH] Added firmware load patch to crap directory.
To: Bala Shanmugam <sbalashanmugam@atheros.com>
Cc: linux-wireless@vger.kernel.org, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 4, 2010 at 02:00, Bala Shanmugam <sbalashanmugam@atheros.com> wrote:
> +Reason for not yet publishing: Marcel feels that Atheros sflash based BT device
> +doesn't follow bluetooth H:2 specification and HCI commands should be supported
> +in firmware if it is detected as bluetooth device. Using HCI command, firmware
> +should be loaded.
> +
> +In sflash based device there is not enough memory to support HCI commands in firmware.
> +So load firmware from btusb when the device comes up.

Stupid question: What's to stop you from producing a driver that
connects to this device when unflashed, loads the firmware, then hands
it over to the proper HCI bluetooth driver? (other than it being an
ugly hack)

You could post such a driver to Linux-usb and "solve" the problem in a
way that (should) make everyone happy.

Thanks,

-- 

Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
