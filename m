Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Fix bluez5 capabilities for Smack setup
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1467964987-6402-1-git-send-email-wu.zheng@intel.com>
Date: Fri, 8 Jul 2016 11:07:43 +0200
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Message-Id: <30D5A9D0-8BBC-44FD-8E13-5C7C9A52619B@holtmann.org>
References: <1467964987-6402-1-git-send-email-wu.zheng@intel.com>
To: wu.zheng@intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wu,

> Recent bluez5 releases started limiting the capabilities of
> bluetoothd. When running on a Smack-enabled system, that change has the
> effect that bluetoothd can no longer create the input device under
> /sys because bluez5 running with label "System" has no write
> access to that.
> 
> It works when running as normal root with unrestricted capabilities
> because then CAP_MAC_OVERRIDE (a Smack-specific capability) allows
> the process to ignore Smack rules.
> 
> We need to ensure that bluetoothd still has that capability.
> ---
> src/bluetooth.service.in | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
> index f799f65..1b0fead 100644
> --- a/src/bluetooth.service.in
> +++ b/src/bluetooth.service.in
> @@ -10,7 +10,7 @@ ExecStart=@libexecdir@/bluetoothd
> NotifyAccess=main
> #WatchdogSec=10
> #Restart=on-failure
> -CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
> +CapabilityBoundingSet=CAP_MAC_OVERRIDE CAP_NET_ADMIN CAP_NET_BIND_SERVICE

this looks like the big hammer approach. I think if this is needed, then the Smack policies are just wrong. Why not fix them instead of punching such a big hole into it.

Regards

Marcel

