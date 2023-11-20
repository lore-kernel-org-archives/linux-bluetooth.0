Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id A9CEB133
	for <linux-bluetooth@vger.kernel.org>; Sun, 19 Nov 2023 18:26:17 -0800 (PST)
Received: (qmail 1432777 invoked by uid 1000); 19 Nov 2023 21:26:16 -0500
Date: Sun, 19 Nov 2023 21:26:16 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
  Johan Hedberg <johan.hedberg@gmail.com>,
  Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
  linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
  linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
  Hans de Goede <hdegoede@redhat.com>
Subject: Re: Qualcomm Atheros QCA61x4 keeps drawing 0.85 W despite Bluetooth
 being disable in GNOME
Message-ID: <d61ae9a8-2228-4af1-a5f0-912e7763fbd1@rowland.harvard.edu>
References: <d994bd71-8d8b-4b6a-855e-8ea5bfede3ca@molgen.mpg.de>
 <22494842-a785-4151-915d-6f3a677d96cb@molgen.mpg.de>
 <1f3cb0cc-4bb0-471f-a785-a5d237cd46a3@rowland.harvard.edu>
 <d63ebc5f-9b72-4457-949b-3e90883bd3c0@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d63ebc5f-9b72-4457-949b-3e90883bd3c0@molgen.mpg.de>

On Sun, Nov 19, 2023 at 11:09:32PM +0100, Paul Menzel wrote:
> $ sudo modprobe btusb

> $ grep . /sys/bus/usb/devices/1-3/power/*
> /sys/bus/usb/devices/1-3/power/active_duration:119053224
> /sys/bus/usb/devices/1-3/power/async:enabled
> /sys/bus/usb/devices/1-3/power/autosuspend:2
> /sys/bus/usb/devices/1-3/power/autosuspend_delay_ms:2000
> /sys/bus/usb/devices/1-3/power/connected_duration:148065372
> /sys/bus/usb/devices/1-3/power/control:auto
> /sys/bus/usb/devices/1-3/power/level:auto
> /sys/bus/usb/devices/1-3/power/persist:1
> /sys/bus/usb/devices/1-3/power/runtime_active_kids:0
> /sys/bus/usb/devices/1-3/power/runtime_active_time:119060567
> /sys/bus/usb/devices/1-3/power/runtime_enabled:enabled
> /sys/bus/usb/devices/1-3/power/runtime_status:active
> /sys/bus/usb/devices/1-3/power/runtime_suspended_time:28831453
> /sys/bus/usb/devices/1-3/power/runtime_usage:0
> /sys/bus/usb/devices/1-3/power/wakeup:disabled
> ```

Hmmm.  It's not immediately clear why the device isn't being suspended.
The btusb driver does support autosuspend.

Can you also post the output from

	grep . /sys/bus/usb/devices/1-3:*/power/*

with the driver module loaded?  I should have asked for it before.

> ```
> $ sudo modprobe -r btusb
> $ sudo dmesg | tail -1
> [314106.155163] usbcore: deregistering interface driver btusb
> $ grep . /sys/bus/usb/devices/1-3/power/*
> /sys/bus/usb/devices/1-3/power/active_duration:119072176
> /sys/bus/usb/devices/1-3/power/async:enabled
> /sys/bus/usb/devices/1-3/power/autosuspend:2
> /sys/bus/usb/devices/1-3/power/autosuspend_delay_ms:2000
> /sys/bus/usb/devices/1-3/power/connected_duration:148320980
> /sys/bus/usb/devices/1-3/power/control:auto
> /sys/bus/usb/devices/1-3/power/level:auto
> /sys/bus/usb/devices/1-3/power/persist:1
> /sys/bus/usb/devices/1-3/power/runtime_active_kids:0
> /sys/bus/usb/devices/1-3/power/runtime_active_time:119079518
> /sys/bus/usb/devices/1-3/power/runtime_enabled:enabled
> /sys/bus/usb/devices/1-3/power/runtime_status:suspended
> /sys/bus/usb/devices/1-3/power/runtime_suspended_time:29068110
> /sys/bus/usb/devices/1-3/power/runtime_usage:0
> /sys/bus/usb/devices/1-3/power/wakeup:disabled
> ```

Okay, and here we see that without the driver, the device does get 
suspended.

Alan Stern
