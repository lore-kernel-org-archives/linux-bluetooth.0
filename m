Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69988212550
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786606984; cv=none; b=JK92ILckpDa/wIKL4ywN1WPvnXt4uQAH/fFeqEvUXfzJN4xNJZXsLjSDCQQYGDBfUgak2nbNJe2zqLOM+d33Xfgoolx9i+OMZXsXCfQWQzpnM8FCGD2daLicaACw8F0+f7DZOiKm6cv+1hp6gSTA7pJY87d5LvfDqKXloz5Q69I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786606984; c=relaxed/simple;
	bh=KneGrvr3rSpBGgjf8vMSZ04LejLtAlsRDWusb7Em6CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgE1PYgl3IGlU3HqyYN5LgJcWGGBSMWZCariYur5U0UWLflivIJuuKDORsA8JfoMDx3UO8wQ5weMb84WleEri4bJCpTj41dFZhPgbof4FLga/9z6k3PIe5KxCb4X2AzL8l997o/Y7AoofcltZMk5hKypcfRgJbWNFMvAuGF92pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Hxov9nt+; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Hxov9nt+"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4295F240101
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 09:42:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1786606974;
	bh=c9hkIRbgf6f8zhvt7Cywz8SNv/EGeT2pavotY+wqHrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
	 Content-Transfer-Encoding:From;
	b=Hxov9nt+wsfDcXgoY9lw7RVgbOp+ciMbzhmz9NKHulIbQC7ksz2YyR8yW4S3b4tut
	 wScAnOWhjcdpcdTf/DGBufM+EQONUbo1O4FQ4qv1f++JILRxTbyDvOS+8aPg6MTVJL
	 t6SkDxJtwFp2S50Prvs4NxR3x+69UAOcv3nY4Bj2AtHmexN4MPbMQZijffxlbWLrvj
	 6O7dfwg4Zwd3tNjP/vi/QG7D/UBBL0SVegJYHE7aYZPniOHXWRIoXVnU73EJgPi/Nb
	 luAZymtinI5R7upUNH2FyKuv9D1RvPWxT3eAUTizf7p5BF6sdpcabCbUJOHyw3WmBP
	 3Qeb0oEdPQcrw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hLHQP4jWGz6tvx;
	Thu, 13 Aug 2026 09:42:53 +0200 (CEST)
Message-ID: <7a787c1e-0aab-432c-9e70-a844d201aaf6@posteo.de>
Date: Thu, 13 Aug 2026 07:42:54 +0000
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BUG] Bluetooth: WCN6855 10ab:9309 stops reporting ISO TX
 completions during BAP LC3
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, brgl@kernel.org
References: <28554782-1f3b-4537-b891-1c483a29e8c3@posteo.de>
 <CABBYNZ+3dd4qea4LZAXiEwD3MHkiK82y5S7RFE2EQzQx5jS+Rw@mail.gmail.com>
Content-Language: en-US, de-DE
From: Jonas Zunker <jonas-zunker@posteo.de>
In-Reply-To: <CABBYNZ+3dd4qea4LZAXiEwD3MHkiK82y5S7RFE2EQzQx5jS+Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks, that makes sense.

CC'ing Bartosz since this looks like it may be related to the Qualcomm 
Bluetooth driver or firmware.

A few extra details:

  * Bluetooth is connected over USB: 10ab:9309
  * ROM version: 0x130201
  * Firmware:
      o qca/rampatch_usb_00130201.bin
      o qca/nvm_usb_00130201_gf.bin
  * I checked both files against current upstream linux-firmware and
    they match exactly.

SHA-256:

rampatch_usb_00130201.bin
10bb07a4c8d0e38d4fae9f6f5c10c51b54308fefe58d5587e3a3bb14b8fdb3c0

nvm_usb_00130201_gf.bin
59052bce0444fc35028aea8a854d31adb738a0ffd6ec5fbd4df54e6cf5475af8

The issue is still the same: four HCI ISO packets are sent, but no 
completion events are returned for the CIS, so transmission stops once 
the available buffers are used up.

Bartosz, does this look like a Qualcomm driver/firmware issue, or is 
there someone at Qualcomm I should CC for this?

Regards,
Jonas


Am 11.08.26 um 04:58 schrieb Luiz Augusto von Dentz:
> Hi Jonas,
>
> On Mon, Aug 10, 2026 at 6:22 PM Jonas Zunker <jonas-zunker@posteo.de> wrote:
>> Hello,
>>
>>     I am seeing a Bluetooth LE Audio/BAP failure with a Qualcomm WCN6855
>>     controller and Sony WH-1000XM6 headphones.
>>
>>     BAP negotiation succeeds and the audio profile appears active, but no
>> sound is
>>     heard. The attached btmon capture indicates that the controller stops
>> returning
>>     HCI ISO transmit completions.
>>
>>     Observed sequence
>>     =================
>>
>>     1. The sink and source ASE QoS configurations are accepted.
>>     2. The Enable operation succeeds for both ASEs.
>>     3. The connected isochronous stream is established successfully as CIS
>>        handle 4.
>>     4. Both host-to-controller and controller-to-host ISO data paths are
>> configured
>>        successfully.
>>     5. The sink and source ASEs both reach the Streaming state.
>>     6. The host submits four 120-byte HCI ISO packets on CIS handle 4.
>>     7. No Number Of Completed Packets event is received for CIS handle 4.
>>     8. Number Of Completed Packets events for ACL handle 3 continue normally.
>>     9. No further ISO audio packets are submitted, although application
>> playback
>>        remains active.
>>
>>     The final ISO packets in the attached capture are:
>>
>>         < LE-CIS: Handle 4 SN 0 ... slen 120
>>         < LE-CIS: Handle 4 SN 1 ... slen 120
>>         < LE-CIS: Handle 4 SN 2 ... slen 120
>>         < LE-CIS: Handle 4 SN 3 ... slen 120
>>
>>     There is no completion event for CIS handle 4 after these packets.
>>
>>     This appears to exhaust the four initial HCI ISO transmit credits.
>> The host
>>     cannot submit more audio because the controller does not replenish those
>>     credits.
>>
>>     PipeWire/WirePlumber also reports:
>>
>>         spa.bluez5.iso: Missing completion reports for packet ...
>>         Bluetooth adapter firmware bug?
>>
>>     After approximately 20 seconds, the kernel reports:
>>
>>         Bluetooth: hci0: link tx timeout
>>         Bluetooth: hci0: killing stalled connection <headset-address>
>>
>>     I am not attaching my complete system journal. The kernel messages
>> above were
>>     selected manually from the local logs.
>>
>>     Hardware
>>     ========
>>
>>     - Bluetooth controller: Qualcomm WCN6855
>>     - USB ID: 10ab:9309
>>     - Kernel drivers: btusb / btqca
>>     - Firmware patch file: qca/rampatch_usb_00130201.bin
>>     - NVM file: qca/nvm_usb_00130201_gf.bin
>>     - QCA ROM version: 0x130201
>>     - QCA patch build: 0x994d
>>     - QCA firmware build: 0x38e6
>>     - Headset: Sony WH-1000XM6
>>
>>     Software
>>     ========
>>
>>     - Distribution: Fedora 44
>>     - Kernel: 7.1.7-200.fc44.x86_64
>>     - Fedora BlueZ: bluez-5.87-3.fc44.x86_64
>>     - Upstream BlueZ: latest master, locally built
>>     - PipeWire: 1.6.8-1.fc44.x86_64
>>     - WirePlumber: 0.5.14-1.fc44.x86_64
>>     - linux-firmware: 20260622-1.fc44.noarch
>>
>>     The issue reproduces with both:
>>
>>     1. The unmodified Fedora bluez-5.87-3.fc44 package.
>>     2. A locally built version of the latest upstream BlueZ master tree.
>>
>>     The same four-packet ISO TX stall occurs with both versions.
>> Therefore, the
>>     failure does not appear to depend on my local BlueZ diagnostic changes.
>>
>>     The attached capture was recorded while using the upstream build. I
>> separately
>>     reproduced the same behavior with the unmodified Fedora BlueZ package.
>>
>>     Reproduction
>>     ============
>>
>>     1. Run either the Fedora-provided BlueZ daemon or an unmodified build
>> of the
>>        latest upstream BlueZ master.
>>     2. Pair and connect the Sony WH-1000XM6 over LE.
>>     3. Select the XM6 BAP/LC3 audio profile in GNOME sound settings.
>>     4. Start audio playback.
>>     5. BAP setup succeeds and both ASEs reach Streaming.
>>     6. No sound is heard.
>>     7. btmon records four outgoing ISO packets on CIS handle 4.
>>     8. No completion reports for CIS handle 4 follow.
>>     9. The connection eventually hits the kernel TX timeout.
>>
>>     Completely removing and pairing the headset again does not change the
>> result.
>>
>>     Expected result
>>     ===============
>>
>>     The controller should report completion of transmitted ISO packets
>> for CIS
>>     handle 4, allowing the host to replenish its ISO transmit credits and
>> continue
>>     sending LC3 audio.
>>
>>     Actual result
>>     =============
>>
>>     The controller accepts four ISO packets but provides no completion
>> reports for
>>     CIS handle 4. Audio transmission then stops, and the connection
>> eventually
>>     times out.
>>
>>     Regression status
>>     =================
>>
>>     I initially observed working LE Audio with the Fedora-provided stack,
>> but I have
>>     not yet isolated a specific kernel or firmware version where the behavior
>>     changed. I am therefore not marking this as a confirmed regression.
>>
>>     LLM disclosure
>>     ==============
>>
>>     I used an LLM assistant to help analyze the btmon capture and draft
>> this report.
>>     The capture and reproduction results come from my own system. I
>> reviewed the
>>     technical claims and am responsible for the submitted report.
>>
>>     Please let me know if a longer btmon capture, controller information,
>> or a
>>     comparison against another kernel would be useful.
>>
>>     Regards,
>>     Jonas
> Sounds like a firmware bug, I wouldn't be surprised if the firmware
> doesn't expect the audio to be transmitted over HCI. Anyway, without
> the Number of Completed Packets events the stack stops transmitting as
> soon as it detects the buffer is exhausted, so the packets are
> considered in flight and never complete. You may want to try to
> contact the driver author or the person who submitted the firmware to
> linux-firmware, perhaps Qualcomm will need to provide a different
> firmware for Linux, one that does allow the audio to be transmitted
> over HCI.
>
