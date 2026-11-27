Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.105.117.190
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787131;
	b=d3DUbg40bHXyDkCbNamM1wefaYKqIFznX9BEBAVn2yUP3a783B5J1S5S/xt9QvqFt1kW
	 WKOlxMi8KO7qNllVtO0QonYe4SD2rB16caa976kNz3rHo5F50eDbMaHJu5zdKOoVarKhp
	 0eFeifyjCTk4S0Elf3dfkd7Yk1tyAt2evebL59te1l5OamfR4sdT+9KVznnljoYvcujVC
	 jx/U7YtxEOKRz5Vog9Wfrt+w+2zTnk4aT2DX/a6V3W5EqQVKatYNk/jCpEPEzGF93P5gQ
	 kb0cMbfKtEdxzv6jY2iOw8mS99Yap5JMuN56Xv6AqdoUF3v4lp2KLYAJxUvONtKxIgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787131;
	h=DMARC-Filter:DKIM-Signature:X-Virus-Scanned:Message-ID:Date:
	 MIME-Version:From:Content-Language:To:Subject:Content-Type:
	 Content-Transfer-Encoding;
	bh=SBrNPrltdvvyQrkTkaEFfXJ5STXVmRCxzsvszKq5i14=;
	b=t4zxGvFbWE+VjchFRMIAe6gIfsYlgExQKg5SHFtRYipyfBDpt+u0dWI/Sxm0gH98V2Eh
	 BF4nsnylJ1HPq96IBQLJHT0Jit9+Y3ZiB4oeE7VTrZYIfRjm+B8duZmNyUJyHkUzp3zvy
	 WrGEJSGnLlealLqo01kV0KnN/KEzfNEc75Y+cMlDuffYrcT4Tsihkfh8cyx6vJe7VlNqg
	 9z0MJOEt+lLi0hRXa1WGf++oQXapELD5pP27QN5PIt6kwcRmQJSuemINHaUh1j32NQLjj
	 Ybr1i7pdcS4ZVW/j5OnrtS/ydnze5fAO0M1J0qP9zRwcWc/NM2H/QMAxgGYAZleO4NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renegat.net;
	spf=pass smtp.mailfrom=renegat.net;
	dkim=pass header.d=renegat.net header.i=@renegat.net header.a=rsa-sha256 header.s=mail header.b=iElGJCrL;
	arc=none smtp.remote-ip=46.105.117.190
Received: from mail.renegat.net (axonet.republicate.com [46.105.117.190])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B046B606A327
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 13:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B046B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=renegat.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renegat.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=renegat.net header.i=@renegat.net header.a=rsa-sha256 header.s=mail header.b=iElGJCrL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=renegat.net; s=mail;
	t=1795787128; bh=HgRzelT88K9gCLodymzcWXuAkL6yVNFzjSg5ddy7yPw=;
	h=From:To:Subject:From;
	b=iElGJCrLWsIxvh7W+7elkbIMeRJ1TP5H1X16ReJj81XH/pwl6vRWLfx3YfmQOT8WG
	 DThus2OwdlSdiWKODRskDYDSzgZ7r7X/RcE5K4IAM/8ykg6InyeARbe0xHNTubwOby
	 zQnBzgfV2imjIq4u2sIAZgZZXzl0nbRfQz+RM8Ox2kGUvhq4hM/TZ/NRPMnD1Oojm9
	 GLe5s0pDleF0cjWGX18TzWDkTjzxFVE/WwTD19yjlMVpA2vbWJLdJkHXLkaWSilAz0
	 m9faQTewRZqm72sM5W4qD4u/VihMFfS3TGwAa128BGw8hgSTpUFhjyPrJpfH/yGwhW
	 lRu8WU0LpF3yQ==
X-Virus-Scanned: Yes
Message-ID: <7f613ea3-8402-496a-91d2-c405f995372b@renegat.net>
Date: Fri, 27 Nov 2026 14:45:28 +0100
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Claude Brisson <claude@renegat.net>
Content-Language: en-US, fr
To: linux-bluetooth@vger.kernel.org
Subject: Bonded LE device reconnecting by directed advertising cannot connect
 while discovery is active
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi.

The concrete problem I ran into was that a specific chrome tab was 
scanning bluetooth for nearby phones, and when my laptop was locking my 
gnome session on idle, my external bluetooth keyboard was unpaired.

On the funny side, the net effect was rather drastic for me, because my 
laptop built-in keyboard is broken and I just couldn't log in back...

Here is what Fable drafted about the bug:

A bonded LE keyboard cannot reconnect for as long as any D-Bus client
keeps a discovery session open. It connects within about 2 s once
discovery stops. The cause looks like the private address used for
active scanning: the controller then reports no advertising directed
to the adapter's public address.

Setup

   Kernel      6.8.0-134-generic (Ubuntu 6.8.0-134.134, based on 6.8.12)
   BlueZ       5.72 (Ubuntu 5.72-0ubuntu5.5)
   Controller  Intel AX210, USB 8087:0032, firmware 60-48.23
               (ibt-0041-0041.sfi, timestamp 2023.48 build 75324)
   Adapter     F4:7B:09:40:95:29 (public), Privacy off (default main.conf)
   Peripheral  Microsoft Bluetooth Keyboard, 045E:0830, HoG,
               E3:69:71:80:04:67 (static random), bonded and trusted

What happens

The keyboard drops its link after 10 minutes without a keypress
(Disconnect Complete, reason 0x13, Remote User Terminated Connection).
On the next keypress it reconnects by directed advertising to the
adapter's public address.

Without discovery this works: the background passive scan takes the
ADV_DIRECT_IND and the kernel connects.

With a discovery session open, the keyboard stays dead until the
session is closed. Here the client was Chrome, which keeps a session
with Transport=le for as long as a page with a pending passkey
(WebAuthn) request is open. GNOME Settings left on its Bluetooth panel
appears to have the same effect; I did not trace that case.

Trace

Condensed from "btmon -T". Wall-clock times, 2026-11-27.

1. Discovery rounds. One about every 10.7 s, the next one starting about
    5 ms after the previous one ends, so the background scan never runs.

   @ MGMT Command: Start Service Discovery (0x003a) plen 4
           Address type: 0x06 (LE Public, LE Random)
           RSSI: invalid (0x7f)
           UUIDs: 0
   < HCI Command: LE Set Random Address (0x08|0x0005) plen 6
           Address: 10:FD:21:3D:48:75 (Non-Resolvable)
   < HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13
           Own address type: Random (0x01)
           Filter policy: Accept all advertisement (0x00)
           Entry 0: LE 1M     Type: Active (0x01)
           Entry 1: LE Coded  Type: Active (0x01)
   < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6
           Extended scan: Enabled (0x01)
           Filter duplicates: Disabled (0x00)

2. The keyboard drops its link.

   13:39:13.387
   > HCI Event: Disconnect Complete (0x05) plen 4
           Handle: 2048
           Reason: Remote User Terminated Connection (0x13)

3. From 13:39:13 to 13:44:52, 32 discovery rounds. The controller
    reports 8662 advertising reports from 56 addresses (ADV_IND,
    ADV_NONCONN_IND, SCAN_RSP). None is from the keyboard and none is
    ADV_DIRECT_IND, although the keyboard was being typed on.

4. The client closes its session. The background scan resumes under
    the public address, and the first directed report arrives 2 s later.

   13:44:52.947
   @ MGMT Command: Stop Discovery (0x0024) plen 1
   13:44:52.949
   < HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13
           Own address type: Public (0x00)
           Filter policy: Accept all advertisement (0x00)
           Entry 0: LE 1M     Type: Passive (0x00)
           Entry 1: LE Coded  Type: Passive (0x00)
   13:44:54.992
   > HCI Event: LE Meta Event (0x3e) plen 26
         LE Extended Advertising Report (0x0d)
             Legacy PDU Type: ADV_DIRECT_IND (0x0015)
             Address type: Random (0x01)
             Address: E3:69:71:80:04:67 (Static)
             RSSI: -51 dBm
             Direct address type: Public (0x00)
             Direct address: F4:7B:09:40:95:29
   13:44:54.994
   < HCI Command: LE Extended Create Connection (0x08|0x0043) plen 26
           Own address type: Public (0x00)
           Peer address: E3:69:71:80:04:67 (Static)
   13:44:55.045
   > HCI Event: LE Meta Event (0x3e) plen 31
         LE Enhanced Connection Complete (0x0a)
           Status: Success (0x00)

Where it comes from

hci_active_scan_sync() in net/bluetooth/hci_sync.c always scans under
a private address:

         /* All active scans will be done with either a resolvable private
          * address (when privacy feature has been enabled) or 
non-resolvable
          * private address.
          */
         err = hci_update_random_address_sync(hdev, true, 
scan_use_rpa(hdev),
                                              &own_addr_type);

This code is the same in v6.8 and in current mainline, so I expect the
same behaviour there, but I have only tested the Ubuntu 6.8 kernel.
The same symptom is reported with a Logitech mouse on an Intel AX211
with kernel 7.2.11 and BlueZ 5.87:
https://github.com/mstroecker/Cymba/issues/189

What I cannot tell from the host side is whether dropping these PDUs
is required of the controller, or specific to Intel firmware.

Questions

1. Is this the expected behaviour? A client that only wants scan
    results silently disables reconnection of every bonded device that
    uses directed advertising, and nothing is logged anywhere.

2. Would it be acceptable to scan under the identity address while
    devices are waiting in pend_le_conns? Or to leave the background
    scan a slot between discovery rounds?

The full btsnoop capture (2.4 MB) is available on request, and I can
test patches on this machine.

Thanks,

   Claude Brisson


