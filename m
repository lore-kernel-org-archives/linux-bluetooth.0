Return-Path: <cyrus@holtmann.org>
Date: Fri, 23 Oct 2015 19:34:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Martin Pitt <martin.pitt@ubuntu.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] systemd: Check if bluetooth is supported in the kernel
Message-ID: <20151023163430.GA23194@t440s.P-661HNU-F1>
References: <1445336685-20506-1-git-send-email-martin.pitt@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445336685-20506-1-git-send-email-martin.pitt@ubuntu.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

On Tue, Oct 20, 2015, Martin Pitt wrote:
> When running a kernel without bluetooth support, bluetooth.service fails to
> start with
> 
>     bluetoothd[1640]: Failed to access management interface
>     bluetoothd[1640]: Adapter handling initialization failed
>     systemd[1]: bluetooth.service: Main process exited, code=exited, status=1/FAILURE
>     systemd[1]: Failed to start Bluetooth service.
> 
> This causes an unnecessary "degraded" state and more importantly breaks package
> installation when the bluez package auto-starts the daemon.
> 
> Add a condition to only start the service if /sys/class/bluetooth exists.
> 
> https://launchpad.net/bugs/1506774
> ---
>  src/bluetooth.service.in | 1 +
>  1 file changed, 1 insertion(+)

Applied. Thanks.

Johan
