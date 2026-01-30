Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628302FDC22
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769802601; cv=none; b=nkY04klkGIMqY6PTV5L3A4+HSowQuS+3MR8WRIS+JoT38XWkeatTAdPWCSL1BADBuoAlI4wsYZnCbT1fn07p4vsWLHJOuQ72I9vLbX/SVsDPUd8DUpGRqOREzLqNDKk2y9BLfmkDvqGvS8CpMYeRQaAoW4wiGqXcAd+I0Vvf1uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769802601; c=relaxed/simple;
	bh=LpfTwmVJaH0mZ6KgBoxw8Y/VHK1Sty7MBdGgETmy/fU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IXusYEL4TNHrE+wdm5XGsQkPmPBk89rjgm0Nw440ZJHn2zyhG0kBbfAJcSvkp9PCSM4fLVz3KsM6HPLyKNm3DAe3rovOUbqm7GzKsTMLrYFvmYTBNszqG88Yh/AYjdVtzNykTc5732MGsSqRAkiv++nK0PSVTGD5Pmv7f1osTuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=L346Tg+E; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="L346Tg+E"
Received: from github.com (hubbernetes-node-3e15589.ash1-iad.github.net [10.56.196.55])
	by smtp.github.com (Postfix) with ESMTPA id 71FE69212A3
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769802598;
	bh=fDTUMUFyCqRBeT6Iq5PQTqAQKyoOnV/RPhqTsUm3hyA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=L346Tg+ETWLVUfL2bkoezTWBFb1GuliihD1bb66j7h+l7QNelJp2mmPf7um8G3tDr
	 nr11LqfP65u1v2P6bZ3p7GZYgOVJl1mQgfciueZ9IbT3fPZobsR/K209WMKYMwrS/7
	 Hud1W07ShivBWOeTcds6oJCP7UYaFPIBjDX63bhg=
Date: Fri, 30 Jan 2026 11:49:58 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1049133/000000-b520ac@github.com>
Subject: [bluez/bluez] c63b49: doc/bluetoothctl: Add :Uses: fields and
 document a...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1049133
  Home:   https://github.com/bluez/bluez
  Commit: c63b49b80f7e62bd4a12206d4bb9f095cd80c6d2
      https://github.com/bluez/bluez/commit/c63b49b80f7e62bd4a12206d4bb9f095cd80c6d2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl.rst

  Log Message:
  -----------
  doc/bluetoothctl: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 4e3d3aa401267b31312a412a0a83eca1724d9fe6
      https://github.com/bluez/bluez/commit/4e3d3aa401267b31312a412a0a83eca1724d9fe6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-mgmt.rst

  Log Message:
  -----------
  doc/bluetoothctl-mgmt: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 10bad8a896d941385d212936679d9fa4916d4671
      https://github.com/bluez/bluez/commit/10bad8a896d941385d212936679d9fa4916d4671
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-admin.rst

  Log Message:
  -----------
  doc/bluetoothctl-admin: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: eab370fffc03db23126d74ea7445e6487336aba9
      https://github.com/bluez/bluez/commit/eab370fffc03db23126d74ea7445e6487336aba9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-advertise.rst

  Log Message:
  -----------
  doc/bluetoothctl-advertise: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 96bef72463e3debdc551efd81b999bd0539ba25b
      https://github.com/bluez/bluez/commit/96bef72463e3debdc551efd81b999bd0539ba25b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-assistant.rst

  Log Message:
  -----------
  doc/bluetoothctl-assistant: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 9bb633bf8fb3ea31638f8a7f1d24ef9c1fe97ae0
      https://github.com/bluez/bluez/commit/9bb633bf8fb3ea31638f8a7f1d24ef9c1fe97ae0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-bredr.rst

  Log Message:
  -----------
  doc/bluetoothctl-bredr: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: d51eb6f708461f026775acfa881c72f6c678b897
      https://github.com/bluez/bluez/commit/d51eb6f708461f026775acfa881c72f6c678b897
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-endpoint.rst

  Log Message:
  -----------
  doc/bluetoothctl-endpoint: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 1a85dda59f56b4cf05a440ff90b0170cafa5db8f
      https://github.com/bluez/bluez/commit/1a85dda59f56b4cf05a440ff90b0170cafa5db8f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-gatt.rst

  Log Message:
  -----------
  doc/bluetoothctl-gatt: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 47a04eb9952c80db08b1bdc9a69f68ed4e4cb41f
      https://github.com/bluez/bluez/commit/47a04eb9952c80db08b1bdc9a69f68ed4e4cb41f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-hci.rst

  Log Message:
  -----------
  doc/bluetoothctl-hci: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 0328a0582fb2544ebc4a2e52c9f1509fb0515cd4
      https://github.com/bluez/bluez/commit/0328a0582fb2544ebc4a2e52c9f1509fb0515cd4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-le.rst

  Log Message:
  -----------
  doc/bluetoothctl-le: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 52aa1b41c3a928a35d67ad04a76ce5412f6e44ff
      https://github.com/bluez/bluez/commit/52aa1b41c3a928a35d67ad04a76ce5412f6e44ff
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-monitor.rst

  Log Message:
  -----------
  doc/bluetoothctl-monitor: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: cb4517dff87067daf9625f9998e56b7f0928dd31
      https://github.com/bluez/bluez/commit/cb4517dff87067daf9625f9998e56b7f0928dd31
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-player.rst

  Log Message:
  -----------
  doc/bluetoothctl-player: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 5037a72e5fba89d704e386f20586ca0d861f1172
      https://github.com/bluez/bluez/commit/5037a72e5fba89d704e386f20586ca0d861f1172
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-scan.rst

  Log Message:
  -----------
  doc/bluetoothctl-scan: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 56b25163675f11f6c54ed5ab925981e09fb54387
      https://github.com/bluez/bluez/commit/56b25163675f11f6c54ed5ab925981e09fb54387
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-telephony.rst

  Log Message:
  -----------
  doc/bluetoothctl-telephony: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 9aea3a9c8fa375174f60d0218d6d56b4e132607b
      https://github.com/bluez/bluez/commit/9aea3a9c8fa375174f60d0218d6d56b4e132607b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-transport.rst

  Log Message:
  -----------
  doc/bluetoothctl-transport: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: e4f1591a1a129697ae76a2135bd0dee3a8ee20ca
      https://github.com/bluez/bluez/commit/e4f1591a1a129697ae76a2135bd0dee3a8ee20ca
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.Adapter.rst

  Log Message:
  -----------
  doc/org.bluez.Adapter: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl and Examples sections
showing corresponding bluetoothctl commands for D-Bus methods.


  Commit: b88e2c1dee9e2451a1ec30808a2391264669624b
      https://github.com/bluez/bluez/commit/b88e2c1dee9e2451a1ec30808a2391264669624b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.AdminPolicySet.rst

  Log Message:
  -----------
  doc/org.bluez.AdminPolicySet: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-admin and Examples sections
showing corresponding bluetoothctl commands for D-Bus methods.


  Commit: c05967a6ad65f9541f2ea1ed2fe794981a7a53f6
      https://github.com/bluez/bluez/commit/c05967a6ad65f9541f2ea1ed2fe794981a7a53f6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.AdminPolicyStatus.rst

  Log Message:
  -----------
  doc/org.bluez.AdminPolicyStatus: Add Used by reference

Add :Used by: field linking to bluetoothctl-admin for this interface
which exposes properties read by admin policy commands.


  Commit: 9e748d569352f79edc9687a7104ad28fc071e49b
      https://github.com/bluez/bluez/commit/9e748d569352f79edc9687a7104ad28fc071e49b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.AdvertisementMonitor.rst

  Log Message:
  -----------
  doc/org.bluez.AdvertisementMonitor: Add Used by reference

Add :Used by: field linking to bluetoothctl-monitor for this callback
interface implemented by advertisement monitor clients.


  Commit: fccd2d46978b9c587a75432c476f594e5a140562
      https://github.com/bluez/bluez/commit/fccd2d46978b9c587a75432c476f594e5a140562
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.AdvertisementMonitorManager.rst

  Log Message:
  -----------
  doc/org.bluez.AdvertisementMonitorManager: Add Used by reference

Add :Used by: field linking to bluetoothctl-monitor for this interface
used to register advertisement monitors.


  Commit: a855bf198bea146012ec8eb38823161661dc44f0
      https://github.com/bluez/bluez/commit/a855bf198bea146012ec8eb38823161661dc44f0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.AgentManager.rst

  Log Message:
  -----------
  doc/org.bluez.AgentManager: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl and Examples sections
showing corresponding bluetoothctl commands for agent methods.


  Commit: ae3a9e5f7fdd3903c5df12c1d302409560ed31a1
      https://github.com/bluez/bluez/commit/ae3a9e5f7fdd3903c5df12c1d302409560ed31a1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.Call.rst

  Log Message:
  -----------
  doc/org.bluez.Call: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-telephony and Examples
sections showing corresponding bluetoothctl commands for call methods.


  Commit: b63c712e842416b2bcaac1bb928b6d00de623dc1
      https://github.com/bluez/bluez/commit/b63c712e842416b2bcaac1bb928b6d00de623dc1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.Device.rst

  Log Message:
  -----------
  doc/org.bluez.Device: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl and Examples sections
showing corresponding bluetoothctl commands for device methods.


  Commit: 23411320f153a1176d7d09fad73387f151a7cd3f
      https://github.com/bluez/bluez/commit/23411320f153a1176d7d09fad73387f151a7cd3f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.GattCharacteristic.rst

  Log Message:
  -----------
  doc/org.bluez.GattCharacteristic: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-gatt and Examples sections
showing corresponding bluetoothctl commands for GATT operations.


  Commit: 287bc711f9a7b7244814b0520aeec12286f86453
      https://github.com/bluez/bluez/commit/287bc711f9a7b7244814b0520aeec12286f86453
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.GattDescriptor.rst

  Log Message:
  -----------
  doc/org.bluez.GattDescriptor: Add Used by reference

Add :Used by: field linking to bluetoothctl-gatt for this interface
used by GATT descriptor operations.


  Commit: 4730b57dc63b0069116e332f8afd1e475e4c36d0
      https://github.com/bluez/bluez/commit/4730b57dc63b0069116e332f8afd1e475e4c36d0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.GattManager.rst

  Log Message:
  -----------
  doc/org.bluez.GattManager: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-gatt and Examples sections
showing corresponding bluetoothctl commands for GATT application methods.


  Commit: 1d49c2ab9acebfa78b89d712aa3a8611f085da26
      https://github.com/bluez/bluez/commit/1d49c2ab9acebfa78b89d712aa3a8611f085da26
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.GattService.rst

  Log Message:
  -----------
  doc/org.bluez.GattService: Add Used by reference

Add :Used by: field linking to bluetoothctl-gatt for this interface
exposing GATT service properties.


  Commit: fce953dc5abc2d888d1a5e09475eb05814a4cc0c
      https://github.com/bluez/bluez/commit/fce953dc5abc2d888d1a5e09475eb05814a4cc0c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.LEAdvertisement.rst

  Log Message:
  -----------
  doc/org.bluez.LEAdvertisement: Add Used by reference

Add :Used by: field linking to bluetoothctl-advertise for this callback
interface implemented by LE advertisement clients.


  Commit: fbc56f3cdbff1f31d94c7328d25d272b671f6fcc
      https://github.com/bluez/bluez/commit/fbc56f3cdbff1f31d94c7328d25d272b671f6fcc
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.LEAdvertisingManager.rst

  Log Message:
  -----------
  doc/org.bluez.LEAdvertisingManager: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-advertise and Examples
sections showing corresponding bluetoothctl advertising commands.


  Commit: 4eacc7e1db071bc6ab7acb12e1a56a90eab0170a
      https://github.com/bluez/bluez/commit/4eacc7e1db071bc6ab7acb12e1a56a90eab0170a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.Media.rst

  Log Message:
  -----------
  doc/org.bluez.Media: Add Used by reference

Add :Used by: field linking to bluetoothctl-endpoint for this interface
used for media endpoint registration.


  Commit: 35890dcd2b747095f05ff05b45205a39c14f3418
      https://github.com/bluez/bluez/commit/35890dcd2b747095f05ff05b45205a39c14f3418
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.MediaAssistant.rst

  Log Message:
  -----------
  doc/org.bluez.MediaAssistant: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-assistant and Examples
sections showing corresponding bluetoothctl assistant commands.


  Commit: e4097b049a040af4560abb8f67d3a6b77237ab4b
      https://github.com/bluez/bluez/commit/e4097b049a040af4560abb8f67d3a6b77237ab4b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.MediaEndpoint.rst

  Log Message:
  -----------
  doc/org.bluez.MediaEndpoint: Add Used by reference

Add :Used by: field linking to bluetoothctl-endpoint for this callback
interface implemented by media endpoint clients.


  Commit: b6338af37b82e2e87225463509ed13da978e4024
      https://github.com/bluez/bluez/commit/b6338af37b82e2e87225463509ed13da978e4024
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.MediaPlayer.rst

  Log Message:
  -----------
  doc/org.bluez.MediaPlayer: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-player and Examples sections
showing corresponding bluetoothctl player commands.


  Commit: f48b31460eb319b696de35ecd249f309a9a29607
      https://github.com/bluez/bluez/commit/f48b31460eb319b696de35ecd249f309a9a29607
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.MediaTransport.rst

  Log Message:
  -----------
  doc/org.bluez.MediaTransport: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-transport and Examples
sections showing corresponding bluetoothctl transport commands.


  Commit: b520acd81aa8bb719ceade9f8066cf7def151ee1
      https://github.com/bluez/bluez/commit/b520acd81aa8bb719ceade9f8066cf7def151ee1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.Telephony.rst

  Log Message:
  -----------
  doc/org.bluez.Telephony: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-telephony and Examples
sections showing corresponding bluetoothctl telephony commands.


Compare: https://github.com/bluez/bluez/compare/c63b49b80f7e%5E...b520acd81aa8

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
