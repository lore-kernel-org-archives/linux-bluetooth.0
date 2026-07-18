Received: from mailsrv.dsidata.sk (mailsrv.dsidata.sk [80.87.208.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E91243F0A0;
	Sat, 18 Jul 2026 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.87.208.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784370068; cv=none; b=pC40QLR6JUqTAuUlDvaSt9i+0ujj6wpynClgasi4jEkVkL9PfUi7+iGMMXGVi6HBBWNaIqhyJJpF8uIJXS9AM7JLh+nDSOZyk526IBUADUrnH1U5AqVhh5x/g3aEZZRs6kKGZKAtXCkMQYjgSgtd9ojc9E0I/Gf11nRO8imA71c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784370068; c=relaxed/simple;
	bh=5iMZmqmjBSKbPtQY4PLTrVc2WqfrJPG6IZMqVKRBSu4=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=G3CWW08a1/wVsgHwP0EUcZ5UvDs6Dvk78sBVSu6W17o0ygOGsSmaAhHeQrVGVSM4hVHifa5bZMqp3lsNZZDNNZ/cSsxUhehZimF2dGMVruf3ceuoxZxVSU0hC2cdMpbssd3fHf4spxo0unjFTayOA+amGc8EYqcMVl1SPMtm72k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orava.sk; spf=pass smtp.mailfrom=orava.sk; dkim=pass (1024-bit key) header.d=orava.sk header.i=@orava.sk header.b=hxbHppgw; arc=none smtp.client-ip=80.87.208.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orava.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orava.sk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=orava.sk header.i=@orava.sk header.b="hxbHppgw"
DKIM-Signature: a=rsa-sha256; t=1784369911; x=1784974711; s=2018; d=orava.sk; c=relaxed/relaxed; v=1; bh=Ws1dxkoGI05DP5xLCcQhzaRSrH1Hg7hjHyjznl3MjwY=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
   b=hxbHppgw2GBEX4PAJuaIb1+jP5CyDNaZs3HraOT6TguFyCucv+7DO8h4OZGDJUq7sRnQngCRm734NwE2Lk9mJJEUbaKVD+rlz+zZoGa+l4zx86KVklGq9gozrlAkadJJw42F11fJLG4WoD+FhZxYbA4E1SR5QwYwWKrWSfyercw=
Received: from [192.168.15.14] ([213.81.222.48])
        by mailsrv.dsidata.sk (14.2.0 build 16 ) with ASMTP (SSL) id 202607181218315607;
        Sat, 18 Jul 2026 12:18:31 +0200
Message-ID: <c79e7821-eff0-4c75-a41a-bf14b00333c9@orava.sk>
Date: Sat, 18 Jul 2026 12:18:24 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-usb@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, mathias.nyman@intel.com
Subject: xHCI TT: FS audio capture glitches when btusb SCO runs concurrently
Content-Language: en-US, sk-SK
From: Branislav Klocok <branislav.klocok@orava.sk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CTCH: RefID="str=0001.0A2D035C.6A5B52F6.003C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

Hi,

I'd like to report (and ask for guidance on) an apparent conflict between
two concurrent full-speed isochronous streams on the same xHCI controller:
a full-speed USB audio device behind a hub (split transactions through the
hub's TT) and the SCO endpoints of an Intel Bluetooth controller (btusb)
on a root port.

Short version: while an HFP call is active over Bluetooth (SCO), the
capture stream of a full-speed USB headset plugged in *behind a dock hub*
is subtly corrupted. After mSBC encoding and the telephony path, the far
end hears severely "robotic" audio. Moving the same headset to a direct
root port makes the problem disappear immediately; moving it back behind
the dock brings it back. CVSD calls are perceptually unaffected.

Environment
-----------
- ThinkPad X1 Carbon 6th gen; xHCI: Intel Sunrise Point-LP [8086:9d2f]
- Kernel 7.1.3-1-default (openSUSE Tumbleweed), BlueZ 5.82,
   PipeWire 1.6.8 / WirePlumber 0.5.15 (HFP native backend, laptop = HF)
- Bluetooth: Intel 8265 [8087:0a2b], full-speed, internal (bus 1 root
   port 7), fw ibt-12-16
- USB headset: C-Media [0d8c:0014], full-speed, mono capture 48 kHz
- Dock: Lenovo USB dock (hubs 17ef:3071/17ef:3070, cascade incl.
   067b:2586 and 05e3:0610)
- HFP counterpart: Android phone (Volla X23) as AG; a call was placed to
   a second handset held at my ear, so I judged the far-end quality
   directly while speaking

SCO detail during mSBC: eSCO, air mode Transparent, 60-byte RX/TX packet
length, btusb isoc alt setting 1 (9-byte packets), HCI SCO frames
dlen 24. CVSD uses alt setting 2 (17-byte packets).

Reproduction (single call, changing only the capture source / port)
-------------------------------------------------------------------
I kept the same position and speech style throughout and judged the
quality on the far-end handset:

   uplink capture source                    far-end verdict
   1. HS webcam (behind the same dock)      clean
   2. FS headset behind dock hub A          severely "robotic"
   3. same, headset moved 30 cm away        severely "robotic"
                                            (rules out mic proximity/level)
   4. FS headset on a DIRECT root port      clean
   5. FS headset behind dock hub B          severely "robotic" again
                                            (immediately reversible)

A parallel capture of the same source during phase 5 (recording to a file
while the stream also feeds the call) contains audible subtle glitching
already at the capture side -- i.e. the corruption exists in the USB
capture data before any Bluetooth/mSBC processing. Amplitude analysis
shows no zero-runs or full-scale clicks, so the defect consists of small
sample-level discontinuities, which the frame-based mSBC codec then
amplifies into severe artifacts, while sample-based CVSD mostly masks
them.

What I ruled out
----------------
- Bluetooth host stack: btmon traces covering a clean -> robotic -> clean
   cycle show the HCI SCO TX stream is byte-perfect (intact 60-byte mSBC
   framing with H2 headers, ~3333 frames/10 s constant) and the write
   timing pattern is identical between clean and robotic phases (bursts of
   3x24 B every ~7.5 ms). The RX direction is likewise clean. So
   BlueZ/PipeWire/btusb submit correct data on time; the corruption
   happens elsewhere.
- Audio content/level: same speech, same position (phase 3).
- The specific adapter/hub: reproduced behind two different hub chains,
   and with a different FS combo headset (Sennheiser) behind a different
   (Thunderbolt) dock in another location -- there the mSBC *downlink*
   died completely while CVSD kept working.
- PipeWire graph effects: an *idle* parallel capture from the FS device
   behind the dock (both via PipeWire and via direct ALSA hw:) does NOT
   disturb a call whose uplink comes from the HS webcam -- the corruption
   only matters when the TT capture stream is the one feeding the call.
   Consistent with the corruption being on the TT capture stream itself.

Possibly related: "Bluetooth: hci0: corrupted SCO packet" bursts (~14-32
messages) at SCO setup time, with both codecs, transient. Earlier this
year, on 6.18.8 with the Thunderbolt dock setup, mSBC showed frequent
decode errors but audio still flowed; I have not bisected.

Questions
---------
1. Is this a known limitation of xHCI TT split-isochronous scheduling
    with two concurrent FS isoc streams (one behind a TT, one on a root
    port)? EHCI had a software TT scheduler
    (CONFIG_USB_EHCI_TT_NEWSCHED); as far as I can tell xHCI relies on
    hardware scheduling with no equivalent knob.
2. Which captures would help most? I can provide btmon traces (a 26 MB
    clean/robotic cycle), usbmon captures, xhci dynamic debug logs and
    audio samples, and I'm happy to test patches.

Best regards,

-- 
Branislav Klocok
email: branislav.klocok@orava.sk
tel: +421908703366

