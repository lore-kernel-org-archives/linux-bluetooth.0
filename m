Received: from server1021.dmsolutionsonline.de (server1021.dmsolutionsonline.de [23.88.69.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28FC4E06CC
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.69.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592232; cv=none; b=EHTTPXjLiM5Um2Iv4flGmjk5Re7eamu55TVCMZ2NiHw0FXnfTdKXmmldYB8f3rWHjYugfy2Wa5PVDRykJOaF85eDrxRXAqTbZ3wg7n8ktF4HkumrmOcfZgGEHuXOPOq4TuFIa8Yh+VcZJlLCi52CCo3G+sXZVCW+FM4qN4RCYTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592232; c=relaxed/simple;
	bh=ayEEXsmb51woO/uP+sCE7h4No2Q4jOfDkGU/rMJfbzM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=M6o998wTgM6gkREl2RQpaxwic42G2dWlZWNRixAFPoTDieQhytR/HIDYBDXMAkOSug17vrqEhRqBCzQnbBrb5CQ4sIgKxh3NFjvRXRMv7ikmbQ1wBRUf+10/qA5G+SV3NrcpbabQ/62OZjCEcq7YUsHX63cnzROt24tfAptzpZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noblesound.at; spf=pass smtp.mailfrom=noblesound.at; arc=none smtp.client-ip=23.88.69.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noblesound.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noblesound.at
Received: from [192.168.178.65] (77.119.29.226.wireless.dyn.drei.com [77.119.29.226])
	by server1021.dmsolutionsonline.de (Mailservice) with ESMTPSA id 91B304DC2272;
	Wed, 16 Sep 2026 22:57:01 +0200 (CEST)
Authentication-Results: server1021;
        spf=pass (sender IP is 77.119.29.226) smtp.mailfrom=peter.lemken@noblesound.at smtp.helo=[192.168.178.65]
Received-SPF: pass (server1021: connection is authenticated)
Message-ID: <8ba2bb7b-181e-4a11-bfef-268e1ff99276@noblesound.at>
Date: Wed, 16 Sep 2026 22:57:01 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com
From: Peter Lemken <peter.lemken@noblesound.at>
Subject: Bonded LE HID device cannot reconnect while any process holds a
 discovery session
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.9 at server1021
X-Virus-Status: Clean

Hi,

A bonded BLE mouse becomes unreachable for as long as any userspace
process keeps a discovery session open on the adapter. In my case the
process was Google Chrome, which holds a Web Bluetooth discovery session
indefinitely, but the kernel/BlueZ behaviour is the part that turns a
badly behaved client into "every paired mouse and keyboard stops working
with nothing logged".

Environment
   Fedora 44, kernel 7.2.4-200.fc44.x86_64
   bluez 5.87+1.git8750129efca8
   Intel controller, firmware ibt-0040-0041 (202-5.26)
   Two Lenovo Bluetooth Mice, USB ID 17EF:60EF (LE HOG, bonded, trusted,
   WakeAllowed, static random address regenerated on each pairing)

Symptom
   Mouse goes to its normal idle sleep. Moving it never reconnects.
   bluetoothctl connect <addr> fails with le-connection-abort-by-local.
   Re-pairing (new address) is the only thing that restores input.
   Restarting bluetoothd, power off/on, rfkill and reloading btusb do not
   help, because the client re-arms discovery each time.

What btmon shows during 20 s of moving the dead mouse
   - Active discovery in progress the whole time (SCAN_RSP reports, MGMT
     Device Found events, Start Service Discovery re-issued every ~10 s).
   - Zero packets from the bonded address, zero LE Create Connection.
   - 168 connectable advertisements from other devices, all undirected.

Who holds the scan (dbus-monitor across a bluetoothd restart)
   Only caller of SetDiscoveryFilter/StartDiscovery: Comm=chrome,
   /opt/google/chrome/chrome. Killing it -> Discovering: no -> the mouse
   reconnects within seconds. Starting it again -> problem returns.

Analysis
   hci_passive_scan_sync() deliberately uses the identity address so that
   directed advertising to us is reported by the controller. While a
   discovery session exists, hci_update_passive_scan_sync() returns early
   ("If discovery is active don't interfere with it") and the active scan
   runs under a non-resolvable private address, so ADV_DIRECT_IND aimed at
   the identity address is dropped by the controller before the host sees
   it. A bonded HID device that reconnects via directed advertising is
   therefore invisible for the entire lifetime of the discovery session,
   and explicit connects from BlueZ fail for the same reason.

Expected
   A device in the auto-connect list should remain reachable during
   discovery, e.g. by keeping the accept-list passive scan or the identity
   address in effect for auto-connect candidates, or by interleaving. At
   minimum, log when an auto-connect candidate is being starved by an
   active scan; today there is no trace in dmesg or bluetoothd.

Reproduce
   1. Pair a BLE HID mouse (bonded, trusted).
   2. Start a long-lived discovery from any client, e.g. open
      chrome://bluetooth-internals in Chrome, or `bluetoothctl scan on`.
   3. Let the mouse sleep, then move it: it never reconnects.
   4. Stop the discovery: it reconnects immediately.

I can provide the btsnoop captures (dead state, and dead state during an
explicit connect attempt) on request.

-- 
Best, Peter


