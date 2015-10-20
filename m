Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH] systemd: Check if bluetooth is supported in the kernel
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1445336685-20506-1-git-send-email-martin.pitt@ubuntu.com>
Date: Tue, 20 Oct 2015 15:19:25 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3C809C59-9F50-40AC-B55D-C5456B333183@holtmann.org>
References: <1445336685-20506-1-git-send-email-martin.pitt@ubuntu.com>
To: Martin Pitt <martin.pitt@ubuntu.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

> When running a kernel without bluetooth support, bluetooth.service fails to
> start with
> 
>    bluetoothd[1640]: Failed to access management interface
>    bluetoothd[1640]: Adapter handling initialization failed
>    systemd[1]: bluetooth.service: Main process exited, code=exited, status=1/FAILURE
>    systemd[1]: Failed to start Bluetooth service.
> 
> This causes an unnecessary "degraded" state and more importantly breaks package
> installation when the bluez package auto-starts the daemon.
> 
> Add a condition to only start the service if /sys/class/bluetooth exists.
> 
> https://launchpad.net/bugs/1506774
> ---
> src/bluetooth.service.in | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
> index 35e9457..83e4732 100644
> --- a/src/bluetooth.service.in
> +++ b/src/bluetooth.service.in
> @@ -1,6 +1,7 @@
> [Unit]
> Description=Bluetooth service
> Documentation=man:bluetoothd(8)
> +ConditionPathIsDirectory=/sys/class/bluetooth

and this is not a race condition? I mean that directory might be not present because the module has not yet been loaded. So strictly speaking the kernel has been compiled with Bluetooth support, but it has not been yet loaded. Are we not exchanged one issue for another?

Regards

Marcel

