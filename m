Received: from m.b4.vu (m.b4.vu [203.16.231.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6162211CBA;
	Thu, 13 Mar 2025 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.16.231.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850051; cv=none; b=o2m1XSx8hHHx1iWFD+sf7zoLZlAh7/Azkwh6SmcOkeC1DsF3wMeTQFK490RO0wbSqTA2Pjc+RRc83pKqGZKCI2QrqjRIQcgiNC+pXcW+ZgGBmdFA7Do4AYwsEQWQ12fah67bdj1cIsvHEpHOnM0PIBfUONdbcJX6rFS9r3rYl6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850051; c=relaxed/simple;
	bh=1HZI2M9JlXTUZ1YgkAN4AqKwcZV+DmReLxxNsgawvjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+kgI5Oy3ZGiXKgL6tnGnUjzRzA4cyYD78abJb/8dw3ixBfqwNQ6GZZndMkzSfDLpUIcwLSGlP5lhzEWwBAJxgqljjOmKWi7jeUQlVbJK5ECnfjDsXxSDnSNZ+vQDU9jA2DNx7LNhbnOvDAgAUATZcfm6kwAtShPFGb2iYf0M+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=b4.vu; spf=pass smtp.mailfrom=b4.vu; dkim=pass (2048-bit key) header.d=b4.vu header.i=@b4.vu header.b=tF5pZGcN; arc=none smtp.client-ip=203.16.231.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=b4.vu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b4.vu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b4.vu header.i=@b4.vu header.b="tF5pZGcN"
Received: by m.b4.vu (Postfix, from userid 1000)
	id E0A946668A63; Thu, 13 Mar 2025 17:43:57 +1030 (ACDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.b4.vu E0A946668A63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b4.vu; s=m1;
	t=1741850037; bh=1XEVGlSxb/36UGnG9MCwM00BNA/70lDNhCkO1sNAHjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tF5pZGcNP/0TLwdufTkh7ip1NBGmfFOfuqNk5yzwfQYFvto472c0sv3k6Putw3U5a
	 +19aILl7HeGHbeX/tiXtefIOxWRDeplHeoFMRV6O5tPR4treQEH8M15+6k4TxTx46g
	 30ksiOJtp/zU7GK3fevsIP3nupnVZmrZdSQY57Dy51cKQEP97xEnDMqnZ49jMgTEUW
	 nFnrjMBDa8NJooyrGs8GAEN2BEMkfNsi/W8mYQjbLdjkwk8QQL5qtyjAjN8O95cuV7
	 M/FMCf3sNBq7stD14NE6fZH4d2bBGQSHkSWBDJvozxmd+g7Ad+w1meBUI+keuemJ5e
	 TIqWAeUgz/vGQ==
Date: Thu, 13 Mar 2025 17:43:57 +1030
From: "Geoffrey D. Bennett" <g@b4.vu>
To: Benedikt Ziemons <ben@rs485.network>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Geraldo Nascimento <geraldogabriel@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Hao Qin <hao.qin@mediatek.com>, linux-bluetooth@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>, linux-sound@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] Fix for MediaTek reset affecting Focusrite audio
 interfaces
Message-ID: <Z9KFtWYLQhaP7RzU@m.b4.vu>
References: <Z8ybO7DfeP3Ag9wz@m.b4.vu>
 <Z89YcqoED633dr_M@geday>
 <CABBYNZJCko6radLuW=M=jTzqUEr2rUoKc_TUBVWP9wFSgkKb6Q@mail.gmail.com>
 <d81e863b00b3153c1de1c782205713fa99a79308.camel@rs485.network>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d81e863b00b3153c1de1c782205713fa99a79308.camel@rs485.network>

On Thu, Mar 13, 2025 at 02:43:09AM +0100, Benedikt Ziemons wrote:
> On Tue, 2025-03-11 at 21:53 -0400, Luiz Augusto von Dentz wrote:
> > Hi Chris, Sean, Hao,
> > 
> > On Mon, Mar 10, 2025 at 5:24 PM Geraldo Nascimento
> > <geraldogabriel@gmail.com> wrote:
> > > 
> > > On Sun, Mar 09, 2025 at 06:02:11AM +1030, Geoffrey D. Bennett
> > > wrote:
> > > > This series (choose 1 of the 2 patches) addresses an issue where
> > > > the
> > > > MT7922 Bluetooth controller reset added in commit ccfc8948d7e4
> > > > ("Bluetooth: btusb: mediatek: reset the controller before
> > > > downloading
> > > > the fw") is causing Focusrite USB audio devices to fail to
> > > > initialise
> > > > when connected during boot on kernels 6.11 and newer.
> > > > 
> > > > Reported by three users here:
> > > > https://github.com/geoffreybennett/linux-fcp/issues/24
> > > > 
> > > > Two users confirmed they have an MT7922.
> > > > 
> > > > I'm providing two possible solutions as I note there was a
> > > > similar
> > > > change made in commit a7208610761a ("Bluetooth: btmtk: Remove
> > > > resetting mt7921 before downloading the fw"), so I'm not sure if
> > > > the
> > > > reset should be reverted for the MT7925 as well as the MT7922.
> > > > 
> > > > Option 1: Revert the problematic reset behaviour entirely (MT7922
> > > > +
> > > > MT7925)
> > > > 
> > > > Option 2: Remove the reset only for the MT7922
> > > > 
> > > > Geoffrey D. Bennett (2):
> > > > 
> > > >   [PATCH 1/2] Revert "Bluetooth: btusb: mediatek: reset the
> > > > controller
> > > >     before downloading the fw"
> > > > 
> > > >   [PATCH 2/2] Bluetooth: btmtk: Remove resetting mt7922 before
> > > >     downloading the fw
> > > > 
> > > > --
> > > > 2.45.0
> > > > 
> > > > 
> > > 
> > > Hi Geoffrey,
> > > 
> > > I understand there's no apparent nexus of causality here.
> > > 
> > > However if three different users suddenly reported the same problem
> > > and
> > > the fix fixes it, we should take the report seriously and back down
> > > on the problematic commit until we figure for sure what the heck is
> > > going on.
> > > 
> > > My bet is this is bona fide bug in the USB subsystem, but either
> > > I'm not
> > > looking hard enough or I'm looking into the wrong places, because
> > > there's no way I can see in which way USB bluetooth driver from
> > > MediaTek could cause clock detection to fail.
> > > 
> > > No point in pressing this harder, but yeah, take the reports more
> > > than
> > > seriously, because if we don't understand in which way our own
> > > (Linux)
> > > code could be causing this, at least we should take cautionary
> > > measures.
> > > 
> > > In that sense, putting Takashi Iwai and Greg KH to Cc: in a modest
> > > but
> > > sincere belief that this issue is more than real, even though it
> > > looks
> > > like anticipated April 1st. Takashi can help with his expertise in
> > > clock
> > > detection and Greg could help pinpoint if this is indeed madness in
> > > the
> > > USB subsystem.
> > > 
> > > Hope you and them don't mind the escalation :)
> > 
> > Do you guys have any idea what could be possibly going on here? There
> > really seems something is not right if one driver affects the other,
> > especially if the devices are not actually related in any way.
> > 
> > 
> 
> Hello everyone,
> 
> I did the kernel bisection on this issue and tested Geoffrey's patches
> since I own the affected combination of hardware and can reliably
> reproduce the issue.
> 
> I was now able to capture both the sound device initialization failure
> and the successful initialization from initramfs using the usbmon
> module. One difference that is immediately noticeable is the amount of
> URB_CONTROL data that is sent to the mediatek btusb device and a
> considerable slow-down of the boot process (around 16s difference).
> 
> Following is some more information about the timing and other related
> messages from the kernel message log. The first excerpt is from an
> unpatched kernel 6.14.0-rc5:
> 
> [   59.987242] lunar kernel: usb 1-2: new high-speed USB device number 2 using xhci_hcd
> [   59.987975] lunar kernel: usb 1-2: New USB device found, idVendor=1235, idProduct=8212, bcdDevice= 6.45
> [   59.988048] lunar kernel: usb 1-2: New USB device strings: Mfr=1, Product=3, SerialNumber=2
> [   59.988121] lunar kernel: usb 1-2: Product: Scarlett 4i4 USB
> [   59.988197] lunar kernel: usb 1-2: Manufacturer: Focusrite
> [   60.571193] lunar kernel: mt7921e 0000:0a:00.0: enabling device (0000 -> 0002)
> [   60.571314] lunar kernel: mt7921e 0000:0a:00.0: ASIC revision: 79220010
> [   60.571501] lunar kernel: usbcore: registered new interface driver btusb
> [   60.571513] lunar kernel: mt7921e 0000:0a:00.0: HW/SW Version: 0x8a108a10, Build Time: 20241106163228a
> [   60.571627] lunar kernel: mt7921e 0000:0a:00.0: WM Firmware Version: ____000000, Build Time: 20241106163310
> [   60.616673] lunar kernel: Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20241106163512
> [   64.549017] lunar kernel: mt7921e 0000:0a:00.0 wlp10s0: renamed from wlan0
> [   70.700407] lunar kernel: usb 1-2: parse_audio_format_rates_v2v3(): unable to retrieve number of sample rates (clock 41)
> [   81.264360] lunar kernel: usb 1-2: parse_audio_format_rates_v2v3(): unable to retrieve number of sample rates (clock 41)
> [   81.264611] lunar kernel: usb 1-2: Focusrite Scarlett Gen 3 Mixer Driver enabled (pid=0x8212); report any issues to https://github.com/geoffreybennett/scarlett-gen2/issues
> [   81.264782] lunar kernel: usb 1-2: Error initialising Scarlett Gen 3 Mixer Driver: -71
> [   81.264903] lunar kernel: snd-usb-audio 1-2:1.0: probe with driver snd-usb-audio failed with error -71
> [   81.265040] lunar kernel: usb 1-2: Quirk or no altset; falling back to MIDI 1.0
> [   81.400030] lunar kernel: Bluetooth: hci0: Device setup in 20435397 usecs
> [   81.400114] lunar kernel: Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [   81.680052] lunar kernel: Bluetooth: hci0: AOSP extensions version v1.00
> [   81.680170] lunar kernel: Bluetooth: hci0: AOSP quality report is supported
> [   87.373353] lunar kernel: usbcore: registered new interface driver snd-usb-audio
> 
> 
> The following second excerpt is from the same kernel version with
> Geoffrey's second patch applied:
> 
> [  139.603887] lunar kernel: usb 1-2: new high-speed USB device number 2 using xhci_hcd
> [  139.604524] lunar kernel: usb 1-2: New USB device found, idVendor=1235, idProduct=8212, bcdDevice= 6.45
> [  139.604598] lunar kernel: usb 1-2: New USB device strings: Mfr=1, Product=3, SerialNumber=2
> [  139.604672] lunar kernel: usb 1-2: Product: Scarlett 4i4 USB
> [  139.604744] lunar kernel: usb 1-2: Manufacturer: Focusrite
> [  140.192488] lunar kernel: usbcore: registered new interface driver btusb
> [  140.192501] lunar kernel: mt7921e 0000:0a:00.0: enabling device (0000 -> 0002)
> [  140.192627] lunar kernel: Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20241106163512
> [  140.192639] lunar kernel: mt7921e 0000:0a:00.0: ASIC revision: 79220010
> [  140.192753] lunar kernel: mt7921e 0000:0a:00.0: HW/SW Version: 0x8a108a10, Build Time: 20241106163228a
> [  140.192866] lunar kernel: mt7921e 0000:0a:00.0: WM Firmware Version: ____000000, Build Time: 20241106163310
> [  140.240011] lunar kernel: Bluetooth: hci0: Device setup in 188119 usecs
> [  140.240048] lunar kernel: Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [  140.513341] lunar kernel: Bluetooth: hci0: AOSP extensions version v1.00
> [  140.513379] lunar kernel: Bluetooth: hci0: AOSP quality report is supported
> [  144.115475] lunar kernel: mt7921e 0000:0a:00.0 wlp10s0: renamed from wlan0
> [  144.115747] lunar kernel: usb 1-2: Focusrite Scarlett Gen 3 Mixer Driver enabled (pid=0x8212); report any issues to https://github.com/geoffreybennett/scarlett-gen2/issues
> [  144.115857] lunar kernel: usb 1-2: Firmware version 1605
> [  144.115954] lunar kernel: usb 1-2: Quirk or no altset; falling back to MIDI 1.0
> [  147.843340] lunar kernel: usbcore: registered new interface driver snd-usb-audio
> 
> 
> Comparing the USB captures from the hub, filtered to just the first few
> messages of the audio device yield the following exchanges. Again,
> first the broken case:
> 
> No.     Time           Source                Destination           Protocol Length Info
>       7 0.011098       host                  1.2.0                 USB      64     GET DESCRIPTOR Request DEVICE
>       8 0.015218       1.2.0                 host                  USB      82     GET DESCRIPTOR Response DEVICE
>       9 0.015272       host                  1.2.0                 USB      64     GET DESCRIPTOR Request CONFIGURATION
>      10 0.017966       1.2.0                 host                  USB      73     GET DESCRIPTOR Response CONFIGURATION
>      11 0.018020       host                  1.2.0                 USB      64     GET DESCRIPTOR Request CONFIGURATION
>      12 0.025965       1.2.0                 host                  USB      425    GET DESCRIPTOR Response CONFIGURATION
>      23 2.482241       host                  1.2.0                 USB      64     GET DESCRIPTOR Request STRING
>      24 2.484931       1.2.0                 host                  USB      98     GET DESCRIPTOR Response STRING
>      25 2.484939       host                  1.2.0                 USB      64     GET DESCRIPTOR Request STRING
>      26 2.487916       1.2.0                 host                  USB      84     GET DESCRIPTOR Response STRING
>      27 2.487941       host                  1.2.0                 USBAUDIO 65     SET CUR CX_CLOCK_SELECTOR_CONTROL request
>    2047 7.661154       1.2.0                 host                  USBAUDIO 64     SET CUR CX_CLOCK_SELECTOR_CONTROL status
>    2048 7.661197       host                  1.2.0                 USBAUDIO 64     GET RANGE CS_SAM_FREQ_CONTROL request
>    4097 12.781553      1.2.0                 host                  USBAUDIO 64     GET RANGE CS_SAM_FREQ_CONTROL[Malformed Packet]
> 
> 
> The first discrepancy can be found in the URB status field of packet
> no. 2047 (vs. 74 below) which is -2: No such file or directory (-
> ENOENT).
> In the second (following) case where the sound device initializes okay,
> the URB status of the similar packet is Success (0) instead:
> 
> No.     Time           Source                Destination           Protocol Length Info
>       7 0.011565       host                  1.2.0                 USB      64     GET DESCRIPTOR Request DEVICE
>       8 0.015471       1.2.0                 host                  USB      82     GET DESCRIPTOR Response DEVICE
>       9 0.015523       host                  1.2.0                 USB      64     GET DESCRIPTOR Request CONFIGURATION
>      10 0.018477       1.2.0                 host                  USB      73     GET DESCRIPTOR Response CONFIGURATION
>      11 0.018537       host                  1.2.0                 USB      64     GET DESCRIPTOR Request CONFIGURATION
>      12 0.026331       1.2.0                 host                  USB      425    GET DESCRIPTOR Response CONFIGURATION
>      23 4.168190       host                  1.2.0                 USB      64     GET DESCRIPTOR Request STRING
>      24 4.171031       1.2.0                 host                  USB      98     GET DESCRIPTOR Response STRING
>      25 4.171040       host                  1.2.0                 USB      64     GET DESCRIPTOR Request STRING
>      26 4.174021       1.2.0                 host                  USB      84     GET DESCRIPTOR Response STRING
>      27 4.174041       host                  1.2.0                 USBAUDIO 65     SET CUR CX_CLOCK_SELECTOR_CONTROL request
>      74 4.476033       1.2.0                 host                  USBAUDIO 64     SET CUR CX_CLOCK_SELECTOR_CONTROL status
>      75 4.476050       host                  1.2.0                 USBAUDIO 64     GET CUR CX_CLOCK_SELECTOR_CONTROL request
>      76 4.479034       1.2.0                 host                  USBAUDIO 65     GET CUR CX_CLOCK_SELECTOR_CONTROL response
>      77 4.479050       host                  1.2.0                 USBAUDIO 64     GET RANGE CS_SAM_FREQ_CONTROL request
>     202 4.582043       1.2.0                 host                  USBAUDIO 66     GET RANGE CS_SAM_FREQ_CONTROL response
> 
> 
> Please ask, if I should provide any more information or how and to whom
> I can provide the full USB captures.
> 
> Thank you,
> Ben

Hi Ben,

This bit sticks out to me:

> [   81.400030] lunar kernel: Bluetooth: hci0: Device setup in 20435397 usecs

20 seconds to initialise bluetooth, vs. 188ms when not doing the reset:

> [  140.240011] lunar kernel: Bluetooth: hci0: Device setup in 188119 usecs

Does it still take 20 seconds when the Scarlett is not plugged in at
boot time?

I presume lsusb -t shows both devices on the same USB bus?

Thanks,
Geoffrey.
