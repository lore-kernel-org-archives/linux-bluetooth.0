Return-Path: <wu.zheng@intel.com>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>,
	"Ohly, Patrick" <patrick.ohly@intel.com>, "Schaufler, Casey"
	<casey.schaufler@intel.com>
Subject: RE: [PATCH] Fix bluez5 capabilities for Smack setup
Date: Thu, 14 Jul 2016 03:56:27 +0000
Message-ID: <2CF57A644018A745B8FE029C7223E16E130585D8@shsmsx102.ccr.corp.intel.com>
References: <1467964987-6402-1-git-send-email-wu.zheng@intel.com>
 <30D5A9D0-8BBC-44FD-8E13-5C7C9A52619B@holtmann.org>
In-Reply-To: <30D5A9D0-8BBC-44FD-8E13-5C7C9A52619B@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

To the issue, It is trouble for distro bluez to the Smack-enabled system.
(Many issues are related with the issue in Smack-enable system, such as HID=
 can't work and so on)

Patrick and Casey(the Smack architect) had a talk about how the program tou=
ch /proc and /sys when it run
on a Smack-enabled system.
Casey has some ideas about the topic for Smack-enabled system:
"Turning off privilege is a great thing to do *so long as you don't really =
need the privilege*.In this case you really need it.
The application package isn't written to account for Smack's use of CAP_MAC=
_OVERRIDE as the mechanism for controlling this dangerous operation.
Yes, it would be possible to change /proc to change the Smack label on that=
 particular file, but that might open other paths for exploit.
I say give the program the required capability. The program maintainer may =
well say change the kernel handling of /proc.
You're stuck in the middle, as both work the way they're intended and hence=
 the system doesn't work. :(=20
There isn't a way to make this work without "loosening" something."

When we run the program with CAP_MAC_OVERRIDE, the whole reason for having =
capabilities is so the we can give a=20
process the ability to bypass one kind of check without giving it the abili=
ty to bypass other, unrelated checks. A process with=20
CAP_MAC_OVERRIDE is still constrained by the file mode bits.

We was overly worried about granting that capability.=20
When it has no other effect than excluding a process from Smack MAC enforce=
ment, then adding to the process seems like the right solution for now.

The conclusion from Patrick and Casey is that this is the solution preferre=
d by the Smack architect.

Best Regards
Zheng Wu

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Sent: Friday, July 8, 2016 5:08 PM
To: Zheng, Wu <wu.zheng@intel.com>
Cc: open list:BLUETOOTH DRIVERS <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Fix bluez5 capabilities for Smack setup

Hi Wu,

> Recent bluez5 releases started limiting the capabilities of=20
> bluetoothd. When running on a Smack-enabled system, that change has=20
> the effect that bluetoothd can no longer create the input device under=20
> /sys because bluez5 running with label "System" has no write access to=20
> that.
>=20
> It works when running as normal root with unrestricted capabilities=20
> because then CAP_MAC_OVERRIDE (a Smack-specific capability) allows the=20
> process to ignore Smack rules.
>=20
> We need to ensure that bluetoothd still has that capability.
> ---
> src/bluetooth.service.in | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in index=20
> f799f65..1b0fead 100644
> --- a/src/bluetooth.service.in
> +++ b/src/bluetooth.service.in
> @@ -10,7 +10,7 @@ ExecStart=3D@libexecdir@/bluetoothd NotifyAccess=3Dmain
> #WatchdogSec=3D10
> #Restart=3Don-failure
> -CapabilityBoundingSet=3DCAP_NET_ADMIN CAP_NET_BIND_SERVICE
> +CapabilityBoundingSet=3DCAP_MAC_OVERRIDE CAP_NET_ADMIN=20
> +CAP_NET_BIND_SERVICE

this looks like the big hammer approach. I think if this is needed, then th=
e Smack policies are just wrong. Why not fix them instead of punching such =
a big hole into it.

Regards

Marcel
