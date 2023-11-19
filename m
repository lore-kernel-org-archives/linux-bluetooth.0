Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804EB15B0;
	Sun, 19 Nov 2023 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PtkuutV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1B8C433C7;
	Sun, 19 Nov 2023 14:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700404510;
	bh=E6zJHBhYXrmLej8MZ2nYDjFpIEaxCqU2Xw6h3zWA/xM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PtkuutV44momtUH3Bdr0Z5NreXGP10WNAzwIhG3yOGJY+doGyoJeMkPFzAS1F2NxO
	 v6TyH+J9XknTcrbnqC1RkeH2v2a9oAKVabQ70071jj0/XeHahDt6KhVLs0irYMpNLv
	 piQAUUL3n7J8MSIQWwNkmb1LSQhl2W6DsHrk/OpQ=
Date: Sun, 19 Nov 2023 15:35:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: Qulcomm Atheros QCA61x4 keeps drawing 0.85 W despite Bluetooth
 being disable in GNOME
Message-ID: <2023111947-levitate-undergo-12d6@gregkh>
References: <d994bd71-8d8b-4b6a-855e-8ea5bfede3ca@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d994bd71-8d8b-4b6a-855e-8ea5bfede3ca@molgen.mpg.de>

On Sun, Nov 19, 2023 at 02:40:35PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On the Dell XPS 13 9360 from 2016, BIOS 2.21.0 06/02/2022, with Debian
> sid/unstable and Debian’s Linux 6.5.10 kernel, I am trying to extend the
> run-time with battery, at under 50 % of it’s original capacity, and I am
> using PowerTOP 2.15.
> 
>     [    0.000000] microcode: updated early: 0xf0 -> 0xf4, date = 2023-02-22
>     [    0.000000] Linux version 6.5.0-4-amd64
> (debian-kernel@lists.debian.org) (gcc-13 (Debian 13.2.0-6) 13.2.0, GNU ld
> (GNU Binutils for Debian) 2.41) #1 SMP PREEMPT_DYNAMIC Debian 6.5.10-1
> (2023-11-03)
>     […]
>     [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
>     […]
>     [   15.646414] usbcore: registered new interface driver btusb
>     [   15.648188] ath10k_pci 0000:3a:00.0: pci irq msi oper_irq_mode 2
> irq_mode 0 reset_mode 0
>     [   15.649555] bluetooth hci0: firmware: direct-loading firmware
> qca/rampatch_usb_00000302.bin
>     [   15.650018] Bluetooth: hci0: using rampatch file:
> qca/rampatch_usb_00000302.bin
>     [   15.650020] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8,
> firmware rome 0x302 build 0x111
> 
> Although radio/wireless devices are turned off in GNOME, PowerTOP shows the
> Bluetooth device drawing 0.85 W of energy:
> 
>     848 mW    100.0%   Device         USB device: usb-device-0cf3-e300
> 
>     $ lsusb -d 0cf3:e300
>     Bus 001 Device 002: ID 0cf3:e300 Qualcomm Atheros Communications QCA61x4
> Bluetooth 4.0
> 
>     $ lspci -nn -s 3a:00.0
>     3a:00.0 Network controller [0280]: Qualcomm Atheros QCA6174 802.11ac
> Wireless Network Adapter [168c:003e] (rev 32)
> 
> After unloading the module `btusb`, the entry disappears from the PowerTOP
> list after a while.
> 
>     usbcore: deregistering interface driver btusb
> 
> Auto-suspend was enabled for the device. (Though it shouldn’t have mattered
> as it was disabled in GNOME?)
> 
> Anyways, have you heard of such an issue? Can I provide more information, to
> get it to not use any energy while being disable in GNOME?

USB devices still can draw power when their "wireless ability" is
disabled, that's up to the hardware to go into lower power states if it
can, or wants to.

So I recommend working with the bluetooth developers, maybe this device
can really not go any lower in power and still work properly when asked
to?  Do you know if the chipset even supports this?  If not, there's not
much the kernel can do about it.

thanks,

greg k-h
