Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B6E1DFFD
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744967580; cv=none; b=AvMurO1gUc4Xhcp9KP6D61lXmrFsnZ5SNo4PyT7uXTDngZTa1Y4yJsqZCFK2BwVnAjMLskOZOZsbggFyU1MbfDcATiR8wUzOw616vbFdTJy/6rO0S6nFOKzs4cz7fOgr6iZfhFufMoral106KKaH4beH2LFMt4aeEi7T9OA6rwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744967580; c=relaxed/simple;
	bh=qjZXvryJ2W+KSJcZg6q/yL/hMFJBWsY9K5bryQV8mPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KhTrIm1Vl9v5jFLnOr/x2kF+DuYXhhoezAJQf46Rjg6uBWrlWMzY0VKp/W4jhcya/3rqVvaH25Wq1eayEjmq29PFAbeDQ+/jZDRHkInLckI5SdY6+etnDpb5TccpNZ0jl6XeE45YfUDo0I7xJlNDdDlSmclzYPu4bKaY6UDSdss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from 5.b.4.c.0.b.6.8.4.c.5.9.d.5.9.8.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:895d:95c4:86b0:c4b5] helo=[IPV6:fd34:5ae5:dfe:ae11::1])
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <andrew+antispam-20250418@pileofstuff.org>)
	id 1u5hmJ-000Rqy-0n;
	Fri, 18 Apr 2025 10:12:54 +0100
Message-ID: <db879066-a355-4b98-a802-7982e9736a2b@pileofstuff.org>
Date: Fri, 18 Apr 2025 10:12:30 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 2/2] obexd: only run one instance at once
To: linux-bluetooth@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20250416152039.971257-1-kernel.org@pileofstuff.org>
 <20250416152039.971257-3-kernel.org@pileofstuff.org>
Content-Language: en-GB
From: Andrew Sayers <andrew+antispam-20250418@pileofstuff.org>
In-Reply-To: <20250416152039.971257-3-kernel.org@pileofstuff.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/04/2025 16:19, Andrew Sayers wrote:
> Obex is a device-oriented protocol, so only one instance can run per device.
> But Linux file security is user-oriented, so obexd should be a user service.
> Tell systemd to only run this service for the first non-system user to log in.
>
> Without this patch, errors like the following will occur if you
> use the "switch account" feature of your desktop environment,
> then log in with another account:
>
> Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:register_profile() :1.2016 tried to register 00001133-0000-1000-8000-00805f9b34fb which is already registered
> Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:register_profile() :1.2016 tried to register 00001132-0000-1000-8000-00805f9b34fb which is already registered
> Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:register_profile() :1.2016 tried to register 0000112f-0000-1000-8000-00805f9b34fb which is already registered
> Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:register_profile() :1.2016 tried to register 00001104-0000-1000-8000-00805f9b34fb which is already registered
> Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:register_profile() :1.2016 tried to register 00001106-0000-1000-8000-00805f9b34fb which is already registered
> Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:register_profile() :1.2016 tried to register 00001105-0000-1000-8000-00805f9b34fb which is already registered
> Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:register_profile() :1.2016 tried to register 00005005-0000-1000-8000-0002ee000001 which is already registered
> Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestProfile error: org.bluez.Error.NotPermitted, UUID already registered
> Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestProfile error: org.bluez.Error.NotPermitted, UUID already registered
> Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestProfile error: org.bluez.Error.NotPermitted, UUID already registered
> Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestProfile error: org.bluez.Error.NotPermitted, UUID already registered
> Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestProfile error: org.bluez.Error.NotPermitted, UUID already registered
> Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestProfile error: org.bluez.Error.NotPermitted, UUID already registered
> Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestProfile error: org.bluez.Error.NotPermitted, UUID already registered
>
> The above errors indicate the service completely failed to register, so this
> does not change the user experience beyond removing the above messages.
> Specifically, the first user who logs in to a multi-user system still retains
> obex access to devices paired by users who log in later.
>
> This is based on a pair of recent changes to the FluidSynth daemon:
>
> https://github.com/FluidSynth/fluidsynth/pull/1491
> https://github.com/FluidSynth/fluidsynth/pull/1528
>
> This was discussed in the comments for a GitHub advisory available at
> https://github.com/bluez/bluez/security/advisories/GHSA-fpgq-25xf-jcwv
> but comments are not shown in the published version of the advisory.
> To summarise the useful conversation with Luiz Augusto von Dentz:
>
> Obex requires access to the user's home directory, so an attacker can only
> transfer files between locations the user controls.  That may be a problem
> if the user who runs obexd is different to the user who paired the device,
> but solving that would involve pairing per-user, which causes other problems.
> Bluetooth connections can be initiated by peripherals, so switching user could
> trigger re-pairing and cause the original user to lose access to the device.
> This may seem reasonable for file access, but for example users would likely
> object to constantly re-pairing their Bluetooth keyboard.
>
> Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
> ---
>   obexd/src/obex.service.in | 6 ++++++
>   tools/bluez.tmpfiles.in   | 1 +
>   2 files changed, 7 insertions(+)
>
> diff --git a/obexd/src/obex.service.in b/obexd/src/obex.service.in
> index cf4d8c985..42d2185fb 100644
> --- a/obexd/src/obex.service.in
> +++ b/obexd/src/obex.service.in
> @@ -1,10 +1,16 @@
>   [Unit]
>   Description=Bluetooth OBEX service
> +# This is a user-specific service, but bluetooth is a device-specific protocol.
> +# Only run one instance at a time, even if multiple users log in at once:
> +ConditionPathExists=!/run/lock/bluez/obexd.lock
> +ConditionUser=!@system
>   
>   [Service]
>   Type=dbus
>   BusName=org.bluez.obex
>   ExecStart=@PKGLIBEXECDIR@/obexd
> +ExecStartPre=touch /run/lock/bluez/obexd.lock
> +ExecStopPost=rm -f /run/lock/bluez/obexd.lock

Recent experience with the equivalent FluidSynth patch shows that,
if a package maintainer upgrades without adding the tmpfile,
the above causes the service to fail in ways that users find confusing.

One solution would be to prefix a '-' to make systemd ignore errors:

+-ExecStartPre=touch /run/lock/bluez/obexd.lock
+-ExecStopPost=rm -f /run/lock/bluez/obexd.lock

That would reduce a missing tmpfile from a crash to just log spam.
But if the tmpfile gains a more important use case in future,
you might uncover bugs in distro's that never installed the tmpfile.

An alternative would be to add a comment like:

+# If the service fails on the following line, please ensure
+# the bluez tmpfile has been installed in /usr/lib/tmpfiles.d/
+ExecStartPre=touch /run/lock/bluez/obexd.lock
+ExecStopPost=rm -f /run/lock/bluez/obexd.lock

That wouldn't fix the problem, but would make it easier to debug,
and hopefully nudge users to file a useful report with their distro.

>   
>   [Install]
>   Alias=dbus-org.bluez.obex.service
> diff --git a/tools/bluez.tmpfiles.in b/tools/bluez.tmpfiles.in
> index e69de29bb..05b8ad65c 100644
> --- a/tools/bluez.tmpfiles.in
> +++ b/tools/bluez.tmpfiles.in
> @@ -0,0 +1 @@
> +d /run/lock/bluez 0777 root root
