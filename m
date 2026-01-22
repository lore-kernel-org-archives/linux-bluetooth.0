Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417A83BE4B6
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101413; cv=none; b=FoCIeTusUx4Em/lhOM/06loZ2fq1CILEUPO/xmLqbpq9pB4jjQ5KorfBNH83dDhiUYv66y6eQgq9HzPKF2DJXcvzw7XCGsVLbhT8MDNPIThoGq+/+F71Ve7cMLo6nk8zCtQit6UjtABsd+q6T0K4T2m7ha7nIBY3nP9OQWmnBIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101413; c=relaxed/simple;
	bh=DqnF1tGIUsDCOt6Q/T37H9VSuqBJPrOoy3pE6V0zSps=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hRY/1vF18Xp7S1cEl1Sss+rTLkDJhF0ggSNBV3+UDJBRFO1ESAe8vgbTiaHEOHHG086nymb0TLokqlfr0c6yRVKrmGeKdHFljaH04PX01nFmD2bI7lFr1dayjMWzcQoaR1ZLcYbplBS+/xgO46Et/3BeuWlVSGqBLjClPFyUeiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lsNIkRyH; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lsNIkRyH"
Received: from github.com (hubbernetes-node-89ac1ca.ash1-iad.github.net [10.56.207.29])
	by smtp.github.com (Postfix) with ESMTPA id 5CEA01414E0
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 09:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769101403;
	bh=MTnXgCkONBryB4pSQkg4wUIn2VJeU1Tv5d4LXwEiEXk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lsNIkRyH1FdfJBAEr/1FORdqw1ZWMT1McmUcAIKdLWF36R7TyUgbVdJNCXaGarslP
	 Ge++WQ77f5hmNC5GwPb/FpK63frkc0MMXgsvlrwcgO0klOFjupG1Gu+K6RjRDz7XDp
	 tmkXtQwYPL4zleM/R5WLWmvT/6HIjzASmr+PSEVE=
Date: Thu, 22 Jan 2026 09:03:23 -0800
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8dea25-fddcda@github.com>
Subject: [bluez/bluez] 5e2bb7: doc: Rename section 7 man pages
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 5e2bb7b1ba131252dc739c9e9e5ab75e2e037af9
      https://github.com/bluez/bluez/commit/5e2bb7b1ba131252dc739c9e9e5ab75e2e037af9
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    M Makefile.am
    A doc/hci-protocol.rst
    R doc/hci.rst
    A doc/iso-protocol.rst
    R doc/iso.rst
    A doc/l2cap-protocol.rst
    R doc/l2cap.rst
    A doc/mgmt-protocol.rst
    R doc/mgmt.rst
    A doc/rfcomm-protocol.rst
    R doc/rfcomm.rst
    A doc/sco-protocol.rst
    R doc/sco.rst

  Log Message:
  -----------
  doc: Rename section 7 man pages

So that rfcomm.rst can be used for the rfcomm command-line utilities.
This does not change the names of the generated man pages.


  Commit: 44e3dd321e4be052bcde40939552b93b734538d3
      https://github.com/bluez/bluez/commit/44e3dd321e4be052bcde40939552b93b734538d3
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    M Makefile.am
    M Makefile.mesh
    M Makefile.tools
    R client/bluetoothctl-admin.rst
    R client/bluetoothctl-advertise.rst
    R client/bluetoothctl-assistant.rst
    R client/bluetoothctl-bredr.rst
    R client/bluetoothctl-endpoint.rst
    R client/bluetoothctl-gatt.rst
    R client/bluetoothctl-hci.rst
    R client/bluetoothctl-le.rst
    R client/bluetoothctl-mgmt.rst
    R client/bluetoothctl-monitor.rst
    R client/bluetoothctl-player.rst
    R client/bluetoothctl-scan.rst
    R client/bluetoothctl-telephony.rst
    R client/bluetoothctl-transport.rst
    R client/bluetoothctl.rst
    M configure.ac
    A doc/bdaddr.rst
    A doc/bluetooth-meshd.rst.in
    A doc/bluetoothctl-admin.rst
    A doc/bluetoothctl-advertise.rst
    A doc/bluetoothctl-assistant.rst
    A doc/bluetoothctl-bredr.rst
    A doc/bluetoothctl-endpoint.rst
    A doc/bluetoothctl-gatt.rst
    A doc/bluetoothctl-hci.rst
    A doc/bluetoothctl-le.rst
    A doc/bluetoothctl-mgmt.rst
    A doc/bluetoothctl-monitor.rst
    A doc/bluetoothctl-player.rst
    A doc/bluetoothctl-scan.rst
    A doc/bluetoothctl-telephony.rst
    A doc/bluetoothctl-transport.rst
    A doc/bluetoothctl.rst
    A doc/bluetoothd.rst.in
    A doc/btattach.rst
    A doc/btmgmt.rst
    A doc/btmon.rst
    A doc/ciptool.rst
    A doc/hciattach.rst
    A doc/hciconfig.rst
    A doc/hcidump.rst
    A doc/hcitool.rst
    A doc/hid2hci.rst
    A doc/isotest.rst
    A doc/l2ping.rst
    A doc/rctest.rst
    A doc/rfcomm.rst
    A doc/sdptool.rst
    R mesh/bluetooth-meshd.rst.in
    R monitor/btmon.rst
    R src/bluetoothd.rst.in
    R tools/bdaddr.rst
    R tools/btattach.rst
    R tools/btmgmt.rst
    R tools/ciptool.rst
    R tools/hciattach.rst
    R tools/hciconfig.rst
    R tools/hcidump.rst
    R tools/hcitool.rst
    R tools/hid2hci.rst
    R tools/isotest.rst
    R tools/l2ping.rst
    R tools/rctest.rst
    R tools/rfcomm.rst
    R tools/sdptool.rst

  Log Message:
  -----------
  doc: Move all the man pages to doc/

No modifications are made to the documentation files, their sources (rst
or rst.in) are just moved to doc/ and the autotools build files adjusted
for the new path.


  Commit: e93d8cd4fe4104b1158b54de271e1179bdf8a846
      https://github.com/bluez/bluez/commit/e93d8cd4fe4104b1158b54de271e1179bdf8a846
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    M Makefile.am
    A doc/assigned-numbers.rst
    R doc/assigned-numbers.txt

  Log Message:
  -----------
  doc: Port assigned-numbers.txt to RST


  Commit: 4371db7798b3aae146c07073469387f073864414
      https://github.com/bluez/bluez/commit/4371db7798b3aae146c07073469387f073864414
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.Thermometer.rst
    A doc/org.bluez.ThermometerManager.rst
    A doc/org.bluez.ThermometerWatcher.rst
    R doc/thermometer-api.txt

  Log Message:
  -----------
  doc: Port thermometer-api.txt to RST


  Commit: 17d407e34cbef272446fd3d1836d619828325837
      https://github.com/bluez/bluez/commit/17d407e34cbef272446fd3d1836d619828325837
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    A doc/security-bugs.rst
    R doc/security-bugs.txt

  Log Message:
  -----------
  doc: Port security-bugs.txt to RST


  Commit: ff58eeb2b1adac497c53b9e78e3bbfc23b1f3050
      https://github.com/bluez/bluez/commit/ff58eeb2b1adac497c53b9e78e3bbfc23b1f3050
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    A doc/coding-style.rst
    R doc/coding-style.txt

  Log Message:
  -----------
  doc: Port coding-style.txt to RST


  Commit: fddcda9751afbeb6c1083d4e83f4b6128125c1c6
      https://github.com/bluez/bluez/commit/fddcda9751afbeb6c1083d4e83f4b6128125c1c6
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    A doc/maintainer-guidelines.rst
    R doc/maintainer-guidelines.txt

  Log Message:
  -----------
  doc: Port maintainer-guidelines.txt to RST


Compare: https://github.com/bluez/bluez/compare/8dea2591fcc2...fddcda9751af

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
