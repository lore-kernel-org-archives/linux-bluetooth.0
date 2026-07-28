Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B33B8130;
	Tue, 28 Jul 2026 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785224503; cv=none; b=HGpTqd3tnZlxpIe9vpIso1qBdyNxlmbopnelFwbX9bvLVPz54QFn9RqH1iJoOcUP5WOHy6Sa3/GZKC9vjOWtwMXBeUtMKFuBzi2FNxZ3h3QTYLQX1WOkQAon7qW6pjXuLHgdNu08ry+e6jbke90CavMlMiQYhKP95pLMD41oHZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785224503; c=relaxed/simple;
	bh=XsdmZou0fTackEh0WMM0sYbZNqkiECMQ5w0O9RIbk1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myVp2NGJHIFpWVxJ8qLyans5R5cfNaqqPAUUspRnooMAOXUMB17900cdARzVUymqDvRDGa4jCdpMPCxoW+NUhKM73qEtC5+WqpPowkpvK3bm0Inb9LjXNJ35DAc4q2irymhiLTDnVAwWkRIhz2XmLDRsKwCBWXnisgA4Z8hq1b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qmce/vpk; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qmce/vpk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785224500; x=1816760500;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XsdmZou0fTackEh0WMM0sYbZNqkiECMQ5w0O9RIbk1E=;
  b=Qmce/vpku3wASksIP0SriLTjgjbGJG9fSxf3xtnfrfv4cp4B3v0cNA3n
   WskwFPCk/kTtPI9Q87uKjCfkG+pucTdvz0vxF1mf5XpzJN0lqUZUgUPiZ
   15Etey5Zp8C0izJMGqSSiMNENlS3TccTG2nOilJmqVw3L7ly2J6ycJ1h9
   FAnkHrSUSP49HsBFBMB4oqLouAbTOjXPrRV4/PzP1iqlh4GksEizmgZS4
   uAR21wdN7B83U6dKZHamueMYhQeiXkahSN2ieIR8wvvLafgzaGblUpYOD
   BnyWB7IjNUOyEZNV6NH0sid6H0Tyg56rIZCguWB8Fl4RzR8kPLTtzqkBC
   g==;
X-CSE-ConnectionGUID: VYwVzdNgTCGN1QXhQeWRnw==
X-CSE-MsgGUID: C1umCBqZRW6r3lGCR/Pwzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85567995"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="85567995"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 00:41:40 -0700
X-CSE-ConnectionGUID: +NujepCgQ3iuswt3bfII8w==
X-CSE-MsgGUID: WxNcIiCnRVmVf3tDlJ6b3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="264623587"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.244.93]) ([10.245.244.93])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 00:41:38 -0700
Message-ID: <2649b958-9f70-4cf6-a017-7ce3d9e423f9@linux.intel.com>
Date: Tue, 28 Jul 2026 10:41:35 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: xHCI TT: FS audio capture glitches when btusb SCO runs
 concurrently
To: Branislav Klocok <branislav.klocok@orava.sk>, linux-usb@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, mathias.nyman@intel.com
References: <c79e7821-eff0-4c75-a41a-bf14b00333c9@orava.sk>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <c79e7821-eff0-4c75-a41a-bf14b00333c9@orava.sk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi

Back from vacation

On 7/18/26 13:18, Branislav Klocok wrote:
> Hi,
> 
> I'd like to report (and ask for guidance on) an apparent conflict between
> two concurrent full-speed isochronous streams on the same xHCI controller:
> a full-speed USB audio device behind a hub (split transactions through the
> hub's TT) and the SCO endpoints of an Intel Bluetooth controller (btusb)
> on a root port.
> 
> Short version: while an HFP call is active over Bluetooth (SCO), the
> capture stream of a full-speed USB headset plugged in *behind a dock hub*
> is subtly corrupted. After mSBC encoding and the telephony path, the far
> end hears severely "robotic" audio. Moving the same headset to a direct
> root port makes the problem disappear immediately; moving it back behind
> the dock brings it back. CVSD calls are perceptually unaffected.
> 
> Environment
> -----------
> - ThinkPad X1 Carbon 6th gen; xHCI: Intel Sunrise Point-LP [8086:9d2f]
> - Kernel 7.1.3-1-default (openSUSE Tumbleweed), BlueZ 5.82,
>    PipeWire 1.6.8 / WirePlumber 0.5.15 (HFP native backend, laptop = HF)
> - Bluetooth: Intel 8265 [8087:0a2b], full-speed, internal (bus 1 root
>    port 7), fw ibt-12-16
> - USB headset: C-Media [0d8c:0014], full-speed, mono capture 48 kHz
> - Dock: Lenovo USB dock (hubs 17ef:3071/17ef:3070, cascade incl.
>    067b:2586 and 05e3:0610)
> - HFP counterpart: Android phone (Volla X23) as AG; a call was placed to
>    a second handset held at my ear, so I judged the far-end quality
>    directly while speaking
> 
> SCO detail during mSBC: eSCO, air mode Transparent, 60-byte RX/TX packet
> length, btusb isoc alt setting 1 (9-byte packets), HCI SCO frames
> dlen 24. CVSD uses alt setting 2 (17-byte packets).
> 
> Reproduction (single call, changing only the capture source / port)
> -------------------------------------------------------------------
> I kept the same position and speech style throughout and judged the
> quality on the far-end handset:
> 
>    uplink capture source                    far-end verdict
>    1. HS webcam (behind the same dock)      clean
>    2. FS headset behind dock hub A          severely "robotic"
>    3. same, headset moved 30 cm away        severely "robotic"
>                                             (rules out mic proximity/level)
>    4. FS headset on a DIRECT root port      clean
>    5. FS headset behind dock hub B          severely "robotic" again
>                                             (immediately reversible)
> 
> A parallel capture of the same source during phase 5 (recording to a file
> while the stream also feeds the call) contains audible subtle glitching
> already at the capture side -- i.e. the corruption exists in the USB
> capture data before any Bluetooth/mSBC processing. Amplitude analysis
> shows no zero-runs or full-scale clicks, so the defect consists of small
> sample-level discontinuities, which the frame-based mSBC codec then
> amplifies into severe artifacts, while sample-based CVSD mostly masks
> them.
> 
> What I ruled out
> ----------------
> - Bluetooth host stack: btmon traces covering a clean -> robotic -> clean
>    cycle show the HCI SCO TX stream is byte-perfect (intact 60-byte mSBC
>    framing with H2 headers, ~3333 frames/10 s constant) and the write
>    timing pattern is identical between clean and robotic phases (bursts of
>    3x24 B every ~7.5 ms). The RX direction is likewise clean. So
>    BlueZ/PipeWire/btusb submit correct data on time; the corruption
>    happens elsewhere.
> - Audio content/level: same speech, same position (phase 3).
> - The specific adapter/hub: reproduced behind two different hub chains,
>    and with a different FS combo headset (Sennheiser) behind a different
>    (Thunderbolt) dock in another location -- there the mSBC *downlink*
>    died completely while CVSD kept working.
> - PipeWire graph effects: an *idle* parallel capture from the FS device
>    behind the dock (both via PipeWire and via direct ALSA hw:) does NOT
>    disturb a call whose uplink comes from the HS webcam -- the corruption
>    only matters when the TT capture stream is the one feeding the call.
>    Consistent with the corruption being on the TT capture stream itself.
> 
> Possibly related: "Bluetooth: hci0: corrupted SCO packet" bursts (~14-32
> messages) at SCO setup time, with both codecs, transient. Earlier this
> year, on 6.18.8 with the Thunderbolt dock setup, mSBC showed frequent
> decode errors but audio still flowed; I have not bisected.
> 
> Questions
> ---------
> 1. Is this a known limitation of xHCI TT split-isochronous scheduling
>     with two concurrent FS isoc streams (one behind a TT, one on a root
>     port)? EHCI had a software TT scheduler
>     (CONFIG_USB_EHCI_TT_NEWSCHED); as far as I can tell xHCI relies on
>     hardware scheduling with no equivalent knob.
> 2. Which captures would help most? I can provide btmon traces (a 26 MB
>     clean/robotic cycle), usbmon captures, xhci dynamic debug logs and
>     audio samples, and I'm happy to test patches.

both xhci traces, and dynamic debug of a failing case behind a hub,
and successful case behind a roothub port could reveal something.

mount -t debugfs none /sys/kernel/debug
echo 'module xhci_hcd =p' >/sys/kernel/debug/dynamic_debug/control
echo 'module usbcore =p' >/sys/kernel/debug/dynamic_debug/control
echo 81920 > /sys/kernel/debug/tracing/buffer_size_kb
echo 1 > /sys/kernel/debug/tracing/events/xhci-hcd/enable
echo 1 > /sys/kernel/debug/tracing/tracing_on
< Reproduce issue >
Send output of dmesg
Send content of /sys/kernel/debug/tracing/trace

xhci traces should show all split transaction errors, and ring
under/overrun events.

There are a couple patches related to isoc transfer scheduling that
could be worth testing. They are not directly related to split
transactions but maybe worth a shot.

https://lore.kernel.org/linux-usb/20260513143533.52992-1-mathias.nyman@linux.intel.com/
https://lore.kernel.org/linux-usb/20260513143533.52992-2-mathias.nyman@linux.intel.com/

-Mathias

