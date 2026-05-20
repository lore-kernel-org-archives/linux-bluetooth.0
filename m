Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F1548EE
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779276991; cv=none; b=CNlJj8VP6n+ubnUOtrbpu22o99wSrAi2fdV1F1qjQOXE0JTnFVDmL6iFmGsxXajG7RAhlR71exDIOLPXJk7XweeQvoKbk9peI7NGtc3qpW5+15bZK0zVVXe3a9cWZH0lMyj91RDqNTrjBilkyNXC2B8CCg9nDvOf6ByuALNTq54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779276991; c=relaxed/simple;
	bh=m0wqkp9zrSFHlR9fbC8W2hs2AXAkdV7C0ItK8vHKWXM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=SeinglQdDKVF+gx4+TaFH3HBFC+KwzJMj7SbOEfIP201iT6sGSR+eyllAZKCof1xgHHfN2th1wdOrcL/DR2rObX6Ah32sknQ05ba45KFzCa8W82k2lV+i6wHS4GlgU9h3ZRwTw6B6oeM0/67K5J3E1ZbN63OTEt3VIT9XZ9n4Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=qQ+G8A32; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="qQ+G8A32"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 7EB11240027
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 13:36:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1779276986; bh=tXEyRfTpnFLwkQuHJ3oDkW6Ay+3lVK79eFFjXuuXhnM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type:
	 Content-Transfer-Encoding:From;
	b=qQ+G8A32u3JXEju9xvsLgKrQU2O1SutvIgyK+87zgaV735KyiZfD9+P45H1xYj1W1
	 glsyjeDabB1wY4o+DL+XG2ONUjnsBQmE7TavC7RfyaYW8AT0cJwNbiCHMg6h3kChge
	 iMWDt9FOUZ4DeAnMZcpeO/3e68zNG+ZroHvmSxJH2DCJtPYkOL7CWnXc/YJvQbd4q3
	 7fs4Ig48hqOIhxXWfhYeCnsU827aJCB+7f1EtKxPmW7aQiQV17eB9N+P3nS18Gyk2p
	 YLaY5M9wCdDmAGNOw7mDwrEDUEZPNYE6zm3XNbSM3RUwMrrQANlbqllEEl5DG62G0T
	 cJKZm6BCAzqww==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gL8d575HSz9rxL;
	Wed, 20 May 2026 13:36:25 +0200 (CEST)
Message-ID: <20d6a474-18c9-439b-8b01-a3ef5e8310cd@posteo.de>
Date: Wed, 20 May 2026 11:36:26 +0000
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Benjamin Mirko Blume <benjaminblume@posteo.de>
To: linux-bluetooth@vger.kernel.org
Cc: Max Chou <max.chou@realtek.com>
Subject: RTL8922A (0bda:d922): BLE HID disconnects with supervision timeout
 (0x08) during active HFP/SCO call
Content-Language: en-US, de-DE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

This is a bug report for what looks like an SCO/eSCO versus BLE 
airtime-scheduling problem on the Realtek RTL8922A USB combo controller: 
a BLE-only HID device (mouse) is disconnected with link supervision 
timeout whenever an HFP voice call (SCO) is active on the same 
controller. The SCO audio link itself stays up; only the LE HID link 
starves.

Adding Max Chou on Cc as the author of the RTL8922A btrtl support.

Environment
- Controller: Realtek RTL8922A combo, USB 0bda:d922, btusb
- Firmware: rtl_bt/rtl8922au_fw.bin, fw version 0x41c0c905 
(linux-firmware 1:20260410), AOSP extensions v1.00
- Kernel: 6.18.32 x86_64. The same behaviour was present on the previous 
non-LTS kernel 7.0.9-1, so it is not a kernel-version regression.
- BlueZ: 5.86
- Host: Lenovo Yoga 7 14AKP10, AMD Ryzen AI 7 350
- Peripherals:
     - Logitech POP Mouse, BLE-only HID (HID-over-GATT), address 
DB:5C:42:57:1E:1E
     - Jabra Evolve2 65, HFP headset, SCO/eSCO on the same controller

Symptom
With both the BLE mouse and the Jabra headset connected to the RTL8922A, 
the mouse works fine until an HFP voice call starts (mic active, so eSCO 
with the Transparent/wideband codec). Within a few seconds the mouse 
stops responding and is disconnected. With the headset used only for 
A2DP playback (ACL) the mouse stays stable; the disconnects coincide 
specifically with HFP/SCO.

Steps to reproduce
1. Pair and connect a BLE-only HID (mouse) to the RTL8922A.
2. Pair and connect an HFP headset to the same controller.
3. Start a voice call so the headset switches to HFP (eSCO active).
4. The BLE HID disconnects within seconds.

Evidence (btmon)
     HCI Event: Disconnect Complete (0x05)  Handle: 16
         Status: Success (0x00)
         Reason: Connection Timeout (0x08)
     MGMT Event: Device Disconnected
         LE Address: DB:5C:42:57:1E:1E   (the mouse)
         Reason: Connection timeout

During the disconnect window the bus is saturated with SCO data on the 
headset handle (about one packet every 2 ms; 91714 SCO packets total in 
the capture, 534 of them within the 2 s window in which the mouse was 
silent). The last mouse ACL/ATT packet is at t=202.4 s; the Disconnect 
Complete is at t=209.4 s, i.e. about 7 s with no serviced LE connection 
events before the supervision timeout fires. SCO continues uninterrupted 
before, during and after the LE timeout.

Interpretation and questions
The controller appears to keep the reserved (e)SCO slots while the LE 
connection events are starved to the point of supervision timeout. On 
other controllers (for example Intel) BLE HID survives an active HFP 
call, so this looks like an RTL8922A firmware coexistence/scheduling 
issue rather than a hard single-radio limitation.
- Is this a known limitation of the RTL8922A firmware?
- Is the SCO/LE arbitration firmware-tunable, or can the host side 
mitigate it (for example via LE connection parameters)?
- Could this have regressed between linux-firmware versions? I am happy 
to bisect linux-firmware if that would help.

Workaround
Moving the headset onto a separate USB dongle (off the RTL8922A) removes 
all SCO load from the chip and the BLE HID stays connected.

I have a full btmon trace and can provide a short, payload-scrubbed 
reproducer (the raw SCO payload contains call audio, so I would strip 
it). Happy to test patches or gather more logs.

Thanks,
Benjamin Blume



