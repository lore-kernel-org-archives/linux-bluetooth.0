Received: from mailsrv.dsidata.sk (mailsrv.dsidata.sk [80.87.208.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25F413D51E;
	Thu, 30 Jul 2026 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.87.208.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419182; cv=none; b=hcVkqw4r4u1hQ50v+aBNPpRDnyzERovahbVLT9PncZmSVIIGx6dM7eweYwKaIctqKsijWeETMMth4/h0bPzmFQTa/E8P3gvTvMaWDVRxuZHsGzQonp5ZSIGWJKphxt7XZrsInRDfWlcdaeAZJsObIemQ2g0Tk+BR3jTzc7qiDUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419182; c=relaxed/simple;
	bh=gBc6dAPzgjhIPeyEpIdEKebvmEGyuB9fxektSBdYM1Y=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=piIVTEN6sQJcxCVKCxuGSQo0oxl8cI2PgrHM759iyfpvpPP8QX/d12oJa9S889XZq6wm/7QE3t0YeV8gWfGTX8XQgNw9c1ZHo9d0w7wbATz0OsXdN5bNvjkjpNB6HVM5XM/a/1wRIK15KOme/ffz7HuYrJQc1yzYz+/JbQVhrcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orava.sk; spf=pass smtp.mailfrom=orava.sk; dkim=pass (1024-bit key) header.d=orava.sk header.i=@orava.sk header.b=ovq8e1zN; arc=none smtp.client-ip=80.87.208.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orava.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orava.sk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=orava.sk header.i=@orava.sk header.b="ovq8e1zN"
DKIM-Signature: a=rsa-sha256; t=1785419045; x=1786023845; s=2018; d=orava.sk; c=relaxed/relaxed; v=1; bh=rpyfyDanVcfZpxgOjM2yt6sclvo1o8Lg363OG1kJBwM=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:In-Reply-To:References;
   b=ovq8e1zNOGVs47Tew2s0TrOFrlKvMyUwLFe6YpzBAjEBGKY8yGk6VJl732MiBEBeW3x8ccPNV7dllYXve10PEIfNRED+rEGpsB+ZQQRRR6Jv8urT7h54hzcOJYuv7eVmj1MX/+68zU+UMenOJTXmzpoPg/paAzrUFem/HATEjuQ=
Received: from [192.168.20.107] ([80.87.210.74])
        by mailsrv.dsidata.sk (14.2.0 build 16 ) with ASMTP (SSL) id 202607301544057733;
        Thu, 30 Jul 2026 15:44:05 +0200
Content-Type: multipart/mixed; boundary="------------YRg0t3bwjovL460c4aAf7mO0"
Message-ID: <8afc07eb-9c15-4bfc-b46a-465eacd3e986@orava.sk>
Date: Thu, 30 Jul 2026 15:43:58 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: xHCI TT: FS audio capture glitches when btusb SCO runs
 concurrently
Content-Language: en-US, sk-SK
To: Mathias Nyman <mathias.nyman@linux.intel.com>, linux-usb@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, mathias.nyman@intel.com
References: <c79e7821-eff0-4c75-a41a-bf14b00333c9@orava.sk>
 <2649b958-9f70-4cf6-a017-7ce3d9e423f9@linux.intel.com>
From: Branislav Klocok <branislav.klocok@orava.sk>
In-Reply-To: <2649b958-9f70-4cf6-a017-7ce3d9e423f9@linux.intel.com>
X-CTCH: RefID="str=0001.0A2D033E.6A6B5525.0014,ss=1,re=0.000,recu=0.000,reip=0.000,vtr=str,vl=0,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

This is a multi-part message in MIME format.
--------------YRg0t3bwjovL460c4aAf7mO0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mathias,

thanks for the recipe. I captured both cases exactly as described
(dynamic debug for xhci_hcd + usbcore, xhci-hcd trace events,
81920 kB buffer), on the same kernel 7.1.3-1-default, during an
active mSBC HFP call each time, ~60-90 s per run. This time the
failing setup was the second environment from my original report
(Sennheiser FS combo headset [1395:0024] behind a Lenovo dock hub);
the clean run is the same headset moved to a direct root port
(usb-0000:00:14.0-2). Audible symptom matched previous findings:
uplink severely robotic behind the dock, clean on the root port
(downlink was clean in both runs this time).

Summary of the captures:

                             failing (behind dock)   clean (root port)
   trace Underrun events            2596                    0
   trace Missed events              3018                    0
   dmesg "Miss service
     interval error"                2219                    0
   trace isoc entries             368979                 361875 
(similar load)

The errors concentrate on exactly the two devices/endpoints involved:

- slot 39 = Sennheiser behind the dock TT:
     "Miss service interval error ... set skip flag"
     4090x on ep index 4 (EP2 IN  - the isoc capture endpoint),
      234x on ep index 1 (EP1 OUT - the isoc playback endpoint)
   (interleaved with "Found td. Clear skip flag" lines)

- slot 4 = Intel 8265 Bluetooth controller on root port 7 (1-7):
     "Underrun event on slot 4 ep 5"
     1884x on ep index 5 (EP3 OUT - the SCO isoc OUT endpoint)

Excerpt from the failing dmesg (first lines after the call went up):

   [58827.830235] xhci_hcd 0000:00:14.0: Underrun event on slot 4 ep 5
   [58827.830635] xhci_hcd 0000:00:14.0: Found td. Clear skip flag for 
slot 39 ep 4.
   [58827.833216] xhci_hcd 0000:00:14.0: Miss service interval error for 
slot 39 ep 4, set skip flag
   [58827.833699] xhci_hcd 0000:00:14.0: Found td. Clear skip flag for 
slot 39 ep 4.
   [58827.850113] xhci_hcd 0000:00:14.0: Miss service interval error for 
slot 39 ep 4, set skip flag
   [58827.876134] xhci_hcd 0000:00:14.0: Underrun event on slot 4 ep 5

Both error types run continuously for the whole duration of the call
(~90 s, first 58827.8, last 58916.9) and disappear completely when the
same headset is on the root port -- zero Underrun/Missed/MSIE events in
the clean run at comparable isoc traffic volume.

So during the call the xHC misses service intervals on the FS capture
stream behind the TT (matching the audible capture glitches from my
report) and at the same time hits ring underruns on the Bluetooth SCO
isoc OUT endpoint. The ep-index-to-endpoint mapping above is my
reading of xhci_get_endpoint_index(); please correct me if I misread.

Attached (xz):
- 12_failing_dock_dmesg.txt.xz      (32 kB)
- 12_failing_dock_xhci_trace.txt.xz (13 MB, full trace)
- 12_ok_rootport_dmesg.txt.xz       (9 kB)
- 12_ok_rootport_xhci_trace.txt.xz  (13 MB, full trace)

If the large attachments arrive as download links, that is my mail
server converting them; tell me if you prefer a different way to get
the full traces.

Next I will test the two isoc scheduling patches you pointed to and
report back:
https://lore.kernel.org/linux-usb/20260513143533.52992-1-mathias.nyman@linux.intel.com/
https://lore.kernel.org/linux-usb/20260513143533.52992-2-mathias.nyman@linux.intel.com/

Best regards,
Branislav Klocok

-- 
Branislav Klocok
email: branislav.klocok@orava.sk
tel: +421908703366

Dňa 28. 7. 2026 o 9:41 Mathias Nyman napísal(a):
> Hi
> 
> Back from vacation
> 
> On 7/18/26 13:18, Branislav Klocok wrote:
>> Hi,
>>
>> I'd like to report (and ask for guidance on) an apparent conflict between
>> two concurrent full-speed isochronous streams on the same xHCI 
>> controller:
>> a full-speed USB audio device behind a hub (split transactions through 
>> the
>> hub's TT) and the SCO endpoints of an Intel Bluetooth controller (btusb)
>> on a root port.
>>
>> Short version: while an HFP call is active over Bluetooth (SCO), the
>> capture stream of a full-speed USB headset plugged in *behind a dock hub*
>> is subtly corrupted. After mSBC encoding and the telephony path, the far
>> end hears severely "robotic" audio. Moving the same headset to a direct
>> root port makes the problem disappear immediately; moving it back behind
>> the dock brings it back. CVSD calls are perceptually unaffected.
>>
>> Environment
>> -----------
>> - ThinkPad X1 Carbon 6th gen; xHCI: Intel Sunrise Point-LP [8086:9d2f]
>> - Kernel 7.1.3-1-default (openSUSE Tumbleweed), BlueZ 5.82,
>>    PipeWire 1.6.8 / WirePlumber 0.5.15 (HFP native backend, laptop = HF)
>> - Bluetooth: Intel 8265 [8087:0a2b], full-speed, internal (bus 1 root
>>    port 7), fw ibt-12-16
>> - USB headset: C-Media [0d8c:0014], full-speed, mono capture 48 kHz
>> - Dock: Lenovo USB dock (hubs 17ef:3071/17ef:3070, cascade incl.
>>    067b:2586 and 05e3:0610)
>> - HFP counterpart: Android phone (Volla X23) as AG; a call was placed to
>>    a second handset held at my ear, so I judged the far-end quality
>>    directly while speaking
>>
>> SCO detail during mSBC: eSCO, air mode Transparent, 60-byte RX/TX packet
>> length, btusb isoc alt setting 1 (9-byte packets), HCI SCO frames
>> dlen 24. CVSD uses alt setting 2 (17-byte packets).
>>
>> Reproduction (single call, changing only the capture source / port)
>> -------------------------------------------------------------------
>> I kept the same position and speech style throughout and judged the
>> quality on the far-end handset:
>>
>>    uplink capture source                    far-end verdict
>>    1. HS webcam (behind the same dock)      clean
>>    2. FS headset behind dock hub A          severely "robotic"
>>    3. same, headset moved 30 cm away        severely "robotic"
>>                                             (rules out mic proximity/ 
>> level)
>>    4. FS headset on a DIRECT root port      clean
>>    5. FS headset behind dock hub B          severely "robotic" again
>>                                             (immediately reversible)
>>
>> A parallel capture of the same source during phase 5 (recording to a file
>> while the stream also feeds the call) contains audible subtle glitching
>> already at the capture side -- i.e. the corruption exists in the USB
>> capture data before any Bluetooth/mSBC processing. Amplitude analysis
>> shows no zero-runs or full-scale clicks, so the defect consists of small
>> sample-level discontinuities, which the frame-based mSBC codec then
>> amplifies into severe artifacts, while sample-based CVSD mostly masks
>> them.
>>
>> What I ruled out
>> ----------------
>> - Bluetooth host stack: btmon traces covering a clean -> robotic -> clean
>>    cycle show the HCI SCO TX stream is byte-perfect (intact 60-byte mSBC
>>    framing with H2 headers, ~3333 frames/10 s constant) and the write
>>    timing pattern is identical between clean and robotic phases 
>> (bursts of
>>    3x24 B every ~7.5 ms). The RX direction is likewise clean. So
>>    BlueZ/PipeWire/btusb submit correct data on time; the corruption
>>    happens elsewhere.
>> - Audio content/level: same speech, same position (phase 3).
>> - The specific adapter/hub: reproduced behind two different hub chains,
>>    and with a different FS combo headset (Sennheiser) behind a different
>>    (Thunderbolt) dock in another location -- there the mSBC *downlink*
>>    died completely while CVSD kept working.
>> - PipeWire graph effects: an *idle* parallel capture from the FS device
>>    behind the dock (both via PipeWire and via direct ALSA hw:) does NOT
>>    disturb a call whose uplink comes from the HS webcam -- the corruption
>>    only matters when the TT capture stream is the one feeding the call.
>>    Consistent with the corruption being on the TT capture stream itself.
>>
>> Possibly related: "Bluetooth: hci0: corrupted SCO packet" bursts (~14-32
>> messages) at SCO setup time, with both codecs, transient. Earlier this
>> year, on 6.18.8 with the Thunderbolt dock setup, mSBC showed frequent
>> decode errors but audio still flowed; I have not bisected.
>>
>> Questions
>> ---------
>> 1. Is this a known limitation of xHCI TT split-isochronous scheduling
>>     with two concurrent FS isoc streams (one behind a TT, one on a root
>>     port)? EHCI had a software TT scheduler
>>     (CONFIG_USB_EHCI_TT_NEWSCHED); as far as I can tell xHCI relies on
>>     hardware scheduling with no equivalent knob.
>> 2. Which captures would help most? I can provide btmon traces (a 26 MB
>>     clean/robotic cycle), usbmon captures, xhci dynamic debug logs and
>>     audio samples, and I'm happy to test patches.
> 
> both xhci traces, and dynamic debug of a failing case behind a hub,
> and successful case behind a roothub port could reveal something.
> 
> mount -t debugfs none /sys/kernel/debug
> echo 'module xhci_hcd =p' >/sys/kernel/debug/dynamic_debug/control
> echo 'module usbcore =p' >/sys/kernel/debug/dynamic_debug/control
> echo 81920 > /sys/kernel/debug/tracing/buffer_size_kb
> echo 1 > /sys/kernel/debug/tracing/events/xhci-hcd/enable
> echo 1 > /sys/kernel/debug/tracing/tracing_on
> < Reproduce issue >
> Send output of dmesg
> Send content of /sys/kernel/debug/tracing/trace
> 
> xhci traces should show all split transaction errors, and ring
> under/overrun events.
> 
> There are a couple patches related to isoc transfer scheduling that
> could be worth testing. They are not directly related to split
> transactions but maybe worth a shot.
> 
> https://lore.kernel.org/linux-usb/20260513143533.52992-1- 
> mathias.nyman@linux.intel.com/
> https://lore.kernel.org/linux-usb/20260513143533.52992-2- 
> mathias.nyman@linux.intel.com/
> 
> -Mathias

--------------YRg0t3bwjovL460c4aAf7mO0
Content-Type: application/octet-stream; name="12_failing_dock_dmesg.txt.xz"
Content-Disposition: attachment; filename="12_failing_dock_dmesg.txt.xz"
Content-Transfer-Encoding: base64

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
AAHA+gHrqSVWCfP5scRn+wIAAAAABFla
--------------YRg0t3bwjovL460c4aAf7mO0
Content-Type: application/octet-stream; name="12_ok_rootport_dmesg.txt.xz"
Content-Disposition: attachment; filename="12_ok_rootport_dmesg.txt.xz"
Content-Transfer-Encoding: base64

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

--------------YRg0t3bwjovL460c4aAf7mO0--
